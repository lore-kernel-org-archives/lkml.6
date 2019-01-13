Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20675C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E370B20842
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547350311;
	bh=i3YZhurD+wS38n1W/dKsJd/8/j3dp3xIr4+kune7Zxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QvsItfZ48QtnObrrrITKADbK4z+br7Hb5rdTfY6HQ2P2M/cI6UhuXiTQOW+OdQcBc
	 dhAV+/J/88FEU1Bt+3uAGjS2OTmJCoMmeb1aA/U6nOGRQmFrKNfdSMIZz0FalIMpEc
	 9I74h/HIe3Xcpqf7VilolDknXJOlReU3Ggvsg17A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfAMDbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 22:31:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfAMDbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 22:31:40 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C3AB20842;
        Sun, 13 Jan 2019 03:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547350300;
        bh=i3YZhurD+wS38n1W/dKsJd/8/j3dp3xIr4+kune7Zxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jnn7/10AFQ25Tyk+pVSEDuAUebK+YxALTfB5yfgsKg+Qq+8mHIoBNq4dvdgdaEM1x
         oyJBlGd4by+lcSrCO6wazvs0u5daDtVAQaOi51+WyLdlkwg/sN6GUqYGvOzVvm23+t
         cbmjUeLAGdVVFvtdl6nkeUzDfL7tvW2arz3E3OwY=
Date:   Sun, 13 Jan 2019 11:31:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 5/7] ARM: dts: ls1021a: Remove
 fsl,qspi-has-second-chip as it is not used
Message-ID: <20190113033117.GG11426@dragon>
References: <20190107092823.11188-1-frieder.schrempf@kontron.de>
 <20190107092823.11188-6-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107092823.11188-6-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 09:29:54AM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> After switching to the new FSL QSPI driver the property
> 'fsl,qspi-has-second-chip' is not needed anymore.
> 
> The driver now uses the 'reg' property to determine the bus and
> the chipselect.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied, thanks.
