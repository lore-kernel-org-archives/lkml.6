Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAC9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B388820C01
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gprwmfar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfBPPfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 10:35:52 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55037 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfBPPfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 10:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BCwTNLnSfWmWx+msq9qhbUOplBjAEYWNyi4p1N/H5yM=; b=gprwmfarwTg+Ep8c32bETQsViH
        m5Ny3E7Y7HCXTrPPkebVghY+533NbYhKh53qfRmwO3WqAT6bBEpwavZTiLcBNDyHxVUXagCvA0ouA
        HPQZLxs4PPFtFbC8cA0pQu+YGUVD4+/aatWSX0twkneaKXE+nIFaNWPuDfqbd/m3QfSA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gv20H-0008UV-W0; Sat, 16 Feb 2019 16:35:46 +0100
Date:   Sat, 16 Feb 2019 16:35:45 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rundong Ge <rdong.ge@gmail.com>
Cc:     vivien.didelot@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: Implement flow_dissect callback for tag_dsa.
Message-ID: <20190216153545.GM5699@lunn.ch>
References: <20190216083524.860-1-rdong.ge@gmail.com>
 <CAN1Lvyqo4K3OJEO-RAnp03tM5SgBr3ZK=NTCtKOc+YTymjw8CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN1Lvyqo4K3OJEO-RAnp03tM5SgBr3ZK=NTCtKOc+YTymjw8CA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 04:38:25PM +0800, Rundong Ge wrote:
> Hi Andrew
> 
> I have tested the L3 forwarding throughput performance of my box (with
> an intel 4-core processor and each core’s frequency is 2.20GHz).
> In my test scenario, I generated 200 UDP flows (frame size is 64
> bytes) with different src/dst pairs from eth1 to eth0. Eth1 is a slave
> DSA device from mv88e6190x, eth0 is an intel NIC. Then get the max fps
> with no frame losing.
> 
> The max fps with RPS working is 400235fps, frames are hashed to four
> cores’ backlog.
> And the max fps without RPS is 199686fps.

Nice numbers, thanks.

     Andrew
