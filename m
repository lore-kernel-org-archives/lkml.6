Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30B5C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688CF2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bl5Uz/oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688CF2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeI1NuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:50:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36660 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeI1NuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:50:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id a85-v6so3267989qkg.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Nijw2aHwQv8PU4BQQ4Gl3dziJr1LOgbV0erSMgWGY4=;
        b=bl5Uz/oqzj+KMX1zioUyg+OekSXYQX+WGKEgtPKTJuSrXKS5FAF/cUbahC7iE1W16D
         QmuW/+vZ0nl7gfiKiuz/sjLMQ6V3UOFx54IQ5h0w3BWPWIcmq/hKwdJpgEtUY1UaZglJ
         hsmcKRGw98rg0VukbVNyKMFwA4na8LFU8NbvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Nijw2aHwQv8PU4BQQ4Gl3dziJr1LOgbV0erSMgWGY4=;
        b=dYzGTWF+U5sJazvHUVnpIdfTLymDDEt9HC/Ra2iCVkuUdtRf1eV+fPfrzd0qQkZmo7
         4f81xMo20MSEQYqjRtzxshGoFT4lT3HK4n6H2cCTqiMgtkyo70bKProLtfhfZMd+50xi
         h12XDXCIRc+DgojeikfNktJ3S7vImW+2REnWu+7qrT5Xpa6KGK3IFvQhfR6s6XaI68+s
         MrC+yX+70CLeD+HOqWsfJJ8LPUdG87KCrWMX80EidemZzca6xf3FTseCaSQ/kaCGPpmL
         bwgYPWgbeu64bkA3fjwwame1citOUSdS2v6Lqoy1soJFWJkngWkUg4hyVdvEN+PSqHh3
         PjGg==
X-Gm-Message-State: ABuFfoi6wc7jsMPnKQXTIkqgBW83vaxotZ1m2WNqEAP9klp9muq3h+Tl
        XZUz8tIMReqyv9gtH7B1AyoLIJYfRpwB8iNLD3iTJRas
X-Google-Smtp-Source: ACcGV62+lTsY1VN14vRk6aFmEMJSL8HtL6CgVDzvMM6q1+r8bwOr7RIHKQJsoh30skksL3T9sMaKcIcpGCKldiEWL70=
X-Received: by 2002:a37:4150:: with SMTP id o77-v6mr10967953qka.78.1538119668359;
 Fri, 28 Sep 2018 00:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180926193818.2481220-1-arnd@arndb.de>
In-Reply-To: <20180926193818.2481220-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Sep 2018 09:27:36 +0200
Message-ID: <CACRpkdY-9VhNJdh2FtzRUiwZTUfKQ+KKM5cFA2LuCwhCC+Ao6Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: mark dummy helpers as 'static inline'
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

On Wed, Sep 26, 2018 at 9:38 PM Arnd Bergmann <arnd@arndb.de> wrote:

> mtk_eint_set_debounce and mtk_eint_find_irq are defined as stub functions
> in a header file, but without marking them as 'static inline', we get
> a copy for each file that includes the header:
>
> drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.o: In function `mtk_eint_set_debounce':
> pinctrl-mtk-common-v2.c:(.text+0x134): multiple definition of `mtk_eint_set_debounce'
> drivers/pinctrl/mediatek/pinctrl-moore.o:pinctrl-moore.c:(.text+0x7d0): first defined here
> drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.o: In function `mtk_eint_find_irq':
> pinctrl-mtk-common-v2.c:(.text+0x13c): multiple definition of `mtk_eint_find_irq'
>
> Fixes: e46df235b4e6 ("pinctrl: mediatek: refactor EINT related code for all MediaTek pinctrl can fit")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied with Sean's ACK.

Yours,
Linus Walleij
