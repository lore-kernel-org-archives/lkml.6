Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF6EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CBA20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZsTTXhAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404999AbfAPPon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:44:43 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45383 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728777AbfAPPon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Zc8Ub3ApSTPyG+9Bl4BPfynnA5U5HNdRYwwgarLP/VY=;
        b=ZsTTXhAupcl8K7uW8VPMv3iBqX6vSD5XsV6/i4mFUzMmuNdIeLRh2VxvQF94b8nrVzTEKhBdJGRDb7LQR/gyrTpk6P+QolhdDiE/AV+UmDKTRxxi2coR9++OGKkQX7bgWgoXcWS2QJwV2V5wpBh7Xy86K+dDuapUEu2nHxSHrV0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjnMt-0007oz-Ls; Wed, 16 Jan 2019 16:44:39 +0100
Date:   Wed, 16 Jan 2019 16:44:39 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] net: phy: mdio_bus: add missing device_del() in
 mdiobus_register() error handling
Message-ID: <20190116154439.GA29244@lunn.ch>
References: <20190116095358.28354-1-thomas.petazzoni@bootlin.com>
 <20190116144829.GC25731@lunn.ch>
 <20190116161855.1d01e083@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116161855.1d01e083@windsurf>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:18:55PM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Wed, 16 Jan 2019 15:48:29 +0100, Andrew Lunn wrote:
> 
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > However, i wounder if it makes sense to add a label before the
> > existing device_del() at the end of the function, and convert this,
> > and the case above into a goto? That might scale better, avoiding the
> > same issue in the future?
> 
> That's another option indeed.
> 
> Hmm, now that I looked at it, I think we should use device_unregister()
> instead. device_unregister() does both device_del() and put_device().

Hi Thomas

device_unregister() does seem symmetrical with device_register() which
is what we are trying to undo.

   Andrew
