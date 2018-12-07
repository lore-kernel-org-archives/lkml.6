Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087A1C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D6D208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQSQ9oLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D6D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeLGMdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:33:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42045 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeLGMdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:33:13 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so2894437lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ES8MK/RwZjGLjfY9+x5k0xxQosWdqghb5Jp4Xp7lBpU=;
        b=UQSQ9oLs7tZyipAf1dn4luDabSvQQLp4vSUN9Jnk412ByVsaURrwtynURjvd42NJA7
         SusdgPArBQVz+VmleShGnMecgzq3XKjcRGWmLRvl7JoCG/k1V+uq87tJVDKUFwCzXrVu
         DeOBgI8CR8cUdTvNxsOakG5vNF7Z0HPRd5pDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ES8MK/RwZjGLjfY9+x5k0xxQosWdqghb5Jp4Xp7lBpU=;
        b=FSdE9EcLeiTVZzy2hq9U0DxbovybXmY7fHmycgltvUfeTeyrXvewx7/CjCRwLLbNjs
         2VaMPVeV27ky1WTXZbZiexVxDliCN3bDSMO1gbv39Zx5Yk8JorG5P1/Y69TgAfFZsrxP
         /KsnJFvhJ+jOfeEaykxVGHOI5mxRDS2s6PQt0dQj5cHsvKLDTTV5pfBWIWOMoHg9EnCT
         kwB7zVukdn+fYUoYoHxLEv7I/DRmBbJ2hj9S//Vkh1Y8xYydTSmZUHO/lkQ3mYN2ZKgv
         zSNmQBE/oPH5+8oLk7W1gAeITxvZlxsoQjNLv8rmhpo+Cv3z+ImfK+OqJzCpM7ynakpS
         lVhw==
X-Gm-Message-State: AA+aEWYk5kAVUqy2bwPrRO3EBw1/er+CjWXjp7NUMBMcHw45PLLe/Dn+
        Of79/Ugi0hd2dT7wEndHigmcUqyyGsBzpGBBHqQPRA==
X-Google-Smtp-Source: AFSGD/XPVkLgLMKp6cZzG78i2wo3NqvipQ51b51RJEmGXVzXov/sOdK9kpm0VzvmuJWNtMAHGZKGo8xtGbCkySsieps=
X-Received: by 2002:a19:789:: with SMTP id 131mr1294172lfh.11.1544185991378;
 Fri, 07 Dec 2018 04:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20181204090457.15597-1-wens@csie.org>
In-Reply-To: <20181204090457.15597-1-wens@csie.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 13:32:58 +0100
Message-ID: <CACRpkdavWcT=JbsvNCEgqzL0BeQjLMqksBk+9k+oULzVsZ44Hw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: a83t: Fix IRQ offset typo for PH11
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 10:05 AM Chen-Yu Tsai <wens@csie.org> wrote:

> Pin PH11 is used on various A83T board to detect a change in the OTG
> port's ID pin, as in when an OTG host cable is plugged in.
>
> The incorrect offset meant the gpiochip/irqchip was activating the wrong
> pin for interrupts.
>
> Fixes: 4730f33f0d82 ("pinctrl: sunxi: add allwinner A83T PIO controller support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied for fixes with Maxime's ACK.

Yours,
Linus Walleij
