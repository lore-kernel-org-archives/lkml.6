Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664C4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A97721479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSqr8kXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A97721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeJJTPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:15:47 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33503 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJJTPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:15:47 -0400
Received: by mail-it1-f195.google.com with SMTP id h6-v6so15866675ith.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 04:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TDAU36tamx6DJw155u+O3kffuH8ZWLqMRfQX+tRDgcE=;
        b=hSqr8kXwdAZ3yBWXH4gudzTUj7ncE/9wsx8SggBqv++ha+JYv7mIK5Sz7yzzBqexU9
         r4hi++O/IzeoRjnhOdC4b3z6UqsBV63pEY66cb7iu0sfNDIpWneYLRnHQ3KfwZnPSZo6
         jp9o2LgAmR++4nXhrFsPYfsBNmjJsAUYw4BmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDAU36tamx6DJw155u+O3kffuH8ZWLqMRfQX+tRDgcE=;
        b=jznhONI9fWw3in8mf6WD8bI1aVg9BlqC3M8wdoiKIItT16u11tNGMDEuSt3jl+6DTU
         89/Wt+NoKBPyAfhr8YAaEOeRRborOv8DpycXTvqKlOMpCACwGbA5k6+QNDmjGtQ6yxAW
         LzhzomnngRV6fGuqrO78yTK4RIeI9CVsprMndzGmPFKoF/BUPCsPjR9wPgxIl8O6GVkc
         SkmEGybgS4RBoJi6BjU9QPoPTjWBHa/KTdvLYowDauIdcSNRISIAySOMOc7LACMLoKVP
         Tc1sImU6LF894Mc5oqmpEZmLMDaWnjvn5kI6XmdOZ890s0zW3F2zjbSGS2qp6nmrPRq2
         wHhg==
X-Gm-Message-State: ABuFfoj5G/glkfg0lshq438zWEfVvZw6jPY6aHXnsweyifX9H87eaz6K
        UheCYWet6cLvYSLsYfO42cKNGj/hskuQXYs/ltRYQzg+
X-Google-Smtp-Source: ACcGV62wue0aUv0wjTZLgW97Wha9P7iob4Ruzd1Lgl6duWECBiHpvUC2ROErWTvaiDYKtamlx1kLaip8XYEduxeoNao=
X-Received: by 2002:a02:3f5d:: with SMTP id c29-v6mr26102970jaf.107.1539172438635;
 Wed, 10 Oct 2018 04:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181008155803.3322412-1-arnd@arndb.de>
In-Reply-To: <20181008155803.3322412-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Oct 2018 13:53:46 +0200
Message-ID: <CACRpkdYwGyMosmwW9YkMSKs4VCet7c0itwx0jUKOXnGMkS2g9w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: select GPIOLIB
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Biao Huang <biao.huang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, zh.chen@mediatek.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 5:58 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Removing the linux/gpio.h include means we no longer have a declaration
> of gpiochip_lock_as_irq() when CONFIG_GPIOLIB is disabled:
>
> drivers/pinctrl/mediatek/mtk-eint.c: In function 'mtk_eint_irq_request_resources':
> drivers/pinctrl/mediatek/mtk-eint.c:247:8: error: implicit declaration of function 'gpiochip_lock_as_irq'; did you mean 'spin_lock_irq'? [-Werror=implicit-function-declaration]
> drivers/pinctrl/mediatek/mtk-eint.c: In function 'mtk_eint_irq_release_resources':
> drivers/pinctrl/mediatek/mtk-eint.c:272:2: error: implicit declaration of function 'gpiochip_unlock_as_irq'; did you mean 'spin_unlock_irq'? [-Werror=implicit-function-declaration]
>
> Select it explictly instead.
>
> Fixes: 1c5fb66afa2a ("pinctrl: Include <linux/gpio/driver.h> nothing else")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
