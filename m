Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B832C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78E220870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+JJtphM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78E220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbeG2Wr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:47:59 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37961 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbeG2Wr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:47:58 -0400
Received: by mail-it0-f66.google.com with SMTP id v71-v6so14203203itb.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=579M2nR2uE01uou3cUiXxSFzPvDN4DE1kG5Gnl1VGvE=;
        b=G+JJtphMDewMloF32/Ks9eyrNcgkJ+BR76yJYqtv3iHdu4tn9K/snH49kD/0cmxUE/
         t8xTcafop7ku+ssIBf91HmFY6kxPezwRWzHR4cJ1M0dUSMtLNkPbvrNcwgi20DyN00Sl
         gBMukgr7GFl16RJ41lIp9b9ovtp27WQvtzBo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=579M2nR2uE01uou3cUiXxSFzPvDN4DE1kG5Gnl1VGvE=;
        b=qcW9d/KFI8t93SjR0tnJ4Ilp71C3DRXDFqSABQezUG2fACAPurzah/VNNoTkIRTR1z
         7s16Sh4upzyyJYHqKCBWDgUfXcyHePlRXcAdBtq0EhRE1L7tLyhhW1dRQU37f52bTcpS
         qrQWqOSP//+2wZ9pCdVrVNxY+216pug4vxi2+Bro3IiGU4WemlwEU8iajgf0Yx7vRa3c
         pDPgWUBeTKE7Dt9pE3nN4cXhmuAxyGhXX7eOubmu5z4XzqR8Ke4t+M7Gmr22dV8MmifG
         n7KMJLh8g5Dl4HxcvzhhaJuSyc9uqAtjqOgl6DNmlU5iE+kZgnAT1P8yPAvEREqMrqQv
         PiUg==
X-Gm-Message-State: AOUpUlG1Uh7+GiHnRA7jfVRrC0xDpwcKmLKy6oW/qbfEB1VD6hjHdhrz
        n68sOEDGCUNauaDF/UvosOyiSANnncmgcgbxwMVRbg==
X-Google-Smtp-Source: AAOMgped3btkCchN1CwAu6zICPHOI5uimvl6M3CzE+MGmHMIF7WCHSicW0P/bVI75WprmFQj/d1MaQ31DMpnknibdoo=
X-Received: by 2002:a24:7503:: with SMTP id y3-v6mr12187577itc.70.1532898966404;
 Sun, 29 Jul 2018 14:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180724115722.1274065-1-arnd@arndb.de>
In-Reply-To: <20180724115722.1274065-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 23:15:54 +0200
Message-ID: <CACRpkdYHhS7sPY6RqMNUSZ+otnoGPkBVgcfT20B-jscemnmotQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: include chained_irq.h header
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 1:57 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Some randconfig builds fail in the mtk-eint driver:
>
> drivers/pinctrl/mediatek/mtk-eint.c: In function 'mtk_eint_irq_handler':
> drivers/pinctrl/mediatek/mtk-eint.c:324:2: error: implicit declaration of function 'chained_irq_enter'; did you mean 'rcu_irq_enter'? [-Werror=implicit-function-declaration]
>   chained_irq_enter(chip, desc);
>   ^~~~~~~~~~~~~~~~~
>   rcu_irq_enter
> drivers/pinctrl/mediatek/mtk-eint.c:367:2: error: implicit declaration of function 'chained_irq_exit'; did you mean 'rcu_irq_exit'? [-Werror=implicit-function-declaration]
>
> The functions are declared in linux/irqchip/chained_irq.h, and including
> that header makes it build in all configurations.
>
> Fixes: e46df235b4e6 ("pinctrl: mediatek: refactor EINT related code for all MediaTek pinctrl can fit")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied!

Thanks Arnd!

Yours,
Linus Walleij
