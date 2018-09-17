Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB0FECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37EC214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMe9yjbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37EC214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeIQUFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:05:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43654 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeIQUFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:05:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so7757608pgb.10;
        Mon, 17 Sep 2018 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r13M3UmqOcHbEC8GaTabIZog1gCJnGnjbKlt4PbmxHA=;
        b=HMe9yjbw86Hk/yqDLxlvl9MYZIfztVuXjlh+Ht6+ScfvBhWfXaCJ+JWl164QPWon4j
         HaDWzf+cXtCAhemIzODKuWyMOU5twT3kC5++l9o2Ga5ZSqpRMY8nrlUGAtxE26ARpoo5
         Nsu94eZKn+9ZYSzVwt1LXJmgcJ6TaYFDLPB1iuWNXZR6X7nq7s9fYDnkSKK9tLHeRDun
         UPJ1V7Gj+iIeLOADtdcDzxQFVfGPCXRM9Cxn84N9No0tIVVV2jbxa+a/Kfl6GJesY5+j
         /mDeEvkVL55m8J9uaSV97GCJ93VAn3osSOAJpfsiitwsiPT5gNXe2MuDN4Fd21lfblXo
         BI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r13M3UmqOcHbEC8GaTabIZog1gCJnGnjbKlt4PbmxHA=;
        b=EzRQ7IoniYjboN63OybSBVKmA4TPCF+p/iwPep5+TtcIgYAbi0v27T4hgU47ikvePG
         D6ScsLbrbSDRzYetg3CTm9Yx5dqojK0iSbcIlfO8v7g6LQy2/KBWZ8AUs9SJRFbV3iXe
         wWA9r1kuMuZs4i8+BTIzlQEsCRaYk2Zwr+DVhIjpcPJHyK5E+pe1vHYFlcDKH8OnWR9R
         xskkrLXeOTUmX0yXFguRugBJSdWEpEZOmUt4DH0tCFd5gRpirNBid6sva3QET9sbohR7
         klQ5Fwhrbjhr5cQagb/r6t9UHf+bQPUXD/oBkWxDqbTH+ozLrtvLCrYi5xJ7QPYSxnEH
         fVJA==
X-Gm-Message-State: APzg51Bb5dSDVpV6tN9DeuDwVly/BiHrjsP8RaLsANKZtuQf4QGCYscP
        ZQJFV/BRSBgZDQhtXl+E3HZ5PixA
X-Google-Smtp-Source: ANB0VdYlAU6gp1hOoBYcQGTPuiWWbE6bFYnEQ3oQgE/l/r4IEJ9y0KdS/FMD70/szb8FxC5PjEw+rA==
X-Received: by 2002:a63:b95e:: with SMTP id v30-v6mr23506372pgo.221.1537195083864;
        Mon, 17 Sep 2018 07:38:03 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id h20-v6sm17470216pgg.3.2018.09.17.07.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 07:38:03 -0700 (PDT)
Subject: Re: [PATCH] bonding: avoid repeated display of same link status
 change
To:     mk.singh@oracle.com, netdev@vger.kernel.org
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <20180917072059.32657-1-mk.singh@oracle.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <33a66a80-22ed-d6b3-f6b2-4463357c5ffa@gmail.com>
Date:   Mon, 17 Sep 2018 07:38:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180917072059.32657-1-mk.singh@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/17/2018 12:20 AM, mk.singh@oracle.com wrote:
> From: Manish Kumar Singh <mk.singh@oracle.com>
> 
> When link status change needs to be committed and rtnl lock couldn't be
> taken, avoid redisplay of same link status change message.
> 
> Signed-off-by: Manish Kumar Singh <mk.singh@oracle.com>
> ---
>  drivers/net/bonding/bond_main.c | 6 ++++--
>  include/net/bonding.h           | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 217b790d22ed..fb4e3aff1677 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2087,7 +2087,7 @@ static int bond_miimon_inspect(struct bonding *bond)
>  			bond_propose_link_state(slave, BOND_LINK_FAIL);
>  			commit++;
>  			slave->delay = bond->params.downdelay;
> -			if (slave->delay) {
> +			if (slave->delay && !bond->rtnl_needed) {
>  				netdev_info(bond->dev, "link status down for %sinterface %s, disabling it in %d ms\n",
>  					    (BOND_MODE(bond) ==
>  					     BOND_MODE_ACTIVEBACKUP) ?
> @@ -2127,7 +2127,7 @@ static int bond_miimon_inspect(struct bonding *bond)
>  			commit++;
>  			slave->delay = bond->params.updelay;
>  
> -			if (slave->delay) {
> +			if (slave->delay && !bond->rtnl_needed) {
>  				netdev_info(bond->dev, "link status up for interface %s, enabling it in %d ms\n",
>  					    slave->dev->name,
>  					    ignore_updelay ? 0 :
> @@ -2301,9 +2301,11 @@ static void bond_mii_monitor(struct work_struct *work)
>  		if (!rtnl_trylock()) {
>  			delay = 1;
>  			should_notify_peers = false;
> +			bond->rtnl_needed = true;

How can you set a shared variable with no synchronization ?

A bool is particularly dangerous here, at least on some arches.

>  			goto re_arm;
>  		}
>  
> +		bond->rtnl_needed = false;
>  		bond_for_each_slave(bond, slave, iter) {
>  			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
>  		}
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 808f1d167349..50d61cf77855 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -234,6 +234,7 @@ struct bonding {
>  	struct	 dentry *debug_dir;
>  #endif /* CONFIG_DEBUG_FS */
>  	struct rtnl_link_stats64 bond_stats;
> +	bool rtnl_needed;
>  };
>  
>  #define bond_slave_get_rcu(dev) \
> 
