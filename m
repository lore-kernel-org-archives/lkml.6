Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71AAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B7C20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OoczqLiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfAOOFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:05:15 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:43662 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729370AbfAOOFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=wBET1aOv4IRUslJ37ilGgnCFNrhFE/B+fe4p7JS23OY=;
        b=OoczqLiWbU00wxoHLeQm525I2KjClZq5nMUhuDvLF+261Kkc/HM0ilMA3D5Ns+mIaCjToYa3QqoJoaxxe0RKzpxMxuFUlyRLrB8vW+89EfvAQJ7lkSI8sxhbb/BeJ3lmhSDNxhjiAgsLTWQL9qanSNS12ORjcYlzRd696/qz28E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjPL3-0005n9-9Q; Tue, 15 Jan 2019 15:05:09 +0100
Date:   Tue, 15 Jan 2019 15:05:09 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Camelia Groza <camelia.groza@nxp.com>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        oss@buserror.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: phy driver features are mandatory
Message-ID: <20190115140509.GH19687@lunn.ch>
References: <1547555719-13541-1-git-send-email-camelia.groza@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547555719-13541-1-git-send-email-camelia.groza@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 02:35:19PM +0200, Camelia Groza wrote:
> Since phy driver features became a link_mode bitmap, phy drivers that
> don't have a list of features configured will cause the kernel to crash
> when probed.
> 
> Prevent the phy driver from registering if the features field is missing.
> 
> Fixes: 719655a14971 ("net: phy: Replace phy driver features u32 with link_mode bitmap")
> Reported-by: Scott Wood <oss@buserror.net>
> Signed-off-by: Camelia Groza <camelia.groza@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
