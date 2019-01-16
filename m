Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A5AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9AC20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2vP9VbAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbfAPWPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:15:08 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45895 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732540AbfAPWPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=bR5RZbwLk5HW0kBwtAVbgiXHHXAJhfO4QSLDYgpU2/s=;
        b=2vP9VbAcPhHZjE7DxO4KgoWWy92/hoY+LQiEeeW9MevvC3ReZaclfM2yFbQAG+G0LDUqNAOuqhkGUv1pT0BdT7r8YhHX1a+sV7ofi3DFa9NUorCEyUQn/ZphN6TSTcvjI0Tp1/NpiTRtYqIbxqzBQS4BO8xFzKkVNnD0prL/Poc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjtSe-0002el-DW; Wed, 16 Jan 2019 23:15:00 +0100
Date:   Wed, 16 Jan 2019 23:15:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] net: dsa: lantiq_gswip: fix use-after-free on failed
 probe
Message-ID: <20190116221500.GO29244@lunn.ch>
References: <20190116102335.30433-1-johan@kernel.org>
 <20190116102335.30433-2-johan@kernel.org>
 <20190116150009.GE25731@lunn.ch>
 <1e158c63-c578-1eb3-916e-d6d5a477270e@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e158c63-c578-1eb3-916e-d6d5a477270e@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is correct. But it would be nice if somebody in the future could
> > move the disabling of the switch to the inverse of the gswip_setup()
> > function to make the code symmetrical.
> 
> Should we add an uninit callback?

Yes, that would be good.

It looks like lan9303-core.c could use it as well for
lan9303_disable_processing(chip);

Thanks
	Andrew
