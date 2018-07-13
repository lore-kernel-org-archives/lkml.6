Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE5AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457ED20858
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="R2hG2AVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457ED20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbeGMTd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:33:28 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48760 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731427AbeGMTd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7tmbbBATm1x3nRc79YZNZVC6DnQDRixH0eeClhqTJAI=; b=R2hG2AVW2bJ7PoRUBRFcDCJ0w
        sQYCIKTPL/7joRG+NuT5o4VwGF1iDd1lW7k5m5z38RllPfs2EGKXtXD8RWLhqqrcUtoDG3QijhS+o
        xUaAaSPuN/tQld7hEinyfZ+xfcpF7XUP30Ml+yj8CbTSqGF85rXEqDLi91FEMJBaQ1zMU=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:53293)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fe3ZE-0005gP-RN; Fri, 13 Jul 2018 20:17:25 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fe3ZB-0003Fy-Tt; Fri, 13 Jul 2018 20:17:21 +0100
Date:   Fri, 13 Jul 2018 20:17:20 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Dmitri Epshtein <dima@marvell.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH net-next v2 3/7] net: mvneta: increase number of buffers
 in RX and TX queue
Message-ID: <20180713191720.GA17271@n2100.armlinux.org.uk>
References: <20180713161841.11202-1-gregory.clement@bootlin.com>
 <20180713161841.11202-4-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713161841.11202-4-gregory.clement@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 06:18:37PM +0200, Gregory CLEMENT wrote:
> From: Yelena Krivosheev <yelena@marvell.com>
> 
> The initial values were too small leading to poor performance when using
> the software buffer management.

What does this do to latency when a large transfer is also ongoing
(iow, the classic bufferbloat issue) ?

> 
> Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
> [gregory: extract from a larger patch]
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index f4e3943a745d..c22df28b07c8 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -295,10 +295,10 @@
>  #define MVNETA_RSS_LU_TABLE_SIZE	1
>  
>  /* Max number of Rx descriptors */
> -#define MVNETA_MAX_RXD 128
> +#define MVNETA_MAX_RXD 512
>  
>  /* Max number of Tx descriptors */
> -#define MVNETA_MAX_TXD 532
> +#define MVNETA_MAX_TXD 1024
>  
>  /* Max number of allowed TCP segments for software TSO */
>  #define MVNETA_MAX_TSO_SEGS 100
> -- 
> 2.18.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
