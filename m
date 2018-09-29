Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B5EC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4485A206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4485A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeI3BHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 21:07:33 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56974 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeI3BHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 21:07:33 -0400
Received: from localhost (unknown [IPv6:2603:3023:50c:85e1:b5c5:ae11:3e54:6a07])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D1B391476CF8D;
        Sat, 29 Sep 2018 11:38:03 -0700 (PDT)
Date:   Sat, 29 Sep 2018 11:38:02 -0700 (PDT)
Message-Id: <20180929.113802.1016843680571572182.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     dmitry.tarnyagin@lockless.no, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: caif: fix return type of ndo_start_xmit
 function
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180926092705.28880-1-yuehaibing@huawei.com>
References: <20180926092705.28880-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 29 Sep 2018 11:38:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 26 Sep 2018 17:27:05 +0800

> @@ -1014,7 +1014,7 @@ static int cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
>  	int prio;
>  
>  	if (!dev)
> -		return -EINVAL;
> +		return NETDEV_TX_BUSY;
>  
>  	cfhsi = netdev_priv(dev);
>  

Even though the return type of ndo_start_xmit is netdev_tx_t, negative error codes are
still allowed I believe.

Look, reviewing these are pretty stressful for me, because you aren't documenting your
changes and in many cases the transformations look incorrect.

I'm tossing the rest of your changes in this area for now, sorry.

Please double check your work and resubmit this at some time in the not-too-near
future.

Thank you.
