Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131D3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B412186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aCU287m0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbeLTOR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:17:57 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:39671 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731279AbeLTOR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:17:57 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 11B2712F6;
        Thu, 20 Dec 2018 09:17:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 20 Dec 2018 09:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FAPJNg
        XQNuETPLoRkN8vd6Z2RNtvTyjM0g99HzWNgtE=; b=aCU287m0JpIhtYCqMxcr4o
        5WHxXJ/a1ifrHJrnnfpKao13DBRp43FgwQYa1uVJtrDKZF6+Ru36rxi6LJ7QGTO5
        3ybwP2YWXJmaeDPhCu4J8fgiSnVwuqBZkZgrNWAl9FOoUoszgwColCQS833RVzBI
        GwZ54xZOEdVbv38n5ls6lnVWHdO8ITTiUgYSQOjCVQ6V0TKjQSytpzsF3XykprtD
        TXdudIBkpNkijIjrhnh11cQVMkMUJ6FFw1qHjtrNeHx6yUfTRDsEVAUtBmZujAXB
        9DTXLsky1ynUTXtz2vuAtUfe3oMpiwSNl6kdRqeDiWfmaBl5W7A2iarDl1LN+VpA
        ==
X-ME-Sender: <xms:k6QbXEGWdaSUHZwrrWl2J_bIvxqsNuyS1WE8sMcyh57d-c54UyHIyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudejfedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfh
    ggtggujggfsehttdertddtredvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehi
    ughoshgthhesihguohhstghhrdhorhhgqeenucfkphepudelfedrgeejrdduieehrddvhe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
    necuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:k6QbXI4JM5sSNX3zotQJ1J5R4I9cX_hhogZNhyIjV2TzR9clXCFRGg>
    <xmx:k6QbXFbvBxfMwu7yIssdRgYcGVquWVl9h9TjJEexrhI3uFWWK6PvQg>
    <xmx:k6QbXOduhHZ2C1md4QmlnWWPWCyo44uedxTw-Ins9Lf31JUg0s0jWQ>
    <xmx:k6QbXDdIeKpVk7yHyxhWiQihgheHYa-XP0tQNOK__7umP2f4ALS2vA>
Received: from localhost (unknown [193.47.165.251])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6757E100E5;
        Thu, 20 Dec 2018 09:17:54 -0500 (EST)
Date:   Thu, 20 Dec 2018 16:17:52 +0200
From:   Ido Schimmel <idosch@idosch.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     willemb@google.com, Michael S Tsirkin <mst@redhat.com>,
        netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: 4.20-rc6: WARNING: CPU: 30 PID: 197360 at
 net/core/flow_dissector.c:764 __skb_flow_dissect
Message-ID: <20181220141752.GB861@splinter>
References: <ba519cd8-ab88-2868-f6d0-be321d8df0be@de.ibm.com>
 <20181220091207.GA25942@splinter>
 <0c5a8fa8-efb3-71f2-0da9-6fc0f133cdf9@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5a8fa8-efb3-71f2-0da9-6fc0f133cdf9@de.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 03:09:22PM +0100, Christian Borntraeger wrote:
> On 20.12.2018 10:12, Ido Schimmel wrote:
> > +Willem
> > 
> > On Thu, Dec 20, 2018 at 08:45:40AM +0100, Christian Borntraeger wrote:
> >> Folks,
> >>
> >> I got this warning today. I cant tell when and why this happened, so I do not know yet how to reproduce.
> >> Maybe someone has a quick idea.
> >>
> >> [85109.572032] WARNING: CPU: 30 PID: 197360 at net/core/flow_dissector.c:764 __skb_flow_dissect+0x1f0/0x1318
> > 
> > I managed to trigger this warning as well the other day, but from a
> > different call path:
> 
> FWIW, it also seems to happen on 4.20-rc1. 4.19.0 seems fine. bisect seem to have failed so
> my reproducer is not reliable.

Yes, it is caused by commit d0e13a1488ad ("flow_dissector: lookup netns
by skb->sk if skb->dev is NULL")

$ git tag --contains d0e13a1488ad
v4.20-rc1
v4.20-rc2
v4.20-rc3
v4.20-rc4
v4.20-rc5
v4.20-rc6
