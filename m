Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DF8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5472086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s30BgWgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfBHMPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:15:41 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37995 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfBHMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:15:40 -0500
Received: by mail-lf1-f67.google.com with SMTP id j15so2368054lfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHAsJ6zDs7K1QJ3r7+508Wb4v4HiPVQT0ncKLrJsHQI=;
        b=s30BgWgJ5dKxiFujZwHXi4CK+4+D0AAiJAt162ePz0LB5RMgaWbUeYJm/n/3er5yY4
         1CwsKGjhqu/uVydG/oNawW+QvONVG9et998FNYfbV6aBEKd5shDygHJ90Ci/RmSckTss
         mEgaQzEnUT0MfUSAvyhzS+kXhM71iUudkFvQVDIgu7UnbI3go102O80rrsO3SInaQ1KC
         tF8rOOkKD2RAkwBNCXNsBF/WsvILnsRNNa/CSOWhFbZqbk0nTjuk/M7tvXihRWmt+XTE
         k9UWz/Kz8hdJlUUvW07/ZyJhOeGto1nJ0ZOUQJSvm2+4XxjXxTCj5SNeAr+EyhvL2iqZ
         m4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHAsJ6zDs7K1QJ3r7+508Wb4v4HiPVQT0ncKLrJsHQI=;
        b=ahN2zmPfmLx+qgxAvJCQ6Bmlsiy+LzjhGCkhEzvWpqtRcrp6XRRukBOqvN7gtCumPR
         USXIZrZ4RgKHQYSJHny8smk6AXMLYUB4eo5YpGQwMBY+ZnH4IbPHl7AaOgBMRwcZn4mn
         FPrw1eVQG7MQn3ZbuGI+XgC2vWHvbLBygvNCIvY9xl/fjhch2P2HMmz6Z8USPJL9y6oS
         M263oqhghdhubwmQtZ8tUtDLrT/iVl3qkK3N4o6P6obeW75QB94rHfPtJnv8DXQKdDwM
         jOWLX1oTpmdd1V3QOG56tRS/R89OTwGSwY3jrga+fxkuM74Eu0UYcuMBnQyGptkc7Lqz
         tK5w==
X-Gm-Message-State: AHQUAuajxn9mNvuC8BKp7XGfJXXSYmvYGOEUW5Oz+GryBDcGFFSOEIAi
        MJ9Nmu9kIZoY9lylW108Ci82dhb5B1oDUhw2WbFbbg==
X-Google-Smtp-Source: AHgI3IZjFC+VAzkWma/upBOiAE/iePPXcH7SFStqKOLHnD6qFu1RLLhDHg/FEKid0doei31JuzORyXzy2Zjffk5lvFE=
X-Received: by 2002:ac2:4219:: with SMTP id y25mr13188063lfh.130.1549628138384;
 Fri, 08 Feb 2019 04:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20190205091237.6448-1-brgl@bgdev.pl> <20190205091237.6448-2-brgl@bgdev.pl>
In-Reply-To: <20190205091237.6448-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 13:15:26 +0100
Message-ID: <CACRpkdaERR=jBf-mchuEEyRu_vb8vr8CoZ5uL6apPGD9gOgw=w@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] dt-bindings: mfd: add DT bindings for max77650
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 10:12 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add a DT binding document for max77650 ultra-low power PMIC. This
> describes the core mfd device and the GPIO module.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is a good solution!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
