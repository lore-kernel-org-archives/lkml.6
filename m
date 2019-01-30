Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87685C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D35F20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iqglBNhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbfA3Oyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:54:54 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:60831 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfA3Oyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5lWYKsHmAE4r1e//7E7PKX6QyeygySxcblH/Cgc6XiA=; b=iqglBNhN2HN/ToAD4aambRINrX
        O/mOEaXCQ9Pgk12feWTbhgFHfbmW14X1zEwYQe5lQ9fn1+Z7ocnUTsJ4tx4u1qAoTm5LGFHrddklB
        qSDuTDrVLzNu9OJt9leUqlDPaJgHI/HWSzNEqnzIbazQWsprNc8DYVlmgiAEIfqdsHCU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gorGJ-0003Tw-U1; Wed, 30 Jan 2019 15:54:47 +0100
Date:   Wed, 30 Jan 2019 15:54:47 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: Save switch rules
Message-ID: <20190130145447.GB21904@lunn.ch>
References: <20190125095507.29334-2-miquel.raynal@bootlin.com>
 <c1421a5d-5f92-bb86-b5cc-9fa19a1c8d9f@gmail.com>
 <20190128152456.212ae5ac@xps13>
 <20190128144417.GG4765@lunn.ch>
 <20190128165749.6abf2dc4@xps13>
 <20190128174246.GD28759@lunn.ch>
 <20190129100117.5ef6774c@xps13>
 <20190129145157.GK4765@lunn.ch>
 <20190129104613.GC20920@t480s.localdomain>
 <20190130104606.31639abb@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130104606.31639abb@xps13>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So your proposal is to refuse suspending when using a mv88e6xxx switch.

Hi Miquèl

That is the first step. It makes the mv88e6xxx suspend compliant, in
that it currently does not support suspend.

> What about the current situation where suspending is allowed, but all
> the configuration gone?

That is broken. The whole point of suspending is that you resume back
to the original state.

   Andrew
