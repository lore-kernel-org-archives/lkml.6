Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C0FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38FD2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rT7I4hua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38FD2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeLJTF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:05:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55370 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeLJTF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:05:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so12039745wmc.5;
        Mon, 10 Dec 2018 11:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6u3uYKORfQlqLJiGM74qw/k+wkzZkxkDL0+CkHi7Tx4=;
        b=rT7I4huaVlIFCQmZvQ3Q3qH5s8pFhnSlzaFGjGHNTtc1rmtGf9l6MAyY9i2lxaOmba
         Blvu79rOFkHYl4yHcjpqIfnwIhSO5ffSQz8YZc8cupJPLO8i9D0lKuz43Uccj+RJnk+Z
         d7+O+xf5/FcqzQyymY5xJR/ZuDdRSpaAjZ2MCjEUafpsW6TgZjTuJz1SMmTUknA5rDR1
         bjVKFG9xP8Fj5H0XrxC0e+znDL3snAJ4Ei9VtGOB6jfFbOdegzZWAeiHbF/XVRRH4cIb
         QTJN1iVxKpHMLt5TqUvYxhe6cRRHDcBqah+iVgbBDWJNnyhOp9DMXxqV4LuapyeaShIs
         dPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6u3uYKORfQlqLJiGM74qw/k+wkzZkxkDL0+CkHi7Tx4=;
        b=U8xtIVkw8rFYiHF+O45xzJJyshbqvJS2/NrMrG4Zjlh/U/tRIFSONIyDnRarINNuHx
         l6OjF3FXbaUebeZMr0ryOgrDvZoObvCcM0L2Nx6WvLxRZdHl3cmIzB0j5uWP8jgYrOXi
         5Gz03dkGp7x91hTZJp5e8w28xcCi2Uc9gIW0X6Ox5QnM+8xtg3QupZWo1r2PDRVNR0oT
         AthqBe6GW6gpUkPSbSlY1zGkYCQXdSmk3VcpsJ/foqmZ9Q3JaBZE+hXLrUS4AL9K8rmr
         YOLQwbGZyHWfNLFor+qz3cutQZrJQHV5zibCl0eR6qk7tMWuXAmia+3wRpAN9fmfarLM
         DTaA==
X-Gm-Message-State: AA+aEWZrBhYbGbYP6+o+BafOh4eMhQFl/CvkLW79usH2znSvrZf7E6jS
        3HM14WHbnEs5C6/ZSS1eoQ0=
X-Google-Smtp-Source: AFSGD/X/6bRVvMeax9TAd8Q3h8TDKpkN33A4yUjw3OnFdYeSO5M7KDDQacVr+Sv/B3X49/gV8g+RGg==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr12524198wmg.42.1544468725813;
        Mon, 10 Dec 2018 11:05:25 -0800 (PST)
Received: from gapa-lenovo-ideapad-y580.home (dbq157.neoplus.adsl.tpnet.pl. [83.23.42.157])
        by smtp.googlemail.com with ESMTPSA id j8sm15319284wmd.0.2018.12.10.11.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 11:05:24 -0800 (PST)
Message-ID: <1544468722.17722.45.camel@gmail.com>
Subject: Re: [PATCH 0/5] Add support for STM32F4 SPI
From:   Cezary =?UTF-8?Q?Gapi=C5=84ski?= <cezary.gapinski@gmail.com>
To:     Amelie DELAUNAY <amelie.delaunay@st.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>
Date:   Mon, 10 Dec 2018 20:05:22 +0100
In-Reply-To: <ede8544f-c71d-0901-5522-e97215d23f85@st.com>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
         <ede8544f-c71d-0901-5522-e97215d23f85@st.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amelie,

On Mon, 2018-12-10 at 12:37 +0000, Amelie DELAUNAY wrote:
> Hi Cezary,
> 
> On 12/9/18 2:53 PM, cezary.gapinski@gmail.com wrote:
> > 
> > From: Cezary Gapinski <cezary.gapinski@gmail.com>
> > 
> > This series of patches adds support for first generation of SPI
> > interface
> > for STM32F4 family.
> > 
> First of all, thanks for adding STM32F4 SPI support.

Thanks for your answer and hints for correct approach to this driver.

> > 
> > This version of driver is mostly different to STM32H7 one. Based on
> > linux
> > kernel I2C drivers for STM32 where drivers were splited into
> > STM32F4 and
> > STM32F7 family the same approach seems to be sufficient for SPI
> > STM32
> > drivers. Therefore STM32H7 driver was moved to spi-stm32h7.c file
> > and
> > register and functions were renamed to be more specific to STM32H7.
> > 
> You're right, STM32F4 SPI is slightly different from STM32H7 one: 
> register map/bits offsets are different and STM32H7 has an RX and TX
> FIFO.
> But if you have a look on STM32F7 SPI [1], you'll see that STM32F7
> SPI 
> is based on STM32F4 SPI with new features (data frames & FIFOs) also 
> available on STM32H7 SPI.
> 
> That's why STM32H7 SPI driver was called spi-stm32. The goal was to
> use 
> compatible & match data to differentiate each STM32Fx specificities.
> 
> You can have a look on how it is managed in drivers/rtc/rtc-stm32.c
> (the 
> same driver covers 2 HW version of STM32 RTC), or in 
> drivers/iio/dac/stm32-dac-core.c and stm32-dac.c (the same driver
> also 
> covers 2 HW version of STM32 DAC).
> As your spi-stm32f4.c file is highly based on the existing spi-
> stm32.c 
> file, I think that common code could be factored and specificities
> could 
> be handled with compatible and match data.

I have seen these drivers before. I have been trying to do this for my
previous approach and it is still on my second branch. There was not
too much common parts and I have stuck with complex compatible data
configurations. I thought that was too verbose, therefore I resigned
for it and have gone into idea with two totally different files. I
think I need to get down again to idea you proposed. 

It seems to be more difficult approach and it is gonna take a while
before I send second version of these patches.

Regards,
Cezary

> Regards,
> Amelie
> [1] 
> https://www.st.com/content/ccc/resource/technical/document/reference_
> manual/c5/cf/ef/52/c0/f1/4b/fa/DM00124865.pdf/files/DM00124865.pdf/jc
> r:content/translations/en.DM00124865.pdf
> 
> > 
> > For current version master mode with full-duplex and 8/16 bit data
> > frame
> > format are supported. There is no TX and RX FIFOs like in STM32H7.
> > DMA capabilility is supported for messages longer than arbitrary
> > number
> > of bytes (that is set already to 16 bytes) when TX and RX channels
> > are
> > set at the same time.
> > 
> > Cezary Gapinski (5):
> >    spi: stm32: rename STM32 SPI registers and functions to STM32H7
> >    spi: stm32: rename spi-stm32 to spi-stm32h7
> >    spi: stm32: add driver for STM32F4 controller
> >    ARM: dts: stm32: add SPI support on STM32F429 SoC
> >    spi: stm32: add description about STM32F4 bindings
> > 
> >   .../devicetree/bindings/spi/spi-stm32.txt          |    9 +-
> >   arch/arm/boot/dts/stm32f429.dtsi                   |   60 +
> >   drivers/spi/Kconfig                                |   18 +-
> >   drivers/spi/Makefile                               |    3 +-
> >   drivers/spi/spi-stm32.c                            | 1322 -----
> > --------------
> >   drivers/spi/spi-stm32f4.c                          | 1002
> > +++++++++++++++
> >   drivers/spi/spi-stm32h7.c                          | 1340
> > ++++++++++++++++++++
> >   7 files changed, 2424 insertions(+), 1330 deletions(-)
> >   delete mode 100644 drivers/spi/spi-stm32.c
> >   create mode 100644 drivers/spi/spi-stm32f4.c
> >   create mode 100644 drivers/spi/spi-stm32h7.c
