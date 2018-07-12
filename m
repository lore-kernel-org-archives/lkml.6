Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA2AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DCD20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DCD20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeGLCyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:54:54 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:60528 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeGLCyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:54:54 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 12 Jul
 2018 10:46:50 +0800
Subject: Re: [PATCH v2 1/3] clk: meson: add DT documentation for emmc clock
 controller
To:     Rob Herring <robh@kernel.org>
References: <20180710163658.6175-1-yixun.lan@amlogic.com>
 <20180710163658.6175-2-yixun.lan@amlogic.com>
 <20180711194346.GA32414@rob-hp-laptop>
CC:     <yixun.lan@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
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
Message-ID: <f2eb8632-1113-3bb8-506f-ac0d4e838fd4@amlogic.com>
Date:   Thu, 12 Jul 2018 10:47:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180711194346.GA32414@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

see my comments

On 07/12/18 03:43, Rob Herring wrote:
> On Tue, Jul 10, 2018 at 04:36:56PM +0000, Yixun Lan wrote:
>> Document the MMC sub clock controller driver, the potential consumer
>> of this driver is MMC or NAND.
> 
> So you all have decided to properly model this now?
> 
Yes, ;-)

>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  .../bindings/clock/amlogic,mmc-clkc.txt       | 31 +++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>> new file mode 100644
>> index 000000000000..ff6b4bf3ecf9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>> @@ -0,0 +1,31 @@
>> +* Amlogic MMC Sub Clock Controller Driver
>> +
>> +The Amlogic MMC clock controller generates and supplies clock to support
>> +MMC and NAND controller
>> +
>> +Required Properties:
>> +
>> +- compatible: should be:
>> +		"amlogic,meson-gx-mmc-clkc"
>> +		"amlogic,meson-axg-mmc-clkc"
>> +
>> +- #clock-cells: should be 1.
>> +- clocks: phandles to clocks corresponding to the clock-names property
>> +- clock-names: list of parent clock names
>> +	- "clkin0", "clkin1"
>> +
>> +Parent node should have the following properties :
>> +- compatible: "syscon", "simple-mfd, and "amlogic,meson-axg-mmc-clkc"
> 
> You don't need "simple-mfd" and probably not syscon either. The order is 
> wrong too. Most specific first.
> 
Ok, I will drop "simple-mfd"..

but the syscon is a must, since this mmc clock model access registers
via the regmap interface

I will fix the order, thanks for pointing this out

>> +- reg: base address and size of the MMC control register space.
>> +
>> +Example: Clock controller node:
>> +
>> +sd_mmc_c_clkc: clock-controller@7000 {
>> +	compatible = "amlogic,mmc-clkc", "syscon", "simple-mfd";
> 
> Doesn't match the binding...
> 
oops, I will update this

>> +	reg = <0x0 0x7000 0x0 0x4>;
>> +	#clock-cells = <1>;
>> +
>> +	clock-names = "clkin0", "clkin1";
>> +	clocks = <&clkc CLKID_SD_MMC_C_CLK0>,
>> +			<&clkc CLKID_FCLK_DIV2>;
>> +};
>> -- 
>> 2.18.0
>>
> 
> .
> 

