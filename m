Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703D2C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D85E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DT1V4ovv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D85E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbeLKMgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:36:48 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:42794 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeLKMgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=cO8bqPObluxtwqtj8Yy9cAeq1a0www2jVDD2cOH/QRk=;
        b=DT1V4ovvDhT0t/LTh66Wy+z2sFoLJfmE2O9wcKkg3bm4C4HAwc/JNhVHM/+bzHshR/cmCBH70LlJHqMIbjUkk4SCPkhyxvzp3ebGyP8EcHoPzQrwabdcUp6SNxRgRigdGlnmVVFD3YiX42OkhKUzt8imbVsCcGxilTqBev0/vOM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gWhHE-0001mm-1C; Tue, 11 Dec 2018 13:36:40 +0100
Date:   Tue, 11 Dec 2018 13:36:40 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Rob Herring <robh@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Message-ID: <20181211123640.GC4632@lunn.ch>
References: <1541086962-52626-1-git-send-email-michal.vokac@ysoft.com>
 <5bea0e99.1c69fb81.18be0.5162@mx.google.com>
 <42ffee3e-7c2a-aab9-547f-2064a77339a8@ysoft.com>
 <a61683a2-30aa-e387-2170-3d79e0043739@ysoft.com>
 <18065d41-4ae0-ada2-35f1-00d8a8489397@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18065d41-4ae0-ada2-35f1-00d8a8489397@ysoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Rob, gentle ping on this.
> > 
> > I would like to be sure how to proceed with this. Do you really want me
> > to move *all* nodes that are disabled in this common dtsi into the per
> > board dts?
> > 
> > All the boards use identical PCB. Anything that is disabled here is not
> > present on at least one of the boards. It means it is routed on the
> > board and the SoC has the capability but the parts are not populated.
> > 
> > So it is not only about the LED controller. What about the LCD, OLED,
> > backlight, USB..?
> 
> Can anybody advice how to split these dts/dtsi files, please?
> I am not sure what should reside in the common dtsi and what should
> be moved into the per board dts in case my current solution is not
> appropriate.

The kirkwood-synology.dtsi might be of interest? There are a lot of
Synology NAS boxes which share a lot in common. So all the common
parts are in that .dtsi. The .dbs file for each individual model then
enables the parts its needs.

Although you have one PCB, or the different population options
considered different products, each with there own name?

	   Andrew
