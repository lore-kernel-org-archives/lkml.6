Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E175EECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA5521531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="No82fQL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA5521531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbeITUJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:09:52 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:49516 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731025AbeITUJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:09:52 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 59F9D10C1166;
        Thu, 20 Sep 2018 07:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537453568; bh=vYXaDB7K+xPYlZzvvIQsTH+Y7TjitNWx1YppSjG80Wc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=No82fQL98mYFLn8b24HNMOnTKyp33kvA2JV6abRYcTV9VJ154Uk9SAGtHJETAh71v
         hQhMtGSyfoPg6tvkoPrIHekH1NYgwNO+pdi5nBhjOvx4w/I236iyoU0+MQuj3GZ4Js
         tovmCv2RPXHJu0k92VQxthRyfc76obgMkeSGsuU6BeWWWgFBDI9dbYgjgkjFiUpcvP
         L0J+xJ6QbakwYMKbnverFehGwWAS319/ofeX4L6JyKnyDBG7vENH1VIkxNbt9UqfFI
         emuRImNYXMOQhdSDOzvXIe9SEnGioZ5tA6gODfGt061kg5rOqGVlDi30dTtIwx7Y7c
         NFw2PXjuUBhqQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 62AD93C80;
        Thu, 20 Sep 2018 07:26:06 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 20 Sep 2018 07:26:05 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 20 Sep 2018 16:26:04 +0200
Received: from [10.107.25.72] (10.107.25.72) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 20 Sep 2018 16:26:04 +0200
Subject: Re: [V2, 2/5] Documentation: dt-bindings: Document the Synopsys MIPI
 DPHY Rx bindings
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Luis Oliveira <Luis.Oliveira@synopsys.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Joao.Pinto@synopsys.com>, <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        <devicetree@vger.kernel.org>
References: <20180920111648.27000-1-lolivei@synopsys.com>
 <20180920111648.27000-3-lolivei@synopsys.com> <1754496.WQhu2lOnZY@avalon>
From:   Luis Oliveira <Luis.Oliveira@synopsys.com>
Message-ID: <0cc27ea0-7c05-4c07-6c14-2146b0c2b370@synopsys.com>
Date:   Thu, 20 Sep 2018 15:26:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1754496.WQhu2lOnZY@avalon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.72]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-Sep-18 14:11, Laurent Pinchart wrote:
> Hi Louis,
> 
> Thank you for the patch.
> 

Hi Laurent, thank you for your review, my answers are inline.

> On Thursday, 20 September 2018 14:16:40 EEST Luis Oliveira wrote:
>> Add device-tree bindings documentation for SNPS DesignWare MIPI D-PHY in
>> RX mode.
>>
>> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
>> ---
>> Changelog
>> v2:
>> - no changes
>>
>>  .../devicetree/bindings/phy/snps,dphy-rx.txt       | 36 +++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
>> b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt new file mode
>> 100644
>> index 0000000..9079f4a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
>> @@ -0,0 +1,36 @@
>> +Synopsys DesignWare MIPI Rx D-PHY block details
>> +
>> +Description
>> +-----------
>> +
>> +The Synopsys MIPI D-PHY controller supports MIPI-DPHY in receiver mode.
>> +Please refer to phy-bindings.txt for more information.
>> +
>> +Required properties:
>> +- compatible		: Shall be "snps,dphy-rx".
>> +- #phy-cells		: Must be 1.
>> +- snps,dphy-frequency	: Output frequency of the D-PHY.
> 
> If that's the frequency of the clock on the output side of the RX PHY, doesn't 
> it depend on the frequency on the CSI-2 (or other) bus ? Can't it vary ? Why 
> do you need to have it in DT ?
> 

But you are right, I will move it to the CSI-2 block.
The reason for it to be on the DT is that my use case have a camera with fixed
frequency connected, but of course I can change it after.

>> +- snps,dphy-te-len	: Size of the communication interface (8 bits->8 or
>> 12bits->12).
> 
> We have similar properties in various bindings, such as bus-width in video-
> interfaces.txt. Couldn't we use a more standard name ?

I have read the bus-width property but I don't this is the same.
This is not a video quite a video interface. Our D-PHY is configured using an
control interface, which is called "test interface" and can have 8-bit or 12-bit.

> 
>> +- reg			: Physical base address and size of the device memory mapped
>> +		 	  registers;
> 
> The example below shows three ranges. Could you document the ranges that are 
> expected ?
> 

The three ranges is optional, it can be only two.
- The first is the interface from which we communicate with the d-phy. A small
window the for the referenced above "test interface".
- The second and third reg are regions for configuration for the d-phy before
the d-phy bring up:
a few examples:
 - 4+4 data lanes max, 1 clk
 - 8 data lanes max, 1clk
 - 4+4 data lanes, 2 clk

>> +Optional properties:
>> +- snps,compat-mode	: Compatibility mode control
> 
> What is this ?

This toggles a mode for a specific d-phy that we can't auto-detect. So when we
use it we activate the compatibility mode for it. I can remove it if you think
it's best.

> 
>> +The per-board settings:
>> +- gpios 		: Synopsys testchip used as reference uses this to change 
> setup
>> +		  	  configurations.
> 
> Here too, what is this for ?

Most of our d-phys have a wrapper around that can be controlled by a gpio-driver
that can halt the d-phy.

> 
>> +Example:
>> +
>> +	mipi_dphy_rx1: dphy@3040 {
>> +		compatible = "snps,dphy-rx";
>> +		#phy-cells = <1>;
>> +		snps,dphy-frequency = <300000>;
>> +		snps,dphy-te-len = <12>;
>> +		snps,compat-mode = <1>;
>> +		reg = < 0x03040 0x20
>> +			0x08000 0x100
>> +			0x09000 0x100>;
> 
> The base addresses are pretty low, what kind of bus does this sit on ?
> 

It sits on top of a bus like this for my configuration.

dx_mb {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0x00000000 0x0 0xD0000000 0x10000000>;
		interrupt-parent = <&he_intc>;
		...

>> +	};
>> +
> 

