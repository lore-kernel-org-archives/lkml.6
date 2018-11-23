Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92641C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5870E20874
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5870E20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440537AbeKXDUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:20:21 -0500
Received: from muru.com ([72.249.23.125]:54816 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440517AbeKXDUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:20:21 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A68FE80D4;
        Fri, 23 Nov 2018 16:35:26 +0000 (UTC)
Date:   Fri, 23 Nov 2018 08:35:22 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 07/17] soc: ti: pruss: enable OCP master ports in SYSCFG
 always
Message-ID: <20181123163522.GB53235@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-8-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542886753-17625-8-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [181122 11:39]:
> @@ -160,6 +159,11 @@ static int pruss_enable_module(struct device *dev)
>  	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_MODE_MASK,
>  			  SYSCFG_STANDBY_MODE_SMART);
>  
> +	/* enable OCP master ports/disable MStandby */
> +	ret = pruss_soc_bus_enable_ocp_master_ports(dev);
> +	if (ret)
> +		pruss_disable_module(dev);
> +
>  	return ret;

Seems like all you should need to do here with ti-sysc is to
leave out SYSC_IDLE_SMART and SYSC_IDLE_SMART_WKUP in the dts
for ti,sysc-midle property for am335x.

Regards,

Tony
