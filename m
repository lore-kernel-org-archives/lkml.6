Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3456EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D8621736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfBSAgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:36:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56650 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfBSAgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:36:12 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 43D39108DE82F;
        Mon, 18 Feb 2019 16:36:11 -0800 (PST)
Date:   Mon, 18 Feb 2019 16:36:10 -0800 (PST)
Message-Id: <20190218.163610.648449069622071841.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] mdio_bus: Fix PTR_ERR() usage after
 initialization to constant
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190216025935.22888-1-yuehaibing@huawei.com>
References: <20190216025935.22888-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Feb 2019 16:36:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 16 Feb 2019 10:59:35 +0800

> Fix coccinelle warning:
> 
> ./drivers/net/phy/mdio_bus.c:51:5-12: ERROR: PTR_ERR applied after initialization to constant on line 44
> ./drivers/net/phy/mdio_bus.c:52:5-12: ERROR: PTR_ERR applied after initialization to constant on line 44
> 
> fix this by using IS_ERR before PTR_ERR
> 
> Fixes: bafbdd527d56 ("phylib: Add device reset GPIO support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: remove variable 'ret'

Applied.
