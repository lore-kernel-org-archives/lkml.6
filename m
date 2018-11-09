Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372B1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2CE20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHwfvC4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2CE20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeKJELd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:11:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41607 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJELd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:11:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so1187444pgh.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 10:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oO+HpkLidr/CeyCYN5af7zvbZoEkI1LAH8/hbiIoRMM=;
        b=EHwfvC4pP8WkPe68hfbEAlVnco5DhCMjbh+GSZdeTxVtAZow7aqK1QlpCWf+RMiA0r
         UmwFD9sxQHOA5xxQYZxl4xlAgdH5gMb3Igyg8TlrMuW8GJV/5+BXDMAzWK0cojjDnOGB
         QnY/OB6V42G+e2b1TfFGdl7XafFOssUJj7rhArVct5Mh9tWqoVdFXuWVTiRus+5ZKa9Q
         ADyddMBbA2IOqpVTkJhWCMx1RQwEYD2hiLp3SiYyymNj6Sk+bNhhHgpPcclvuMFWil3l
         QvP0Mm6GgXKaVFZv6JFsZvubzCxB2BYhsIaYsGPue2VmG/OYbWTXN1ynRwpYzYXOPdYn
         L09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oO+HpkLidr/CeyCYN5af7zvbZoEkI1LAH8/hbiIoRMM=;
        b=dTWwevyW+N4km/t+j2hbDQYuXoV1C0hCPizDDf1dq6GhQTVw1so/2WcgTN/9lBTDDp
         zQdNNQO66BXP+ge20K05KAVjNR+YG91XEQ23dHMvpsX/nwrWoAMzh79qZ5EpAG0qXfLK
         MtYF6twwJIRavSM2FOCffKVMkimT0+J9G3mcb6GrDfno99t5R1NawtQoWG4NXcZ+X7bT
         1WzznaMctjbyuOeJmey50lBZ97Em9x5gtC2825CJETFyjDjz/gmFzz0MZkGIw6UuQWPE
         NUIKcFp2Gjtyg0zEceglUxbhgVF/9SM9WfYrOu9Nh7dQ/s0V35ez1ar9jt5hzYFsA2A5
         tR1A==
X-Gm-Message-State: AGRZ1gKd+CKFtAZlGdEG6wmKQHUxF8lXsyqr67fuzAGAzTtfAi/mEztq
        cEBDUnPvid72OeY7KKweCaGDynAR/WefcE+he7y8ww==
X-Google-Smtp-Source: AJdET5fwVRo+ONH8SN2tKhWFTUuEhLBx/GtTiqw6NU31rCHI1fKcO2geN6e0Lgx5d4PhmdX/qIhsel1HxbvbkC36A1I=
X-Received: by 2002:a62:1095:: with SMTP id 21-v6mr9933616pfq.227.1541788186599;
 Fri, 09 Nov 2018 10:29:46 -0800 (PST)
MIME-Version: 1.0
References: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com> <1541473495-25262-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1541473495-25262-2-git-send-email-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 9 Nov 2018 10:29:35 -0800
Message-ID: <CAKwvOd=JwjVu=uk3egVJxTm9vPcF=Jx2Bexx1Wx=Z-PC38X3Uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: consolidate Clang compiler flags
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Matthias Kaehlcke <mka@chromium.org>, joel@jms.id.au,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Hackmann <ghackmann@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 7:05 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Collect basic Clang options such as --target, --prefix, --gcc-toolchain,
> -no-integrated-as into a single variable CLANG_FLAGS so that it can be
> easily reused in other parts of Makefile.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>  - Use := flavor instead of = because $(CLANG_FLAGS) is expanded soon anyway
>
>  Makefile | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index da11700..e173a73 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -487,18 +487,17 @@ endif
>
>  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
>  ifneq ($(CROSS_COMPILE),)
> -CLANG_TARGET   := --target=$(notdir $(CROSS_COMPILE:%-=%))
> +CLANG_FLAGS    := --target=$(notdir $(CROSS_COMPILE:%-=%))
>  GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
> -CLANG_PREFIX   := --prefix=$(GCC_TOOLCHAIN_DIR)
> +CLANG_FLAGS    += --prefix=$(GCC_TOOLCHAIN_DIR)
>  GCC_TOOLCHAIN  := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>  endif
>  ifneq ($(GCC_TOOLCHAIN),)
> -CLANG_GCC_TC   := --gcc-toolchain=$(GCC_TOOLCHAIN)
> +CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> -KBUILD_CFLAGS += -no-integrated-as
> -KBUILD_AFLAGS += -no-integrated-as
> +CLANG_FLAGS    += -no-integrated-as
> +KBUILD_CFLAGS  += $(CLANG_FLAGS)
> +KBUILD_AFLAGS  += $(CLANG_FLAGS)
>  endif
>
>  RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
> --
> 2.7.4
>

Thanks for this patch, Masahiro, it's a good simplification.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Would you mind waiting for a tested-by from Stefan, and maybe an ack
from Greg (added to cc)?
-- 
Thanks,
~Nick Desaulniers
