Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE5CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986C6206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986C6206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeK2XXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:23:02 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:33739 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeK2XXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:23:02 -0500
Received: from [10.28.16.74] (10.28.16.74) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 29 Nov
 2018 20:18:03 +0800
Subject: Re: [PATCH 2/2] i2c: meson: add support for Meson G12A SoC I2C
 controller
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
 <1543489197-183181-3-git-send-email-jian.hu@amlogic.com>
 <865b607c-8419-9c9e-0a00-018e87adf8de@baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <c6dc485a-1399-62ef-36c0-a062fbd311fd@amlogic.com>
Date:   Thu, 29 Nov 2018 20:18:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <865b607c-8419-9c9e-0a00-018e87adf8de@baylibre.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.16.74]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 2018/11/29 19:26, Neil Armstrong wrote:
> On 29/11/2018 11:59, Jian Hu wrote:
>> Add compatible and data for G12A I2C controller.
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> ---
>>   drivers/i2c/busses/i2c-meson.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
>> index 90f5d04..b86eed7 100644
>> --- a/drivers/i2c/busses/i2c-meson.c
>> +++ b/drivers/i2c/busses/i2c-meson.c
>> @@ -462,10 +462,15 @@ static int meson_i2c_remove(struct platform_device *pdev)
>>   	.div_factor = 3,
>>   };
>>   
>> +static const struct meson_i2c_data i2c_g12a_data = {
>> +	.div_factor = 3,
> 
> Especially if the div_factor is the same as AXG.
> 
> If you have some other fixes for G12a in the pipe, you will add the new compatible and meson_i2c_data later,
> for the div_factor, simply use the axg struct and compatible.
> 
> Neil
> 
For axg and g12a SoC, the div_factor is the same, and I have confirmed 
that they share the same IP. I prefer g12a uses axg's compatible and 
data if it is reasonable. I will just submit the i2c controller node in 
meson-g12a.dtsi.
>> +};
>> +
>>   static const struct of_device_id meson_i2c_match[] = {
>>   	{ .compatible = "amlogic,meson6-i2c", .data = &i2c_meson6_data },
>>   	{ .compatible = "amlogic,meson-gxbb-i2c", .data = &i2c_gxbb_data },
>>   	{ .compatible = "amlogic,meson-axg-i2c", .data = &i2c_axg_data },
>> +	{ .compatible = "amlogic,meson-g12a-i2c", .data = &i2c_g12a_data },
>>   	{},
>>   };
>>   
>>
> 
> .
> 
