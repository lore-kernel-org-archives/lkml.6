Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DD2C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB0E21456
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uIrEjdny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB0E21456
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeFYQXg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:23:36 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36941 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeFYQXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:23:33 -0400
Received: by mail-ot0-f195.google.com with SMTP id u6-v6so7527807otk.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nSJdkIHoSZPbWDl725TldO+8C/CZaIidvzHbVqbgSOc=;
        b=uIrEjdny1bPa6duSbjH8UADJBsJDXj6KStaR5+elaLn/IpJdutrQVpcUquLKYkNpo6
         PBSmCvdoQGaGGfpGBDAL96oy6kUFhxJhi2SgQi82LMih662EyCitMmAe1vVzl7y9f6pl
         3AI2LcJdZ/t8cWl63kpcU9stEJp7iWi87gnToR0/2HQSv+DCIl6PldzxHKEKKxBQAtdq
         Vf7hvKBW4Ut0aYjGQeflp4dvmqsCr8LJX5lVJfinyoWG25mAEBN/1RzTIR/6u35CPK8s
         hOy43bZnI6xIhs4xht1mVio0uV0wvIjc4tG839wavfC1w7GDjyRcB+giyeK45WMMhWLy
         t07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nSJdkIHoSZPbWDl725TldO+8C/CZaIidvzHbVqbgSOc=;
        b=RHNePLETu9wGkVKmpyli05RGd1phJ87yorCJ7gIsDVTDQZW/+085/zH1rvBppt+FHL
         a4/1eQqvSPVZGZz4073HYbQ6mKro95jAfYnaknizJueRsK5o8BQlbUh9+npEMdvogMO4
         cC/RH/WOchSsqIpyjm9TaKjgK6hfiYdfsetaKWi3LBKzq4c6KTZAMkSYUF4xgjiCdAGL
         Yfg1xesvsyZw/LeluD6NURHOBTPm3iV+MOuRupZl3HuKB5zkb8c1g5TbLQ2D3kgbKsTA
         CIoxo+T4JDSGE+4YlVvOGpXElyDmpFBc5EqlnDe8FYrYxYH28pICfjZ5qwsqG5frOUxf
         LT3Q==
X-Gm-Message-State: APt69E11gqYiyZE+eKaS4CffLELToNIeU+gkalXYfuAiOJN1o+iXr76A
        AiBp+VDlhr1zqp6PxPFh2ArxcSxKyZpQ0ZGvHj/8Ew==
X-Google-Smtp-Source: AAOMgpeeg5IUXekaeljEeiO01Uj6O+QDan3Xz/FthnB7RnAEUbAhoPhWYoCsiiD5OtNy+ThpxRE6ueAiM1X6GQYnGYg=
X-Received: by 2002:a9d:5a99:: with SMTP id w25-v6mr7536609oth.130.1529943812622;
 Mon, 25 Jun 2018 09:23:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2c15:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 09:23:32
 -0700 (PDT)
In-Reply-To: <0e4bc2fb-15fc-6422-a4a3-0918adf0b1b3@lechnology.com>
References: <20180625152920.11549-1-brgl@bgdev.pl> <20180625152920.11549-7-brgl@bgdev.pl>
 <0e4bc2fb-15fc-6422-a4a3-0918adf0b1b3@lechnology.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 25 Jun 2018 18:23:32 +0200
Message-ID: <CAMpxmJXtH9ibXS55iP-aFGTgd19hSafZdb+hFhPyA8u9arOSfg@mail.gmail.com>
Subject: Re: [PATCH 6/9] ARM: davinci: da830-evm: use aemif platform driver
To:     David Lechner <david@lechnology.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-25 18:20 GMT+02:00 David Lechner <david@lechnology.com>:
> On 06/25/2018 10:29 AM, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We now support board files in the aemif driver. Register a platform
>> device instead of using the handcrafted API in da830-evm.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>   arch/arm/mach-davinci/board-da830-evm.c | 56 +++++++++++++++++++------
>>   1 file changed, 44 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/board-da830-evm.c
>> b/arch/arm/mach-davinci/board-da830-evm.c
>> index b2470141dba3..666db3cee08a 100644
>> --- a/arch/arm/mach-davinci/board-da830-evm.c
>> +++ b/arch/arm/mach-davinci/board-da830-evm.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/platform_data/mtd-davinci-aemif.h>
>>   #include <linux/platform_data/spi-davinci.h>
>>   #include <linux/platform_data/usb-davinci.h>
>> +#include <linux/platform_data/ti-aemif.h>
>>   #include <linux/regulator/machine.h>
>>     #include <asm/mach-types.h>
>> @@ -333,14 +334,48 @@ static struct resource da830_evm_nand_resources[] =
>> {
>>         },
>>   };
>>   -static struct platform_device da830_evm_nand_device = {
>> -       .name           = "davinci_nand",
>> -       .id             = 1,
>> -       .dev            = {
>> -               .platform_data  = &da830_evm_nand_pdata,
>> +static struct platform_device da830_evm_aemif_devices[] = {
>> +       {
>> +               .name           = "davinci_nand",
>> +               .id             = 1,
>
>
> Actually, now that I've thought about it some more. It probably
> makes more sense to make all of the "davinci_nand" devices in this
> series use id = -1 since there is only one per board. It looks like
> da850 is the only one that has a lookup for "davinic_nand.0" already.
>
> I think that we are going to have to add clock lookups for the
> "davinci_nand" devices as well. Although the driver doesn't do
> clk_get() explicitly, I think some function it calls does get a
> clock. I remember that we had to add a clock-ranges property to
> device tree to get the davinci_nand driver working, which is why
> I think we are going to need a clock lookup for these devices
> as well.
>

Seems like ever since commit a8e3923ab571 ("mtd: rawnand: davinci:
don't acquire and enable clock") we no longer need to worry about the
clock entries for nand.

Thanks,
Bart
