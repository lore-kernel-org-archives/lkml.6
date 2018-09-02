Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACA5C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 18:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B73E20857
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 18:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4EsP+KDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B73E20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeIBWi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 18:38:29 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50120 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeIBWi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 18:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=J7nH309r/0kP9BRWaewatVPHYXU5Eu77IKdQX6y78M0=;
        b=4EsP+KDaQIosoEK/abLrSxKPR6kn2O5JDjQiuIoQrwCRTcHTaGgzJEh19cBKODUNdOGDNeXCDaS0G3AWISH/tFiBAJS2zwFOMrwazoSeGpPPOjYyxpoOqtWzntF4B5Osi4VZsDoui2mWgRhBwikU2Rpe0uPQ1OEIVwCPczUhDgw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fwX08-0005Ar-7L; Sun, 02 Sep 2018 20:21:32 +0200
Date:   Sun, 2 Sep 2018 20:21:32 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     thomas.petazzoni@bootlin.com,
        "David S. Miller" <davem@davemloft.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: mvneta: enable NETIF_F_RXCSUM by
 default
Message-ID: <20180902182132.GA18764@lunn.ch>
References: <20180831160810.2539ef4c@xhacker.debian>
 <20180831161003.3f0dc351@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831161003.3f0dc351@xhacker.debian>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 04:10:03PM +0800, Jisheng Zhang wrote:
> The code and HW supports NETIF_F_RXCSUM, so let's enable it by default.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Hi Jisheng

I ran some quick tests on a 370RD devel board, which uses a Marvell
switch connected to mvneta. I did no see any obvious regressions.

Tested-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
