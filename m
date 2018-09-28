Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78071C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F50F2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F50F2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeI1OzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:55:20 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:15251 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeI1OzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:55:20 -0400
Received: from [10.28.18.92] (10.28.18.92) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 28 Sep
 2018 16:33:23 +0800
Subject: Re: [PATCH v4 1/2] dt-bindings: nand: meson: add Amlogic NAND
 controller driver
To:     Rob Herring <robh@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>, Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1537433449-65213-1-git-send-email-jianxin.pan@amlogic.com>
 <1537433449-65213-2-git-send-email-jianxin.pan@amlogic.com>
 <20180927181653.GA22153@bogus>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <8f194c47-10bb-cb9d-c626-39f9b22887cb@amlogic.com>
Date:   Fri, 28 Sep 2018 16:33:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180927181653.GA22153@bogus>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.92]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/28/2018 2:16 AM, Rob Herring wrote:
> On Thu, Sep 20, 2018 at 04:50:48PM +0800, Jianxin Pan wrote:
>> From: Liang Yang <liang.yang@amlogic.com>
>>
>> Add Amlogic NAND controller dt-bindings for Meson SoC,
>> Current this driver support GXBB/GXL/AXG platform.
>>
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>   .../devicetree/bindings/mtd/amlogic,meson-nand.txt | 60 ++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> new file mode 100644
>> index 0000000..803df2a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> @@ -0,0 +1,60 @@
>> +Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
>> +
>> +This file documents the properties in addition to those available in
>> +the MTD NAND bindings.
>> +
>> +Required properties:
>> +- compatible : contains one of:
>> +  - "amlogic,meson-gxl-nfc"
>> +  - "amlogic,meson-axg-nfc"
>> +- clocks     :
>> +	A list of phandle + clock-specifier pairs for the clocks listed
>> +	in clock-names.
>> +
>> +- clock-names: Should contain the following:
>> +	"core" - NFC module gate clock
>> +	"device" - device clock from eMMC sub clock controller
>> +
>> +- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
>> +				controller port C
>> +
>> +Optional children nodes:
>> +Children nodes represent the available nand chips.
>> +
>> +Other properties:
>> +see Documentation/devicetree/bindings/mtd/nand.txt for generic bindings.
>> +
>> +Example demonstrate on AXG SoC:
>> +
>> +	sd_emmc_c_clkc: mmc@7000 {
>> +		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
>> +		reg = <0x0 0x7000 0x0 0x800>;
>> +		status = "okay";
>> +	};
>> +
>> +	nand: nfc@7800 {
> 
> nand-controller@7800
> 
ok, i will fix it.

>> +		compatible = "amlogic,meson-axg-nfc";
>> +		reg = <0x0 0x7800 0x0 0x100>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>> +		status = "disabled";
>> +
>> +		clocks = <&clkc CLKID_SD_EMMC_C>,
>> +			<&sd_emmc_c_clkc CLKID_MMC_DIV>;
>> +		clock-names = "core", "device";
>> +		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
>> +
>> +		status = "okay";
> 
> Don't show status in examples, plus you have it twice.
> 
ok, i will fix it.
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&nand_pins>;
>> +
>> +		nand@0 {
>> +			reg = <0>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			nand-on-flash-bbt;
>> +		};
>> +	};
>> -- 
>> 1.9.1
>>
> 
> .
> 
