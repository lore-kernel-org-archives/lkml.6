Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3802465-1520707696-2-4244888282622292131
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='ISO-8859-1', plain='ISO-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520707696; b=vqtjDlJCIOCQwAueIMM0VZ5j+n88nPapndDfCft6jbC70Rf
    7LGjSrxSK7tABddEfkS6W8eUOdBc57g1JTcd/JEb12FChIuzofXXwuVqSLhC4niu
    wZ2RGXkShvV4cuBaPduAJmJQADO1fDyTcGey4MHaSIX4WO9GGYgKuxKQMfAy0DTV
    etuA1cnhgq5JDScYw7ta8Yu2xhFBbmOekSnGq5mPj2AjwfffrA5racc2nW/hE11j
    bljlcmCNfi85nhikZFtTTVXDwJa+BdjKB2sm6HGL20ttv/CouWlBXkoQV4yg0a3Q
    Z9ZJoc+s9m4Jm7OLpqZGTxSv44NNdRzadKyfMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520707696; bh=OmCnFvjZwY9RIwO7WjFf1vHSU1nlQ2jkjSz61BT7fY8=; b=A
    LrcRJQuuWwRwq7QemQNAZ/LrmHRZr6KYQtyrYfobOA6018e2waKds0Yo1lsp3h78
    vzz6leed3vcLjf4nZBUhD35WzjUaIf60BCe6AZM6jhuWvhYrfoF+YpyfDnEcx6+U
    GDQXz3/lgz4iwjoqS4pI+Mxsigv9W/cI7Fggi5PklEwu7J7YAbZo3EnpLF40JLKe
    XDb6JXNuZtkDlLoJTJpEWnxTgsRIyvghzGJ8InNK3/WfqNRbkfS4qRbwUnUALcrt
    f1KUiPevZ+L6IzZL7KalTri14ZKrdrNe/VcuC2Pa/htbXQPgGyXs7ZG2wKnQTMcn
    8Ep0DkHfg/oUggUcxmmiA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=perches.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=perches.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbeCJSsO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 13:48:14 -0500
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:38926 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750971AbeCJSsN (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 10 Mar 2018 13:48:13 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Remote-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:69:355:379:541:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3872:3874:4321:4605:5007:6119:7576:7903:10004:10400:10848:10967:11026:11232:11473:11658:11914:12043:12048:12294:12296:12438:12555:12683:12740:12760:12895:13439:14096:14097:14181:14659:14721:21080:21324:21451:21627:30012:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: walk34_2e65402bbd83b
X-Filterd-Recvd-Size: 3627
Message-ID: <1520707317.5345.15.camel@perches.com>
Subject: Re: [PATCH 1/2] net/usb/ax88179_178a: Use common code in
 ax88179_chk_eee()
From: Joe Perches <joe@perches.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        "Andrew F. Davis" <afd@ti.com>,
        =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>,
        Philippe Reynes <tremyfr@gmail.com>,
        Yuval Shaia <yuval.shaia@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Date: Sat, 10 Mar 2018 10:41:57 -0800
In-Reply-To: <a7fff45f-4426-ec33-8b8d-caf1e3a9f0be@users.sourceforge.net>
References: <b92bebdb-c1dc-a9d3-2e3a-845d8dc4998f@users.sourceforge.net>
         <a7fff45f-4426-ec33-8b8d-caf1e3a9f0be@users.sourceforge.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 2018-03-10 at 19:24 +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 10 Mar 2018 18:22:43 +0100
> 
> Adjust a jump target so that a bit of common code can be better reused
> at the end of this function.

Please stop mindlessly sending patching Markus.

How about looking at the code being modified and
thinking about what it does?

Try unindenting the block by reversing the first test
and using the same goto set_inactive.

Look at the last & tests
+		if (!(lp & adv & supported))
and see if it should use && or be more simple to read
by using
	if (!condition || !

> ---
>  drivers/net/usb/ax88179_178a.c | 34 +++++++++++-----------------------
>  1 file changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index f32261ecd215..e4b0baa98e9a 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -689,49 +689,37 @@ static int ax88179_chk_eee(struct usbnet *dev)
>  		eee_cap = ax88179_phy_read_mmd_indirect(dev,
>  							MDIO_PCS_EEE_ABLE,
>  							MDIO_MMD_PCS);
> -		if (eee_cap < 0) {
> -			priv->eee_active = 0;
> -			return false;
> -		}
> +		if (eee_cap < 0)
> +			goto set_inactive;
>  
>  		cap = mmd_eee_cap_to_ethtool_sup_t(eee_cap);
> -		if (!cap) {
> -			priv->eee_active = 0;
> -			return false;
> -		}
> +		if (!cap)
> +			goto set_inactive;
>  
>  		eee_lp = ax88179_phy_read_mmd_indirect(dev,
>  						       MDIO_AN_EEE_LPABLE,
>  						       MDIO_MMD_AN);
> -		if (eee_lp < 0) {
> -			priv->eee_active = 0;
> -			return false;
> -		}
> +		if (eee_lp < 0)
> +			goto set_inactive;
>  
>  		eee_adv = ax88179_phy_read_mmd_indirect(dev,
>  							MDIO_AN_EEE_ADV,
>  							MDIO_MMD_AN);
> -
> -		if (eee_adv < 0) {
> -			priv->eee_active = 0;
> -			return false;
> -		}
> +		if (eee_adv < 0)
> +			goto set_inactive;
>  
>  		adv = mmd_eee_adv_to_ethtool_adv_t(eee_adv);
>  		lp = mmd_eee_adv_to_ethtool_adv_t(eee_lp);
>  		supported = (ecmd.speed == SPEED_1000) ?
>  			     SUPPORTED_1000baseT_Full :
>  			     SUPPORTED_100baseT_Full;
> -
> -		if (!(lp & adv & supported)) {
> -			priv->eee_active = 0;
> -			return false;
> -		}
> +		if (!(lp & adv & supported))
> +			goto set_inactive;
>  
>  		priv->eee_active = 1;
>  		return true;
>  	}
> -
> +set_inactive:
>  	priv->eee_active = 0;
>  	return false;
>  }
