Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9823AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C0220657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wQrH+YSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393835AbfAPPCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:02:25 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45319 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732029AbfAPPCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=WAA4HOZ6I/Sr1cYQj0+7DZrnQ+BzNwsjUEdbCAxY84o=;
        b=wQrH+YSlsRigKIJowwNpQKdN9Q4w/kBM6aPnk/WatM9ab/upiG/Ga6/HcNlWxnez9qP9kUOzJnGkdv4bUGU+o63rKDtwJZh9EqwJI/SYifRMQXAnYCIYHh5w4U32HTfGt8BF6zkiboDVRPsmNk6gQh26DsYZY5qNmxveY2wMzZg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjmhw-0007Rc-GA; Wed, 16 Jan 2019 16:02:20 +0100
Date:   Wed, 16 Jan 2019 16:02:20 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Johan Hovold <johan@kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] net: dsa: lantiq_gswip: fix OF child-node lookups
Message-ID: <20190116150220.GF25731@lunn.ch>
References: <20190116102335.30433-1-johan@kernel.org>
 <20190116102335.30433-3-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116102335.30433-3-johan@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:23:34AM +0100, Johan Hovold wrote:
> Use the new of_get_compatible_child() helper to look up child nodes to
> avoid ever matching non-child nodes elsewhere in the tree.
> 
> Also fix up the related struct device_node leaks.
> 
> Fixes: 14fceff4771e ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
> Cc: stable <stable@vger.kernel.org>	# 4.20
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
