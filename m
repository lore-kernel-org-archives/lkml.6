Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3E9ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EF6208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5EF6208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeGNBkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 21:40:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40006 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbeGNBkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 21:40:20 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D934214500EEA;
        Fri, 13 Jul 2018 18:23:13 -0700 (PDT)
Date:   Fri, 13 Jul 2018 18:23:11 -0700 (PDT)
Message-Id: <20180713.182311.1329076241299839709.davem@davemloft.net>
To:     gregory.clement@bootlin.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, yelena@marvell.com,
        nadavh@marvell.com, mw@semihalf.com, dima@marvell.com,
        antoine.tenart@bootlin.com, miquel.raynal@bootlin.com,
        maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v2 5/7] net: mvneta: Allocate page for the
 descriptor
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180713161841.11202-6-gregory.clement@bootlin.com>
References: <20180713161841.11202-1-gregory.clement@bootlin.com>
        <20180713161841.11202-6-gregory.clement@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 13 Jul 2018 18:23:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Fri, 13 Jul 2018 18:18:39 +0200

> -static int mvneta_rx_refill(struct mvneta_port *pp,
> -			    struct mvneta_rx_desc *rx_desc,
> -			    struct mvneta_rx_queue *rxq)
> -
> +/* Allocate page per descriptor */
> +static inline int mvneta_rx_refill(struct mvneta_port *pp,
> +				   struct mvneta_rx_desc *rx_desc,

Please do not use inline functions in foo.c files, let the compiler
decide.

Thank you.
