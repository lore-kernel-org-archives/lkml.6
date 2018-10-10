Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCC5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110972087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110972087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJJWJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:09:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55542 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeJJWJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:09:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CD6C720794; Wed, 10 Oct 2018 16:46:40 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9B71B20618;
        Wed, 10 Oct 2018 16:46:30 +0200 (CEST)
Date:   Wed, 10 Oct 2018 16:46:31 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next] net: mscc: allow extracting the FCS into the skb
Message-ID: <20181010144631.GE3368@kwain>
References: <20181001095714.26024-1-antoine.tenart@bootlin.com>
 <25a88126-2397-a1fb-0c0d-06504bb348ca@gmail.com>
 <20181002065937.GB3368@kwain>
 <20181002124323.GC9155@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181002124323.GC9155@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, Oct 02, 2018 at 02:43:23PM +0200, Andrew Lunn wrote:
> > The question could be "do we need len += ETH_FCS_LEN" to account for the
> > FCS when NETIF_F_RXFCS is used", but I looked at other drivers and it
> > seemed to me the FCS is not accounted in the stats. Should it be?
> 
> There does not appear to be a good answer to that. I submitted a patch
> to a driver i'm using to not count it, so that the stats counters we
> consistent with another driver. The patch was rejected.
> 
> I think the best you can do is flip a coin, and then document it using
> a comment about if it is/is not included.

I'll leave it as-is then :)

@Dave, Florian: it seems to me no modification was requested after
discussing those changes. Where do we stand regarding the patch?

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
