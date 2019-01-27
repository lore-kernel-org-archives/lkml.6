Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC39C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEB52147A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i5Hbb1c8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfA0Vq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:46:59 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:56790 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfA0Vq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 16:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HIllJydWQs4BgpNdQuZJ42RBbRrcF00xi7uMR9vl+1M=; b=i5Hbb1c8idjc/UP+HBVLMtZfDp
        TiNDrvcO4QRHMWkEKVoXxeeEYqrsuv5NmJh1B/P2VMeX0RtOxKII1dSeBgok2AM8ei7LaSVFZHhZM
        7Lpxa6/hayMwMv95HF1tF1iuWd1d3uHHwojDKhX09XcWKihrkXtXoVG8fB4HuqlTsWTQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gnsGS-000135-Nw; Sun, 27 Jan 2019 22:46:52 +0100
Date:   Sun, 27 Jan 2019 22:46:52 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Miller <davem@davemloft.net>
Cc:     miquel.raynal@bootlin.com, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, antoine.tenart@bootlin.com,
        maxime.chevallier@bootlin.com, nadavh@marvell.com
Subject: Re: [PATCH net-next v2 0/2] mv88e6xxx DSA suspend to RAM support
Message-ID: <20190127214652.GB32046@lunn.ch>
References: <20190125095507.29334-1-miquel.raynal@bootlin.com>
 <20190127.132250.578158295862987283.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190127.132250.578158295862987283.davem@davemloft.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 01:22:50PM -0800, David Miller wrote:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> Date: Fri, 25 Jan 2019 10:55:05 +0100
> 
> > After a first attempt of bringing S2RAM support to the DSA switch, it
> > has been reported that a part of the configuration was lost during the
> > cycle. This second version adds a first patch that saves the rules in
> > a per-chip list when they are applied, so that in the second patch we
> > bring S2RAM support by also re-applying these rules.
>  ...
> 
> It seems like the discussion on patch #1 has hit a brick wall.
> 
> The last suggestion was to use:
> 
> +       switch (mode) {
> +       case PHY_INTERFACE_MODE_2500BASEX:
> +               phydev->speed = SPEED_2500;
> +               break;
> +       case PHY_INTERFACE_MODE_10GKR:
> +               phydev->speed = SPEED_10000;
> +               break;
> +
> 
> in dsa_port_fixed_link_register_of(), but that doesn't work
> because swphy will fail without speed=1000 in the dts.
> 
> Well, whatever is decided, the commit message need to be updated
> to explain why this course of action for the most immediate fix
> was ultimately taken.

Hi David

Err. 

I think you are replying to the wrong patch? This comment fits to

https://www.spinics.net/lists/netdev/msg546662.html

Although i don't like it, i think for the moment we are going to have
to accept the proposed fix.

	Andrew
