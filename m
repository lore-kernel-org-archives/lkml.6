Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E21C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4655217BB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXqhHLzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4655217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeHUSf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbeHUSf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:35:57 -0400
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C0B2177F;
        Tue, 21 Aug 2018 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534864523;
        bh=Ld0eNxkdiT6XrPf5RdoxmFeNdsvHjztNzMGGLr29k4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXqhHLzcZ8TawzUTzxIifC7IgL+DTnUOdhzANlwdU+rNcafZPQNMq04A8Fglxk1JZ
         pWvC5PoZEreR13XXdrUQRn/8oMPQJvy9BMzn3WI0mXLWyVAP/8P5MvZ0OFSkVaVODW
         iEstgjmrmQjWVsRtJ/6vQzPgNlUFSO4JboPP+X14=
Date:   Tue, 21 Aug 2018 23:14:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sven Schmitt <Sven.Schmitt@mixed-mode.de>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [PATCH v3 1/3] soc: imx: gpc: fix PDN delay
Message-ID: <20180821151441.GA32159@dragon>
References: <1532425558626.11533@mixed-mode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532425558626.11533@mixed-mode.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 09:46:03AM +0000, Sven Schmitt wrote:
> imx6_pm_domain_power_off() reads iso and iso2sw from GPC_PGC_PUPSCR_OFFS 
> which stores the power up delays. 
> So use GPC_PGC_PDNSCR_OFFS for the correct delays.
> 
> Signed-off-by: Sven Schmitt <sven.schmitt@mixed-mode.de>

Applied, thanks.
