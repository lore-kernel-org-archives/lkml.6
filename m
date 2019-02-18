Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC244C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BD5217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550519171;
	bh=NF1LgOprE2xoZU7ATxINAHHoLax64S8IMeOBbWh0Zdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iezVmUdPq8XztMlkhW9EL4ZD/E/XU66RQ9ABxqfhcXKjVEw5oL8lykmBvDyNBlNIU
	 L1W9BBfXNAIF3sbC6LWHqLGLEKkC+3TX5m8caE3kbAU+Lk8dQj2icDSVr+NnPzGoKV
	 U3JnqjAvK2BL76wwkHlLlJM84ymN2uXFcqgThgK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfBRTqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:46:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45588 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBRTqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:46:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so30176042ota.12;
        Mon, 18 Feb 2019 11:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tSoW1FyvUN0MgZs8WGGIMHNeIAIkS7kF4YTP5yznQcc=;
        b=MwYxMYRxX/okj0Xj4sdLPZViaitQlrC3D3+s026lcKTWN2/PkskRzlFDJhAahzZPSF
         3H+8LsoxuFbEiIXhtLCntZk5SHalEGRvvhG0kOM/sf41W2phZLybVwsKwUOeF2ZqhtRI
         5V1DvhBtVkIjOB44cCzh5RdsJVMbNaZyKCy43DmnEVdkdzZHDNXGaeFfU6QD+dXhtZlx
         Ka5Q0/xNL/z/6Cju4exH0HfUTR8ou0BHfsreu/9xCT1klNLSdHdYkjUTc6ENmnDdzieM
         XNwCdC8mFNXcBOs4f8tQV+J8YSTnN0Su/Ds3WnYDNlTYeZnpJ+m1lZz8oC2W1aU3h+vY
         ffMg==
X-Gm-Message-State: AHQUAuaPUo+Ru6sJKPe43XghqvM1drTZgWwga20+i/Qr9C9C0hxZ967O
        5vnl3TkGGcKPDfoAcvZ7sOYrevc=
X-Google-Smtp-Source: AHgI3IYJlo6Mb/GR1DVsp3ptaKLdvltwHzdPGtjWK6cW9UhK2KzG5yrE/299OWvgBhEwQTUC5+5Kuw==
X-Received: by 2002:a9d:6f97:: with SMTP id h23mr16085809otq.26.1550519168293;
        Mon, 18 Feb 2019 11:46:08 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g2sm5870795otq.24.2019.02.18.11.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:46:07 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:46:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: phy: ti: Add dt binding
 documentation for SERDES in AM654x SoC
Message-ID: <20190218194606.GA25390@bogus>
References: <20190206110753.28738-1-kishon@ti.com>
 <20190206110753.28738-4-kishon@ti.com>
 <5C5C15E4.8010601@ti.com>
 <1eb6eee3-da8a-7400-c419-a60929b78904@ti.com>
 <5C5C3F3D.7080809@ti.com>
 <2669692f-a57e-9c0a-a0ac-bb6c0497f5ba@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2669692f-a57e-9c0a-a0ac-bb6c0497f5ba@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:35:44AM +0530, Kishon Vijay Abraham I wrote:
> Hi Roger,
> 
> On 07/02/19 7:52 PM, Roger Quadros wrote:
> > 
> > 
> > On 07/02/19 14:19, Kishon Vijay Abraham I wrote:
> >> Hi Roger,
> >>
> >> On 07/02/19 4:56 PM, Roger Quadros wrote:
> >>>
> >>>
> >>> On 06/02/19 13:07, Kishon Vijay Abraham I wrote:
> >>>> AM654x has two SERDES instances. Each instance has three input clocks
> >>>> (left input, externel reference clock and right input) and two output
> >>>> clocks (left output and right output) in addition to a PLL mux clock
> >>>> which the SERDES uses for Clock Multiplier Unit (CMU refclock).
> >>>> The PLL mux clock can select from one of the three input clocks.
> >>>> The right output can select between left input and external reference
> >>>> clock while the left output can select between the right input and
> >>>> external reference clock.
> >>>>
> >>>> The left and right input reference clock of SERDES0 and SERDES1
> >>>> respectively are connected to the SoC clock. In the case of two lane
> >>>> SERDES personality card, the left input of SERDES1 is connected to
> >>>> the right output of SERDES0 in a chained fashion.
> >>>>
> >>>> See section "Reference Clock Distribution" of AM65x Sitara Processors
> >>>> TRM (SPRUID7 – April 2018) for more details.
> >>>>
> >>>> Add dt-binding documentation in order to represent all these different
> >>>> configurations in device tree.
> >>>>
> >>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>>> ---
> >>>>  .../devicetree/bindings/phy/ti-phy.txt        | 77 +++++++++++++++++++
> >>>>  include/dt-bindings/phy/phy-am654-serdes.h    | 13 ++++
> >>>>  2 files changed, 90 insertions(+)
> >>>>  create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
> >>>> index 57dfda8a7a1d..fc2fff6b2c37 100644
> >>>> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
> >>>> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
> >>>> @@ -132,3 +132,80 @@ sata_phy: phy@4a096000 {
> >>>>  	syscon-pllreset = <&scm_conf 0x3fc>;
> >>>>  	#phy-cells = <0>;
> >>>>  };
> >>>> +
> >>>> +
> >>>> +TI AM654 SERDES
> >>>> +
> >>>> +Required properties:
> >>>> + - compatible: Should be "ti,phy-am654-serdes"
> >>>> + - reg : Address and length of the register set for the device.
> >>>> + - reg-names: Should be "serdes" which corresponds to the register space
> >>>> +	populated in "reg".
> >>>> + - #phy-cells: determine the number of cells that should be given in the
> >>>> +	phandle while referencing this phy. Should be "2". The 1st cell
> >>>> +	corresponds to the phy type (should be one of the types specified in
> >>>> +	include/dt-bindings/phy/phy.h) and the 2nd cell should be the serdes
> >>>> +	lane function.
> >>>> +	If SERDES0 is referenced 2nd cell should be:
> >>>> +		0 - USB3
> >>>> +		1 - PCIe0 Lane0
> >>>> +		2 - ICSS2 SGMII Lane0
> >>>> +	If SERDES1 is referenced 2nd cell should be:
> >>>> +		0 - PCIe1 Lane0
> >>>> +		1 - PCIe0 Lane1
> >>>> +		2 - ICSS2 SGMII Lane1
> >>>
> >>> Instead of these magic numbers and expecting a human to decipher this
> >>> which is prone to error, is it better to create the following defines and
> >>> check for valid configuration in the driver?
> >>>
> >>> AM654_SERDES_LANE_USB3,
> >>> AM654_SERDES_LANE_PCIE_LANE0,
> >>> AM654_SERDES_LANE_PCIE_LANE1,
> >>> AM654_SERDES_LANE_SGMII,
> >>>
> >>> So if you pass AM654_SERDES_LANE_PCIE_LANE0 to SERDES1, driver can easily
> >>> figure out that it should be 1 if it is serdes0 and 0 if serdes1
> >>>
> >>> Which means the DT must contain something so that you can identify
> >>> if it is serdes0 or serdes1.
> >>
> >> Generally I'd like to avoid drivers having to know instance numbers. That gets
> >> more complicated to handle when the same IP is used in different platforms.

Yes. No indexes please.

> > 
> > But this PHY driver is for AM654 platform. Are you saying that variants of this
> > platform have different lane configurations?
> 
> It can have different lane configurations (we've already seen that in dra72).
> Nothing prevents from having the same SERDES IP in a future platform with
> different lane configuration.

Sounds like this should all be implied by the compatible if it is per 
SoC.

> This is more of a system configuration which might get complicated if we try to
> check all the valid configurations in driver.
> 
> 
> > 
> > You have already specified of the possibilities that can be in 2nd cell in
> > the binding document.
> > 
> > Is it better to create a directory ti/ and put this binding in ti,phy-am654-serdes.txt
> > instead of the already so large ti,phy.txt?
> 
> sure.

+1
