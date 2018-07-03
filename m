Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561EFC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBF223E65
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBF223E65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeGCKAV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:00:21 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:9199 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754469AbeGCKAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:00:18 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 3 Jul 2018
 17:59:29 +0800
Subject: Re: [PATCH 1/3] clk: meson: add DT documentation for emmc clock
 controller
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
 <20180703145716.31860-2-yixun.lan@amlogic.com>
 <1530605776.2900.163.camel@baylibre.com>
CC:     <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <linux-clk@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <0e2d2c14-656a-b43f-7699-ca68644aee57@amlogic.com>
Date:   Tue, 3 Jul 2018 17:59:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1530605776.2900.163.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi jerome

On 07/03/18 16:16, Jerome Brunet wrote:
> On Tue, 2018-07-03 at 14:57 +0000, Yixun Lan wrote:
>> Document the EMMC sub clock controller driver, the potential consumer
>> of this driver is EMMC or NAND.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  .../bindings/clock/amlogic,emmc-clkc.txt      | 45 +++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,emmc-clkc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,emmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,emmc-clkc.txt
>> new file mode 100644
>> index 000000000000..5534bd446363
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,emmc-clkc.txt
>> @@ -0,0 +1,45 @@
>> +* Amlogic EMMC Sub Clock Controller Driver
>> +
>> +The Amlogic EMMC clock controller generates and supplies clock to support
>> +EMMC and NAND controller
>> +
>> +Required Properties:
>> +
>> +- compatible: should be:
>> +		"amlogic,emmc-clkc"
> 
> missing clocks and clock-names here
> 
ok, will update

>> +
>> +- #clock-cells: should be 1.
>> +
>> +Two clocks are provided as the parent of this EMMC clock controller driver from
>> +upper layer clock controller - eg "amlogic,axg-clkc" in AXG platfrom.
>> +The main consumer of this driver is EMMC or NAND, to specify which the clock
>> +they may consume, the preprocessor macros in the dt-bindings/clock/emmc-clkc.h
>> +header and can be used in device tree sources.
> 
> Not sure this explanation belongs in dt-binding documentation.
> Maybe this should be in the driver itself.
> 
ok, I probably will waiting for more comments coming in ;-)

>> +
>> +Parent node should have the following properties :
>> +- compatible: "syscon", "simple-mfd, and "amlogic,emmc-clkc"
>> +- reg: base address and size of the EMMC control register space.
>> +
>> +Example: Clock controller node:
>> +
>> +sd_emmc_c_clkc: clock-controller@7000 {
>> +	compatible = "amlogic,emmc-clkc", "syscon", "simple-mfd";
>> +	reg = <0x0 0x7000 0x0 0x4>;
>> +	#clock-cells = <1>;
>> +
>> +	clock-names = "clkin0", "clkin1";
>> +	clocks = <&clkc CLKID_SD_EMMC_C_CLK0>,
>> +			<&clkc CLKID_FCLK_DIV2>;
>> +};
>> +
> 
> Not sure the following is necessary, you don't really to show how to use a clock
> controller.
> 
ditto,

and I'm fine with either way, this was a copy & paste from gxbb-clkc.h


>> +Example: NAND controller node that consumes the clock generated by the clock
>> +  controller:
>> +
>> +	nand: nfc@7800 {
>> +		compatible = "amlogic,meson-axg-nfc";
>> +		reg = <0x0 0x7800 0x0 0x100>;
>> +		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>> +		clocks = <&clkc CLKID_SD_EMMC_C>,
>> +				<&sd_emmc_c_clkc CLKID_EMMC_C_DIV>;
>> +		clock-names = "core", "device";
>> +	};
> 
> .
> 

