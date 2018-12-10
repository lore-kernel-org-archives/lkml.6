Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E5FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B4620821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B4620821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbeLJXXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:23:22 -0500
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:44429 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728921AbeLJXXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:23:22 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D0E51187A6301;
        Mon, 10 Dec 2018 23:23:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: order75_1d113e709753b
X-Filterd-Recvd-Size: 3518
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Dec 2018 23:23:19 +0000 (UTC)
Message-ID: <128afaebcd8fdb52bd90dcc9a09ee2d23d306a5a.camel@perches.com>
Subject: Re: [PATCH] net: fix braces and comments codestyle
From:   Joe Perches <joe@perches.com>
To:     Darya Litvintseva <litv.daria@gmail.com>
Cc:     alex.mikhalevich@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Dec 2018 15:23:18 -0800
In-Reply-To: <20181210231140.5280-1-litv.daria@gmail.com>
References: <20181210231140.5280-1-litv.daria@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 02:11 +0300, Darya Litvintseva wrote:
> Signed-off-by: Darya Litvintseva <litv.daria@gmail.com>

Hello.

Most maintainers want some patch description
and not a blank commit message.

Whitespace only changes are sometimes not taken.

First kernel patches are best done in drivers/staging.

And some additional comments below...

cheers, Joe

> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
[]
> @@ -90,9 +90,7 @@ int eth_header(struct sk_buff *skb, struct net_device *dev,
>  	else
>  		eth->h_proto = htons(len);
>  
> -	/*
> -	 *      Set the source hardware address.
> -	 */
> +	/* Set the source hardware address.*/

Most single line comments use a space before the */

> @@ -170,13 +166,11 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
>  			skb->pkt_type = PACKET_BROADCAST;
>  		else
>  			skb->pkt_type = PACKET_MULTICAST;
> -	}
> -	else if (unlikely(!ether_addr_equal_64bits(eth->h_dest,
> +	} else if (unlikely(!ether_addr_equal_64bits(eth->h_dest,
>  						   dev->dev_addr)))

please realign multiline statements to the open parenthesis

> @@ -187,8 +181,7 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
>  	if (likely(eth_proto_is_802_3(eth->h_proto)))
>  		return eth->h_proto;
>  
> -	/*
> -	 *      This is a magic hack to spot IPX packets. Older Novell breaks
> +	/*      This is a magic hack to spot IPX packets. Older Novell breaks
>  	 *      the protocol design and runs IPX over 802.3 without an 802.2 LLC
>  	 *      layer. We look for FFFF which isn't a used 802.2 SSAP/DSAP. This
>  	 *      won't work for fault tolerant netware but does for the rest.

Given the ipx protocol removal, perhaps this block
should be revisited.

commit e02554e9a4338c58e75fdfb0ef908a5adc86cba5
Author: Stephen Hemminger <stephen@networkplumber.org>
Date:   Tue Nov 14 08:37:14 2017 -0800

    ipx: move Novell IPX protocol support into staging

commit 7a2e838d28cff6718a0bdf66164465402f8e40ed
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri Jun 1 20:39:54 2018 +0200

    staging: ipx: delete it from the tree
    
    The ipx code moved into the staging tree back in November 2017 and no
    one has complained or even noticed it was gone.  Because of that, let's
    just delete it.

> @@ -197,8 +190,7 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
>  	if (sap && *sap == 0xFFFF)
>  		return htons(ETH_P_802_3);
>  
> -	/*
> -	 *      Real 802.2 LLC
> +	/* Real 802.2 LLC
>  	 */

better to move the closing */ up as a single line comment


