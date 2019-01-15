Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C543EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9524420656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OySq//We"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfAOMyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:54:05 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:43070 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfAOMyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:54:05 -0500
Received: by mail-lf1-f50.google.com with SMTP id u18so1924233lff.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3HLSwkiKa59wFB4FckuMcj1IpI//0uh6c763fmVa98=;
        b=OySq//WewiKOWOlkpKnUSOvtv6pBGpjDlYxQCj3kkHQHGf+c1Zu0XVqW3DUTdGBLFo
         vDm5yFKdyiIeiWYschEEpCKRLs36zqwjHknAXhiqQHwxqFwPOaxUPYNEkUUj4GvoOBNS
         VdZWdzSkmNISQvEK6vgPx8TsPpKdv6CgYPLY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3HLSwkiKa59wFB4FckuMcj1IpI//0uh6c763fmVa98=;
        b=pzqhkEoNL3W8dLmgKX3Eql0Nr8pQ00dLeXEdJdIe+KFBApIjTefI325N5bfAdRzHFR
         j/wKQO1XNz/6mL83B1Uq1jXQTnY3jRYbrjyR4BP7qAx5/ar5Rxfdx4FBI49Wredf0/cG
         FJP0QIqsUxE4O3men2q4d1A4VXO5qYRWlkuhcNgrpI/OhNKrdy3d1VjSoDOHqmgVws5D
         ch7ULHd3hh5Xd+s4Ej8VX+gzoRpA7s3wfOpJHne5M8vkUQuM3Tu3VzOK7N5ulqhalAY/
         452yNgxx3vUtkQnjY5s5LCYSmOvT4JqdS8wJkyAjRE0z3pJXQXA5EQ/pJvVL/TEq8hkP
         9AIA==
X-Gm-Message-State: AJcUukfSz8sIz70ktjAhwwve2oX4rr7SKzuGXKwcS65xpnvGAHfLiKio
        6/ed2mDnqiV8a/EULG07GlUN5LRbdCrFwO1GwzjVaA==
X-Google-Smtp-Source: ALg8bN4F0pTxOXgSrWK6OtOouC7GP5NYLZvHsaYvJO9cqEYaHzX2930vqJNAd+LagxXlEacf39b0QrIs49PzCOIBPDU=
X-Received: by 2002:a19:5154:: with SMTP id f81mr2854868lfb.96.1547556843081;
 Tue, 15 Jan 2019 04:54:03 -0800 (PST)
MIME-Version: 1.0
References: <5c3d0781.1c69fb81.8f009.0d7e@mx.google.com>
In-Reply-To: <5c3d0781.1c69fb81.8f009.0d7e@mx.google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Jan 2019 13:53:51 +0100
Message-ID: <CACRpkdY5ipcZqujGXJN9hcNYA+3WvknaQH0syYDb3YrrrgkgCg@mail.gmail.com>
Subject: Re: broonie-regulator/for-next boot bisection: v5.0-rc2-20-g61b67608c6b9
 on meson-gxl-s905x-libretech-cc
To:     "kernelci.org bot" <bot@kernelci.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        guillaume.tucker@collabora.com,
        Kevin Hilman <khilman@baylibre.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for this pretty impressive automated report!

Maybe it will be hard to ask a robot to test changes! :D

On Mon, Jan 14, 2019 at 11:04 PM kernelci.org bot <bot@kernelci.org> wrote:

>   Target:     meson-gxl-s905x-libretech-cc

I hope there is someone else with this board on CC since I don't
know how to ask the robot to test patches.

The log from the robot isn't super helpful as it does not have
earlyprintk enabled and boot hangs before it gets to that (!)
so no console messages.

So I suppose this is:
arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
a pure device tree plattform which was added by Neil, so I hope
he can test patches.

And that has only one GPIO regulator, this one:

        vcc_card: regulator-vcc-card {
                compatible = "regulator-gpio";

                regulator-name = "VCC_CARD";
                regulator-min-microvolt = <1800000>;
                regulator-max-microvolt = <3300000>;

                gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
                gpios-states = <0>;

                states = <3300000 0>,
                         <1800000 1>;

                regulator-settling-time-up-us = <200>;
                regulator-settling-time-down-us = <50000>;
        };

Meaning this is 3.3 V when that GPIO line is low, and 1.8V when that
line is high, correct?

That controls the VCC. This surely wouldn't block the boot process.
So my code must be crashing completely. OK I will look closer at it
and try to create a mock system of some sort.

Yours,
Linus Walleij
