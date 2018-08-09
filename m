Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2AFC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADD221B32
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USh1l1sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADD221B32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeHILIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:08:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40365 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHILIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:08:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so2489128edq.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 01:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EszDCkn6esoN7AmfxJgxJFUmyQsSVpCtJjJ60dIdsgY=;
        b=USh1l1sqrWJrZOFnbmED+3DXNA4rlwomjVr1T+7BurD/sNcvtvQ2mvCN5xeurbDXu6
         KhS9Zabs0WOnSiETwGmdSPU5DGkU00XxBFt/4472dqcIw3qFnkBcVxy7I9HaTtm1WoQ2
         SaYM6Gxk4DlCSIb6woJ4A1QFC5UdGMQObLdXseHcX8HGpemvLfX182ARSg4dMpGnIg+2
         9bH6qwpedidoOvXLOTxWMprMfRVFIdV/JwMhN//cEbgf5oC6EQwptM2JKm/t/iI8lcw0
         RUCBdKmngHBX/cdpKiXe4ocpPI1KkRaf8lVasEslFnDwSG4XjZq/xjA7fPnQIkeu54SH
         BMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EszDCkn6esoN7AmfxJgxJFUmyQsSVpCtJjJ60dIdsgY=;
        b=Voes1ogIDmTvTnRWnBNcrdo6jhxObAvB+c+AkFmBMKohzxX00HCdEF+0xMgalFqsQj
         0a/GKDEpX4mfZ6o3pHRzbN0Ed8FTpeaQLSIygiPSuzbbEpU+hHFWxACoqrDwoW4RJLvS
         XOy6eoS2Pr72sJvsXszLEJWuJdh9r+OiuLtp92NmBOgVMtkVgm8btvaRcq6/EWarh25K
         08kAU+lQX7+AvugBz54DVqIyb+3FD07s/dltPvRRfRZI4+Wl+KFrzCWWhq9+3KHn2Kji
         Vc0mr2EQ18vbQI8p6GRSchdyuNMCaKkB4/MKc8QZJTQIqQOv9AzWDfdiKKyu60xAMTcE
         afhQ==
X-Gm-Message-State: AOUpUlGBPP2BVVAbVtF5wEwpgkOvfULouJDCM8T+ML/XFvywtwm8J2Zf
        KFnaog3npKfFgMalhvH6hvg=
X-Google-Smtp-Source: AA+uWPzg3PxJ2wH2cgohCazpXA7CosdkgOP3z3ErEww/WvGhDFgWTq0MTEbKCKZGSLnTn1zMtoO6FA==
X-Received: by 2002:a50:bc03:: with SMTP id j3-v6mr2131273edh.34.1533804291555;
        Thu, 09 Aug 2018 01:44:51 -0700 (PDT)
Received: from xux707-tw ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id o27-v6sm2220384edc.77.2018.08.09.01.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 01:44:50 -0700 (PDT)
Date:   Thu, 9 Aug 2018 09:44:53 +0100
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 01/15] staging:rtl8192u: Remove macro eqMacAddr - Style
Message-ID: <20180809084452.GA23526@xux707-tw>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
 <20180808210036.22580-2-johnfwhitmore@gmail.com>
 <cb7de144fb0b6796dc5fc6013120fc95c8e564a9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb7de144fb0b6796dc5fc6013120fc95c8e564a9.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 03:14:19PM -0700, Joe Perches wrote:
> On Wed, 2018-08-08 at 22:00 +0100, John Whitmore wrote:
> > The macro eqMacAddr implements the same functionality as the
> > ether_addr_equal function defined in etherdevice.h, as a result the
> > macro has been removed from the code, and its use replaced with the
> > function call.
> []
> > diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> []
> > @@ -4460,15 +4460,15 @@ static void TranslateRxSignalStuff819xUsb(struct sk_buff *skb,
> >  
> >  	/* Check if the received packet is acceptable. */
> >  	bpacket_match_bssid = (type != IEEE80211_FTYPE_CTL) &&
> > -			       (eqMacAddr(priv->ieee80211->current_network.bssid,  (fc & IEEE80211_FCTL_TODS) ? hdr->addr1 : (fc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 : hdr->addr3))
> > +			       (ether_addr_equal(priv->ieee80211->current_network.bssid,  (fc & IEEE80211_FCTL_TODS) ? hdr->addr1 : (fc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 : hdr->addr3))
> >  			       && (!pstats->bHwError) && (!pstats->bCRC) && (!pstats->bICV);
> >  	bpacket_toself =  bpacket_match_bssid &
> > -			  (eqMacAddr(praddr, priv->ieee80211->dev->dev_addr));
> > +			  (ether_addr_equal(praddr, priv->ieee80211->dev->dev_addr));
> 
> Likely this should be
> 
> 	bpacket_match_bssid = bpacket_match_bss &&
> 
> as boolean use with a bitwise & is odd.
> 

Yes have to agree odd. Somebody famous in Computer Science said that
debugging was twice as difficult as writing code, so why would you
write the cleverest code you possibly could, or something like that.
That's what I thought when I now looked at that line of code.

I've been going through this driver cleaning up header files first.
Once those are sorted I was going to turn to the C and try get my
head around the logic. I'll have to look at the functionality of that
bpacket_toself variable but a bitwise operation does look odd.

