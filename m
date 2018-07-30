Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A21113F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B707C20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kynetics-com.20150623.gappssmtp.com header.i=@kynetics-com.20150623.gappssmtp.com header.b="Q7yEifn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B707C20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kynetics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeG3KwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:52:08 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:44044 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeG3KwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:52:08 -0400
Received: by mail-qt0-f180.google.com with SMTP id b15-v6so11297297qtp.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynetics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yb2OfxeJi1s3dsTFHzzft/KwHps7nJy0mu4sdY63Lck=;
        b=Q7yEifn3NfA5RVsGAYN2fJ8mjnzm/2X9FF+fV8O5iH64b5q0i8Gj6GLAf9J//9+KsZ
         Mw48ZQAOYdzOboi1abSCF79sQ5y29yOt3McjfzVZXgvfHgxSWGAxCncTVkb5GV8vo7UQ
         e6mJFRP5WZcQ67c6OGwJR5W2efrp7lPakzUrBTKAe7Z6EGBIWocMEwbV4TkMqj5mCEcy
         vzPlfk0tCo+5YTK11lngazbedE6NcCra/VFd8Md1ZAh7vB49ry4baF+HP6o1sMMZpDix
         fmQf95BxY3dSD1BmKpNYiXG8Z4m34jzn01WkZv6XNAbtQuul+A+qmNHNXU5kZATFOq/I
         RlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yb2OfxeJi1s3dsTFHzzft/KwHps7nJy0mu4sdY63Lck=;
        b=lRjmGWlgvf6uLRIAOjM1aUTHsCc9rtDtJ8u4N/ZKJt+3z2HAK6rTL5x3COJM6n3Aav
         OhDnW4sHkM/aheoSDkGfdLL+l4GeoAtOcE19P4pBJDQa0ZIrKZqTaNSXKD+kXi00bGgA
         Ss9gR9lbi9w5ElekTXtUmF0PlbaxSkddChw6ypY47HszD2FNrnqzh5/BLqgdpUTZwgyz
         JYA5oeIvh15H4LpVvrIlx7mvWKA7cxjFzuaZbxS3erTfcutki/Lf51/HfqjDqRlqR0V5
         Y49pU31WG1WSIJeVfbr6imu5Hc35lG4tjHBEfaDVN2SW8OpkhB6zKvQ9NMpWpwKD3SIC
         3YMg==
X-Gm-Message-State: AOUpUlEd5GY6tsZsQEuDM2Wc835Lm+kvJ5zto+tAsASIatDi51pq5WO5
        qokt7Jg0ex4Qs7EfM+EJPa45QD3lJc2ZH1GFzlGCPA==
X-Google-Smtp-Source: AAOMgpebmRpe/QE0yvxgIS66QwN2k2dNEg1SDfaXDE4Ft35TQT48+g+l6O3nSncOVt2umONJjrGmQ14GXu2sBx1wYt0=
X-Received: by 2002:a0c:994c:: with SMTP id i12-v6mr14349309qvd.24.1532942284503;
 Mon, 30 Jul 2018 02:18:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:959:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 02:17:44 -0700 (PDT)
X-Originating-IP: [79.7.224.57]
In-Reply-To: <20180730084519.iqyhvocxsfuopze7@flea>
References: <20180727125739.22871-1-diego.rondini@kynetics.com> <20180730084519.iqyhvocxsfuopze7@flea>
From:   Diego Rondini <diego.rondini@kynetics.com>
Date:   Mon, 30 Jul 2018 11:17:44 +0200
Message-ID: <CAMfw5YpH1nbO1eYGoAOEEreboHs3VEY61x8qRO-BYDcGS+DBqg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3 support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, Jul 30, 2018 at 10:45 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Fri, Jul 27, 2018 at 02:57:39PM +0200, Diego Rondini wrote:
>> +/dts-v1/;
>> +
>> +#include "sun8i-h3.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +     model = "OrangePi Zero Plus2 H3";
>> +     compatible = "xunlong,orangepi-zero-plus2", "allwinner,sun8i-h3";
>
> The H5 version doesn't make that easy, and it's unfortunate, but we
> should have a different compatible for the H3 and H5 versions.
>
> What about something like xunlong,orangepi-zero-plus2-h3?

Yes, I think this is the only reasonable option. I'll send v2.

>
>> +&uart1 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
>> +     status = "okay";
>> +};
>
> I guess it is the BT chip? Which chip is it?

Yes, according to schematics Bluetooth is on uart1.
It's an Ampak 6212A with a Broadcom 43438 chip. To my understanding
it's the same chip in the Raspberry Pi 3 B / B+ and Raspberry Zero W.

I've tried to integrate support for Bluetooth with the following:

&uart1 {
    pinctrl-names = "default";
    pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
    status = "okay";

    bluetooth {
        compatible = "brcm,bcm43438-bt";
        max-speed = <2000000>;
        shutdown-gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>; /* PA10 */
        device-wakeup-gpios = <&pio 9 2 GPIO_ACTIVE_HIGH>; /* PL2 */
        host-wakeup-gpios = <&pio 0 20 GPIO_ACTIVE_HIGH>; /* PA20 */
    };
};

but the hci_bcm driver doesn't load automatically and doesn't probe
the device when loaded manually. I haven't investigated further.


Diego Rondini
Sr. Embedded Engineer

Kynetics
www.kynetics.com
