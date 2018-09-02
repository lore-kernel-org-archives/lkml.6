Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9727DC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 16:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4687320835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 16:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4687320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeIBUny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 16:43:54 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:49091 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeIBUnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 16:43:53 -0400
Received: from null ([172.19.249.48]) by mrelayeu.kundenserver.de (mreue101
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LpfQU-1fRIrR1raI-00fQaa; Sun, 02
 Sep 2018 18:26:47 +0200
Date:   Sun, 2 Sep 2018 18:26:44 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        Eric Anholt <eric@anholt.net>,
        Phil Elwell <phil@raspberrypi.org>,
        Jean Delvare <jdelvare@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, serge@raspberrypi.org
Message-ID: <67224834.51159.1535905604770@email.1und1.de>
In-Reply-To: <99ca4f6d-d2b2-36e7-9f27-189df379cfaf@roeck-us.net>
References: <1535887251-29515-1-git-send-email-stefan.wahren@i2se.com>
 <99ca4f6d-d2b2-36e7-9f27-189df379cfaf@roeck-us.net>
Subject: Re: [PATCH RFC 0/2] hwmon: Add RPi PoE HAT fan driver
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev36
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:LTgnAS8jHHrrF7tFzN0pG89q9GehcS3SdTfIixEUuBJgTc0m0e4
 zLybO//WIkXNMXsrvOzSJ1eJxeeiaFB5oD+C3ywj04Au2gp6cNwTwt8IN+YE/IlY3pLZ5Dm
 rUliUjbZSne5/fQKybNct6/pc3oiDQmzFeGZV2qfPgwP5l18uFQkQN8G8l7aZP7cZ2QFaQu
 vOfmPEKTVTqoXNfBryMbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ntaQTbIg/yo=:DP3sxTYD6Ver9uPk2nLVVJ
 EyX/MaReI689PznWULWFKtUas+b5B92HwflcWMrv7tKx5Gy85PmmAVdE3aPvx9hOruHd109B9
 zMuxVHtwqvdkiCl79AJ3mW1ND3PcQLu5xjqS8vIFKvMANl9z+AgF13M2FbjbOLqwrW0vws2U8
 YE+MjKQsZwQQIROCexlcvwJi3YeYr6hFNcMSL7J/wY2t5Wq7vaLJ/2hYwibaCSiBwZg6gtEDu
 rf8mNaHxuUZG3wTDjQr3D0J5QH/Rr5DMZg2fTmEfaQA6Xfmi460wPT88V0NX4von/M5EPFLoM
 EEegBZwkQLxosbiZbbalkazMi3nmA7Y3KNq2lHwpVbIjGFAM6V/I2mkDHg0D1kDwZtzyFBYdP
 eFgvajO/Sx3dmnJ2So2JbSTAECVA24H1yllJTLqu4/vgoObkJfbMgaF9gepjue4M/BiaJ7pq5
 NCM6YwC5iHi0l2riIJ47vyygidgnyAJqLpmYFHTedBlhIIXckd0V6/32n4OdB0CP4ukT5dlsh
 KgpwARLrps2W5X9KMPOyABtINQxn8wBkzoafw9AqwMIHsIz81joppitQk3E1uPQQkcqCa+FTV
 9O7DS1SnwYyqb+IBamC6uwtBrq3k8fcsEJzfGYWStFQ5A4gokO6uOqhHBqpdyohgNQYJ7FGwD
 NjEpHqekKztmjjtPW6+h2Gvfmo3bYaWNylbo5KpkXApghCFof0jmjlwvosiDXfNBImgAtab8X
 lam19Nh8kfqOVVSq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

> Guenter Roeck <linux@roeck-us.net> hat am 2. September 2018 um 16:23 geschrieben:
> 
> 
> On 09/02/2018 04:20 AM, Stefan Wahren wrote:
> > This series is an early stage of the hwmon driver for the fan on the
> > Raspberry Pi Power over Ethernet HAT [1]. At the end this should use a
> > Device Tree Overlay.
> > 
> > Changes by Stefan based on [2]:
> > - reformat the downstream patches for submission
> > - drop reboot notification
> > - fix remaining checkpatch issues
> > - add COMPILE_TEST to Kconfig
> > 
> > The driver is mostly copy & paste from pwm-fan, which isn't good. Personally
> > i see two options:
> > 
> > 1) integrate the driver function into the pwm-fan driver (new compatible)
> > 2) implement the core function as a PWM driver and use the pwm-fan driver on top
> > 
> 
> I don't really see the point of thise driver. Why not implement either of those ?

i'm not sure about your question. Since the fan is placed over the SoC, the fan should takes care of the SoC temperature. AFAIK the firmware should have exclusive access to the I2C. So why we need this mailbox interface instead of a I2C driver.

> 2) sounds like a perfect fit to me.
> 
> Guenter
> 
> > [1] - https://www.raspberrypi.org/products/poe-hat/
> > [2] - https://github.com/raspberrypi/linux/commit/0f937c8dc3201ebffa6c617c616fd7c65db65959
> > 
> > Serge Schneider (2):
> >    dt-bindings: hwmon: Add RPi PoE HAT documentation
> >    hwmon: Add RPi PoE HAT fan driver
> > 
> >   .../devicetree/bindings/hwmon/rpi-poe-fan.txt      |  55 +++
> >   Documentation/hwmon/rpi-poe-fan                    |  15 +
> >   drivers/hwmon/Kconfig                              |  11 +
> >   drivers/hwmon/Makefile                             |   1 +
> >   drivers/hwmon/rpi-poe-fan.c                        | 414 +++++++++++++++++++++
> >   include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
> >   6 files changed, 498 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/hwmon/rpi-poe-fan.txt
> >   create mode 100644 Documentation/hwmon/rpi-poe-fan
> >   create mode 100644 drivers/hwmon/rpi-poe-fan.c
> > 
>
