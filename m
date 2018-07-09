Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D711C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B688F2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bnwhA+i4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B688F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932792AbeGINkm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:40:42 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50581 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932666AbeGINkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:40:39 -0400
Received: by mail-it0-f65.google.com with SMTP id w16-v6so4044945ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZVuAl+U66S/GzNBJOitYhN3ioEoha61GuSSF/k6dR0E=;
        b=bnwhA+i4beb7zMW9aYgbwLFXlGrGWGvlXn48AHH0R5LblyKoMfs/NK/+Io0gFk5aaU
         rdZaQTAS/SUZE0TivCIwKjY9A1MzRG0umDRrfpdLTXHAg1uFo+I1Pwu1SJ57nQEH6Nzb
         AqFWbvlrrW31uVAVrSetYMx5rWD+nFNmyIguo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVuAl+U66S/GzNBJOitYhN3ioEoha61GuSSF/k6dR0E=;
        b=AWajjChMIOZm+YO+X/PhlACF2FWRR8q/AwWWhX2HaBQk1vqYd1ZCnPfQuchZLTCwJG
         YP8mjQPWOwuZ+aHYF+L/Ko0y91XqiGo9zcK8zeCtW0gxtyL8is8OsQK//qF4EByeS1Vy
         Ybls5TIB7fuFFJ7ab9OEIyCwIcItD8BSXqRjG12OO7FsRBC/Av2GPTIRr+3YUyuqRZrF
         AyNPWp4EIgvmy4/RU8Wx5ig2YyJ9dyd2u4iX96z43N8iTifwZkjQZB4XF4czPR4ZOCHC
         Apk9+Bfe6N7R27D/wqmGzPs4is3yVHZ4iCdASM0nmjxpDmigvhJ1YesBsdufEeQM4/vh
         D/ew==
X-Gm-Message-State: APt69E1m0vNFBXM2dBjeRW6nYY2XjslIWc+cUtuHGHDwnb0sS51z7LP2
        2Pjcwdb8w4qLb8tsNWrQeX/JH4z3k3JKnVsevPlldw==
X-Google-Smtp-Source: AAOMgpcXTmgmmcB4HNmgoYr5dKDx2cxDF1sRICwgXPjSra9DNhYhw02OhcAJfAtZQw7SeurfKV42GXLqiJIBclu67K0=
X-Received: by 2002:a24:ad01:: with SMTP id c1-v6mr15833313itf.70.1531143638644;
 Mon, 09 Jul 2018 06:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180629081533.31885-1-ludovic.desroches@microchip.com>
In-Reply-To: <20180629081533.31885-1-ludovic.desroches@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 15:40:26 +0200
Message-ID: <CACRpkdYyeFTsPe+pR26DCO5uOkLZu-+Nz8vDdEg47NWn4f-4Rw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: at91-pio4: add support for drive strength
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 10:19 AM Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> Add support for the drive strength configuration. Usually, this value is
> expressed in mA. Since the numeric value depends on VDDIOP voltage, a
> value we can't retrieve at runtime, the controller uses low, medium and
> high to define the drive strength.
>
> The PIO controller accepts two values for the low drive configuration: 0
> and 1. Most of the time, we don't care about the drive strength. So we
> keep the default value which is 0. The drive strength is advertised
> through the sysfs only when it has been explicitly set in the device
> tree i.e. if its value is different from 0.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>
> Changes:
> - v2: use atmel,drive-strength property instead of drive-strengh one
> since it is not expressend in mA and there is no way to retrieve this
> value at runtime.

Patch applied with Rob's ACK!

Yours,
Linus Walleij
