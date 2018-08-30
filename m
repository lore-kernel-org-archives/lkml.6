Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5274FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FB4205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FB4205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeH3JzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 05:55:02 -0400
Received: from ms.tdt.de ([195.243.126.94]:55129 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbeH3JzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 05:55:01 -0400
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 6302A20060;
        Thu, 30 Aug 2018 05:54:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 30 Aug 2018 07:54:31 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     =?UTF-8?Q?Piotr_Kr=C3=B3l?= <piotr.krol@3mdeb.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: Add driver for PC Engines APU2/APU3 GPIOs
In-Reply-To: <dc367319-8877-83cf-42e0-e3f7e8e14a7a@3mdeb.com>
References: <20180801111243.2848-1-fe@dev.tdt.de>
 <CAHp75VdNf8BCYEq348CQe2OUUOLdYehsr5TmBDQXXEAm59+kDg@mail.gmail.com>
 <dc367319-8877-83cf-42e0-e3f7e8e14a7a@3mdeb.com>
Message-ID: <105943b718ecffbd17a34082130e0f31@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-24 12:56, Piotr Król wrote:
> On 08/03/2018 09:08 PM, Andy Shevchenko wrote:
> 
> Hi Andy,
> 
> (...)
> 
>>> +#define APU_FCH_ACPI_MMIO_BASE 0xFED80000
>>> +#define APU_FCH_GPIO_BASE      (APU_FCH_ACPI_MMIO_BASE + 0x1500)
>> 
>> Wow! Can we see ACPI tables for these boards? Care to share (via some
>> file share service) output of `acpidump -o tables.dat` ?
> 
> Please find acpidump [1]. FYI I'm PC Engines firmware maintainer
> (firmware is coreboot based), so I can fix required things. I'm pretty
> sure that ACPI tables are not in best shape.
> 

Thanks for the dump,

By the way I have seen that the driver
https://github.com/torvalds/linux/blob/master/drivers/gpio/gpio-amdpt.c
is using the acpi to get the mmio address. I think this is the way to go
to get the acpi mmio address in the gpio-apu driver as well.

What is the right "acpi_device_id" for the APU3?
https://github.com/torvalds/linux/blob/master/drivers/gpio/gpio-amdpt.c#L146

