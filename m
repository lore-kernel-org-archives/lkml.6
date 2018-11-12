Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F169C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B82122419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPH7BNza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B82122419
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbeKMEuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:50:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40371 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeKMEuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:50:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so4463613pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 10:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7zJOfAchvRNktzeAWQkae2R/fEUK7VwwkzZ8LQ4i/E=;
        b=dPH7BNzaoiRjfH6sTPW5q8GWsRlrsp4wuWUspJF3mphlpQ5Qk4GApMJM3HthT7iRld
         qJWWhjqxPkC6uG9FQF3My1wxYSUU/l+WvlJUI5CncULx1aEIx4vhCs62XnhUrDj8aFMW
         IVtPfpQXe0bSrxT6/4crKHJJOAlq8oYS4pTOfHcgE+FWMd+vzyESiNQrCLttKTd4elaO
         pRqa0ILAAp7BISlhydp50AVOHhp552eXAlGIVWWoTvS5G5Oj8rw2Cmkc0WIepPEGgkkw
         7QUEFdvFoerVXN3eBIfNf6RQCrpwPv9meYDVWQKUCi/kW3Mduebuh1LI2Ukqnczmk0G/
         Apkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7zJOfAchvRNktzeAWQkae2R/fEUK7VwwkzZ8LQ4i/E=;
        b=LCuQqrS93eM5axfeoU9q+po/LD3QUjfGFv9aBflVKV9T9D7CNRpC6lXEUCn2S8pT/V
         N/DgxXLwpIBE5J6hi6dr4y74zy+LiRHlvmD/LJaYlOCboDDAkUSZgLNRa8ZJHeChdnOo
         iOaDmR/NuxppUEYs3l/leJ+AA39nyEIDfvDhsbJRbZWl7gcFxaqFIBawiOqWuZ4fotXZ
         Wzd9VxeYuTBwbXEw/0hZdIlAagniCiQTfhkZHwHR/A8qWqrvww5ioTd0OlyqmXTQOwAu
         1NMJ/fUGfAi4tFQl5q8cJ0aggJyah7PJueO/bodyKYM0CaAwAgypky++0h/KBsZkQ5/a
         4IqQ==
X-Gm-Message-State: AGRZ1gJebRTBu0+zBK/54ZnXyFHvVlj+CZ4+cSkW8ySKPMi9oy593I/J
        NHw5uK1HIeV4FxHQd0+snDO0+TIlTW2ksJwrP/kIrw==
X-Google-Smtp-Source: AJdET5dlj72dkILax3Mhs9zY8pCeVi8qBTCkLko0bMkImG68ygOgCEWX7t0ijeuZ3n/XDrVC395qAdiE5xFknc6TkKc=
X-Received: by 2002:a63:42c1:: with SMTP id p184mr1809818pga.202.1542048964587;
 Mon, 12 Nov 2018 10:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20181112042116.5271-1-joel@jms.id.au> <20181112042116.5271-2-joel@jms.id.au>
In-Reply-To: <20181112042116.5271-2-joel@jms.id.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Nov 2018 10:55:53 -0800
Message-ID: <CAKwvOdnBMFYXvS+GH0cUiczgkpLWtBinPRjkTJBQGrKjxktUUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Makefile: Export clang toolchain variables
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
> The powerpc makefile will use these in it's boot wrapper.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 09278330282d..840efe6eb54c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -495,6 +495,7 @@ endif
>  ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> +export CLANG_FLAGS
>  CLANG_FLAGS    += -no-integrated-as

Does this export CLANG_FLAGS before `-no-integrated-as` is set?
Either way, I think it would be clearer to export this after all the
relevant flags are set.

>  KBUILD_CFLAGS  += $(CLANG_FLAGS)
>  KBUILD_AFLAGS  += $(CLANG_FLAGS)
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
