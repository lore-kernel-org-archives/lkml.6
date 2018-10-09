Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6643DC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E51F20C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oY31RrJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E51F20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeJIMkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:40:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36889 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeJIMkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:40:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id y11-v6so305475wrd.4;
        Mon, 08 Oct 2018 22:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ku0BiZK//Y7mpOFXuN/xPxbLww3dZcQVqJFu5pOPm0E=;
        b=oY31RrJYahYDbSXYxk07Z9DTx30sSw+zEpHdFQQGmZyO6Q/h0D3HqJ9NqycAheIVm0
         8w3oJmEHI+uHw2yFADAtuvXtyrjIYZCuTIk7IxqO6xNxg8EnKmns5gIGiiZIJUveaN62
         3Z04WNELxGLrDdzJGAqjEP63PmP4V1cgmYQ/yB2OzN6d3wMHHHMGEIsp8yrNBbPLte5Y
         G7dmoJsAWMm4JmvXBDZlKo62WauJUr+RLb0GQ8xlz8qqFwT/BXFLhVja5P/0ssU9DuZR
         dlg4qfkkdVozlpfWNUhmwAN1qjiB+p3dZaRMQFlFh7tYGWZbf9XPke1qiulWeMyVx5eV
         n4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ku0BiZK//Y7mpOFXuN/xPxbLww3dZcQVqJFu5pOPm0E=;
        b=tYv3sLyQoDKv9IxDIl72DGgRafQWOWHyAt+PiXwVSLbNoF+QNcL/FTCCh07xl0sYZe
         5NPqHwyFlaH33O4TST1iEsbUpGzwhtuEbUElujqasGzMkaV8eKfu5Sz/LZchNQ3KpQh8
         CLHUii1zLqrV8FtmLF16fkXmLDA8gMzcDn9qwT2EfYbFKzaZPjPBUGgdDidy4jBhutSy
         9GqmycCIQpNqnAZLLbsTZx2fzsSqVRaOggzj7ODCoGGK0eT8DtUDfvnVoa9RxzkmepxI
         BGel3RfW1krnKt8Etchydr7IDEL2owrSbhUC/xsp1hYq60dQHeoqQgJqP52GDZKvKoju
         GI3g==
X-Gm-Message-State: ABuFfoi6OOJ/2MxgblAPV7Bb6I++FM9I5KATwrQvvyupTX+WusVYqaJL
        LZkNZpg0A5fYSaXr+tY1XiM=
X-Google-Smtp-Source: ACcGV61D6k1AQNUk2Okn0ECTxExw21u/d3QWLV3GMQSLrzJZLsfuk4ozqc2JA9/1UArGqvamE23Tgg==
X-Received: by 2002:a5d:6551:: with SMTP id z17-v6mr17951536wrv.194.1539062696400;
        Mon, 08 Oct 2018 22:24:56 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 64-v6sm19926987wrr.64.2018.10.08.22.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 22:24:55 -0700 (PDT)
Date:   Tue, 9 Oct 2018 07:24:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        David Ahern <dsahern@gmail.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux trace devel <linux-trace-devel@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sanskriti Sharma <sansharm@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/12] perf/core improvements and fixes
Message-ID: <20181009052452.GA104386@gmail.com>
References: <20181009005427.6607-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009005427.6607-1-acme@kernel.org>
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
> The following changes since commit 7c5314b88da6d5af98239786772a1c44cc5eb67d:
> 
>   perf/x86/intel: Add quirk for Goldmont Plus (2018-10-02 10:14:33 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.20-20181008
> 
> for you to fetch changes up to bb3dd7e7c4d5e024d607c0ec06c2a2fb9408cc99:
> 
>   tools lib traceevent, perf tools: Move struct tep_handler definition in a local header file (2018-10-08 15:05:37 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> . Fix building the python bindings with python3, which fixes some
>   problems with building with clang on Clear Linux (Eduardo Habkost)
> 
> . Fix coverity warnings, fixing up some error paths and plugging
>   some temporary small buffer leaks (Sanskriti Sharma)
> 
> . Adopt a wrapper for strerror_r() for the same reasons as recently
>   for libbpf (Steven Rostedt)
> 
> . S390 does not support watchpoints in 'perf test 22', check if
>   that test is supported by the arch. (Thomas Richter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (2):
>       tools include: Adopt linux/bits.h
>       perf auxtrace: Include missing asm/bitsperlong.h to get BITS_PER_LONG
> 
> Eduardo Habkost (2):
>       perf python: Make clang_has_option() work on Python 3
>       perf python: More portable way to make CFLAGS work with clang
> 
> Sanskriti Sharma (5):
>       perf strbuf: Match va_{add,copy} with va_end
>       perf tools: Cleanup trace-event-info 'tdata' leak
>       perf tools: Free 'printk' string in parse_ftrace_printk()
>       perf tools: Avoid double free in read_event_file()
>       perf tools: Free temporary 'sys' string in read_event_files()
> 
> Steven Rostedt (VMware) (1):
>       tools lib traceevent: Separate out tep_strerror() for strerror_r() issues
> 
> Thomas Richter (1):
>       perf test: S390 does not support watchpoints in test 22
> 
> Tzvetomir Stoyanov (1):
>       tools lib traceevent, perf tools: Move struct tep_handler definition in a local header file
> 
>  tools/include/linux/bitops.h             |   7 +-
>  tools/include/linux/bits.h               |  26 +++
>  tools/lib/traceevent/Build               |   2 +
>  tools/lib/traceevent/event-parse-api.c   | 275 +++++++++++++++++++++++++++++++
>  tools/lib/traceevent/event-parse-local.h |  92 +++++++++++
>  tools/lib/traceevent/event-parse.c       |  32 +---
>  tools/lib/traceevent/event-parse.h       | 228 ++++---------------------
>  tools/lib/traceevent/event-plugin.c      |   1 +
>  tools/lib/traceevent/parse-filter.c      |   1 +
>  tools/lib/traceevent/tep_strerror.c      |  53 ++++++
>  tools/perf/check-headers.sh              |   1 +
>  tools/perf/tests/builtin-test.c          |   1 +
>  tools/perf/tests/tests.h                 |   1 +
>  tools/perf/tests/wp.c                    |  12 ++
>  tools/perf/util/auxtrace.h               |   1 +
>  tools/perf/util/setup.py                 |  16 +-
>  tools/perf/util/strbuf.c                 |  10 +-
>  tools/perf/util/trace-event-info.c       |   2 +
>  tools/perf/util/trace-event-parse.c      |  26 +--
>  tools/perf/util/trace-event-read.c       |  11 +-
>  20 files changed, 539 insertions(+), 259 deletions(-)
>  create mode 100644 tools/include/linux/bits.h
>  create mode 100644 tools/lib/traceevent/event-parse-api.c
>  create mode 100644 tools/lib/traceevent/event-parse-local.h
>  create mode 100644 tools/lib/traceevent/tep_strerror.c

Pulled, thanks a lot Arnaldo!

	Ingo
