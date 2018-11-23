Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC917C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C193420685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C193420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632967AbeKXDJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:09:14 -0500
Received: from muru.com ([72.249.23.125]:54774 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387726AbeKXDJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:09:14 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9117080D4;
        Fri, 23 Nov 2018 16:24:21 +0000 (UTC)
Date:   Fri, 23 Nov 2018 08:24:17 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/17] dt-bindings: remoteproc: Add TI PRUSS bindings
Message-ID: <20181123162417.GZ53235@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-2-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542886753-17625-2-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Roger Quadros <rogerq@ti.com> [181122 11:39]:
> From: Suman Anna <s-anna@ti.com>
> +Example:
> +========
> +1.	/* AM33xx PRU-ICSS */
> +	pruss_soc_bus: pruss_soc_bus@4a326004 {
> +		compatible = "ti,am3356-pruss-soc-bus";
> +		ti,hwmods = "pruss";
> +		reg = <0x4a326004 0x4>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;

The top level interconnect target module driver should be just ti-sysc
as documented in Documentation/devicetree/bindings/bus/ti-sysc.txt.
AFAIK there is nothing PRU specific there. So let's not add yet
another custom interconnect target module handling code to deal with.

I also posted a patch a while back for using reset-simple with
ti-sysc as "[PATCHv2] reset: ti-rstctrl: use the reset-simple driver".

> +			pruss_cfg: cfg@4a326000 {
> +				compatible = "syscon";
> +				reg = <0x4a326000 0x2000>;
> +			};
> +
> +			pruss_iep: iep@4a32e000 {
> +				compatible = "syscon";
> +				reg = <0x4a32e000 0x31c>;
> +			};
> +
> +			pruss_mii_rt: mii_rt@4a332000 {
> +				compatible = "syscon";
> +				reg = <0x4a332000 0x58>;
> +			};

Hmm what are these syscon register actually doing? Sseems like
they should be just handled by a phy driver nowadays?

Other than that the binding looks OK to me. Good to finally
see some activity in getting the PRU support merged :)

Regards,

Tony
