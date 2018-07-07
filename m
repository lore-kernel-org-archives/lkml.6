Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAA9C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC4D21EF8
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC4D21EF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbeGGCJH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:09:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40948 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932164AbeGGCJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:09:06 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 23FD414621324;
        Fri,  6 Jul 2018 19:09:01 -0700 (PDT)
Date:   Sat, 07 Jul 2018 11:09:00 +0900 (KST)
Message-Id: <20180707.110900.1021780626656230934.davem@davemloft.net>
To:     gregory.clement@bootlin.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, yelena@marvell.com,
        nadavh@marvell.com, mw@semihalf.com, dima@marvell.com,
        antoine.tenart@bootlin.com, miquel.raynal@bootlin.com,
        maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next 3/6] net: mvneta: discriminate error cause for
 missed packet
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180706131949.2684-4-gregory.clement@bootlin.com>
References: <20180706131949.2684-1-gregory.clement@bootlin.com>
        <20180706131949.2684-4-gregory.clement@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 06 Jul 2018 19:09:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Fri,  6 Jul 2018 15:19:46 +0200

> @@ -609,6 +606,10 @@ struct mvneta_rx_queue {
>  
>  	/* Index of the next RX DMA descriptor to process */
>  	int next_desc_to_proc;
> +
> +	/* error counters */
> +	u32 skb_alloc_err;
> +	u32 refill_err;
>  };

These counters aren't exported anywhere, making them not so useful.

Either remove this stuff or add them to the driver's ethtool state.

Thank you.
