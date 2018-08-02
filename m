Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C0EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF1B214C5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9sXtzMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF1B214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbeHBKoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:44:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52671 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeHBKoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:44:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so1570270wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kJw4BlWyqBjv5DJBECrdt6R0NlQMEOE5J384cgeY6j0=;
        b=e9sXtzMIJk0S94PK3lLtb0CP4pdF8kRw7OAc44NHCKQYdxbwgSloL+vt6IOpi87C2a
         4NdrdQi1bayZczijdhbyGf9yabFhtKdxTOtQxjZhsO2p5fJ0X/Y4rKfpxPt7sHm+Wpsd
         FtFTSdfP/OiRE/5o0jMORAMx5QNAeZfi1a0C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kJw4BlWyqBjv5DJBECrdt6R0NlQMEOE5J384cgeY6j0=;
        b=G/loK6VhnKlLxqlCphhHi0Kou84wkYk/jeKZceABOVHbAg6YinORvuvNd8Eno8g2aW
         00w03Q57GF435d/yPDrZ51pm+gouJPMPJNnvtItW9iptp5d+8wMq3fsLG0ljKb3DfyX1
         rs2zKDP7fOlBHBvRxtMOr2iysPiEWSD1sZwAR4fDyv/2VMwGldNwFefUxbwMbxbipdR7
         iKcwSKYXIrhWSgPfTCfyridtTm+7cfRgjkRCQ2bFY85Sz8Hbj43PMjcRLvP+1CE368RF
         sIM8AFDgTPUaTvexGChweR93XDqZFsP076oKA1USUoJIGma4qRgEZRpExWQd5mlYuhC8
         432w==
X-Gm-Message-State: AOUpUlFYVRPPwNUQBn1blXpRSUJeZrYTd9EFpRWcT0Ia7v2U7D7ZM4WR
        6gfMFjKZZ4jPWvVFlRQcMh+nvg==
X-Google-Smtp-Source: AAOMgpdY202RsXPHy1G+utneUofBugSR98MB/XxgyDz2Tz6yAb7pIPZR1eONZefXLUFNAsJpoCz1jw==
X-Received: by 2002:a1c:7301:: with SMTP id d1-v6mr1254534wmb.34.1533200043530;
        Thu, 02 Aug 2018 01:54:03 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id j3-v6sm1060511wrt.70.2018.08.02.01.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 01:54:02 -0700 (PDT)
Subject: Re: [PATCH v2 03/10] mfd: wcd9335: add wcd irq support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-4-srinivas.kandagatla@linaro.org>
 <20180802080525.GM4662@dell>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <74081a83-abcf-5529-babb-83a7b5242f68@linaro.org>
Date:   Thu, 2 Aug 2018 09:54:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180802080525.GM4662@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 02/08/18 09:05, Lee Jones wrote:
> On Fri, 27 Jul 2018, Srinivas Kandagatla wrote:
> 
>> WCD9335 supports two lines of irqs INTR1 and INTR2.
>> Multiple interrupts are muxed via these lines.
>> INTR1 consists of all possible interrupt sources like:
>> Ear OCP, HPH OCP, MBHC, MAD, VBAT, and SVA
>> INTR2 is a subset of first interrupt sources like MAD, VBAT, and SVA
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/mfd/Makefile                |   2 +-
>>   drivers/mfd/wcd9335-core.c          |   9 ++
>>   drivers/mfd/wcd9335-irq.c           | 172 ++++++++++++++++++++++++++++++++++++
> 
> Any particular reason for separating out IRQ handling?
No particular reason, I tried to follow what other codecs like wm8994, 
wm8350 and 14 others do.

> 
>>   include/dt-bindings/mfd/wcd9335.h   |  43 +++++++++
>>   include/linux/mfd/wcd9335/wcd9335.h |   3 +
>>   5 files changed, 228 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/mfd/wcd9335-irq.c
>>   create mode 100644 include/dt-bindings/mfd/wcd9335.h
>>
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index a4697370640b..210875afe78a 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -58,7 +58,7 @@ obj-$(CONFIG_MFD_ARIZONA)	+= cs47l24-tables.o
>>   endif
>>   
>>   obj-$(CONFIG_MFD_WCD9335)	+= wcd9335.o
>> -wcd9335-objs			:= wcd9335-core.o
>> +wcd9335-objs			:= wcd9335-core.o wcd9335-irq.o
>>   
>>   obj-$(CONFIG_MFD_WM8400)	+= wm8400-core.o
>>   wm831x-objs			:= wm831x-core.o wm831x-irq.o wm831x-otp.o
>> diff --git a/drivers/mfd/wcd9335-core.c b/drivers/mfd/wcd9335-core.c
>> index 8f746901f4e9..6299dfb63aca 100644
>> --- a/drivers/mfd/wcd9335-core.c
>> +++ b/drivers/mfd/wcd9335-core.c
>> @@ -243,12 +243,20 @@ static int wcd9335_slim_status(struct slim_device *sdev,
>>   		return ret;
>>   	}
>>   
>> +	wcd9335_irq_init(wcd);
> 
> Why don't you check the return value?
> 
> What happens if it defers?
> 
It would not defer here as the regmaps are already setup in probe and 
the status callback is only invoked when the SLIMbus device is up.

I will add the missing checks here.

>>   	wcd->slim_ifd = wcd->slim_ifd;
>>   
>>   	return mfd_add_devices(wcd->dev, 0, wcd9335_devices,
>>   			       ARRAY_SIZE(wcd9335_devices), NULL, 0, NULL);
>>   }
>>   
>> +static void wcd9335_slim_remove(struct slim_device *sdev)
>> +{
>> +	struct wcd9335 *wcd = dev_get_drvdata(&sdev->dev);
>> +
>> +	wcd9335_irq_exit(wcd);
>> +}
>> +
>>   static const struct slim_device_id wcd9335_slim_id[] = {
>>   	{0x217, 0x1a0, 0x1, 0x0},
>>   	{}
>> @@ -259,6 +267,7 @@ static struct slim_driver wcd9335_slim_driver = {
>>   		.name = "wcd9335-slim",
>>   	},
>>   	.probe = wcd9335_slim_probe,
>> +	.remove = wcd9335_slim_remove,
>>   	.device_status = wcd9335_slim_status,
>>   	.id_table = wcd9335_slim_id,
>>   };
>> diff --git a/drivers/mfd/wcd9335-irq.c b/drivers/mfd/wcd9335-irq.c
>> new file mode 100644
>> index 000000000000..84098c89419b
>> --- /dev/null
>> +++ b/drivers/mfd/wcd9335-irq.c
>> @@ -0,0 +1,172 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018, Linaro Limited
>> +//
> 
> Blank line?
> 
Yep.

>> +#include <linux/gpio.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/regmap.h>
>> +#include <linux/of_irq.h>
>> +#include <dt-bindings/mfd/wcd9335.h>
>> +#include <linux/mfd/wcd9335/wcd9335.h>
>> +#include <linux/mfd/wcd9335/registers.h>
> 
> Please place in alphabetical order.
> 
sure!

>> +static const struct regmap_irq wcd9335_irqs[] = {
>> +	/* INTR_REG 0 */
>> +	[WCD9335_IRQ_SLIMBUS] = {
>> +		.reg_offset = 0,
>> +		.mask = BIT(0),
>> +	},
> 
> [snipped approx 1,000,000 entries]
> 
>> +	[WCD9335_IRQ_SVA_OUTBOX2] = {
>> +		.reg_offset = 3,
>> +		.mask = BIT(6),
>> +	},
>> +};
> 
> Please use REGMAP_IRQ_REG() to significantly reduce the diff.
> 

Nice, that looks good, I will use that in next version.

>> +static const struct regmap_irq_chip wcd9335_regmap_irq1_chip = {
>> +	.name = "wcd9335_pin1_irq",
>> +	.status_base = WCD9335_INTR_PIN1_STATUS0,
>> +	.mask_base = WCD9335_INTR_PIN1_MASK0,
>> +	.ack_base = WCD9335_INTR_PIN1_CLEAR0,
>> +	.type_base = WCD9335_INTR_LEVEL0,
>> +	.num_regs = 4,
>> +	.irqs = wcd9335_irqs,
>> +	.num_irqs = ARRAY_SIZE(wcd9335_irqs),
>> +};
>> +
>> +int wcd9335_irq_init(struct wcd9335 *wcd)
>> +{
>> +	int ret;
> 
> '\n' here.

yep!

> 
>> +	/*
>> +	 * INTR1 consists of all possible interrupt sources Ear OCP,
>> +	 * HPH OCP, MBHC, MAD, VBAT, and SVA
>> +	 * INTR2 is a subset of first interrupt sources MAD, VBAT, and SVA
>> +	 */
>> +	wcd->intr1 = of_irq_get_byname(wcd->dev->of_node, "intr1");
>> +	if (wcd->intr1 < 0 || wcd->intr1 == -EPROBE_DEFER) {
>> +		dev_err(wcd->dev, "Unable to configure irq\n");
> 
> Nit: s/irq/IRQ/
> 
> Do you really want to issue an error message for -EPROBE_DEFER?
> 
> This maybe confusing if it is initiated later.

Thanks for spotting this, I will take a closer look at this error path 
and handle the DEFER case correctly in next version!
> 
>> +		return wcd->intr1;
>> +	}
>> +
>> +	ret = regmap_add_irq_chip(wcd->regmap, wcd->intr1,
>> +				 IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> +				 0, &wcd9335_regmap_irq1_chip,
>> +				 &wcd->irq_data);
>> +	if (ret != 0) {
> 
> "if (ret)"
> 
Yep!

>> +		dev_err(wcd->dev, "Failed to register IRQ chip: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int wcd9335_irq_exit(struct wcd9335 *wcd)
>> +{
>> +	regmap_del_irq_chip(wcd->intr1, wcd->irq_data);
> 
> '\n' here.
yep!
> 
>> +	return 0;
>> +}
> 
> Or better still, make this a void and remove the superfluous return.

Makes sense, I will give that a try in next version.
