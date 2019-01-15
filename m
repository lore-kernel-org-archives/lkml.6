Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6936C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E7120868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547565530;
	bh=kjck2dWN91B07FyhOC6X6LW0tJP+9eiLLZ8kjOACip0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1THWLHxZjqUOquwS6bAFmllOeGD1zkwSDkOQvCKPe7cByXp6DcNONhsv8xdpQl7uA
	 VO+JxqEck7X3PFMkH8qnTekIvL8vXM52jBg6ObQEo1FkmR9T0qgullvyaLEN30c/Z1
	 vmtdELeHNtrEJFU4B4W+rL/wGZ1jIg2Nb5822Mcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfAOPSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:18:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729583AbfAOPSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:18:49 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C4FD204FD;
        Tue, 15 Jan 2019 15:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547565528;
        bh=kjck2dWN91B07FyhOC6X6LW0tJP+9eiLLZ8kjOACip0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BCjqXdJ7YutbV/t8YXfBBH3Wr0m1iN0GU+zxOov+UaR9BQCe92Yt9Ner89QVsB+ko
         vN2g91VGISnSpLxhLLStNZ3EBgmQopZ05ZYh6mjMaIjJbYcFaZyHhoWAgDCTvI5n0x
         ewAEiFcHXDKDZhySF5rFWV38pd1XoG4+k+X1abFo=
Date:   Tue, 15 Jan 2019 23:18:19 +0800
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
Message-ID: <20190115151818.GD13895@dragon>
References: <20190107092823.11188-1-frieder.schrempf@kontron.de>
 <20190107092823.11188-6-frieder.schrempf@kontron.de>
 <20190113033117.GG11426@dragon>
 <ee3eb5d5-4b04-002e-5e49-d4b766138ec5@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee3eb5d5-4b04-002e-5e49-d4b766138ec5@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 08:18:49AM +0000, Schrempf Frieder wrote:
> Hi Shawn,
> 
> On 13.01.19 04:31, Shawn Guo wrote:
> > On Mon, Jan 07, 2019 at 09:29:54AM +0000, Schrempf Frieder wrote:
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> After switching to the new FSL QSPI driver the property
> >> 'fsl,qspi-has-second-chip' is not needed anymore.
> >>
> >> The driver now uses the 'reg' property to determine the bus and
> >> the chipselect.
> >>
> >> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > 
> > Applied, thanks.
> 
> I just noticed, that this and the arm64 patch depend on the driver 
> changes for 5.1 that go through the SPI tree. So I guess we can't be 
> sure that this will be merged in the right order and we need to delay 
> this cleanup to 5.2, or am I wrong?

You are right.  I just dropped the both patches.  Ping me or resend when
they are ready to go.

Shawn
