Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03223ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC1020831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC1020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJYUWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:22:39 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:19098 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJYUWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:22:39 -0400
Received: from [10.18.29.185] (10.18.29.185) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 25 Oct
 2018 19:50:11 +0800
Subject: Re: [PATCH v5 2/3] clk: meson: add DT documentation for emmc clock
 controller
To:     Yixun Lan <dlan@gentoo.org>, Jerome Brunet <jbrunet@baylibre.com>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-3-git-send-email-jianxin.pan@amlogic.com>
 <ca95948abd58876a23b2eb3e52b96124e9eed793.camel@baylibre.com>
 <20181024145513.GA6647@ofant>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <146f13c1-f309-d619-602b-b14535ab5f79@amlogic.com>
Date:   Thu, 25 Oct 2018 19:50:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024145513.GA6647@ofant>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.185]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/25 15:29, Yixun Lan wrote:
> Hi Jerome, Jianxin:
> 
> see my comments
> 
> On 10:58 Wed 24 Oct     , Jerome Brunet wrote:
>> On Thu, 2018-10-18 at 13:07 +0800, Jianxin Pan wrote:
>>> From: Yixun Lan <yixun.lan@amlogic.com>
>>>
>>> Document the MMC sub clock controller driver, the potential consumer
>>> of this driver is MMC or NAND. Also add four clock bindings IDs which
>>> provided by this driver.
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>>> ---
>>>  .../devicetree/bindings/clock/amlogic,mmc-clkc.txt | 31 ++++++++++++++++++++++
>>>  include/dt-bindings/clock/amlogic,mmc-clkc.h       | 17 ++++++++++++
>>>  2 files changed, 48 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>>>  create mode 100644 include/dt-bindings/clock/amlogic,mmc-clkc.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>>> new file mode 100644
>>> index 0000000..9e6d343
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>>> @@ -0,0 +1,31 @@
>>> +* Amlogic MMC Sub Clock Controller Driver
>>> +
>>> +The Amlogic MMC clock controller generates and supplies clock to support
>>> +MMC and NAND controller
>>> +
>>> +Required Properties:
>>> +
>>> +- compatible: should be:
>>> +		"amlogic,gx-mmc-clkc"
>>> +		"amlogic,axg-mmc-clkc"
>>> +
>>> +- #clock-cells: should be 1.
>>> +- clocks: phandles to clocks corresponding to the clock-names property
>>> +- clock-names: list of parent clock names
>>> +	- "clkin0", "clkin1"
>>> +
>>> +Parent node should have the following properties :
>>> +- compatible: "amlogic,axg-mmc-clkc", "syscon".
>>> +- reg: base address and size of the MMC control register space.
>>
>> I get why Stephen is confused by your description, I am too. The example
>> contradict the documentation.
>>
>> The  documentation above says that the parent node should be a syscon with the
>> mmc register space.
>>
>> But your example shows this in the node itself.
>>
> 
> yes, I think the documentation need to be fixed
ok, Thankyou. I will fix it in the next version.
> 
> for the final solution, we decide to make 'mmc-clkc' an independent node
> instead of being a sub-node of 'mmc', so both of them may exist in parallel..
> 
> the DT part may like this:
> 
> 			sd_emmc_c_clkc: clock-controller@7000 {
> 				compatible = "amlogic,axg-mmc-clkc", "syscon";
> 				reg = <0x0 0x7000 0x0 0x4>;
> 				...
> 			};
> 
> 			sd_emmc_c: mmc@7000 {
> 				compatible = "amlogic,axg-mmc";
> 				reg = <0x0 0x7000 0x0 0x800>;
> 				...
> 			};
> 
> 
>>> +
>>> +Example: Clock controller node:
>>> +
>>> +sd_mmc_c_clkc: clock-controller@7000 {
>>> +	compatible = "amlogic,axg-mmc-clkc", "syscon";
>>> +	reg = <0x0 0x7000 0x0 0x4>;
>>> +	#clock-cells = <1>;
>>> +
>>> +	clock-names = "clkin0", "clkin1";
>>> +	clocks = <&clkc CLKID_SD_MMC_C_CLK0>,
>>> +		 <&clkc CLKID_FCLK_DIV2>;
>>> +};
>>> diff --git a/include/dt-bindings/clock/amlogic,mmc-clkc.h b/include/dt-bindings/clock/amlogic,mmc-clkc.h
>>> new file mode 100644
>>> index 0000000..162b949
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/amlogic,mmc-clkc.h
>>> @@ -0,0 +1,17 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>> +/*
>>> + * Meson MMC sub clock tree IDs
>>> + *
>>> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
>>> + * Author: Yixun Lan <yixun.lan@amlogic.com>
>>> + */
>>> +
>>> +#ifndef __MMC_CLKC_H
>>> +#define __MMC_CLKC_H
>>> +
>>> +#define CLKID_MMC_DIV				1
>>> +#define CLKID_MMC_PHASE_CORE			2
>>> +#define CLKID_MMC_PHASE_TX			3
>>> +#define CLKID_MMC_PHASE_RX			4
>>> +
>>> +#endif
>>
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 

