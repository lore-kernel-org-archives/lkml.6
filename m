Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286F1C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9D2208D9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jjjq6F7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9D2208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeJCDzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:55:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46854 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbeJCDzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:55:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id a5-v6so499942pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1TXJmn4VcIkO3+plPMMzh9LGP6R7lFmEHBEzdI0PW8=;
        b=Jjjq6F7yoFhDRuOPLwWClPLNmxbRcs+4uiir/gotHoKMmnmLK8esa8i7EpasSL4ctC
         FxF0S80PP5Ltb9nx023/rvdj6RomDfJ912A8m6PwZDJ+16IYHCA7x8XGjtnmdXriq24f
         bMoesH6pu+OvaBfA3P3dNoFuLyVISdhPm8VPfJMdFmKgzvsd7tQU1Qcai4TD1EKSVKBZ
         5Vp+0EO4+I8285scei3vy+fnuI93Hs/ZaEDEU94DcBBa3vfveVg1hwbfJeLrPdfacvLw
         ktjIQsNGjADWwo0Yhbo1gnk7z1/WWDQpDRX1vFRFSoxrTh5Q1QS4niuKG+cAg3UPGnM9
         SI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1TXJmn4VcIkO3+plPMMzh9LGP6R7lFmEHBEzdI0PW8=;
        b=RNANXf0Wmu+pE2j95+fNVB8xFKUjY/bl2DF7+18Nx+RdkQSu7h6klhOXJvHeyXCVlU
         9wvcBMvZU9uvDRajZguCzCETJchFiKC1oXtuENy066vDcdvWaDHmxo0BV3GQ86yRDJBm
         wo77/7gprycuLAAot96iLTtGCRyzieJn+YSli41pBMsbtNySquptML/jC3RUZOU6UuKx
         ecMdU6UkJ2sJvVnBBNQVT+2QcjuRlLrbf89N/otL8PvKXaLjo/YL6ZkK6ctWqCbQF/kI
         pY7hho8nySA89DxrFCiCuO7FOBYT27cpo1n53g2nZMoWD0ujvCMBeXtFNdyUn3IT6zDc
         kkEA==
X-Gm-Message-State: ABuFfoj8pehmQrnVOL5YLtRWSpRWpBg9+XTU+nHc3JFpK5zFJn6uBrI2
        GaommM/higitcKRQNMxyALnUylbFRLFmu/FDNCEiZw==
X-Google-Smtp-Source: ACcGV63+WRKc0uf/EKkP3hDXGBxaiN5Sv9EgYwtErWFftf/GugkyfkSy+moXYT+vgZMiUxTi956qAYc3bk76NpAx4DA=
X-Received: by 2002:a63:a047:: with SMTP id u7-v6mr16207928pgn.145.1538514624493;
 Tue, 02 Oct 2018 14:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <1538443943-29805-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1538443943-29805-1-git-send-email-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Oct 2018 14:10:13 -0700
Message-ID: <CAKwvOdmUYu3Hqs1NQru8U3U8ATNc3_TT1o37tSJGzAsScRQnYg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: add -Wno-unused-but-set-variable flag unconditionally
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 6:33 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> We have raised the compiler requirement from time to time.
> With commit cafa0010cd51 ("Raise the minimum required gcc version
> to 4.6"), the minimum for GCC is 4.6 now.
>
> This flag was added by GCC 4.6, and it is recognized by ICC as well.
>
> It is true that Clang does not support this flag but this commit is
> just touching the else part of the "ifeq ($(cc-name),clang)" check.
> Hence, Clang build is not affected.
>
> Let's rip off the cc-disable-warning switch, and see if somebody
> complains about it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - Fix commit log

Mashiro, thank you for this fix.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 8a23fee..2627266 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -716,7 +716,7 @@ else
>
>  # These warnings generated too much noise in a regular build.
>  # Use make W=1 to enable them (see scripts/Makefile.extrawarn)
> -KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
> +KBUILD_CFLAGS += -Wno-unused-but-set-variable
>  endif
>
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
