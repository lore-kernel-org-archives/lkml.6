Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B42EC32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C77F20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nVifOrga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C77F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeKEMKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 07:10:50 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:24744 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKEMKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 07:10:49 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wA52rIH4030771;
        Mon, 5 Nov 2018 11:53:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wA52rIH4030771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541386399;
        bh=7mMub48cGUd9y2ecHB+M9RPzNI5RzJ+jK2O4TfhTw2M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nVifOrga/iaq7YCj52vp1WJPNkDonv8proPF0F6b6eZYJYDTsR1nOoLDMlP9IlG8d
         k74Vu1dikZm2NSCWsWTSL8sjB0AWwiJTpe6jgS59IEJPw4pmYlFG86DVaGiSaLxlu+
         WQumod5WKFUilb+twBlu95UpJO6TbN1/9pf3GPyc63ElJ0idLFz2GoNpdnR3wwH/Ui
         FzUtPNrH4C3hBc6qEKsDFjjNioKQ4RlLP9WsdpUS0/EDI9G7sP8qwWWnHDhdeMVYo2
         XL7VxongXGKhG62nnYnDFjgcvZ6JITaKJGEQzPSvcBvM2npabK9j1+tP2BOND+wqud
         eaantQMyYotnw==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id k14so4230168vsm.10;
        Sun, 04 Nov 2018 18:53:19 -0800 (PST)
X-Gm-Message-State: AGRZ1gK0BfGBgWWHaM7JbXD0LgG6wFaOjwriHAN8y+4wlDmFh0Pr48h/
        DQBfSKgu+3f0OB1Ego3om3j3VlJdpXPH3Edy/58=
X-Google-Smtp-Source: AJdET5e3ukfcttIa4hIqRgUCmYlNLBflocbnY5cM6KGo7Y9JCer3ywPS50uPO9NeLDVAulCGn0hSiXo68ll2OWYJ5jk=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr8724909vsb.155.1541386398029;
 Sun, 04 Nov 2018 18:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20181104231133.30848-1-joel@jms.id.au> <20181104231133.30848-2-joel@jms.id.au>
In-Reply-To: <20181104231133.30848-2-joel@jms.id.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 5 Nov 2018 11:52:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNASeoiNa0Z08KCVhS_nzLEcKE9G6=d_m-dQbX1oep3UPtQ@mail.gmail.com>
Message-ID: <CAK7LNASeoiNa0Z08KCVhS_nzLEcKE9G6=d_m-dQbX1oep3UPtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Makefile: Export clang toolchain variables
To:     Joel Stanley <joel@jms.id.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,


On Mon, Nov 5, 2018 at 9:53 AM Joel Stanley <joel@jms.id.au> wrote:
>
> The powerpc makefile will use these in it's boot wrapper.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 9aa352b38815..a2db3c885b38 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -495,6 +495,9 @@ endif
>  ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_GCC_TC   := --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> +export CLANG_TARGET
> +export CLANG_GCC_TC
> +export CLANG_PREFIX
>  KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>  KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>  KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
> --
> 2.19.1
>


Before exporting these compiler flags,
I'd like to do a cleanup work.


Could you take a look at my patch, please?

https://patchwork.kernel.org/patch/10667369/


By using it as a prerequisite,
your patch set will be more simplified.


-- 
Best Regards
Masahiro Yamada
