Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390A8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E3421479
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E3421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeK2XAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:00:39 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:21852 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeK2XAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:00:39 -0500
Received: from [10.28.16.74] (10.28.16.74) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 29 Nov
 2018 19:55:43 +0800
Subject: Re: [PATCH 0/2] i2c: meson: add support for Meson G12A SoC i2c
 controller
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
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
 <8a6a204b28523e5a181f9e85dda18fade76a26a3.camel@baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <b2bceaf4-92ce-92a4-c382-713d29ae3b70@amlogic.com>
Date:   Thu, 29 Nov 2018 19:55:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8a6a204b28523e5a181f9e85dda18fade76a26a3.camel@baylibre.com>
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



On 2018/11/29 19:02, Jerome Brunet wrote:
> On Thu, 2018-11-29 at 18:59 +0800, Jian Hu wrote:
>> 1)Add G12A SoC i2c compatible string in dt-bindings.
>> 2)Add compatible and data for G12A I2C controller driver.
>>
>> Jian Hu (2):
>>    dt-bindings: i2c: meson: add Meson G12A SoC i2c compatible string
>>    i2c: meson: add support for Meson G12A SoC I2C controller
> 
> Looks to me that the g12a is compatible with the axg. What is the point of
> adding this new compatible string ?
> 

I am okay if it is reasonable below in file 
arch/arm64/boot/dts/amlogic/meson-g12a.dtsi. I2c controller node just 
uses axg's compatible.

			i2c0: i2c@1f000 {
				compatible = "amlogic,meson-axg-i2c";
				reg = <0x0 0x1f000 0x0 0x20>;
				interrupts = <GIC_SPI 21 		   IRQ_TYPE_EDGE_RISING>;
				clocks = <&clkc CLKID_I2C>;
				#address-cells = <1>;
				#size-cells = <0>;
				status = "disabled";
			};

If it is, I just submit the i2c controller node in meson-g12a.dtsi.

>>
>>   Documentation/devicetree/bindings/i2c/i2c-meson.txt | 1 +
>>   drivers/i2c/busses/i2c-meson.c                      | 5 +++++
>>   2 files changed, 6 insertions(+)
>>
> 
> 
> .
> 
