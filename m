Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DADBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E91D2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6xrIupQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E91D2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbeKVBdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:33:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37716 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKVBdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:33:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so6047464wmc.2;
        Wed, 21 Nov 2018 06:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q28t6s0XKJ/C3B4JhA0QX3VjDVzaDitZtReXZMbnuUU=;
        b=G6xrIupQdEqNDEluhPuCd3Ycn+KrdVEtnIDkaDI3ODPa/5GMSW1lzGFFC36yrWJT7w
         9e/liSjL1RkRYE4+u7qMI1YHGZHjPEzpDItKQRojEYLFPzl4g/KI6BYCc2pwnNInjykW
         xf/U3qoD6MgxqteF7dmdHDOFXeDEJm3VwfxBe6SuddOxyQZQ11f36wvpiMAcswTVxQmD
         ajWsYVpN2XvNLUB2xok02uaVyoLFKrkKWhnqY+fiOtS6e9T20yGxZLBkdd5pkf6tIHq1
         Qmp30gavghu12KBK1qXWK/rCB4rmdWbvqKvJtN8fjCeCH5L1UpwreQXg0LP6TUxHtV7I
         R3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q28t6s0XKJ/C3B4JhA0QX3VjDVzaDitZtReXZMbnuUU=;
        b=g0xbsKuBGTJB9j5oH8GKk9iXdBQPrPmxrYsDeA+jgHtsEe80Ka+QP2p6yCRr/ZUuQJ
         Qh29qw1gwaVzby4NyiAkZXoWIgPo0fUiBs0zIV8Btn6bDARe8DflYcVewpn8G9c44meg
         G63vgAtLgV1QJ5Evel4yFoyHMjBEB6POQM0mb9xNQ+A2nNko+uzWYJzf2kJ70iUMN58m
         9buF0XHJO3GVNP6iWPOz4oSONXM4wNsb9wgcPDfXGyDko/ZoWTBVB4pa25Pn3uXWuxYg
         1pfiqTfZzVl7XXmHfxook+xDA4ncBMsKNLzMK5sInidksS6R7c8hcyg8XkhbejG3UOcf
         HiHA==
X-Gm-Message-State: AGRZ1gLFP4AUHFT9dnutH5Rdqm23fCQj9fX3Qmcie33+lYDMsbJoSYwh
        5beyurdQUX9hJg/Xw1PcewEr0aAK
X-Google-Smtp-Source: AFSGD/VQCQE8Ymy6rdutFDVHLO0qeJPOtjndQ+KJK1H/b8NihNQwtk3ceSP80Mi+i2x/23uBM3adPQ==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr6105404wme.135.1542812311504;
        Wed, 21 Nov 2018 06:58:31 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h2sm26892398wrv.87.2018.11.21.06.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:58:30 -0800 (PST)
Date:   Wed, 21 Nov 2018 15:58:28 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adam Lee <leeadamrobert@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Ahern <dsahern@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>,
        Yongxin Liu <yongxin.liu@outlook.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/7] perf/urgent fixes
Message-ID: <20181121145828.GA112176@gmail.com>
References: <20181121142505.27379-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121142505.27379-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, more to come as I process the backlog
> from being away for LPC.
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 4d47d6407ac7b4b442a4e717488a3bb137398b6c:
> 
>   perf/x86/intel/uncore: Support CoffeeLake 8th CBOX (2018-11-12 05:03:26 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.20-20181121
> 
> for you to fetch changes up to a4243e1494532ab8fa679a4134153149a71fa331:
> 
>   perf tools beauty ioctl: Support new ISO7816 commands (2018-11-19 12:38:50 -0800)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Update kernel ABI headers, one of them lead to a small change in
>   the ioctl 'cmd' beautifier in 'perf trace' to support the new ISO7816
>   commands. (Arnaldo Carvalho de Melo)
> 
> - Restore proper cwd on return from mnt namespace (Jiri Olsa)
> 
> - Add feature check for the get_current_dir_name() function used in the
>   namespace fix from Jiri, that is not available in systems such as
>   Alpine Linux, which uses the  musl libc (Arnaldo Carvalho de Melo)
> 
> - Fix crash in 'perf record' when synthesizing the unit for events such
>   as 'cpu-clock' (Jiri Olsa)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (5):
>       tools build feature: Check if get_current_dir_name() is available
>       tools headers uapi: Synchronize i915_drm.h
>       tools arch x86: Update tools's copy of cpufeatures.h
>       tools uapi asm-generic: Synchronize ioctls.h
>       perf tools beauty ioctl: Support new ISO7816 commands
> 
> Jiri Olsa (2):
>       perf tools: Fix crash on synthesizing the unit
>       perf tools: Restore proper cwd on return from mnt namespace
> 
>  tools/arch/x86/include/asm/cpufeatures.h        |  2 ++
>  tools/build/Makefile.feature                    |  1 +
>  tools/build/feature/Makefile                    |  4 ++++
>  tools/build/feature/test-all.c                  |  5 +++++
>  tools/build/feature/test-get_current_dir_name.c | 10 ++++++++++
>  tools/include/uapi/asm-generic/ioctls.h         |  2 ++
>  tools/include/uapi/drm/i915_drm.h               | 22 ++++++++++++++++++++++
>  tools/perf/Makefile.config                      |  5 +++++
>  tools/perf/tests/attr/base-record               |  2 +-
>  tools/perf/trace/beauty/ioctl.c                 |  1 +
>  tools/perf/util/Build                           |  1 +
>  tools/perf/util/evsel.c                         |  2 +-
>  tools/perf/util/get_current_dir_name.c          | 18 ++++++++++++++++++
>  tools/perf/util/namespaces.c                    | 17 +++++++++++++++--
>  tools/perf/util/namespaces.h                    |  1 +
>  tools/perf/util/util.h                          |  4 ++++
>  16 files changed, 93 insertions(+), 4 deletions(-)
>  create mode 100644 tools/build/feature/test-get_current_dir_name.c
>  create mode 100644 tools/perf/util/get_current_dir_name.c

Pulled, thanks a lot Arnaldo!

	Ingo
