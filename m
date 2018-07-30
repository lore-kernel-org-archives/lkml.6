Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12077C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55F0208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r50aQGiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55F0208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbeG3UqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:46:15 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34362 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731355AbeG3UqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:46:14 -0400
Received: by mail-yb0-f195.google.com with SMTP id e9-v6so5191835ybq.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 12:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lZSgVZhDw2wx+9kimYDnh1Fll64NkObCs/TKpkm2f0c=;
        b=r50aQGiu0eI/I0wQmPZGocp/IqnfGyRMYJbSxfiWkcWSc0ClXygSBzSuzfdkcFuFrD
         hJxfH+JL0gg966CoI0iclKspCGAem/08KPCekaSpWWRr/5PeGcKM6WawUeyfKwnujB89
         LL3dcazCVkR7Yb5Ogjdsn+u7YP3Rw1R3ga5VIUbe2wxDCE6yOuyD+CM81tW3pHtDVLiw
         haJ6QYlFqJ/T/uxUpMT2AbqVcCtXpVLXvNZr3B2tVGP9dZqip1851OQXLyK483/4G7Wv
         5HT3/lx3CudxIm54k3e1xug2pKTy8YIfvw7mmmSAyINoysr12qkmuxrAK/mtbmZm6bnz
         zeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lZSgVZhDw2wx+9kimYDnh1Fll64NkObCs/TKpkm2f0c=;
        b=JCQoxK05xM9cfjoq/D53Q/zHv0S/Ro0NJ26Mlep1IuAbHrUOCTSTNdB1UD5XTzZ6Vd
         /qKTly7YbBr2sheSUlGbUIQjY4E5NmJ+JPELWKkleSQsUrNsuMvDISed1jbP+Hs6JAKG
         prxDZ4k7MvCkC7/xwwjAHP9ijRVPUqps/9fFw0LJOF6grcILK+NaksEpJEdidPJBGlP0
         a9AArmAjAwGr5MmRi1O3k/koAu3xQbihFZsc1CH5V8OUQ/wSx7tmtLUZVUAWscNlHpei
         +l3EqRX8KGkbKRsGY550V36kHM+eC/lP18YohOEngDKxUHgkbiTaLGz+R1OEcmVP/icu
         xpvQ==
X-Gm-Message-State: AOUpUlGiVx5AH640JKqHILLPklyMMZVjXmf7wdk3KZ9XF9OS7Hi/G78J
        SRGUSfUcqQiRBacEKUHYcQmB2wvNYDfGzbtwqEBqRw==
X-Google-Smtp-Source: AAOMgpdB6bzRVx3SFwcsY8DY8BExe80Q9H01oaxb4TMTGCXlIi8H7P9awBcWGU6niaIvbgwogcQopmAoG9Mw0vLZvvk=
X-Received: by 2002:a25:b219:: with SMTP id i25-v6mr10447882ybj.112.1532977790451;
 Mon, 30 Jul 2018 12:09:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 12:09:49
 -0700 (PDT)
In-Reply-To: <20180730183118.25869-1-labbott@redhat.com>
References: <20180730163722.GD4276@arm.com> <20180730183118.25869-1-labbott@redhat.com>
From:   Kees Cook <keescook@google.com>
Date:   Mon, 30 Jul 2018 12:09:49 -0700
Message-ID: <CAGXu5j+iuCig4jYY-89nBFB8ZPxu932B5kfkqMCXse9MVxE-mA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Only disable stackleak plugin for arm64
To:     Laura Abbott <labbott@redhat.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:31 AM, Laura Abbott <labbott@redhat.com> wrote:
> arm64 uses the full KBUILD_CFLAGS for building libstub as opposed
> to x86 which doesn't. This means that x86 doesn't pick up
> the gcc-plugins. We need to disable the stackleak plugin but
> doing this unconditionally breaks x86 build since it doesn't
> have any plugins. Switch to disabling the stackleak plugin for
> arm64 only.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

> ---
>  drivers/firmware/efi/libstub/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 25dd2a14560d..88c322d7c71e 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -11,7 +11,10 @@ cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ -O2 \
>                                    -fPIC -fno-strict-aliasing -mno-red-zone \
>                                    -mno-mmx -mno-sse -fshort-wchar
>
> -cflags-$(CONFIG_ARM64)         := $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
> +# arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
> +# disable the stackleak plugin
> +cflags-$(CONFIG_ARM64)         := $(subst -pg,,$(KBUILD_CFLAGS)) -fpie \
> +                                  $(DISABLE_STACKLEAK_PLUGIN)
>  cflags-$(CONFIG_ARM)           := $(subst -pg,,$(KBUILD_CFLAGS)) \
>                                    -fno-builtin -fpic -mno-single-pic-base
>
> @@ -21,7 +24,6 @@ KBUILD_CFLAGS                 := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>                                    -D__NO_FORTIFY \
>                                    $(call cc-option,-ffreestanding) \
>                                    $(call cc-option,-fno-stack-protector) \
> -                                  $(DISABLE_STACKLEAK_PLUGIN)
>
>  GCOV_PROFILE                   := n
>  KASAN_SANITIZE                 := n
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
