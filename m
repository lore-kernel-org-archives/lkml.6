Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A651CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6843E20673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6843E20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeGRIPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:15:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38950 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbeGRIPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:15:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 67BD4207B4; Wed, 18 Jul 2018 09:39:00 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 39AED20798;
        Wed, 18 Jul 2018 09:38:50 +0200 (CEST)
Date:   Wed, 18 Jul 2018 09:38:50 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Denis OSTERLAND <denis.osterland@diehl.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 5/5] rtc: isl1219: add device tree docu
Message-ID: <20180718073850.GH3211@piout.net>
References: <20180710090710.9066-1-Denis.Osterland@diehl.com>
 <20180710090710.9066-6-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710090710.9066-6-Denis.Osterland@diehl.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/07/2018 09:44:15+0000, Denis OSTERLAND wrote:
> From: Denis Osterland <Denis.Osterland@diehl.com>
> 
> The devicetree documentation for the ISL1219 device tree
> binding is added with an short example. It is not a trivial
> device, because it supports two interrupt souces.
> 
> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> ---
>  .../devicetree/bindings/rtc/isil,isl1219.txt  | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1219.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/isil,isl1219.txt b/Documentation/devicetree/bindings/rtc/isil,isl1219.txt
> new file mode 100644
> index 000000000000..f26f1e9d4bde
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/isil,isl1219.txt
> @@ -0,0 +1,29 @@
> +Intersil ISL1219 I2C RTC/Alarm chip with event in
> +
> +ISL1219 has additional pins EVIN and #EVDET for tamper detection.
> +
> +Required properties supported by the device:
> +
> + - "compatible": must be "isil,isl1219"
> + - "reg": I2C bus address of the device
> +
> +Optional properties:
> +
> + - "interrupt-names": list which may contains "irq" and "evdet"
> + - "interrupt-parent", "interrupts", "interrupts-extended":
> +   for passing the interrupt line of the SoC connected to #IRQ pin
> +   and #EVDET pin of the RTC chip.
> + - "isil,ev-evienb": if present bit can be set to disable event input pull-up

I would use a clearer name for that property like isil,ev-pull-up-enabled.

Also make it an int so 0 is disabling the pull-up (EVIENB set to 1) 1 is
enabling the pull-up (EVIENB set to 0) and do nothing when the property
is not present.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
