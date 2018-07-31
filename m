Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040DE208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNcqrr8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040DE208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeGaHaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:30:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45792 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeGaHaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:30:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id f12-v6so5313700wrv.12;
        Mon, 30 Jul 2018 22:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q1ZeDc3gbLkSYOUFn93rKQRhlHKlYDUpFDY7unztkBM=;
        b=RNcqrr8oytPAfYAGaZhe6Y1q3odGn9VXGErSlU3nyXjbWQpAgn4gxXdrz4ny52TTuw
         +YpA0v1FgboM9XF9PV7apWhiJzlplGh9b7Tjpoy2+iaaqbcs+R96MQLlct+e2kKDvGMi
         lBsvqeD1AdzHNpDGwRFMIupFmsE4LxpG35HGiBlH/6xjnPdFoa68l7/i52xK9r/kAPit
         pELrY7SqEgmO7+/CK1HTYF9Nf7ZE5xYg1j11dc1Axhx/Rkxlo908ox5cZqY93M++mZO3
         O8+yp0ycLjZF52KtsmKRIKRgwwAy8zkVpzdKkB6OhFXeDazr0okYSJyGH6Y2cMCukvfa
         HkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q1ZeDc3gbLkSYOUFn93rKQRhlHKlYDUpFDY7unztkBM=;
        b=E7zzh6v59ZN04jMuZFFphP51ChyM9sc0yx1sj08SDDl9Lgl7Q02Hy/nvoj4oxUyucn
         x8Qflw6B0Cpod/oKFIj4r/Hwwg/toeOL5QXxfWIpW2unyK4ztvj1rp2DYfBt/ccWPq9i
         5jqV2n03I3C6P5tF7Yl5TW9S+wuo5iO1RCNUpiYaySH3UM8X64CPR6J2rpQxhoNJf2qg
         mZBhZvShLhW2WFbi5ej8B44NZHPnxtlrFWRQfGboK9K+RBzdyBZen6/1LblS/jZVDeYU
         vwuWyc4r4BZBxY5mVvL9tGlPNSx9my28139oRY+i4YiccElHNqn/Dg3SKts4YgPgDJAl
         6sHQ==
X-Gm-Message-State: AOUpUlFwfHd5sW65ihEHAUCdlndsrgYAN6RabJ0+sl3Fqkhb45CrAd20
        +UfBaWQ0PKYHeulZ9tB9HnY=
X-Google-Smtp-Source: AAOMgpcyYHfC8F/Zm/qy5jx24hM41RpR23juo3zbc7ahEBI3ujuQknY8ou4kIzH1dPxTGY3nS4AptA==
X-Received: by 2002:a5d:694e:: with SMTP id r14-v6mr7961019wrw.278.1533016299182;
        Mon, 30 Jul 2018 22:51:39 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e141-v6sm2106532wmd.32.2018.07.30.22.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 22:51:38 -0700 (PDT)
Date:   Tue, 31 Jul 2018 07:51:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Breno Leitao <leitao@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/5] perf/urgent fixes
Message-ID: <20180731055135.GA29199@gmail.com>
References: <20180730205031.12853-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730205031.12853-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, just to get the build without warnings
> and finishing successfully in all my test environments,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 7f635ff187ab6be0b350b3ec06791e376af238ab:
> 
>   perf/core: Fix crash when using HW tracing kernel filters (2018-07-25 11:46:22 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.18-20180730
> 
> for you to fetch changes up to 44fe619b1418ff4e9d2f9518a940fbe2fb686a08:
> 
>   perf tools: Fix the build on the alpine:edge distro (2018-07-30 13:15:03 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes: (Arnaldo Carvalho de Melo)
> 
> - Update the tools copy of several files, including perf_event.h,
>   powerpc's asm/unistd.h (new io_pgetevents syscall), bpf.h and
>   x86's memcpy_64.s (used in 'perf bench mem'), silencing the
>   respective warnings during the perf tools build.
> 
> - Fix the build on the alpine:edge distro.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (5):
>       tools headers uapi: Update tools's copy of linux/perf_event.h
>       tools headers powerpc: Update asm/unistd.h copy to pick new
>       tools headers uapi: Refresh linux/bpf.h copy
>       tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'
>       perf tools: Fix the build on the alpine:edge distro
> 
>  tools/arch/powerpc/include/uapi/asm/unistd.h |   1 +
>  tools/arch/x86/include/asm/mcsafe_test.h     |  13 ++++
>  tools/arch/x86/lib/memcpy_64.S               | 112 +++++++++++++--------------
>  tools/include/uapi/linux/bpf.h               |  28 +++++--
>  tools/include/uapi/linux/perf_event.h        |   2 +
>  tools/perf/arch/x86/util/pmu.c               |   1 +
>  tools/perf/arch/x86/util/tsc.c               |   1 +
>  tools/perf/bench/Build                       |   1 +
>  tools/perf/bench/mem-memcpy-x86-64-asm.S     |   1 +
>  tools/perf/bench/mem-memcpy-x86-64-lib.c     |  24 ++++++
>  tools/perf/perf.h                            |   1 +
>  tools/perf/util/header.h                     |   1 +
>  tools/perf/util/namespaces.h                 |   1 +
>  13 files changed, 124 insertions(+), 63 deletions(-)
>  create mode 100644 tools/arch/x86/include/asm/mcsafe_test.h
>  create mode 100644 tools/perf/bench/mem-memcpy-x86-64-lib.c

Pulled, thanks a lot Arnaldo!

	Ingo
