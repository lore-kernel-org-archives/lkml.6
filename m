Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45096C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AC6223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfvvi/Ik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AC6223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbeKNAkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:57206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbeKNAkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:40:47 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EEC4214F1;
        Tue, 13 Nov 2018 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542120140;
        bh=8kCSd+umX5xBdI0B83Zs/v/ACL1cESMlBmkNd07ivwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kfvvi/IkmXBAc4AC59K2cr8HpAQgZL6/b1aGh0IUxhwbfc0vJgF7lVdAw+OQy1LYy
         Y47CmSsVjAuYQkGpRHoI8S4041YBlD6fuGNHWkcSkPzT/A6vTP1LAgUvN4jq/PiRoe
         V9TajUBKwPPgl5lUU2Vrp4NvK183HaeXV3CbcgyY=
Date:   Tue, 13 Nov 2018 22:42:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: i.MX25: add the clocks for the EPIT blocks
Message-ID: <20181113144209.GB4557@dragon>
References: <1541093567-29205-1-git-send-email-martin@kaiser.cx>
 <20181104144614.GJ26016@tiger>
 <20181105091230.z2ooz7olbdpopxyd@viti.kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181105091230.z2ooz7olbdpopxyd@viti.kaiser.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 10:12:30AM +0100, Martin Kaiser wrote:
> Hi,
> 
> Thus wrote Shawn Guo (shawnguo@kernel.org):
> 
> > On Thu, Nov 01, 2018 at 06:32:47PM +0100, Martin Kaiser wrote:
> > > The i.MX25 contains two EPIT (Enhanced Periodic Interrupt Timer)
> > > function blocks. Add their ipg and per clocks to the device tree.
> 
> > > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> 
> > Are these EPIT devices actually used in upstream kernel, or just
> > somewhere else?
> 
> Until I saw Vladimir's mail this morning, I wasn't aware of any mainline
> driver that's using the EPIT devices. I found that the clocks are
> missing when I tried to use EPIT with a company-internal driver that's
> not suitable for mainline integration.
> 
> Still, I think that merging this patch does no harm. If the EPIT devices
> are present in the DT, we should add all resources they're using.

Agreed.  I will be happy to apply the patch if I can get an ACK from
Clément saying this works with his driver in upstreaming.

Shawn
