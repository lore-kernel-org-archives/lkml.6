Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B427C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7452081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+V/DVKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7452081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeKCCmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:42:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40817 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCCmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:42:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id g21-v6so1334817pfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 10:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W5cpov5BUBzUk05UG86XRpq/4qB8M3Cgo8tsQRLRHzI=;
        b=B+V/DVKzBFgI/iaBjPgFGYEahDPwrCF8G6iKlIXoDDyoEf5uFJGomwv2ycltuvSdXg
         ID3XjWRKO56PW4AoQudq+a1S+8a9LQ4Iv8+xCYjC5D8ELYEoOZpey/Rfm8MTzpKb2FwB
         dmJk1ih4+Xy89imU7rllOYbpG4pzhy1OEObE8tZdv/FLPNaDa4wGPAp3/FH/OihJrOI8
         9lFGFjYbKC7qhOTE5Z516hpr+yb75N/ABON/wfxJnn39O//WTOzWJoS/2zmYduCVX1Oe
         j8w6SBH/y3TH7iesrdY9byi0G7aazEtjiIwes8MQbNVmSFacXnCcXcwZHLBXOFx71p2p
         MZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W5cpov5BUBzUk05UG86XRpq/4qB8M3Cgo8tsQRLRHzI=;
        b=oe49jED09I2xJIbHmi2x8QHr2shLFRwWiNTGBDk5PFUG0CZMxvyIl/YSj54TwRoYpy
         f+/OQCPnRM8v4UOgoWotGBVmOy7hOjMGnIcqrPZOM0Bg6PrhJLW7QxUCQmLvjhfKJBq1
         sJHqBLYqEsCLl6gyQDkAKZYByIMePVdWywgyUsfEbDUeBlLuh1rkogQYTOh7bqxXUfXz
         nI2fRNfSYWSRbXoROq2xXkm5en0oFouK9TRAuEh2ZAB7IDaiNhv14Jg+cDSO0falajGx
         gBfGHn7HR/SzmZdzgwhya2nJk9itYEJdegsRT8fsxmwtMrwj9vexxw772AjX39ig+cdR
         MyKA==
X-Gm-Message-State: AGRZ1gJSfIuXsSis8gWgqsp1bz0V/Gd8e+14jMFmeUsbaapryBsUYsdX
        /pjC+nogfbRwj6q6pVlhMx/wNpZ9FU3L3oB0nRGCXw==
X-Google-Smtp-Source: AJdET5e8mhIia7P6TY25XmjwcH1EZYCgIR2kvu1kTOuAVTmp0Q6K+ht8NlaSUkYffmST9kNZmYEqkb+Wt06HbYA/YUc=
X-Received: by 2002:a62:4b09:: with SMTP id y9-v6mr12626347pfa.93.1541180095479;
 Fri, 02 Nov 2018 10:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181102004455.10157-1-joel@jms.id.au>
In-Reply-To: <20181102004455.10157-1-joel@jms.id.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 2 Nov 2018 10:34:44 -0700
Message-ID: <CAKwvOdni_iJ4beAWYkUUpZss_PYZezMGR7hN9k1rm9J0iB0gHQ@mail.gmail.com>
Subject: Re: [PATCH v2] raid6/ppc: Fix build for clang
To:     joel@jms.id.au
Cc:     mpe@ellerman.id.au, LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>, jji@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 5:45 PM Joel Stanley <joel@jms.id.au> wrote:
>
> We cannot build these files with clang as it does not allow altivec
> instructions in assembly when -msoft-float is passed.
>
> Jinsong Ji <jji@us.ibm.com> wrote:
> > We currently disable Altivec/VSX support when enabling soft-float.  So
> > any usage of vector builtins will break.
> >
> > Enable Altivec/VSX with soft-float may need quite some clean up work, so
> > I guess this is currently a limitation.
> >
> > Removing -msoft-float will make it work (and we are lucky that no
> > floating point instructions will be generated as well).
>
> This is a workaround until the issue is resolved in clang.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=31177
> Link: https://github.com/ClangBuiltLinux/linux/issues/239
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2: fix typo in comment, thanks Jinsong
>
>  lib/raid6/Makefile | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> index 2f8b61dfd9b0..7ed43eaa02ef 100644
> --- a/lib/raid6/Makefile
> +++ b/lib/raid6/Makefile
> @@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
>
>  ifeq ($(CONFIG_ALTIVEC),y)
>  altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
> +
> +ifdef CONFIG_CC_IS_CLANG
> +# clang ppc port does not yet support -maltivec when -msoft-float is
> +# enabled. A future release of clang will resolve this
> +# https://bugs.llvm.org/show_bug.cgi?id=31177
> +CFLAGS_REMOVE_altivec1.o  += -msoft-float
> +CFLAGS_REMOVE_altivec2.o  += -msoft-float
> +CFLAGS_REMOVE_altivec4.o  += -msoft-float
> +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> +CFLAGS_REMOVE_vpermxor1.o += -msoft-float
> +CFLAGS_REMOVE_vpermxor2.o += -msoft-float
> +CFLAGS_REMOVE_vpermxor4.o += -msoft-float
> +CFLAGS_REMOVE_vpermxor8.o += -msoft-float
> +endif

Hi Joel, thanks for this patch!  My same thoughts about
CONFIG_CC_IS_CLANG vs cc-option from
https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/180939.html
apply here as well.  I don't feel strongly about either though.  What
are your thoughts?

>  endif
>
>  # The GCC option -ffreestanding is required in order to compile code containing
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
