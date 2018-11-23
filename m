Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1B7C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F231320664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F231320664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440203AbeKXBr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:47:29 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36251 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732166AbeKXBr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:47:29 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9160D20D72; Fri, 23 Nov 2018 16:02:56 +0100 (CET)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6242D20742;
        Fri, 23 Nov 2018 16:02:56 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 6/6] arm64: dts: marvell: Add cpu clock node on Armada 7K/8K
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
        <20180922181709.13007-7-gregory.clement@bootlin.com>
        <153936613666.5275.6122138233361141260@swboyd.mtv.corp.google.com>
Date:   Fri, 23 Nov 2018 16:02:56 +0100
In-Reply-To: <153936613666.5275.6122138233361141260@swboyd.mtv.corp.google.com>
        (Stephen Boyd's message of "Fri, 12 Oct 2018 10:42:16 -0700")
Message-ID: <87a7lzq1jz.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
 
 On ven., oct. 12 2018, Stephen Boyd <sboyd@kernel.org> wrote:

> +Rob
>
> Quoting Gregory CLEMENT (2018-09-22 11:17:09)
>> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
>> index 4a65e4e830aa..27c840e91abe 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
>> @@ -280,6 +280,12 @@
>>                                 #address-cells = <1>;
>>                                 #size-cells = <1>;
>>  
>> +                               cpu_clk: clock-cpu {
>> +                                       compatible = "marvell,ap806-cpu-clock";
>> +                                       clocks = <&ap_clk 0>, <&ap_clk 1>;
>> +                                       #clock-cells = <1>;
>> +                               };
>
> This looks like the wrong place because there isn't a reg property. It

There is no reg property because we are inside a syscon node where the
registers are shared between multiple IPs.

> should go to the root of the tree. And then it looks like we're adding
> something to DT to get a driver to probe, which is improper DT design.

There is nothing related to the driver, this subnode describes the way
the hardware is designed. Under the system controller node there are
several IPs , like the CPU clocks, but also the GPIO or the pinctrl.

Gregory

>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
