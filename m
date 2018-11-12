Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ABAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAEF22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5U0YE0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAEF22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbeKME5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:57:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42138 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeKME5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:57:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id x21-v6so2044375pln.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F73BoH0qM9ADBHcBiXopQvKF5rs7oS9TiYg6Gnm6VE8=;
        b=n5U0YE0KV5X+yt9XJiCTk2U2pc+3hYvhfkq8lnunAu8ulH1YrGg87MIhjiHReNBV1i
         SKvGtiUJukrKVvY1zvAncLqQvnGEWI+LwEFfUUU6O0Ari6jamMfNsTJRvE47ea8pjaqw
         PMTH16GXQjNST18Bky/yFIB3Tai6rtbIX5y25f2PHNyBqpzAzk5g3Nn5Mipq2CrvxxBW
         Cf1jnbddP66EHDsUTUp3edTYuqBtcZjOk+k/G78/uw3xOmixRPt2ZUyFj5ZF9xGjE9Ra
         zf6/+8ctNgKAPZI4fnCveo+rGnDU0aubRCL2yvnGtpz7kcPVdyKi95dy2+oBoELnd8Ed
         tdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F73BoH0qM9ADBHcBiXopQvKF5rs7oS9TiYg6Gnm6VE8=;
        b=FiuXlYraR6JYaEzRMHUOD2vIihuESeBI+VjDHe/NJBXp/xTMU3pCM399LZcFH3SrZV
         fqikeeEpGk5WMCvaFqjyjFhrEVDXVnXl6X2JN2mRKsHLkgX1KfXVrWyKIzqPl3AzY5Td
         uYUk5Rsziy83Z69gUSZXvVSGIooeBXZW+wqSmIVxuwAHAJCTC8eLZ4OYbl2+6Ij0uZdi
         YMarKCCeJnhjUH5wsJlNadBsgz3AgZCp6sbg+58C+LguzMv7IYjXua5gK+WIEFDDRKgq
         u91/Giyh2+CMhmX4A6dlHsVajMD5LWeYDZUolMD/OCMv1YLgZBySrnYSAIoQ/dAjuuHJ
         o7Iw==
X-Gm-Message-State: AGRZ1gLAeHiOnwf0J0cjViti7MCPk2EdfXbLHodkuQ9WNvmHvlaLUe4J
        lf6lWlcK1jUzlpxehyHIVwNJJZbySzq4zbkMPYXo5Q==
X-Google-Smtp-Source: AJdET5e4CNDXaQXU1S03LHDzBgpbuVHAM/bvtWP1Imul3RBJIrJunv87XDOcXGRt9Z9UlkV4DpudASr7swqN/ajQ/c8=
X-Received: by 2002:a17:902:5a2:: with SMTP id f31-v6mr2005249plf.320.1542049403085;
 Mon, 12 Nov 2018 11:03:23 -0800 (PST)
MIME-Version: 1.0
References: <20181112042116.5271-1-joel@jms.id.au> <20181112042116.5271-3-joel@jms.id.au>
In-Reply-To: <20181112042116.5271-3-joel@jms.id.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Nov 2018 11:03:11 -0800
Message-ID: <CAKwvOd=Sck9MMyq4sBe24iNbcVd=KX7enfxN=+Y7uvL-YrxHrg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/boot: Set target when cross-compiling for clang
To:     joel@jms.id.au
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        mpe@ellerman.id.au, Michal Marek <michal.lkml@markovi.net>,
        dja@axtens.net,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 8:21 PM Joel Stanley <joel@jms.id.au> wrote:
>
> Clang needs to be told which target it is building for when cross
> compiling.

Neat! This will help us for continuous integration.
https://github.com/ClangBuiltLinux/continuous-integration

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/259
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Assuming patch 1/2 gets fixed up (or is fine) and doesn't radically change:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/powerpc/boot/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 39354365f54a..111f97b1ccec 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -55,6 +55,11 @@ BOOTAFLAGS   := -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
>
>  BOOTARFLAGS    := -cr$(KBUILD_ARFLAGS)
>
> +ifdef CONFIG_CC_IS_CLANG
> +BOOTCFLAGS += $(CLANG_FLAGS)
> +BOOTAFLAGS += $(CLANG_FLAGS)
> +endif
> +
>  ifdef CONFIG_DEBUG_INFO
>  BOOTCFLAGS     += -g
>  endif
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
