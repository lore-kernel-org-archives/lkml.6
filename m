Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3384C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC822084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzlUJtQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC822084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbeKFGkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:40:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33306 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387469AbeKFGkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:40:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id q5-v6so4800802pgv.0;
        Mon, 05 Nov 2018 13:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WmEOTvBWNOIDxVa7Fczr5dT/PHlRMf+n7m2uXkZtvqk=;
        b=CzlUJtQDMXwkTXH9U/wXl6WZ0CpxkzbtfBJ7D3gqbxoQ/mJ+KxMDOQeXQWEgfPqAsV
         u3X5ctqzOySijTBeyKYB94ZbdPL4hM99k1e8cv0kPWJUc7JndPODaBWsTRCRJRQIwtqi
         jHak6E0LUaUIJ/aqyUo/hNQq3h4CCuXdhvp3tYHpilU2uGmJxdukzToLFr+OUe0cJ4Jo
         Mh4yjtuZFDWTtFWxN71wS/j4ULATIGx6v0IVDQPT3NPoWZvt2YP0IMvjn6IGXghnw7JE
         48ndSmiaccMjuvU/A2GycbrOatxKTLBVKFbrM77KUeFmqn1EQaA+UPuzN/Trn+qIA8k2
         QXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WmEOTvBWNOIDxVa7Fczr5dT/PHlRMf+n7m2uXkZtvqk=;
        b=dfFi+RuFipfrvmmzCKcmSOXf+d5EZE8n0bJo/1zXXqkU292l+70WlVFGNIX5JzTQGu
         NEOX2Yv4aFSVKRXUuttQAWfn9tpspWGSebVFvt7+TilkFgIF/R9gKU+Uojsj3syJryWc
         lvi2W2welxBFuKhz6kcCfJozI934uBDbgt6fiiH/rSIC1K/zRIrDhOGLlN+j8345Fup0
         mK7imvP99VoRJGUq8A7Hku0bZVlkjL8svLsE0c3aJTiq39n2Njjy7BkIfpBA8Qy1zjDK
         ccHEKW2fPcqbMcbJsQg86zV44xqcghm6MYrcti98hmTnXIMs3h/Jk5XTpzAqJozl1scz
         +avw==
X-Gm-Message-State: AGRZ1gKFAmTPIM1WhMmDyp8SB2aPT1UGgL9GdqnXH9m3afhY42d2uraQ
        1t2qGRa2kJUhIEzwgzE2xjU=
X-Google-Smtp-Source: AJdET5cjtLL+Q7gi3GgXAB/VanjJFc7gWpiu53EojYgmpGXgc0Ob6xKMv0E++wvSaCiy4OqcZmW37Q==
X-Received: by 2002:a62:5c41:: with SMTP id q62-v6mr8046690pfb.171.1541452727050;
        Mon, 05 Nov 2018 13:18:47 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l3sm14087028pga.92.2018.11.05.13.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 13:18:45 -0800 (PST)
Date:   Mon, 5 Nov 2018 13:18:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 19/28] perf beauty: Wire up the mmap flags table
 generator to the Makefile
Message-ID: <20181105211844.GA15984@roeck-us.net>
References: <20181031164508.4784-1-acme@kernel.org>
 <20181031164508.4784-20-acme@kernel.org>
 <20181105154433.GA11115@roeck-us.net>
 <20181105171140.GD11147@kernel.org>
 <20181105184612.GD7077@kernel.org>
 <20181105191356.GF7077@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105191356.GF7077@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 04:13:56PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> I did the tests and it seems to work, its the same method used by the
> kernel sources, so I have this in place now:
> 
> commit e2c39f36c354a06c6e9d32d4fdf8660b41803d82
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Mon Nov 5 15:46:51 2018 -0300
> 
>     perf beauty: Use SRCARCH, ARCH=x86_64 must map to "x86" to find the headers
>     
>     Guenter reported that using ARCH=x86_64 to build perf has regressed:
>     
>       $ make -C tools/perf O=/tmp/build/perf ARCH=x86_64
>       make: Entering directory '/home/acme/git/perf/tools/perf'
>         BUILD:   Doing 'make -j4' parallel build
>         HOSTCC   /tmp/build/perf/fixdep.o
>         HOSTLD   /tmp/build/perf/fixdep-in.o
>         LINK     /tmp/build/perf/fixdep
>     
>       Auto-detecting system features:
>       ...                         dwarf: [ on  ]
>       <SNIP>
>       ...                           bpf: [ on  ]
>     
>         GEN      /tmp/build/perf/common-cmds.h
>       make[2]: *** No rule to make target '/home/acme/git/perf/tools/arch/x86_64/include/uapi/asm//mman.h', needed by '/tmp/build/perf/trace/beauty/generated/mmap_flags_array.c'.  Stop.
>       make[2]: *** Waiting for unfinished jobs....
>         PERF_VERSION = 4.19.gf6c23e3
>       make[1]: *** [Makefile.perf:207: sub-make] Error 2
>       make: *** [Makefile:70: all] Error 2
>       make: Leaving directory '/home/acme/git/perf/tools/perf'
>       $
>     
>     This is because we must use $(SRCARCH) where we were using $(ARCH), so
>     that, just like the top level Makefile, we get this done:
>     
>       # Additional ARCH settings for x86
>       ifeq ($(ARCH),i386)
>               SRCARCH := x86
>       endif
>       ifeq ($(ARCH),x86_64)
>               SRCARCH := x86
>       endif
>     
>     Which is done in tools/scripts/Makefile.arch, so switch to use
>     $(SRCARCH).
>     
>     Reported-by: Guenter Roeck <linux@roeck-us.net>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Clark Williams <williams@redhat.com>
>     Cc: David Ahern <dsahern@gmail.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Wang Nan <wangnan0@huawei.com>
>     Fixes: fbd7458db757 ("perf beauty: Wire up the mmap flags table generator to the Makefile")
>     Link: https://lkml.kernel.org/r/20181105184612.GD7077@kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

That seems to do the trick.

Tested-by: Guenter Roeck <linux@roeck-us.net>

> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 3ccb4f0bf088..d95655489f7e 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -387,7 +387,7 @@ SHELL = $(SHELL_PATH)
>  
>  linux_uapi_dir := $(srctree)/tools/include/uapi/linux
>  asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
> -arch_asm_uapi_dir := $(srctree)/tools/arch/$(ARCH)/include/uapi/asm/
> +arch_asm_uapi_dir := $(srctree)/tools/arch/$(SRCARCH)/include/uapi/asm/
>  
>  beauty_outdir := $(OUTPUT)trace/beauty/generated
>  beauty_ioctl_outdir := $(beauty_outdir)/ioctl
