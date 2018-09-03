Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E21C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B13720843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B13720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeICXR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:17:26 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38233 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeICXRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:17:25 -0400
Received: from null ([172.19.249.173]) by mrelayeu.kundenserver.de (mreue102
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MHYCK-1ftcDB1nx6-003MpC; Mon, 03
 Sep 2018 20:55:09 +0200
Date:   Mon, 3 Sep 2018 20:55:06 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>, serge@raspberrypi.org,
        linux-rpi-kernel@lists.infradead.org,
        Eric Anholt <eric@anholt.net>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Phil Elwell <phil@raspberrypi.org>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org
Message-ID: <698422655.399555.1536000906069@email.1und1.de>
In-Reply-To: <642d46f3-7c1d-2b97-5d49-8772c75be530@gmail.com>
References: <1535887251-29515-1-git-send-email-stefan.wahren@i2se.com>
 <99ca4f6d-d2b2-36e7-9f27-189df379cfaf@roeck-us.net>
 <67224834.51159.1535905604770@email.1und1.de>
 <e8d4e69c-2668-2794-6474-79749bf8b577@roeck-us.net>
 <829194253.51526.1535908415057@email.1und1.de>
 <642d46f3-7c1d-2b97-5d49-8772c75be530@gmail.com>
Subject: Re: [PATCH RFC 0/2] hwmon: Add RPi PoE HAT fan driver
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev36
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:rFHsk3cf/BponRJoEb9q4NZtbCPm25NckiyxgrNiqv08YiZr39Z
 2OIV9rMdsPbmjtKGk7aUuCojTjZmRNj+lDF0rEkCTbb/RA7fw8hBxYwgrAJFF4efCOCcLEO
 I0unmaHWPXNfzOWsAxEpYOBRJxOlGN5q2aopZnPh31rXdDMoeTQ0EcDqOyHAY6YQRhZhOnE
 lo0GeXl0gQFUnm1kDbzIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:02cPqEk0lpQ=:86ZjBSnNwbQOtjYsGgQaFM
 wkg2vuWebNrhJiTaP/cElEnxctFiQM939LL6R3heS3VUys/agW84HkQiVgwGlEOVguY3eaK+w
 EHWXTlS+do134YAk+jtXDLbJoxMarvQMuVuO+NWyhSmy/ATjhNJVPuSt4UFDmxdDcmHx7fqaB
 YNDtAZfMkV0MBr7bDZiXSupJ63v2oc0TpylR9XcdMcqknCtslyjcpi1dITFvYSOuF5iK/f2w5
 QLt4vLsfLBPuGkkvtPXB8FTTCskP0PXtIzm8GM8/2oooO30X/Lt/5qacrUf4pTbHA1EEivnfO
 oGgqgwOdDOlC44DXmN9R7FzzZO+o85blHaHvqif6vvrZtyCaKQ5mlU+mX0RsoSCLo3Nmeq7zi
 YE2en4Ibry423G8+VDrNi1axbv+ecVJvE9pFoN3drApGhXhvwOMZIVXOKRp5ESVAMv6pV16Rh
 WDYNEaNjINznwSKG7NgkIsd5DUDP71GO5P1wT5ppe6ba1ZmUGzhNV0CARJCuPYoBoNXHrQZBR
 Z4Eab/Ei48zsjuLFxp6bHVbkh6i9sQGmmYwgrIZa5aQ7BRFOPwF30WrcSK81HulgvV/+6nC9f
 cp4kZjeDYOsh16oDb6OxSSoxl8m+LteSywDsomNASV+O/yzhxi/G7UFV/tGvud6qUYlTdiVCe
 rcmGkF8EMsIFEJvlTH/AdasleYWU89iHIIYyaFcvJ8LRqd66njRRpekopU9IDDgAXg/7o2FzM
 D95A+Wag84i68HZ1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Florian Fainelli <f.fainelli@gmail.com> hat am 3. September 2018 um 20:31 geschrieben:
> 
> 
> 
> 
> On 9/2/2018 10:13 AM, Stefan Wahren wrote:
> > Hi Guenter,
> > 
> >> Guenter Roeck <linux@roeck-us.net> hat am 2. September 2018 um 18:49 geschrieben:
> >>
> >>
> >> On 09/02/2018 09:26 AM, Stefan Wahren wrote:
> >>> Hi Guenter,
> >>>
> >>>> Guenter Roeck <linux@roeck-us.net> hat am 2. September 2018 um 16:23 geschrieben:
> >>>>
> >>>>
> >>>> On 09/02/2018 04:20 AM, Stefan Wahren wrote:
> >>>>> This series is an early stage of the hwmon driver for the fan on the
> >>>>> Raspberry Pi Power over Ethernet HAT [1]. At the end this should use a
> >>>>> Device Tree Overlay.
> >>>>>
> >>>>> Changes by Stefan based on [2]:
> >>>>> - reformat the downstream patches for submission
> >>>>> - drop reboot notification
> >>>>> - fix remaining checkpatch issues
> >>>>> - add COMPILE_TEST to Kconfig
> >>>>>
> >>>>> The driver is mostly copy & paste from pwm-fan, which isn't good. Personally
> >>>>> i see two options:
> >>>>>
> >>>>> 1) integrate the driver function into the pwm-fan driver (new compatible)
> >>>>> 2) implement the core function as a PWM driver and use the pwm-fan driver on top
> >>>>>
> >>>>
> >>>> I don't really see the point of thise driver. Why not implement either of those ?
> >>>
> >>> i'm not sure about your question. Since the fan is placed over the SoC, the fan should takes care of the SoC temperature. AFAIK the firmware should have exclusive access to the I2C. So why we need this mailbox interface instead of a I2C driver.
> >>>
> >>
> >> The driver sets pwm values. The pwm-fan driver sets pwm values. A pwm driver
> >> sets pwm values. The pwm-fan driver uses a pwm driver to set pwm values.
> >> You appear to be arguing that the pwm-fan driver for Rpi is different than
> >> a pwm-fan driver for all other hardware and should _not_ use a pwm driver
> >> to set pwm values.
> > 
> > thanks for your explanation. Now i think i understand and sorry for the confusion. We need a driver which translate the pwm values into the mailbox properties. "My" RFC series is only a starting point (not intended for merge and not an option) for a discussion and i'm perfectly fine with 2).
> > Both options would be feasible in general. I only wanted to know your opinion before i start to implement one of them.
> 
> Is not there a way to expose the PWM pins directly to the kernel instead 
> of going through the firmware to do that for us? I am just asking 
> because sometimes this appears to be possible, guess not in this case?

According to this blog entry (no schematics available so far) [1], this is my understanding of the fan control:

| Raspberry Pi 3B+               | PoE HAT               |         
ARM core -Mailbox-> VideoCore4 -I2C-> Atmel MCU -PWM-> FAN

The only chance would be to bypass VC4 and talk to the Atmel microcontroller directly. But this would require a specification of the I2C protocol or some time of reverse engineering.

Maybe the foundation guys can say something about that?

[1] - https://www.raspberrypi.org/blog/introducing-power-over-ethernet-poe-hat/

> -- 
> Florian
