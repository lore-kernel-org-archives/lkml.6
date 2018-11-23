Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D82C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D3320868
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D3320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440609AbeKXDZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:25:09 -0500
Received: from muru.com ([72.249.23.125]:54850 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730360AbeKXDZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:25:09 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EA82380D4;
        Fri, 23 Nov 2018 16:40:12 +0000 (UTC)
Date:   Fri, 23 Nov 2018 08:40:08 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 14/17] ARM: OMAP2+: use pdata quirks for PRUSS reset
 lines on AM335x
Message-ID: <20181123164008.GD53235@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-15-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542886753-17625-15-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [181122 11:40]:
> From: Suman Anna <s-anna@ti.com>
> 
> The omap_device API is needed to perform the reset management for
> any IP instances with PRCM RSTCTRL registers (hard reset lines).
> This API is limited to the mach-omap2 layer, and cannot be exposed
> to drivers layer directly. So use platform data ops and pdata quirks
> for the PRUSS IP in AM335x SoCs to plumb the required omap_device
> API. The PRUSS SoC bus driver can then use these pdata ops to
> achieve the required reset functionality.
> 
> This is being implemented this way as there is no separate reset
> driver at the moment.

If the reset-simple approach has issues we can certainly do
this until the issues are fixed. I believe Suman had an issue
where we need to prevent the related clockdomain from idling.

Regards,

Tony
