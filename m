Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9586FC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD422082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xD//XRnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD422082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeJ2Vw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:52:56 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:51980 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJ2Vwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:52:54 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w9TD4Fvx011893;
        Mon, 29 Oct 2018 22:04:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w9TD4Fvx011893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540818256;
        bh=t/8A7yVZQ2O0p60HD19rRpcS1YNmjufORWnIox32jrI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xD//XRnNhmPvMcoA7EzyRH/UxSw1KgV+Sp83myrXiThaOpyTDVtVAS+XN/E0FbbIZ
         53YVOsjgQzqX6Z8wDNaDiMkmvrMUvT1Y3ApC+uEO0rIyMx4nuDbxN20UB+xWBCmL59
         KwFLdmLcUm52PDEDH3Qh8dhq77LsLwRI/HxLYu3YFId4zp9NKpEsGS068h79WBh5Ur
         Ha21kOmkfMVjhsp7akIGJ1hiCySB9ZBc07i3bVbOGzXMYazPE/JuUxHMGHFquL5517
         QyhOnakomnBqghb17cweedE/DLJuH6fBs2ynXjN5idyJWGOjzOmDeyA0JFRprxUz9V
         hCO6/29Nj2iDA==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id v205so2524105vsc.3;
        Mon, 29 Oct 2018 06:04:16 -0700 (PDT)
X-Gm-Message-State: AGRZ1gImZLQ5G28YoSr7LEueFdjG2t9i3yC/o4psMWTdBaESEjpkCcQA
        /TrjCf6F29UUMrmWMYjdTamHgXu4SoCFxyvoftg=
X-Google-Smtp-Source: AJdET5db04YEM52vF6jvjKhAx5P4AnIzgRjmeFcGdL8OUewoJvEnevdVmFJPiycyfHUXFJG4eVL5E0XU6SN2oWJI7EY=
X-Received: by 2002:a67:385a:: with SMTP id f87mr5992449vsa.179.1540818255048;
 Mon, 29 Oct 2018 06:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181028130945.23581-1-changbin.du@gmail.com> <20181028130945.23581-3-changbin.du@gmail.com>
In-Reply-To: <20181028130945.23581-3-changbin.du@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 29 Oct 2018 22:03:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNASiGPar_Aj1KDu8E+S=NKRf7mEJ8gwe2=OMUGggZmtfNQ@mail.gmail.com>
Message-ID: <CAK7LNASiGPar_Aj1KDu8E+S=NKRf7mEJ8gwe2=OMUGggZmtfNQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 10:13 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting


I fixed "This patch add ..." to "This patch adds ..."
then applied to linux-kbuild.




> this option will prevent the compiler from optimizing the kernel by
> auto-inlining functions not marked with the inline keyword.
>
> With this option, only functions explicitly marked with "inline" will
> be inlined. This will allow the function tracer to trace more functions
> because it only traces functions that the compiler has not inlined.
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  Makefile          |  6 ++++++
>  lib/Kconfig.debug | 17 +++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 7d4ba5196010..04beb822ddfc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -749,6 +749,12 @@ KBUILD_CFLAGS      += $(call cc-option, -femit-struct-debug-baseonly) \
>                    $(call cc-option,-fno-var-tracking)
>  endif
>
> +ifdef CONFIG_NO_AUTO_INLINE
> +KBUILD_CFLAGS   += $(call cc-option, -fno-inline-functions) \
> +                  $(call cc-option, -fno-inline-small-functions) \
> +                  $(call cc-option, -fno-inline-functions-called-once)
> +endif
> +
>  ifdef CONFIG_FUNCTION_TRACER
>  ifdef CONFIG_FTRACE_MCOUNT_RECORD
>    # gcc 5 supports generating the mcount tables directly
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 04adfc3b185e..d50711b41dad 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -211,6 +211,23 @@ config GDB_SCRIPTS
>           instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
>           for further details.
>
> +config NO_AUTO_INLINE
> +       bool "Disable compiler auto-inline optimizations"
> +       help
> +         This will prevent the compiler from optimizing the kernel by
> +         auto-inlining functions not marked with the inline keyword.
> +         With this option, only functions explicitly marked with
> +         "inline" will be inlined. This will allow the function tracer
> +         to trace more functions because it only traces functions that
> +         the compiler has not inlined.
> +
> +         Enabling this function can help debugging a kernel if using
> +         the function tracer. But it can also change how the kernel
> +         works, because inlining functions may change the timing,
> +         which could make it difficult while debugging race conditions.
> +
> +         If unsure, select N.
> +
>  config ENABLE_MUST_CHECK
>         bool "Enable __must_check logic"
>         default y
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
