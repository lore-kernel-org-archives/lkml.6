Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A817AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E6720841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E6720841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeIBVat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 17:30:49 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:35557 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeIBVat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 17:30:49 -0400
Received: from null ([172.19.249.48]) by mrelayeu.kundenserver.de (mreue104
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MOAEO-1fznjY42PU-005Wgd; Sun, 02
 Sep 2018 19:13:37 +0200
Date:   Sun, 2 Sep 2018 19:13:35 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@raspberrypi.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Elwell <phil@raspberrypi.org>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org
Message-ID: <829194253.51526.1535908415057@email.1und1.de>
In-Reply-To: <e8d4e69c-2668-2794-6474-79749bf8b577@roeck-us.net>
References: <1535887251-29515-1-git-send-email-stefan.wahren@i2se.com>
 <99ca4f6d-d2b2-36e7-9f27-189df379cfaf@roeck-us.net>
 <67224834.51159.1535905604770@email.1und1.de>
 <e8d4e69c-2668-2794-6474-79749bf8b577@roeck-us.net>
Subject: Re: [PATCH RFC 0/2] hwmon: Add RPi PoE HAT fan driver
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev36
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:O8zxYbfeMvFOy61OTsXfxH2F1ijI97uP1RiszwdRCxxLIGmWb7c
 YE1kOaKnzfUbYA5YfT5UL9g5Xvzi0HpOgjBDYIvm9sBOFx/ECxvR8saF2sME2h4atswqB7/
 sT+tcV0SdXoTSEhQkjjkGFsqhnL4nhJ3B5Mx4+w9Rm/v+sYEh3Z9BMYmeMcNP8rRuo8FuLZ
 MTTmzujm8bvE3I3SwcKpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rC2DQqxzvBc=:g/wxmo9UWjAq8NtMCvlVJM
 qXbxZjpGHtJXY/fDIziCfWsBrt9LX4WdXGgErZ9sPYgjgq0mOF9e4i78vaHPoMZdjtQ/y79jz
 T4L8HOiQ7Rzmnx6pwy7E6y5yD/PEGd2dflPh1g9rg3AqsT027KGh9UzMgcBKu6CAp1DDkMuQ9
 KKTIMvBm7pIbQGYKAn+Eg322zhjjgNiTNXJxhP1wo3INIruV9W1XoFKRVxomIEsOGzIZdNECE
 yw98FQ+HajyPowpR7O4Vmm7yL0NH7gN7jxQUUEqhDW4/2xdguaD70IaTjnzFIQLc1zUwe+pAn
 YycYj6lUBnQD+u7fqG+8EzJeUiUYQbf6+J7a5ni4nEI2FA7/JixrimEKQSCeCEuh67fU/x/6z
 7/LZ/s86q34xHmG91J2/LU3k0UzPwycXnZhpEOThx2NIaRCoTfEw5pAq2yA+DIkUMN2pu/Bcu
 0tni1EtQBnr+KGNhHQTsBixd/fF3iNvp4P843s1qUaA+r6fM9OYnICC8uFbOgs+4DrBFl0WU4
 E96oev3TtnRtvX0yqtsj5ucCBskCRjPi6N3/9pGKDLMfZfdymz2G+aZtA4VM/+aGEu8aA4onq
 KRXjr6gbNyAKdC6K0aT8y5F4K//RJnrAbwwxfoPFrjKQUMGLavORFtNe2pdUC4OzVvs899Qdx
 UZKZc3KdrkxBe293WplW0FvrGX8iVtYqlHPQije6V5n4FBJTAO9sLoWflf2YBeXjBCwBfJNQu
 4fbr9x5Lz+W90JxnpVQiWY9mGSZ//LoIMDPVESTqLzGEz1xfy+p0j+eVW23bB6Ij5szq/RFdV
 S6mtXIlfXOcHD0w+pmQpMGA6Jw9VGEO0y2gCbJIYeLAMhe0i2Nz3ZQNa7+Ob9vkNaYCyRC5/f
 4K9WCp0XyPbUwPMSIWIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

> Guenter Roeck <linux@roeck-us.net> hat am 2. September 2018 um 18:49 geschrieben:
> 
> 
> On 09/02/2018 09:26 AM, Stefan Wahren wrote:
> > Hi Guenter,
> > 
> >> Guenter Roeck <linux@roeck-us.net> hat am 2. September 2018 um 16:23 geschrieben:
> >>
> >>
> >> On 09/02/2018 04:20 AM, Stefan Wahren wrote:
> >>> This series is an early stage of the hwmon driver for the fan on the
> >>> Raspberry Pi Power over Ethernet HAT [1]. At the end this should use a
> >>> Device Tree Overlay.
> >>>
> >>> Changes by Stefan based on [2]:
> >>> - reformat the downstream patches for submission
> >>> - drop reboot notification
> >>> - fix remaining checkpatch issues
> >>> - add COMPILE_TEST to Kconfig
> >>>
> >>> The driver is mostly copy & paste from pwm-fan, which isn't good. Personally
> >>> i see two options:
> >>>
> >>> 1) integrate the driver function into the pwm-fan driver (new compatible)
> >>> 2) implement the core function as a PWM driver and use the pwm-fan driver on top
> >>>
> >>
> >> I don't really see the point of thise driver. Why not implement either of those ?
> > 
> > i'm not sure about your question. Since the fan is placed over the SoC, the fan should takes care of the SoC temperature. AFAIK the firmware should have exclusive access to the I2C. So why we need this mailbox interface instead of a I2C driver.
> > 
> 
> The driver sets pwm values. The pwm-fan driver sets pwm values. A pwm driver
> sets pwm values. The pwm-fan driver uses a pwm driver to set pwm values.
> You appear to be arguing that the pwm-fan driver for Rpi is different than
> a pwm-fan driver for all other hardware and should _not_ use a pwm driver
> to set pwm values.

thanks for your explanation. Now i think i understand and sorry for the confusion. We need a driver which translate the pwm values into the mailbox properties. "My" RFC series is only a starting point (not intended for merge and not an option) for a discussion and i'm perfectly fine with 2).
Both options would be feasible in general. I only wanted to know your opinion before i start to implement one of them.

Stefan

> 
> As you don't understand my question, I don't understand your rationale either.
> I will require detailed explanations why 2) is not feasible, and why 1) is not
> feasible either. Until then, NACK.
> 
> Guenter
> 
> >> 2) sounds like a perfect fit to me.
> >>
> >> Guenter
> >>
> >>> [1] - https://www.raspberrypi.org/products/poe-hat/
> >>> [2] - https://github.com/raspberrypi/linux/commit/0f937c8dc3201ebffa6c617c616fd7c65db65959
> >>>
> >>> Serge Schneider (2):
> >>>     dt-bindings: hwmon: Add RPi PoE HAT documentation
> >>>     hwmon: Add RPi PoE HAT fan driver
> >>>
> >>>    .../devicetree/bindings/hwmon/rpi-poe-fan.txt      |  55 +++
> >>>    Documentation/hwmon/rpi-poe-fan                    |  15 +
> >>>    drivers/hwmon/Kconfig                              |  11 +
> >>>    drivers/hwmon/Makefile                             |   1 +
> >>>    drivers/hwmon/rpi-poe-fan.c                        | 414 +++++++++++++++++++++
> >>>    include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
> >>>    6 files changed, 498 insertions(+)
> >>>    create mode 100644 Documentation/devicetree/bindings/hwmon/rpi-poe-fan.txt
> >>>    create mode 100644 Documentation/hwmon/rpi-poe-fan
> >>>    create mode 100644 drivers/hwmon/rpi-poe-fan.c
> >>>
> >>
> > 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
