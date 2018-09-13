Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573CDC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E018720C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="j3yow6JN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E018720C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeIMPhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:37:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37960 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeIMPhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:37:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id h33-v6so4210764edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 03:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FLA+r5NYG0s3eIIhSySu8fuz6fE0lGJg332IqybXSBg=;
        b=j3yow6JN/fIfYyEicb/G76pSYBWmIyZGlpq3k5zSjFb+Ftu9I5ZVqrK4lIvBAoSjrj
         GzzTgFyad9xz03GkqCDJ0C5LqmxbellVCL1IvHBAp1NLSVHVWMXNghgCg3xcHIs3ictQ
         EqlAYHB05OyX2fCzQ0YbJ8i2wTWcRyGqY9GoL1dTPxMDRBirs3qF99IFm48p+tumWoxQ
         EjQdIG+rLfRbKtxvN4o6cWWWqxjUOsxcCO8bix3l/BOpTyTB43w2NN/axOd9E879FP0g
         P8d/FCpgXuSR+iItAy35g0kr0tbvPJu/ePBNo4myywIBjCfGdI1YlASKSSpLGhFLBFX/
         V7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLA+r5NYG0s3eIIhSySu8fuz6fE0lGJg332IqybXSBg=;
        b=Zw+hOBeGFC31PhN3KaurvhdSC5N+g5fI2TzD/RoG+7RrKpAyooC6t9k1Htajtsn1C9
         G87/bWWMxgUjL48hg+iYqAmP46K4VrpdCkECtnePGj0VNgJgoobqaUr2y3f1JUF9XNME
         HC6Qbup+/gGh9/ZN+qgbfjnamaotUv2eP4BHyeMCFmB5R5T2X5EqXmwkyaxM69dZbFev
         4mlmb8yPKE231sM4We339mtiGDiqnCu+ZcpM5X85jiJwoVofd3vvvohUYQ2jdLok7PVd
         qeETXr55yekrkKTh8hQjRUbuATanIPWzunrToXjywFf8ef7WUKj3e9fv/349cQ2WtAVO
         lGxg==
X-Gm-Message-State: APzg51BKKP+APPzRi7ATDPn3gVUbD9dj3dYe2gH73VXfHCcNG5YokStE
        /vVRMJVkWQnW1OhurmPcBud/pQ==
X-Google-Smtp-Source: ANB0VdZiaoC/qiIH3dgpI/luxCe2bQxnCXzUvni0RDdrPCLKbJ+31RU70eEqOvkYrPJgbeLJKRio0w==
X-Received: by 2002:a50:8406:: with SMTP id 6-v6mr9546134edp.97.1536834542375;
        Thu, 13 Sep 2018 03:29:02 -0700 (PDT)
Received: from netronome.com (watermunt.horms.nl. [80.127.179.77])
        by smtp.gmail.com with ESMTPSA id f7-v6sm2774545edd.6.2018.09.13.03.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 03:29:02 -0700 (PDT)
Date:   Thu, 13 Sep 2018 12:28:59 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuznet@ms2.inr.ac.ru,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] net: ipv4: Use BUG_ON directly instead of a if
 condition followed by BUG
Message-ID: <20180913102859.kpeelj3mycjnyvhd@netronome.com>
References: <1536671593-14746-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536671593-14746-1-git-send-email-zhongjiang@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:13:13PM +0800, zhong jiang wrote:
> The if condition can be removed if we use BUG_ON directly.
> The issule is detected with the help of Coccinelle.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  net/ipv4/tcp_input.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 62508a2..526c05e 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4934,8 +4934,8 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
>  			BUG_ON(offset < 0);
>  			if (size > 0) {
>  				size = min(copy, size);
> -				if (skb_copy_bits(skb, offset, skb_put(nskb, size), size))
> -					BUG();
> +				BUG_ON(skb_copy_bits(skb, offset,
> +						     skb_put(nskb, size), size));

Perhaps things have changed but it doesn't seem desirable to me to use
BUG_ON with statements that have side-effects in case at some point BUG_ON
gets compiled out.

>  				TCP_SKB_CB(nskb)->end_seq += size;
>  				copy -= size;
>  				start += size;
> @@ -5327,8 +5327,8 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
>  		/* Is the urgent pointer pointing into this packet? */
>  		if (ptr < skb->len) {
>  			u8 tmp;
> -			if (skb_copy_bits(skb, ptr, &tmp, 1))
> -				BUG();
> +
> +			BUG_ON(skb_copy_bits(skb, ptr, &tmp, 1));
>  			tp->urg_data = TCP_URG_VALID | tmp;
>  			if (!sock_flag(sk, SOCK_DEAD))
>  				sk->sk_data_ready(sk);
> -- 
> 1.7.12.4
> 
