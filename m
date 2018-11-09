Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36577C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077D3208A3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077D3208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeKIRph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:45:37 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:60099 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeKIRph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:45:37 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Nov 2018 12:45:33 EST
Received: from [10.28.16.26] (10.28.16.26) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 9 Nov 2018
 15:51:00 +0800
Subject: Re: [PATCH v4 0/2] clk: meson-g12a: Add EE clock controller driver
To:     <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        "Rob Herring" <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1541682912-120480-1-git-send-email-jian.hu@amlogic.com>
 <1157f0a9419eea01c099d8dc08d7757593720286.camel@baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <dae47e53-2ea2-5cfc-e69c-48585b1c4644@amlogic.com>
Date:   Fri, 9 Nov 2018 15:51:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1157f0a9419eea01c099d8dc08d7757593720286.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.16.26]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome

On 2018/11/8 21:34, jbrunet@baylibre.com wrote:
> On Thu, 2018-11-08 at 21:15 +0800, Jian Hu wrote:
>> Changes since v3 at[4]
>> -add fixed clocks clk_regmap definition
> 
> Jian,
> 
> When replying to the v1 of your clk_ao patchset :
> https://patchwork.kernel.org/patch/10562563/#22177627
> 
> I have explained that I would like to stop taking clock (such as xtal) from
> nowhere. Clocks (even the xtal) should be properly claimed through DT.
> I have specifically asked this to be taken into account for the EE controller.
> 
> If you need an exemple on how to get the input clock from DT to your
> controller, please have look at the axg audio clock controller.
> 
> This comment does not appear to be addressed in this version.
> Please make sure you have addressed all the comments of past reviews before
> reposting
> 
> Thx
> 

Thanks, I will resolve it, I want make sure for it.

I should take the "periphs_xtal" clock in ee g12a clock controller 
driver through DT , And then I can get its clock name "xtal" by property
of clock-output-names. Is that right?

ee g12a clock dts:

		hiubus: bus@ff63c000 {
			compatible = "simple-bus";
			reg = <0x0 0xff63c000 0x0 0x1c00>;
			#address-cells = <2>;
			#size-cells = <2>;
			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;

			sysctrl: syscon@0 {
                                compatible = 
"amlogic,meson-g12a-hhi-sysctrl", "simple-mfd", "syscon";
				reg = <0x0 0x0 0x0 0x400>;

				clkc: clock-controller {
					compatible = "amlogic,g12a-clkc";
					#clock-cells = <1>;
					clocks = <&xtal>;
					clock-name = "periphs_xtal";
				};
			};
		};


		xtal: xtal-clk {
			compatible = "fixed-clock";
			clock-frequency = <24000000>;
			clock-output-names = "xtal"; 
 

			#clock-cells = <0>;
		};
>>
>> Changes since v2 at[2]
>> -fix fixed clocks's descriptions
>> -fix aligment
>> -add enable bit for plls base on [3] patches
>> -add fixed clock gate bit
>>
>> Changes since v1 at[1]
>> -fix typo of 'Everything'.
>> -change the word 'AmLogic' to 'Amlogic'
>> -squash patch 1 and 2.
>> -delete usless message of "Trying obsolete regs".
>> -delete the empty line in include/dt-bindings/clock/g12a-clkc.h.
>> -rebase on top of the "next/drivers" branch, and add g12a clock patch.
>> -add CLK_MUX_ROUND_CLOSEST for g12a_sd_emmc_b_clk0_sel and
>>   g12a_sd_emmc_c_clk0_sel.
>>
>> [1]
>> https://lkml.kernel.org/r/1531133549-25806-2-git-send-email-jian.hu@amlogic.com
>> [2]
>> https://lkml.kernel.org/r/1531728707-192230-2-git-send-email-jian.hu@amlogic.com
>> [3]https://lkml.kernel.org/r/20180717095617.12240-1-jbrunet@baylibre.com
>> [4]
>> https://lkml.kernel.org/r/1533890858-113020-1-git-send-email-jian.hu@amlogic.com
>>
>> Jian Hu (2):
>>    dt-bindings: clk: meson-g12a: Add G12A EE Clock Bindings
>>    clk: meson-g12a: Add EE Clock controller driver
>>
>>   .../bindings/clock/amlogic,gxbb-clkc.txt           |    1 +
>>   drivers/clk/meson/Kconfig                          |   10 +
>>   drivers/clk/meson/Makefile                         |    1 +
>>   drivers/clk/meson/g12a.c                           | 1134
>> ++++++++++++++++++++
>>   drivers/clk/meson/g12a.h                           |  128 +++
>>   include/dt-bindings/clock/g12a-clkc.h              |   93 ++
>>   6 files changed, 1367 insertions(+)
>>   create mode 100644 drivers/clk/meson/g12a.c
>>   create mode 100644 drivers/clk/meson/g12a.h
>>   create mode 100644 include/dt-bindings/clock/g12a-clkc.h
>>
> 
> 
> .
> 
