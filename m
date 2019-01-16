Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E612C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDDF20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Yp39e4pF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404694AbfAPOnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:43:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37653 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfAPOnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:43:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so7222382wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 06:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zramX682su8aqcQBBzfMpz8/YfoItosHzRkFNq+n1E4=;
        b=Yp39e4pFi0HU+VrwohXd292nuf7Jp5ajxPJWl6iPcspwPmUFI+B3bWjU1djKSitclG
         BvZ5K4jT6r2gV8FuWDnCorty5/U4N/OPVP8Pj8jdXRdCzcKQOLWmsxjIEwau6ZVPYHEc
         gS13V8d0n+RtZrv06NYnrsW6HjFF/QNMIsFqFm1cEhuBYCqcy25Om1L3Qr0VEuTMQBOh
         6EQJUj8Pvk03IWPW4q455uSEDj5GMHVYBdpQfyDlFkiXWKvWCpdcKPkmLDTSOfnb7v7o
         9aij3AVbD43f8Gm16ItZicVBfSxCNeHKfV8D5RFnEFxZqgXxqpnzFq3Eb5lQzjWwZfru
         oF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zramX682su8aqcQBBzfMpz8/YfoItosHzRkFNq+n1E4=;
        b=ogFJUh2uFn7+zV6mCqmaYetA9YBQeaNeeQ7Lyo6FewtKm+tiMu5NP2/5hN8D6Hi2yz
         YrjV5kZDwevTfziWnBb0KtDQeXC3CIgHPTMlLe58rwBAssqb28T+kvP9ZSm2r4lic+Fw
         7bg3pkJDzT2cIAW3QLYP7c7Kn7H3FISKMe9o2PXUtl63ROzoBifcRAf0MVOwpnYOKZqS
         3y6EhmW+faWjG3WSZtxcbN0Cq0AXBpUen2nDMJSKKgK24pzlTpdjL9DNIS0NujKlLtMI
         4mJaiAhXOivxVDY5QohIkcqRPjJE61TwvhZCX2UAaWXhfZyfUkENg/jpBBlnpdeBdmzX
         Z3aQ==
X-Gm-Message-State: AJcUukeuYPRYF/NyN0CH6r7olCOAlAuf3lCyHSXQY3FJqV4O4AQfwPU4
        bCbSftCqGGjHeG7IIRYTkiD5GA==
X-Google-Smtp-Source: ALg8bN6fQ7Gz0nFH7kZnFh9N6YBvVz2RVedj/AWwHZcbMvEJkFek5AeGWCvQ7mZr1fjmYBZYHdruhQ==
X-Received: by 2002:adf:c846:: with SMTP id e6mr7563883wrh.243.1547649782649;
        Wed, 16 Jan 2019 06:43:02 -0800 (PST)
Received: from localhost (ip-89-177-6-176.net.upcbroadband.cz. [89.177.6.176])
        by smtp.gmail.com with ESMTPSA id c12sm75469331wrs.82.2019.01.16.06.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 06:43:02 -0800 (PST)
Date:   Wed, 16 Jan 2019 15:34:31 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org, linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] net; lorawan: Fix net device leakage
Message-ID: <20190116143431.GG5265@nanopsycho>
References: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
 <20190116142458.19542-3-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116142458.19542-3-starnight@g.ncu.edu.tw>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jan 16, 2019 at 03:24:58PM CET, starnight@g.ncu.edu.tw wrote:
>The net device may be missed to be put after error check.  This patch
>fixes the issue to prevent the leakage.
>
>Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
>---
> net/lorawan/socket.c | 12 ++++--------
> 1 file changed, 4 insertions(+), 8 deletions(-)
>
>diff --git a/net/lorawan/socket.c b/net/lorawan/socket.c
>index 9c0722379e25..7139fab63159 100644
>--- a/net/lorawan/socket.c
>+++ b/net/lorawan/socket.c
>@@ -51,8 +51,10 @@ lrw_get_dev_by_addr(struct net *net, u32 devaddr)
> 
> 	rcu_read_lock();
> 	ndev = dev_getbyhwaddr_rcu(net, ARPHRD_LORAWAN, (char *)&be_addr);
>-	if (ndev)
>+	if (ndev && ndev->type == ARPHRD_LORAWAN)
> 		dev_hold(ndev);
>+	else
>+		ndev = NULL;
> 	rcu_read_unlock();
> 
> 	return ndev;
>@@ -99,11 +101,6 @@ dgram_bind(struct sock *sk, struct sockaddr *uaddr, int len)
> 	}
> 	netdev_dbg(ndev, "%s: get ndev\n", __func__);
> 
>-	if (ndev->type != ARPHRD_LORAWAN) {
>-		ret = -ENODEV;
>-		goto dgram_bind_end;
>-	}
>-
> 	ro->src_devaddr = addr->addr_in.devaddr;
> 	ro->bound = 1;
> 	ret = 0;
>@@ -152,7 +149,7 @@ dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
> 	if (size > ndev->mtu) {
> 		netdev_dbg(ndev, "size = %zu, mtu = %u\n", size, ndev->mtu);
> 		ret = -EMSGSIZE;
>-		goto dgram_sendmsg_end;
>+		goto dgram_sendmsg_no_skb;
> 	}
> 
> 	netdev_dbg(ndev, "%s: create skb\n", __func__);
>@@ -189,7 +186,6 @@ dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
> 	kfree_skb(skb);
> dgram_sendmsg_no_skb:
> 	dev_put(ndev);
>-

Please avoid hunks like this one.


> dgram_sendmsg_end:
> 	return ret;
> }
>-- 
>2.20.1
>
>
>_______________________________________________
>linux-lpwan mailing list
>linux-lpwan@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-lpwan
