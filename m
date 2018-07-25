Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B33C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0A420843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="txjnzKef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0A420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbeGYPgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:36:08 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45600 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbeGYPgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=1V/D8usG1FbAr8jPPtbtCkdYo00WFgH4Uau5Ec3OmCI=;
        b=txjnzKefLHWpTdQAKdk+QuvxF6QIaaGv2SiepxNtgfcT+ATQNmjTI2vvIiB/FzQhJ07TeD/pdWTEelh499gaKztQuMga86SFlwhHvPJexWiQJ5dHyHh+AOTRiu3w6OC6ooXwMvFkclgV4mL/qfB0FLhFgllsVN2gFX6v3bkWUco=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fiKhy-00045D-SJ; Wed, 25 Jul 2018 16:24:06 +0200
Date:   Wed, 25 Jul 2018 16:24:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Camelia Groza <camelia.groza@nxp.com>
Cc:     f.fainelli@gmail.com, rmk+kernel@armlinux.org.uk,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: prevent PHYs w/o Clause 22 regs from
 calling genphy_config_aneg
Message-ID: <20180725142406.GC13891@lunn.ch>
References: <1532358375-8146-1-git-send-email-camelia.groza@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532358375-8146-1-git-send-email-camelia.groza@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 06:06:15PM +0300, Camelia Groza wrote:
> genphy_config_aneg() should be called only by PHYs that implement
> the Clause 22 register set. Prevent Clause 45 PHYs that don't implement
> the register set from calling the genphy function.
> 
> Signed-off-by: Camelia Groza <camelia.groza@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
