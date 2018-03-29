Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AG47ELupVvBmMI/FUza+n27tbBS6dZ33YYuoER7CuT+4utNvYktY8fSHo420/HMf+2FvYjYU61Ig
ARC-Seal: i=1; a=rsa-sha256; t=1522303349; cv=none;
        d=google.com; s=arc-20160816;
        b=TJl39SBzBptUHhyfczUKr9sCfwSF3IRD6kDtQoaRBY2rp/CyqEoqAWZXhc/kiGgHQ7
         6ErKMBcDLb29wdAdMx12+YATpwBFHOpCmTZ8Gnbsg0V+vwYqbo9Ij5RGwrhHBfYK3yJw
         27IlW4QjE2ibhYzL0HSPc3yW00W80By5SmCJZlnz+N6M5BIPf2gycuqxTGMkEDU5Zh0S
         HmfbK/oGmF5gMRcJ5oo+zkGph+/EZntSATZpl3Pt6rsU5Vr9zx5xCNfuunYqduQDFr5g
         dCtTbW55ztcz/WEW7AcATbx5MLSgq5lj+iIhwNMezcgtNcp6ytvOwvhCuxY6ymaqkQPE
         S8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=s21N/PF+ddOGrNZIxGOTCtQwMSvYZIauHyrB8T65MiI=;
        b=iDo2b+gclCwsa9xoFswNTNakwOtS35ZrZ5sjWyPzvpIvB66sl69XJHGX9w4Og4VwIE
         2pVk5xXZNNZd8tbbUznt6vnDAcRAlDo7GnUZE2SqEf+7mQZo1r9MlrnfzDa6FoSsNKVj
         7lwIazEx1cyyyMhDlzIOFTgtukRlcXaQmun2p19f1mnekxhoCE4mjegPTVnp7fdLoUa/
         HphCmuRgTw+4zZzdTtk1gVwT6RVqsyltQUIktABUKDEM2hLaDMBXFxYC9jbqGB5vMoIU
         mZax8BF6J5+BgpKsQei2CnqdPwPt5VImOlG4mPBPTU4Ns4hqJ+rS4ipVzbsFSS50QstF
         Itcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.94 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.94 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:4250:4321:5007:6119:7903:10004:10400:10848:11026:11232:11658:11914:12043:12296:12438:12740:12760:12895:13069:13255:13311:13357:13439:14659:14721:21080:21627:30003:30012:30054:30079:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: mind91_3299389433401
X-Filterd-Recvd-Size: 2111
Message-ID: <1522303346.2210.19.camel@perches.com>
Subject: Re: [PATCH 1/9] staging: ks7010: Replace manual array copy with
 ether_addr_copy().
From: Joe Perches <joe@perches.com>
To: Quytelda Kahja <quytelda@tamalin.org>, gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Date: Wed, 28 Mar 2018 23:02:26 -0700
In-Reply-To: <20180329055152.13059-1-quytelda@tamalin.org>
References: <20180329055152.13059-1-quytelda@tamalin.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596250102144779067?=
X-GMAIL-MSGID: =?utf-8?q?1596250757182562070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-03-28 at 22:51 -0700, Quytelda Kahja wrote:
> Copying the dummy HW address into the struct net_device doesn't need
> to be done byte by byte; use ether_addr_copy() instead.
> Additionally, dev->dev_addr is not eight bytes long.
> ether_setup() sets the dev->addr_len to ETH_ALEN (defined as 6)
> in the net core code.
[]
> diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
[]
> @@ -2900,15 +2900,7 @@ int ks_wlan_net_start(struct net_device *dev)
>  	timer_setup(&update_phyinfo_timer, ks_wlan_update_phyinfo_timeout, 0);
>  
>  	/* dummy address set */
> -	memcpy(priv->eth_addr, dummy_addr, ETH_ALEN);

why remove the copy of dummy_addr into priv->eth_addr ?

Also, dummy_addr could be removed and eth_zero_addr()
used instead.

> -	dev->dev_addr[0] = priv->eth_addr[0];
> -	dev->dev_addr[1] = priv->eth_addr[1];
> -	dev->dev_addr[2] = priv->eth_addr[2];
> -	dev->dev_addr[3] = priv->eth_addr[3];
> -	dev->dev_addr[4] = priv->eth_addr[4];
> -	dev->dev_addr[5] = priv->eth_addr[5];
> -	dev->dev_addr[6] = 0x00;
> -	dev->dev_addr[7] = 0x00;
> +	ether_addr_copy(dev->dev_addr, priv->eth_addr);

Perhaps

	eth_zero_addr(priv->eth_addr);
	eth_zero_addr(dev->dev_addr);
