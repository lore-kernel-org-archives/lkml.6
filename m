Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCF3C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45C4216E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45C4216E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeHOIZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 04:25:34 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:44106 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeHOIZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 04:25:34 -0400
Received: from [10.28.16.194] (10.28.16.194) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 15 Aug
 2018 13:35:08 +0800
Subject: Re: [PATCH 1/2] dt-bindings: clk: meson-g12a: Add G12A AO Clock
 Bindings
To:     Rob Herring <robh@kernel.org>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1533894868-85815-1-git-send-email-jian.hu@amlogic.com>
 <1533894868-85815-2-git-send-email-jian.hu@amlogic.com>
 <20180814204801.GA9362@rob-hp-laptop>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <486c8771-ccbe-2f9b-e1e6-1ac9549432f0@amlogic.com>
Date:   Wed, 15 Aug 2018 13:35:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814204801.GA9362@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.16.194]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/15 4:48, Rob Herring wrote:
> On Fri, Aug 10, 2018 at 05:54:27PM +0800, Jian Hu wrote:
>> Add new clock controller compatible and dt-bingdings headers
>> for the Always-On domain of the g12a SoC
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> ---
>>   .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  1 +
>>   include/dt-bindings/clock/g12a-aoclkc.h            | 28 ++++++++++++++++++++++
>>   2 files changed, 29 insertions(+)
>>   create mode 100755 include/dt-bindings/clock/g12a-aoclkc.h
> 
> checkpatch says wrong mode.
Yes, I have checked the g12a-aoclk.h file,It is wrong mode. I will chmod 
a-x for it.Thank you for review.
> 
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
>> index 3a88052..6f02288 100644
>> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
>> @@ -10,6 +10,7 @@ Required Properties:
>>   	- GXL (S905X, S905D) : "amlogic,meson-gxl-aoclkc"
>>   	- GXM (S912) : "amlogic,meson-gxm-aoclkc"
>>   	- AXG (A113D, A113X) : "amlogic,meson-axg-aoclkc"
>> +	- G12A (S905D2, S905X2) : "amlogic,g12a-aoclkc"
>>   	followed by the common "amlogic,meson-gx-aoclkc"
>>   
>>   - #clock-cells: should be 1.
>> diff --git a/include/dt-bindings/clock/g12a-aoclkc.h b/include/dt-bindings/clock/g12a-aoclkc.h
>> new file mode 100755
>> index 0000000..6b3f921
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/g12a-aoclkc.h
>> @@ -0,0 +1,28 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
>> +/*
>> + * Copyright (c) 2016 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + *
>> + * Copyright (c) 2018 Amlogic, inc.
>> + * Author: Jian Hu<jian.hu@amlogic.com>
>> + */
>> +
>> +#ifndef DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
>> +#define DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
>> +
>> +#define CLKID_AO_AHB_BUS		0
>> +#define CLKID_AO_REMOTE			1
>> +#define CLKID_AO_I2C_MASTER		2
>> +#define CLKID_AO_I2C_SLAVE		3
>> +#define CLKID_AO_UART1			4
>> +#define CLKID_AO_PROD_I2C		5
>> +#define CLKID_AO_UART2			6
>> +#define CLKID_AO_IR_BLASTER		7
>> +#define CLKID_AO_SAR_ADC		8
>> +#define CLKID_AO_CLK81			9
>> +#define CLKID_AO_SAR_ADC_SEL		10
>> +#define CLKID_AO_SAR_ADC_DIV		11
>> +#define CLKID_AO_SAR_ADC_CLK		12
>> +#define CLKID_AO_ALT_XTAL		13
>> +
>> +#endif
>> -- 
>> 1.9.1
>>
> 
> .
> 
