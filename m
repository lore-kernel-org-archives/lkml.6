Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F2EC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7411A206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T58W2BTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7411A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeI3CQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:16:02 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49518 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbeI3CQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=+CB8mwFDNNkQUlYtd5DdX6BjyEOvIDmkAZ6qeGemSCU=;
        b=T58W2BTex0LuYGBiSZe+CXvpUKHtjr66TjHP2rr0+i4iDqQAyPxB0usBlkYzTgvBUe2+7+x/GcX0DHqMQilIawibxm+YdTqoXymaT2CKnk1czuigftNd+1ZoRB8JJ0fXJZDoFb8KL5wROqZsUUM1KuQ9065/rTA0/6WSACPthxw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g6LBw-0003Nj-Ec; Sat, 29 Sep 2018 21:46:16 +0200
Date:   Sat, 29 Sep 2018 21:46:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [v2, 1/5] net: dpaa2: move DPAA2 PTP driver out of staging/
Message-ID: <20180929194616.GA11532@lunn.ch>
References: <20180929072645.20027-1-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929072645.20027-1-yangbo.lu@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/drivers/net/ethernet/freescale/dpaa2/Kconfig
> @@ -0,0 +1,15 @@
> +config FSL_DPAA2_ETH
> +	tristate "Freescale DPAA2 Ethernet"
> +	depends on FSL_MC_BUS && FSL_MC_DPIO

Could you add in here COMPILE_TEST? 

> +	depends on NETDEVICES && ETHERNET

With the move out of staging, i don't think these two are required.

     Andrew
