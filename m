Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7BCC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D9F22DFB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4qJZQbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D9F22DFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeFZHJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:09:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51310 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeFZHJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:09:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id w137-v6so568366wmw.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N7YFuugXGLZn+v6TNm2WAHOXVZQY0S01FoB+zNKrHzw=;
        b=b4qJZQbieEJr4/xLHtU9dgTR4UrlYmbX+7yayQInuY0lpWsnDD8lFEXXelAVTYFk3m
         UvdUT+stN7iLRvSywu7gU/tZYIdmSPMSIODQ7LC4VCwPEeKB3385J+QDQXMVaSjs1qpN
         3v/A5nU0AGxW4vcktUMF//Nv4GlcxzEXn2ojgZup3awiMA+SlstYZ0B3U55qNr8C0fPR
         GSRSk+w4CfEwp+QRSv+C8OxHBywtYMeRJ7PRvlRr3DQ8jgnuiXIDUEG9RPp5milfCiAw
         HdoilsYFqRk4uLBIfvaLhYWODC5arhnA5WKY8xrc4E1CcYR3255rVHblZdHkCaGPragj
         GQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=N7YFuugXGLZn+v6TNm2WAHOXVZQY0S01FoB+zNKrHzw=;
        b=IAgMkP5rgpqZCgqhCIYHOefPHEYJSPFI0l0ZTXSIRSFYdMSYx+vCqg24Ms+8VApp/H
         iRkmWSMGSKb7ifmwx+pZ2RZIq1c9fUSfS5IH0o5HlCfBxtg7gv8Ju/wnJbgz5++tOOF3
         VVDzF7/7EmI23B0jOc013lFP73kCs7Jj7jBoXCDY1D29aZL2BvDzK61H3RIX1KTPIKLj
         1eooQmZCwbm1tg4jTb7yvdO3+pWnmo5iar4KbWOZ+E2mbZvodtM6rzxOJ3ZXxipbcbYX
         63KecwV9YtqzcrEiS3nMLvZzKNo/IVsiFHtEWtStyf+IsSYyMHnYxnFC32pgZlKcLdv8
         6h/A==
X-Gm-Message-State: APt69E350N2qQcgmVIuDK+J8Xqmj2XJndA0/rQ3OyBWrcJxA9kiMX48P
        /157OZuAcoP/Vt+c7KVtweE=
X-Google-Smtp-Source: AAOMgpc4cVMMnbdzMLbuZH5UXVWLkpKLSwJ+5CGdeYdrNrLZn5L9b+ZdPIjAfcy+kRx52tVEhh9sOw==
X-Received: by 2002:a1c:8f8b:: with SMTP id r133-v6mr547565wmd.1.1529996943787;
        Tue, 26 Jun 2018 00:09:03 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g14-v6sm808541wro.86.2018.06.26.00.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 00:09:03 -0700 (PDT)
Date:   Tue, 26 Jun 2018 09:09:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [GIT PULL] breakpoint: Rework arch validation v4
Message-ID: <20180626070900.GC26169@gmail.com>
References: <1529981939-8231-1-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529981939-8231-1-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

> Ingo,
> 
> Please pull the perf/breakpoint-v4 branch that can be found at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	perf/breakpoint-v4
> 
> HEAD: ba25ee9c7b3ef1543c2a24a7ca6a621433803ee4
> 
> Only change since v3 is a rebase against latest tip:perf/core
> 
> ---
> When we modify a hardware breakpoint, the architecture code fills up
> the architecture data as the validation of generic attributes progresses.
> If something goes wrong in the middle, the architecture data changes
> aren't rolled back and we are left with a halfway fiddled breakpoint.
> 
> This set fixes the various misdesigns that back this bad behaviour.
> 
> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (12):
>       perf/breakpoint: Split attribute parse and commit
>       perf/breakpoint: Pass arch breakpoint struct to arch_check_bp_in_kernelspace()
>       x86: Implement hw_breakpoint_arch_parse()
>       powerpc: Implement hw_breakpoint_arch_parse()
>       arm: Implement hw_breakpoint_arch_parse()
>       arm64: Implement hw_breakpoint_arch_parse()
>       sh: Remove "struct arch_hw_breakpoint::name" unused field
>       sh: Implement hw_breakpoint_arch_parse()
>       xtensa: Implement hw_breakpoint_arch_parse()
>       perf/breakpoint: Remove default hw_breakpoint_arch_parse()
>       perf/breakpoint: Pass new breakpoint type to modify_breakpoint_slot()
>       perf/breakpoint: Clean up and consolidate modify_user_hw_breakpoint_check()
> 
> 
>  arch/arm/include/asm/hw_breakpoint.h     |   7 +-
>  arch/arm/kernel/hw_breakpoint.c          |  78 +++++++++---------
>  arch/arm64/include/asm/hw_breakpoint.h   |   7 +-
>  arch/arm64/kernel/hw_breakpoint.c        |  86 ++++++++++----------
>  arch/powerpc/include/asm/hw_breakpoint.h |   7 +-
>  arch/powerpc/kernel/hw_breakpoint.c      |  47 ++++++-----
>  arch/sh/include/asm/hw_breakpoint.h      |   8 +-
>  arch/sh/kernel/hw_breakpoint.c           |  53 ++++++-------
>  arch/x86/include/asm/hw_breakpoint.h     |   7 +-
>  arch/x86/kernel/hw_breakpoint.c          | 131 ++++++++++++++++---------------
>  arch/xtensa/include/asm/hw_breakpoint.h  |   7 +-
>  arch/xtensa/kernel/hw_breakpoint.c       |  40 ++++------
>  kernel/events/hw_breakpoint.c            |  92 +++++++++++++---------
>  13 files changed, 294 insertions(+), 276 deletions(-)

Ok, this looks really good. Applied to the v4.19 queue, thanks a lot Frederic!

I'll push it out once it passes testing.

Thanks,

	Ingo
