Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDCEC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37AA20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37AA20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754235AbeFSWwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:52:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49262 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754138AbeFSWwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:52:05 -0400
Received: from localhost (unknown [61.102.160.116])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 990AA1438F5CF;
        Tue, 19 Jun 2018 15:52:03 -0700 (PDT)
Date:   Wed, 20 Jun 2018 07:52:02 +0900 (KST)
Message-Id: <20180620.075202.1458380285687445735.davem@davemloft.net>
To:     stefan@agner.ch
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: hamradio: use eth_broadcast_addr
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180617214058.6926-1-stefan@agner.ch>
References: <20180617214058.6926-1-stefan@agner.ch>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Jun 2018 15:52:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>
Date: Sun, 17 Jun 2018 23:40:53 +0200

> The array bpq_eth_addr is only used to get the size of an
> address, whereas the bcast_addr is used to set the broadcast
> address. This leads to a warning when using clang:
> drivers/net/hamradio/bpqether.c:94:13: warning: variable 'bpq_eth_addr' is not
>       needed and will not be emitted [-Wunneeded-internal-declaration]
> static char bpq_eth_addr[6];
>             ^
> 
> Remove both variables and use the common eth_broadcast_addr
> to set the broadcast address.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied.
