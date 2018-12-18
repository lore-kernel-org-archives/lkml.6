Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CFCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D18217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dw/V4BB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeLRRFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:05:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34094 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbeLRRFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:05:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so16711002wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 09:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0UABLY0sC2/dA1ONjVtKPIGM/LSKggAr8PeSdYnjYjw=;
        b=Dw/V4BB813XemQCoYKeH6O/y+vdLVkP2MIBxVTndpyzvz84jB/4BId3RCzORb8Ygbr
         rEjJZM0mbB9PJOShcfaKvIYVujShafVVci0H+MDQTwfIBx1ytG3tK14vRKruY2Q2sRsH
         mi8cHw3U+rGxZ+JKCtuyWoj2MiG+mS/pYm5yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0UABLY0sC2/dA1ONjVtKPIGM/LSKggAr8PeSdYnjYjw=;
        b=b/faxGoUX76z2tqWXwRPw0aKtMPt5Hp9ZgizECmu/AgfWyfCyU4jQhM97Wb+D3ysAh
         TlUNwgv23LG7dP4t6WMDbHL5Ya6D9Tdrn+Ey1N4xQfRnyTfrwmNX3uhCLaZDVHFklJsf
         FLPE2KcYkRGPvnbIDNqtGKr728685Lb7KHWPIP09Y+LBGULl1xKkU5nTioZF3uyHwrus
         A5oTi4rGX/dC4FQDzC+WHYVjfDKXTEqZqnEd3+BPCsN91lws72WksrNj4PNolY8XpXfR
         zT3GD+//QICK+jparSD0Ssb3bMHwUIzJdYwDCOyT7m6c+xf7yvWk6aRo9YyIZef9SdJg
         aVFg==
X-Gm-Message-State: AA+aEWbkRFes2Tj6fQ8sNQICeKIxvC0HyaUz35NtxCMMgJT5QD4xBV87
        WVBWuErDFNtJZdA1cd0H7e4z6A==
X-Google-Smtp-Source: AFSGD/UrI19p1P8R+7IqzHfOj3Nq94unw0vGZNCDY2uzHALQKRlyakTX5qrPVQvaOi/tk2kSypBdgg==
X-Received: by 2002:adf:efd1:: with SMTP id i17mr15131725wrp.200.1545152713727;
        Tue, 18 Dec 2018 09:05:13 -0800 (PST)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j63sm1914884wmb.40.2018.12.18.09.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 09:05:12 -0800 (PST)
Date:   Tue, 18 Dec 2018 17:05:10 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        briannorris@chromium.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debug: Allow forcing entering debug mode on
 panic/exception
Message-ID: <20181218170510.GA28994@wychelm.lan>
References: <20181210023649.229271-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210023649.229271-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 06:36:49PM -0800, Douglas Anderson wrote:
> Ever since commit 5516fd7b92a7 ("debug: prevent entering debug mode on
> panic/exception.") (yes, years ago) my kgdb workflow has been broken.
> On Chrome OS we have 'kernel.panic = -1' in
> '/etc/sysctl.d/00-sysctl.conf'.  That means that when userspace starts
> up it will tell the kernel "please reboot on panic".  ...and so when I
> get a panic then the system reboots instead of letting me debug it.
> 
> While I could go in an change the 'sysctl.conf' and I could go in and
> hack the kernel myself, these things are inconvenient.  I either need
> to keep a private kernel patch or or remember to edit a file every
> time I install an updated version of Chrome OS.  What is convenient
> (for me) is to have a CONFIG option that makes kgdb override the panic
> request.  This is because the Chrome OS build system makes it very
> easy for me to add some extra CONFIG "fragments" to my debug kernels.
> 
> Hopefully having this extra config option is OK and useful to others
> who would also prefer to make sure that kgdb is always entered on a
> panic no matter what userspace might request.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Sorry to be late with this review. I forgot to search for "debug:" when
I was checking for missed patches earlier.

Mind you... one of the reasons I deferred review when you first sent it
in was that my gut reaction was "I don't like it" so I decided to wait
until I could offer a head reaction instead.

Ultimately I'm not sure this should be solved within kgdb. Perhaps best
phrased as: is the problem that kgdb *misinterprets* panic_timeout or is
the problem that Doug wants to *override* panic_timeout?

I think the answer to this question is the later meaning I'm interested
in what happens if you introduce a CONFIG_PANIC_TIMEOUT_FORCE (c.f.
CONFIG_CMDLINE_FORCE) to prevent the userspace changing the
panic_timeout (either by avoiding registering the panic sysctl or, if
that is a huge ABI problem attaching it to a different variable).

TBH I'm not sure if such a patch would be accepted but I think it makes
more semantic sense! 

(there is a small review comment below but the above is more important)


> ---
> 
>  kernel/debug/debug_core.c |  5 +++--
>  lib/Kconfig.kgdb          | 10 ++++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 65c0f1363788..d4a38543fcdd 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -703,7 +703,8 @@ kgdb_handle_exception(int evector, int signo, int ecode, struct pt_regs *regs)
>  	 * reboot on panic. We don't want to get stuck waiting for input
>  	 * on such systems, especially if its "just" an oops.
>  	 */
> -	if (signo != SIGTRAP && panic_timeout)
> +	if (!IS_ENABLED(CONFIG_KGDB_ALWAYS_ENTER_ON_PANIC) &&
> +	    signo != SIGTRAP && panic_timeout)

This code path is called via notify_die() rather than a panic().


Daniel.

>  		return 1;
>  
>  	memset(ks, 0, sizeof(struct kgdb_state));
> @@ -843,7 +844,7 @@ static int kgdb_panic_event(struct notifier_block *self,
>  	 * panic_timeout indicates the system should automatically
>  	 * reboot on panic.
>  	 */
> -	if (panic_timeout)
> +	if (!IS_ENABLED(CONFIG_KGDB_ALWAYS_ENTER_ON_PANIC) && panic_timeout)
>  		return NOTIFY_DONE;
>  
>  	if (dbg_kdb_mode)
> diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
> index ab4ff0eea776..f12c6e1394c6 100644
> --- a/lib/Kconfig.kgdb
> +++ b/lib/Kconfig.kgdb
> @@ -67,6 +67,16 @@ config KGDB_LOW_LEVEL_TRAP
>           exception handler which will allow kgdb to step through a
>           notify handler.
>  
> +config KGDB_ALWAYS_ENTER_ON_PANIC
> +       bool "KGDB: Enter kgdb on panic even if reboot specified"
> +       default n
> +       help
> +         If kgdb is enabled and the system is configured to reboot on
> +         panic then there's a question of whether we should drop into
> +         kgdb on panic or whether we should reboot on panic.  If you
> +         say yes here then we'll enter kgdb.  If you say no here then
> +         we'll reboot.
> +
>  config KGDB_KDB
>  	bool "KGDB_KDB: include kdb frontend for kgdb"
>  	default n
> -- 
> 2.20.0.rc2.403.gdbc3b29805-goog
> 
