Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2364C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640F72080F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640F72080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=robertabel.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeKRHm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 02:42:26 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:50062 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeKRHmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 02:42:25 -0500
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Nov 2018 02:42:23 EST
Received: from [192.168.178.21] (unknown [5.63.45.188])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id AD71B14116E;
        Sat, 17 Nov 2018 22:15:44 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 5.63.45.188) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Received-SPF: pass (mxf98a: connection is authenticated)
From:   Robert Abel <rabel@robertabel.eu>
Subject: [of] deadlock b/c of gpiochip and pinctrl dependency
Openpgp: preference=signencrypt
Autocrypt: addr=rabel@robertabel.eu; prefer-encrypt=mutual; keydata=
 xsBNBFuld24BCACo/2iGEWd0080a1KqLfB2AYsRzA/86Yx64XNOynZWKk+ToSzDxmEtgUq3u
 By7wZNpIRVeijJ/DvV2Bk2PVAyUMQrQx85rOX+uLW9+WmXgyiO5o+KN6GZDamJu2nDTnvn4z
 Nqowt/tlXMzt+QSL5ypa76AIh8o7QmoV0JpfnxD9NlLX/ysiYXZD1mFi0B8Ef9i22XIE+kuj
 hx03vmNvmKKjr6ajAN3lX3o6ftC2J3BMXl6BiISeO+FkKKbHfMwP4fz70ezrNhD5EdKJZFHe
 FyVQSThR5D1Yxhw4xWy/bQFqlJ96ulfXx5wYNdVck1Vftf5LnvRzrZgKNZU0zzIhMfvBABEB
 AAHNIVJvYmVydCBBYmVsIDxyYWJlbEByb2JlcnRhYmVsLmV1PsLAlAQTAQgAPhYhBAPU/UOS
 MYeSZeDf9jncurJ4JrbIBQJbpXduAhsDBQkDwmcABQsJCAcCBhUICQoLAgQWAgMBAh4BAheA
 AAoJEDncurJ4JrbI2oIIAIpEXpKW3L3lfZ71QxRp4XiXh+s3QqnMIYlXMNbd/A/ZU+70ulDs
 MnnNUeyzjbx4glUDIfAQ/x3tAJyl3Gr6GJcfCumJG/cVu5XYv48CO52qGLVtJsuc75D+Qu41
 pt6r6jdD0y2bVmTRT2bUtZR1kh0gKy/dL+4INiG38JDkLl/JemErLt9GOTfgJGFSdxjMjsuP
 wZmSPVoc8o+xOUBmUxrEICanaK5Hh2imctpAPkqCCWQKOGF9wW/DfdKdQWER4BT4Y/afq1rC
 Z74g/BN3sKnPSoemfvxP6I+PHJn+nXVm9RX7qcHv2Yg3x2MO5Fz1dZ18Rg0w51pVmjBwaCtx
 R5nOwE0EW6V3bgEIAKgY410eN1ERCBNf3j6Kzpm+OiZCELJf8pXGMxe+hJWZjDZd9gsk5PgX
 H4CTk3fBM+Q3ke1XbqhXvf08ynM/hIvl4mkvSHT0G6tHbKcm1jSantj4gloZd5sjcnire2Gs
 bFt6u9BJdh+qJki981O3YqppYGPuXx770NkP6AL9buAxRqMtPv55dHii4LOKUIrOLn6Z427c
 9lzZAVtG6a5HREtDg+M35QwkGkubB1onn9mRBB2Dr/2sr73htU8cRQCQ6kZPILuV3nHMmlUr
 XaEdHyvufv1YEAWQdg08+Pig1ZK57zlGO4WwWUAUuT/9iQm1qzMLP2683OoWbCihbjtYGskA
 EQEAAcLAfAQYAQgAJhYhBAPU/UOSMYeSZeDf9jncurJ4JrbIBQJbpXduAhsMBQkDwmcAAAoJ
 EDncurJ4JrbI/boH/2AzoE6EfGEwkMHMTjH5lmarhDTkg9EQNwi3orH2836RYPlO1geOrItm
 rM9b/lX5OXrE/K24lvxviVV8EaMN9EhEuCyoo6tnv+pUni3U2qWu3WUfAIMtkKlZspa4sO4Z
 slCvBwZtNTb2Al6Rs/knPXnV8mcQ/gMnd99feaIRL7FvsDvlCqIh+B0785igWYQ9VsGUuDXr
 Dmhm/j1LMoAQS4+31+lARM4sX7pdBnlSp0OGHj7vzTMirAjGAAr/Kh7BgcfRtin7n9rAMenu
 9h1RQsQoayamC18CP2SQIZHbbiquUttmrvj7tkJAI2Y7bWqgfmBHHhNsVslYkpd4wYV62uc=
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
To:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Message-ID: <6409e5aa-4129-0706-2704-f5f609bb54a8@robertabel.eu>
Date:   Sat, 17 Nov 2018 22:15:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <20181117211544.23253.72671@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I found a dependency issue with gpiochip and pinctrl while using the gpio-hog feature that was implemented by Benoit
Parrot in f625d4601759f. Relevant device-tree overlay shown below [3].

I ran into a deadlock situation, because adding a gpiochip requires a registered pinctrl with registered ranges, because
the function to add the gpiochip will check for hogged pins and request gpio pin functionality for them.
This works in situations when gpiochip and pinctrl functionality don't depend on each other. However, consider the
following code, which is from the bcm2835 driver for Raspberry Pi found here [1]:

pinctrl-bcm2835.c:
    err = gpiochip_add_data(&pc->gpio_chip, pc);
    if (err) {
            dev_err(dev, "could not add GPIO chip    n");
            return err;
    }

    ...

    pc->pctl_dev = devm_pinctrl_register(dev, &bcm2835_pinctrl_desc, pc);
    if (IS_ERR(pc->pctl_dev)) {
        gpiochip_remove(&pc->gpio_chip);
        return PTR_ERR(pc->pctl_dev);
    }

    ...

    pinctrl_add_gpio_range(pc->pctl_dev, &pc->gpio_range);


It's not very obvious, that calling gpiochip_add_data should only be done after adding the required ranges to pinctrl,
because the following happens:

gpiochip_add_data(_with_key):
  of_gpiochip_add:
    of_gpiochip_scan_gpios:
      for_each_available_child_of_node(chip->of_node, np) with "gpio-hog":
        gpiod_hog
          gpiochip_request_own_desc:
            gpiod_request_commit:
              status = chip->request(chip, gpio_chip_hwgpio(desc)):
                gpiochip_generic_request(...):
                  pinctrl_gpio_request:
                    pinctrl_get_device_gpio_range:
                      /* GPIO range not found, because it wasn't registered yet */
                      return -EPROBE_DEFER;

This of course deadlocks my system, because everything ends up waiting on the gpiochip, which cannot ever be
instantiated. I couldn't find any documentation explicitly mentioning this dependency between gpiochip and pinctrl.
My workaround for the moment is to re-order the gpiochip_add_data call after the devm_pinctrl_register and
pinctrl_add_gpio_range calls. I haven't observed any ill effect, but I'm not sure what other components may already act
on pinctrl while gpiochip is dangling or if any of the other functions that are called by add require it as well.

Obviously, this approach won't work for SoCs where setting certain pinctrl settings need to touch gpio settings to e.g.
activate pull-ups.

In general, I sought the same functionality that Markus Pargmann was trying to implement in 2015 [2].
That is, to name and possibly export gpios through device tree.

It seems disadvantageous that one cannot currently specify pinctrl settings while hogging or export by name.
Dynamic device tree overlays also don't work. Perhaps an actual driver instead of the hogging mechanism would solve all
dependency issues better?

Regards,

Robert

Please CC, as I'm off-list.


  [1]: https://github.com/raspberrypi/linux/blob/83ea2e93/drivers/pinctrl/bcm/pinctrl-bcm2835.c#L1027
  [2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/357418.html
  [3]: gpio-hog.dtso
       /dts-v1/;
       /plugin/;

       #include <dt-bindings/gpio/gpio.h>

       / {
           compatible = "brcm,bcm2708";
           fragment@0 {
               target = <&gpio>;
               __overlay__ {
                   myLed {
                       gpios = <18 GPIO_ACTIVE_HIGH>;
                       gpio-hog;
                       output-low;
                   };
               };
           };
       };
