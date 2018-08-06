Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CB4C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA3C21471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA3C21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeHFCkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 22:40:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42710 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeHFCkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 22:40:06 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 155CF128F4E9A;
        Sun,  5 Aug 2018 17:33:37 -0700 (PDT)
Date:   Sun, 05 Aug 2018 17:33:36 -0700 (PDT)
Message-Id: <20180805.173336.2098484669514510834.davem@davemloft.net>
To:     zhongjiang@huawei.com
Cc:     stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/bridge/br_multicast: remove redundant variable
 "err"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1533478723-18361-1-git-send-email-zhongjiang@huawei.com>
References: <1533478723-18361-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 05 Aug 2018 17:33:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>
Date: Sun, 5 Aug 2018 22:18:43 +0800

> @@ -1797,7 +1795,7 @@ static int br_multicast_ipv4_rcv(struct net_bridge *br,
>  	struct sk_buff *skb_trimmed = NULL;
>  	const unsigned char *src;
>  	struct igmphdr *ih;
> -	int err;
> +	int err = 0;
>  
>  	err = ip_mc_check_igmp(skb, &skb_trimmed);

The initialization of err to '0' is unnecessary, it gets assigned on
the very next line.
