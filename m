Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD9FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655F720866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655F720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeIJJig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 05:38:36 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:60359 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeIJJig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 05:38:36 -0400
Received: from [10.28.18.79] (10.28.18.79) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Mon, 10 Sep
 2018 12:46:44 +0800
Subject: Re: [RFC PATCH v3 1/2] dt-bindings: nand: meson: add Amlogic NAND
 controller driver
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     <linux-mtd@lists.infradead.org>, Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1536317831-58056-1-git-send-email-jianxin.pan@amlogic.com>
 <1536317831-58056-2-git-send-email-jianxin.pan@amlogic.com>
 <20180907141944.4dd4406b@bbrezillon>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <824dd234-30d6-d47d-8abd-352578b232f6@amlogic.com>
Date:   Mon, 10 Sep 2018 12:46:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180907141944.4dd4406b@bbrezillon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.79]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi boric,

Thanks for your quick reply.

On 9/7/2018 8:19 PM, Boris Brezillon wrote:
> On Fri, 7 Sep 2018 18:57:10 +0800
> Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> 
>> From: Liang Yang <liang.yang@amlogic.com>
>>
>> Add Amlogic NAND controller dt-bindings for Meson SoC,
>> Current this driver support GXBB/GXL/AXG platform.
>>
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>   .../devicetree/bindings/mtd/amlogic,meson-nand.txt | 91 ++++++++++++++++++++++
>>   1 file changed, 91 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> new file mode 100644
>> index 0000000..655a778
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> @@ -0,0 +1,91 @@
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
>> +- pins     : Select pins which NFC need.
>> +- nand_pins: Detail NAND pins information.
> 
> You mean pinctrl-names and pinctrl-0, right? Not sure it's necessary to
> document that, but if you do, please use the correct DT prop names.
> 

I find no documentation for that in other xx_nand.txt; I will consider 
to remove it.

>> +- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
>> +				controller port C
>> +
>> +Optional children nodes:
>> +Children nodes represent the available nand chips.
>> +
>> +
>> +
> 
> One too many blank lines here.
> 
ok, i will remove it.

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
>> +			nand-ecc-mode = "hw";
>> +			nand-ecc-strength = <8>;
>> +			nand-ecc-step-size = <1024>;
> 
> Drop nand-ecc- props. I guess you have a sensible default value and I
> prefer when ECC requirements are directly extracted during chip
> detection. Defining that in the DT is a bad habit. The only one that
> could make sense (assuming you support it) is nand-ecc-maximize.
> 
ok, i will drop them.
we adopt auto detection during init stage, it works too.

>> +
>> +			amlogic,nand-enable-scrambler;
> 
> Please drop this property (it's not longer documented).
> 
em, we should have removed it when nfc driver never use it.

>> +
>> +			partition@0 {
>> +				label = "boot";
>> +				reg = <0x00000000 0x00200000>;
>> +				read-only;
>> +			};
>> +			partition@200000 {
>> +				label = "env";
>> +				reg = <0x00200000 0x00400000>;
>> +			};
>> +			partition@600000 {
>> +				label = "system";
>> +				reg = <0x00600000 0x00a00000>;
>> +			};
>> +			partition@1000000 {
>> +				label = "rootfs";
>> +				reg = <0x01000000 0x03000000>;
>> +			};
>> +			partition@4000000 {
>> +				label = "media";
>> +				reg = <0x04000000 0x8000000>;
>> +			};
> 
> No need to define the partitions in your example, especially since they
> should be placed in a partitions subnode with a "fixed-partitions"
> compat.
>

ok, i will remove it.

>> +		};
>> +	};
> 
> .
> 
