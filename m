Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 00CB9C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A202F208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSWaa3Ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A202F208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbeFNGNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:13:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45068 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752671AbeFNGNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:13:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id o12-v6so5007688wrm.12;
        Wed, 13 Jun 2018 23:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eBvb007vbF4Ex48y25zdErs+Nf8nPK5faUmYjeCRDG0=;
        b=bSWaa3Ryy/04ULXJK91pzqolh2L7uuZYdXL5QiziqhudVBZyIfQMFhJPDI8NxY4s5E
         rCzA9ftHCFGKmYUoOmhYLV3PVSd015VIfx/pA9YUyTFvVFlovpiOpvZocXVipQ/upMii
         WpWacwUo9x5+jAAyEGoIX+Gy3R0KXT4i7nlCWcAczKJW4pzQjCOwPBVqPH+1nxOlRUDC
         UO/NvLRpeYKuv4S5uSByp21iYTIKVXvwL15ZzF+IA5HJmC1TjWgb+DuR+DODsCBTEI+5
         TjKnfPivYJdmuhCYAOcS9ePGs7DgRXmUHjIsXgQ5dUjT5JLsGOMNgh+Thh8cr/vKda2J
         hwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eBvb007vbF4Ex48y25zdErs+Nf8nPK5faUmYjeCRDG0=;
        b=NACPORLs9i76Y5h6LEp+F9mYfefvfzRzru+xQo2VDHOicvBP0Lc8tTMk7Lf/lTkkKv
         JoGZaa7e/4D5eZG9ZdttLlxdnIR10JPT/kb4XwpYnhGgjS1OXjkjmiM4XYx05P+N58lb
         qFXF/EQ4S/AzbnpujW5R3h7dP0qUev3AIn3TplA+99mGHrN9Ti+VsfCM8HKMbPV5ZsXe
         nNn4cqJUfvM/bae178b64nE3OwACJJCo7NdGbtqz6lonw9+fnzQdvzYOn0kga9ql+SnC
         sjBuzJW+QHnZ6Ma8B6Wy8sIg6tvv54uEgVbaFsOrz+WccNdtD90rkniqbPMFw3WU97A+
         HfzA==
X-Gm-Message-State: APt69E22Lh0YZDtYhNKxADD+sGmuK9IAYBVIeNAmwvAXEuBDt9TEootD
        aB0DdW3WALEH+aUFtOK+oEI=
X-Google-Smtp-Source: ADUXVKIemRFeZebva4kfPPmElzMhWqyKAskHn39aTvuNbrbB3UYHF0RcKgaI6zZVUxgSuso4L3rPYg==
X-Received: by 2002:adf:e4cd:: with SMTP id v13-v6mr861903wrm.238.1528956798630;
        Wed, 13 Jun 2018 23:13:18 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t13-v6sm5722431wro.62.2018.06.13.23.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 23:13:17 -0700 (PDT)
Date:   Thu, 14 Jun 2018 08:13:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        David Ahern <dsahern@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/12] perf/urgent fixes and improvements
Message-ID: <20180614061315.GA28715@gmail.com>
References: <20180611174810.14815-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 2696ec4566f598ab483a6bebc4ec841b2efb88ec:
> 
>   Merge tag 'perf-core-for-mingo-4.18-20180606' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-06-07 07:18:51 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.18-20180611
> 
> for you to fetch changes up to fad76d4333fe73cf3f73704aa34d4ce523b1c458:
> 
>   perf script: Show hw-cache events (2018-06-08 13:41:30 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes and improvements:
> 
> perf stat:
> 
> . Add --interval-clear option, to provide a 'watch' like printing (Jiri Olsa)
> 
> . Fix metric column header display alignment (Jiri Olsa)
> 
> . Improve error messages for default attributes, providing better output
>   for error in command lines such as:
> 
>   $ perf stat -T
>   Cannot set up transaction events
>   event syntax error: '..cycles,cpu/cycles-t/,cpu/tx-start/,cpu/el-start/,cpu/cycles-ct/}'
>                                     \___ unknown term
> 
>   Where the "event syntax error" line now appears (Jiri Olsa)
> 
> perf script:
> 
> . Show hw-cache events too (Seeteena Thoufeek)
> 
> perf c2c:
> 
> . Fix data dependency problem in layout of 'struct c2c_hist_entry', where
>   its member 'struct hist_entry' must be at the end because it has a ZLA
>   as its last member, that gets space when handling callchains (Jiri Olsa)
> 
> Core:
> 
> - We cannot assume that a 'struct perf_evsel'  is to be obtained from a
>   container_of operation on a 'struct hists' as there are tools, such as
>   'perf c2c' that uses 'struct hist' instances without having them in
>   container structs that also have 'struct perf_evsel' in a particular
>   layout, so provide a different way of figuring out if a 'struct hists'
>   and 'struct hist_entry' have callchains (Arnaldo Carvalho de Melo)
> 
> - Fix error index in the PMU event parser, so that error messages can
>   point to the problematic token (Jiri Olsa)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       perf hists: Save the callchain_size in struct hist_entry
>       perf hists: Make hist_entry__has_callchains() work with 'perf c2c'
>       perf hists browser gtk: Use hist_entry__has_callchains()
>       perf hists: Reimplement hists__has_callchains()
> 
> Jiri Olsa (7):
>       perf tools: Fix error index for pmu event parser
>       perf stat: Add --interval-clear option
>       perf stat: Use only color_fprintf call in print_metric_only
>       perf stat: Fix metric column header display alignment
>       perf stat: Allow to specify specific metric column len
>       perf stat: Add event parsing error handling to add_default_attributes
>       perf c2c: Keep struct hist_entry at the end of struct c2c_hist_entry
> 
> Seeteena Thoufeek (1):
>       perf script: Show hw-cache events
> 
>  tools/perf/Documentation/perf-stat.txt |  3 +++
>  tools/perf/builtin-c2c.c               | 10 +++----
>  tools/perf/builtin-script.c            | 12 +++++++++
>  tools/perf/builtin-stat.c              | 48 ++++++++++++++++++++--------------
>  tools/perf/ui/gtk/hists.c              |  2 +-
>  tools/perf/util/hist.c                 | 12 ++++++---
>  tools/perf/util/hist.h                 |  4 +--
>  tools/perf/util/parse-events.y         |  5 ++++
>  tools/perf/util/sort.h                 |  4 ++-
>  9 files changed, 67 insertions(+), 33 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
