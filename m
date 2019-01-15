Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C532EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957C020656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wEBLWGzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbfAORdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:33:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35607 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfAORdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:33:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so1644368pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 09:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=4U0OvVrkxFBjSA8W5Lm7VS40KUbUjrzMUZQnvA9o4pU=;
        b=wEBLWGzTNbnLT0SQ7XjOWnMPDC05vGd2UjO5hbTWczX2JqnycaJr3E3fby9boGD03w
         XZVOafE9R6nzFek66oe3FzBqsJbexwLYn54wZXtBViHA1LRKQUvkaAWP588kFIlj0VB8
         yp2r9asYVbCYlLa/MMpjJjcVudk+HVk4YFs/U+7ASP3pUnLU+VqWAZRgxKwQgnO4aUy8
         DPye/+VuPF4PgXiOuvLVxsGYcUt+DtGaRniJHChff8oSt/odNozH9TxF2rTKSiOMTpTJ
         Veqv7S0wYlFZ/gMvR8tLvbqnNoEoE8pM+To0zH5soTftlKn6O6/AJE9DbBS6gu/JaEG7
         ivYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4U0OvVrkxFBjSA8W5Lm7VS40KUbUjrzMUZQnvA9o4pU=;
        b=ACuH5T/APJrnfVF+y6kRddQTdlJoLGP8KQ1+pbtaidJARP7TJw/IR+sSOBff1AkoIp
         SmEIkbZtTe8Kqnq+CM0R/GJ08AO+SXokvvSqGAPWaOLf8coDo6v97JXoYmSidXdruNXw
         KXMln6fyAROQrR+Gl8DiqvTnnNL1ez3IHdxQkXSzKtf24+1ZY0Sof+yMQ51CeR9zZA2w
         nXYHL1803j9Nizq49Hsmo07XOyj3P7W4+Wt31AN62xc/mjaNEmjE84PUSEQA0PRHY78i
         cT3ite76mO+4BD4BuycuV03U3yWCclZpWHf1QovqbQF5xiEHi0dNMsRdpfKXM2s8zyKP
         yv7A==
X-Gm-Message-State: AJcUukfJ2xL9AbQi3Pv/tpEdmypOiZw/1bydzczqy3Y+fg3Z7OS+9K1+
        WsKt/ZDYevDxEsoMhf75ruSzWfheVao=
X-Google-Smtp-Source: ALg8bN6/M5WBB7GNfbjGqgI0MPWGrQajvmlUJTF9TSvVrP8AubuQo8DgeGH/g/OOzA6lHafWFLD9Kg==
X-Received: by 2002:a63:c42:: with SMTP id 2mr4795113pgm.372.1547573581531;
        Tue, 15 Jan 2019 09:33:01 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:5cbd:8bed:2b0a:a142])
        by smtp.googlemail.com with ESMTPSA id w3sm4462914pge.8.2019.01.15.09.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 09:33:00 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        guillaume.tucker@collabora.com,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: broonie-regulator/for-next boot bisection: v5.0-rc2-20-g61b67608c6b9 on meson-gxl-s905x-libretech-cc
In-Reply-To: <CACRpkdY5ipcZqujGXJN9hcNYA+3WvknaQH0syYDb3YrrrgkgCg@mail.gmail.com>
References: <5c3d0781.1c69fb81.8f009.0d7e@mx.google.com> <CACRpkdY5ipcZqujGXJN9hcNYA+3WvknaQH0syYDb3YrrrgkgCg@mail.gmail.com>
Date:   Tue, 15 Jan 2019 09:33:00 -0800
Message-ID: <7ha7k1ker7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:

> Thanks for this pretty impressive automated report!
>
> Maybe it will be hard to ask a robot to test changes! :D
>
> On Mon, Jan 14, 2019 at 11:04 PM kernelci.org bot <bot@kernelci.org> wrote:
>
>>   Target:     meson-gxl-s905x-libretech-cc
>
> I hope there is someone else with this board on CC since I don't
> know how to ask the robot to test patches.
>
> The log from the robot isn't super helpful as it does not have
> earlyprintk enabled and boot hangs before it gets to that (!)
> so no console messages.
>
> So I suppose this is:
> arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> a pure device tree plattform which was added by Neil, so I hope
> he can test patches.
>
> And that has only one GPIO regulator, this one:
>
>         vcc_card: regulator-vcc-card {
>                 compatible = "regulator-gpio";
>
>                 regulator-name = "VCC_CARD";
>                 regulator-min-microvolt = <1800000>;
>                 regulator-max-microvolt = <3300000>;
>
>                 gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
>                 gpios-states = <0>;
>
>                 states = <3300000 0>,
>                          <1800000 1>;
>
>                 regulator-settling-time-up-us = <200>;
>                 regulator-settling-time-down-us = <50000>;
>         };
>
> Meaning this is 3.3 V when that GPIO line is low, and 1.8V when that
> line is high, correct?
>
> That controls the VCC. This surely wouldn't block the boot process.
> So my code must be crashing completely. OK I will look closer at it
> and try to create a mock system of some sort.

Both Neil and I have access to this board, so we can test any fixes for
you.

Kevin
