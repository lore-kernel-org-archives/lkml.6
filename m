Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD13C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C42720862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C42720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeK0Ga7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:30:59 -0500
Received: from muru.com ([72.249.23.125]:55290 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbeK0Ga7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:30:59 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 688088068;
        Mon, 26 Nov 2018 19:35:51 +0000 (UTC)
Date:   Mon, 26 Nov 2018 11:35:46 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 01/17] dt-bindings: remoteproc: Add TI PRUSS bindings
Message-ID: <20181126193546.GP53235@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-2-git-send-email-rogerq@ti.com>
 <20181123162417.GZ53235@atomide.com>
 <5BFBA525.3060806@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BFBA525.3060806@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [181126 07:48]:
> Not the PHY driver but the Ethernet driver. The PHY driver will be
> a davinci-MDIO device node (not yet in this series). I should probably
> add merge that with this series.
> 
> The Ethernet device tree node will reference to these syscon nodes.
> e.g.
>         pruss2_eth {
>                 compatible = "ti,am57-prueth";
>                 prus = <&pru2_0>, <&pru2_1>;
>                 firmware-name = "ti-pruss/am57xx-pru0-prueth-fw.elf",
>                                 "ti-pruss/am57xx-pru1-prueth-fw.elf";
>                 sram = <&ocmcram1>;
>                 interrupt-parent = <&pruss2_intc>;
> -->             mii-rt = <&pruss2_mii_rt>;
> -->             iep = <&pruss2_iep>;
> 	}
> 
> Do you see any issues with that?

Well maybe take a look at Grygorii's series adding proper
PHY driver for CPSW and see if it affects this too.

Regards,

Tony
