Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FC5C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A39023D06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lpb7Q1ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A39023D06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965520AbeF1Tzl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:55:41 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37536 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965337AbeF1Tzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:55:40 -0400
Received: by mail-wr0-f193.google.com with SMTP id k6-v6so6664043wrp.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kkNhqenB8MhpFWi7dzM5+PzGYmdvdl9wNRtG9QyBVLs=;
        b=Lpb7Q1kuNPrO5vltcjtQ1N++dTAeD/3upA6fkGMlR7f2MOH0WKZGfT/MgykurxiBED
         0YWZFH7k1UzPtsfcLN0QFXS2dNZlsczArDgDHKVz5hasmP/b93osn2O5/f/VN+xLcw8L
         b8X2A2NtTq3LCYJOp9dLbcuVV7T7fliUxkHDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kkNhqenB8MhpFWi7dzM5+PzGYmdvdl9wNRtG9QyBVLs=;
        b=oHN141J4omr4Ut1kjJgG81n9dKOVeX+vK5pw+7Xltiu1pbaubQEqqTIxBr5rVpd1Hq
         8Wm42JAjTu3HMZ74NjQhPWuG1eZCMZ3k4+SS6qnH7oOI8F5AuNpBOaaqm8eM9FUzfMXm
         pVzQsLCdBCQlxAO7aQWTszqd/WAQNM0jewAxm1u72dwH0jRanLoqpNZoF2EII+V9BaXS
         fakBJUSe4jzZYAuLnG1R/SORRZbNi1zoFcSbx6HzsGqOQVSYvRFj0naXzyTGUTZiFCKi
         Rfj7e8W4cQjGUUzv+Am5uY44FeXjNwzIq+Zmg/ZbsxAwJonaoguALd7Ry6UcqCf1rNl6
         CmTw==
X-Gm-Message-State: APt69E2maX/14gTbHITHO54OJSa6NsUo5q/WgjtJ6iU+jtXufh0dIO1H
        0Jlegpz6xR+wuGzXsd2M1p+wL9bHYSw=
X-Google-Smtp-Source: AAOMgpeAYNRFcVzocRy0EX3LgeLcUhZ4jEu5z9dIyn2pY3lOJMCoN/UyovUaZMEGOL2O/9BSqBv4CQ==
X-Received: by 2002:adf:e90c:: with SMTP id f12-v6mr1411441wrm.126.1530215738540;
        Thu, 28 Jun 2018 12:55:38 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:3923:5e2e:38ae:83dc? ([2001:41d0:fe90:b800:3923:5e2e:38ae:83dc])
        by smtp.googlemail.com with ESMTPSA id r14-v6sm4917553wrl.4.2018.06.28.12.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 12:55:37 -0700 (PDT)
Subject: Re: [PATCH v5 1/6] ARM: at91: add TCB registers definitions
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180619211929.22908-1-alexandre.belloni@bootlin.com>
 <20180619211929.22908-2-alexandre.belloni@bootlin.com>
 <1bc64ccb-1e22-364c-e08c-fa86692783ff@linaro.org>
 <20180628183409.GS4207@piout.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0c5f2b1b-a910-7d76-b169-a85d67a9faae@linaro.org>
Date:   Thu, 28 Jun 2018 21:55:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628183409.GS4207@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2018 20:34, Alexandre Belloni wrote:
> On 28/06/2018 17:15:39+0200, Daniel Lezcano wrote:
>> On 19/06/2018 23:19, Alexandre Belloni wrote:
>>> Add registers and bits definitions for the timer counter blocks found on
>>> Atmel ARM SoCs.
>>>
>>> Tested-by: Alexander Dahl <ada@thorsis.com>
>>> Tested-by: Andras Szemzo <szemzo.andras@gmail.com>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>> ---
>>>  include/soc/at91/atmel_tcb.h | 216 +++++++++++++++++++++++++++++++++++
>>
>> Is the header necessary ? Can it be moved in the .c ?
>>
> 
> Ultimately, the clocksource driver will not be the only one to use it.
> There is the pwm driver that will be converted (it was converted in the
> first version of the series). and then there is a counter driver that
> will be submitted once the subsystem is upstreamed.

Ok.

>>>  1 file changed, 216 insertions(+)
>>>  create mode 100644 include/soc/at91/atmel_tcb.h
>>>
>>> diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
>>> new file mode 100644
>>> index 000000000000..3ed66031fc76
>>> --- /dev/null
>>
>> [ ... ]
>>
>>> +static inline struct clk *tcb_clk_get(struct device_node *node, int channel)
>>> +{
>>> +	struct clk *clk;
>>> +	char clk_name[] = "t0_clk";
>>> +
>>> +	clk_name[1] += channel;
>>
>> clever :)
>>
>>> +	clk = of_clk_get_by_name(node->parent, clk_name);
>>> +	if (!IS_ERR(clk))
>>> +		return clk;
>>> +
>>> +	return of_clk_get_by_name(node->parent, "t0_clk");
>>
>> Why do you want to return clk from t0_clk if another channel is
>> requested ? This is prone to error.
> 
> The newer TCBs only have one peripheral clocks. The current DT binding only
> have t0_clk in that case so whatever the channel, t0_clk is the correct
> one.
> 
>>
>> I would clarify that at the caller level, if tcb_clk_get fails then try
>> with channel zero.
> 
> This was hidden from the individual drivers by tclib but this can be
> open coded in the drivers.
> 
>>
>>> +}
>>> +
>>> +static inline int tcb_irq_get(struct device_node *node, int channel)
>>
>> no inline
>>
> 
> IIRC, removing the inline will make linking the kernel fail when there
> is more than 2 drivers using the TCBs but I'll try again. Or I can
> remove both those functions and open code as you suggest.

Yes, preferable to remove these functions.

>>> +{
>>> +	int irq;
>>> +
>>> +	irq = of_irq_get(node->parent, channel);
>>> +	if (irq > 0)
>>> +		return irq;
>>> +
>>> +	return of_irq_get(node->parent, 0);
>>
>> Same comment than above.
>>
>>> +}
>>> +
>>> +static const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
>>> +
>>> +struct atmel_tcb_info {
>>> +	int bits;
>>> +};
>>> +
>>> +static const struct atmel_tcb_info atmel_tcb_infos[] = {
>>> +	{ .bits = 16 },
>>> +	{ .bits = 32 },
>>> +};
>>
>> Structuring the code with structure is a good practice. However, this is
>> too much :)
>>
> 
> I was going to add the divisor there but as AVR32 is gone, this is
> indeed unnecessary.
> 
>>> +static const struct of_device_id atmel_tcb_dt_ids[] = {
>>> +	{
>>> +		.compatible = "atmel,at91rm9200-tcb",
>>> +		.data = &atmel_tcb_infos[0],
>>
>> 		.data = (void *)16;
>>
>>> +	}, {
>>> +		.compatible = "atmel,at91sam9x5-tcb",
>>> +		.data = &atmel_tcb_infos[1],
>>> +	}, {
>>> +		/* sentinel */
>>> +	}
>>> +};
>>> +
>>
>>
>>
>>> +#endif /* __SOC_ATMEL_TCB_H */
>>>
>>
>>
>> -- 
>>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

