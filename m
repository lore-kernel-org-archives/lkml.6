Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D668FC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA1620685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA1620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeKUE7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:59:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44698 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeKUE7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:59:14 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 36B9D148BD7E3;
        Tue, 20 Nov 2018 10:28:44 -0800 (PST)
Date:   Tue, 20 Nov 2018 10:28:43 -0800 (PST)
Message-Id: <20181120.102843.2033247081781930217.davem@davemloft.net>
To:     vincentc@andestech.com
Cc:     gregkh@linuxfoundation.org, rdunlap@infradead.org,
        yuehaibing@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: faraday: ftmac100: remove netif_running(netdev)
 check before disabling interrupts
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1542692266-17720-1-git-send-email-vincentc@andestech.com>
References: <1542692266-17720-1-git-send-email-vincentc@andestech.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 20 Nov 2018 10:28:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aFrom: Vincent Chen <vincentc@andestech.com>
Date: Tue, 20 Nov 2018 13:37:46 +0800

> +	/* Disable interrupts for polling */
> +	ftmac100_disable_all_int(priv);
>  	if (likely(netif_running(netdev))) {
> -		/* Disable interrupts for polling */
> -		ftmac100_disable_all_int(priv);
>  		napi_schedule(&priv->napi);
>  	}

This is now a single-line basic block, so please remove the curly
braces.

Thank you.
