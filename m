Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847FCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E39520684
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp2kAyVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfBYXJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:09:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44668 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfBYXJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:09:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id j3so5180454pgm.11;
        Mon, 25 Feb 2019 15:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WBmJDAiGQcXOQxB1YGYwH/LOUJt0VYenTmlXycJJSa4=;
        b=Wp2kAyVX1cFPVBHZ/Xe4LPZvddRa9VavqQ5Xu9LGJMfppQwqm1hXP5Evnr6Ev52e/D
         p5hPlPHVvJJguvot8GWXPEHkn4PtVbU9iWTqJEaHUWTuR/6Q9WNTV0+M2XlwCzupCjfN
         juv7SXhUjbOoJZIQj+5Q2X5MdnMAcHXDVCr9Qhl0sbvJXETS+tcG5zYWhFzLEP4A89zY
         Z+JgMvhNZSC+bkSlrKUHJJr+mnQa4KmjiQiACniOwh5Ppknjb7HCXv1NV4aqMtyevSg4
         zDXxaRaUAGA4Nscc0c07b3uwJRY6F1TZR0Yp0/hgUEeBk+z0HwAMxRhF/zDNACSlA60p
         EGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WBmJDAiGQcXOQxB1YGYwH/LOUJt0VYenTmlXycJJSa4=;
        b=SwizwMBD7TcwADt7eeHucpu01vqM36P34RIRXTdlJ+LbZnj8zbM9BaTFWlpjYbuEsf
         nDlBkOsYFD4JAqTF6znCWTMZXTCDeUkyjQ6SOp7SqyQU07ivtG9mteqjx02iMBfqgbMa
         S42hs1udp6CEI6fIlZ61xtmwz1Gt882zkYSP1pM1WgzbyNGHHvJ5BoiEpChkxHtQJU6Z
         gVij3cmTLgM60wzjhkLHy7W9IvRyH3i7ZE+ttfrwmfjzMzxkE7/OeyZCOtgYaLtOG0eI
         7gmhXhi2Q48CtgRgFbMk/y3uwK0UIQLejncevDRDb2LJgwpuyy/jYEWcDvuIR8CHF1KR
         Fkng==
X-Gm-Message-State: AHQUAuaxR6+jHpJy4sFuiesjRmxY/3MAhc5bgpcfqZGvsLUfwV1nwZ9l
        0PV+OTFDubXdEls70MiSb8icLnR3
X-Google-Smtp-Source: AHgI3IbKzbB6BiI6VKIdCA5eb0XjcvHrLmGJRGw+Qa/qeAB4+SdLSKssa4b5wmeRgpaIbwMZQTINQA==
X-Received: by 2002:a62:4743:: with SMTP id u64mr22288467pfa.95.1551136147926;
        Mon, 25 Feb 2019 15:09:07 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id k18sm96221pfj.92.2019.02.25.15.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 15:09:06 -0800 (PST)
Subject: Re: [PATCH] rtnetlink: Synchronze net in rtnl_unregister()
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        netdev@vger.kernel.org
References: <20190225212721.2908-1-dima@arista.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <eb7bca34-2b6a-1140-b230-71f333b42807@gmail.com>
Date:   Mon, 25 Feb 2019 15:09:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190225212721.2908-1-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/25/2019 01:27 PM, Dmitry Safonov wrote:
> rtnl_unregister() unsets handler from table, which is protected
> by rtnl_lock or RCU. At this moment only dump handlers access the table
> with rcu_lock(). Every other user accesses under rtnl.
> 
> Callers may expect that rtnl_unregister() prevents any further handlers
> calls, alike rtnl_unregister_all(). And they do expect it.
> 
> I've looked on in-tree caller uses:
> br_mdb: safe, but in err-path br_netlink_init()
> fib_rules: safe - err-path is very early in __init
> ip6mr: safe - following unregister_pernet_subsys() calls internally rcu_barrier()
> qrtr: safe - following sock_unregister() calls internally synchronize_rcu()

If rcu_barrier() was needed, then all callers should use it.

If synchronize_rcu() was needed, then all callers should use it.

But mixing is probably wrong.

> 
> While it's possible to document that rtnl_unregister() requires
> synchronize_net() afterwards - unlike rtnl_unregister_all(), I believe
> the module exit is very much slow-path.

rtnl_unregister_all() needs the sychronize_rcu() at this moment
because of the kfree(tab), not because of the kfree_rcu(link, rcu);

> 
> Issue seems to be very theoretical and unlikely, so I'm not Cc'ing
> stable tree.
> 
> Fixes: 6853dd488119 ("rtnetlink: protect handler table with rcu")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Florian Westphal <fw@strlen.de>
> Cc: "Hannes Frederic Sowa" <hannes@stressinduktion.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  net/core/rtnetlink.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 5ea1bed08ede..3db70da4f951 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -308,7 +308,9 @@ int rtnl_unregister(int protocol, int msgtype)
>  	rcu_assign_pointer(tab[msgindex], NULL);
>  	rtnl_unlock();
>  
> -	kfree_rcu(link, rcu);
> +	synchronize_net();
> +
> +	kfree(link);


I really do not see a difference here (other than this being much slower of course)

If the caller needs rcu_barrier(), then add it in the caller ?
