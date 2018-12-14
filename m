Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FB2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6D4208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbeLNVUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:20:46 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33822 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbeLNVUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:20:45 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4BFAE14E088C5;
        Fri, 14 Dec 2018 13:20:45 -0800 (PST)
Date:   Fri, 14 Dec 2018 13:20:44 -0800 (PST)
Message-Id: <20181214.132044.183096780468259380.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        lipeng321@huawei.com, tanhuazhong@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hns3: prevent building without CONFIG_INET
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181210204448.2338398-1-arnd@arndb.de>
References: <20181210204448.2338398-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Dec 2018 13:20:45 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Dec 2018 21:44:34 +0100

> We now get a link failure when CONFIG_INET is disabled, since
> tcp_gro_complete is unavailable:
> 
> drivers/net/ethernet/hisilicon/hns3/hns3_enet.o: In function `hns3_set_gro_param':
> hns3_enet.c:(.text+0x230c): undefined reference to `tcp_gro_complete'
> 
> Add an explicit CONFIG_INET dependency here to avoid the broken
> configuration.
> 
> Fixes: a6d53b97a2e7 ("net: hns3: Adds GRO params to SKB for the stack")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
