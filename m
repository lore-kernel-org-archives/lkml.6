Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A919C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E378E20664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WZmxVeoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E378E20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeK0Cpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:45:44 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:20436 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeK0Cpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:45:44 -0500
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wAQFp9si022767;
        Tue, 27 Nov 2018 00:51:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wAQFp9si022767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543247470;
        bh=AXrhHwipHRWk/uap1KGeKLx2+numImCbBmKA1MIby+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WZmxVeozajryrWIf3LMhhHoKsFA0HW3UXLIhp7Mz93H+XfZHSMzaBuPGdOHmkAiV2
         xpU+q/mMvG510XuHojteof60Vzdb4nCvq58ygJ0bh5vG20Kc1aO4/C42uSE2CvPOG6
         noMqXdZSG0aDx/GrgK9LJy/VyN/K6/jI6zVht3iURANV0fwFbGbZnbj7/s+1I2/+7i
         uaFoB0rP97aYu03bMJpY/n/j9ZvPZVDq3HthSUUMFXsr+Uvpml9F3ghQCp2tnUS8UZ
         B2fBVC8nRxwKBO+nfyh0Bg8QV26vfpw0ADAxQlT0BtFDfBFlJKSh0IEIkRFtPQ2m30
         7nIGaLPAQZsUQ==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id h128so4262124vkg.11;
        Mon, 26 Nov 2018 07:51:10 -0800 (PST)
X-Gm-Message-State: AA+aEWbmCrJuM0YdUE0+/SKYJqVCPPiaS2qnvzdIbtIBAZk9HPy5988b
        GMkjadRnWEc1zK0EADGM0uNElMC0X0grVvUxick=
X-Google-Smtp-Source: AFSGD/VX3O38ZjWE/636iI3IuancZauJnAWOG/WqBmnglrVNquyylM2JQjDVT6S7OoFaGA+PBiTxPQPw+1Bcn9m9w5I=
X-Received: by 2002:a1f:fcc3:: with SMTP id a186mr11613916vki.0.1543247468658;
 Mon, 26 Nov 2018 07:51:08 -0800 (PST)
MIME-Version: 1.0
References: <1539945019-24950-1-git-send-email-yamada.masahiro@socionext.com> <1539945019-24950-3-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1539945019-24950-3-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 27 Nov 2018 00:50:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ9D2V1bYJxuiuCAOW2yfXrqbHSfODyVTkj4oaW4CzSaA@mail.gmail.com>
Message-ID: <CAK7LNAQ9D2V1bYJxuiuCAOW2yfXrqbHSfODyVTkj4oaW4CzSaA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: uniphier: move cache-uniphier.txt to
 vendor directory
To:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 7:33 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Now, the Socionext vendor directory is available at
> Documentation/devicetree/bindings/arm/socionext/
>
> Move cache-uniphier.txt over to it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to linux-uniphier.



> Changes in v3: None
> Changes in v2:
>   - New patch
>
>  .../devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt    | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt (100%)
>
> diff --git a/Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt b/Documentation/devicetree/bindings/arm/socionext/cache-uniphier.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt
> rename to Documentation/devicetree/bindings/arm/socionext/cache-uniphier.txt
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
