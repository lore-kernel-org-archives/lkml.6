Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D6FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19D72070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfBVXfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:35:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59892 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVXfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:35:12 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A420C14AD9210;
        Fri, 22 Feb 2019 15:35:11 -0800 (PST)
Date:   Fri, 22 Feb 2019 15:35:10 -0800 (PST)
Message-Id: <20190222.153510.173474295420771682.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] mdio_bus: Fix use-after-free on device_register fails
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190221144201.11488-1-yuehaibing@huawei.com>
References: <20190221144201.11488-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Feb 2019 15:35:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Thu, 21 Feb 2019 22:42:01 +0800

> From: YueHaibing <yuehaibing@huawei.com>
> 
> KASAN has found use-after-free in fixed_mdio_bus_init,
> commit 0c692d07842a ("drivers/net/phy/mdio_bus.c: call
> put_device on device_register() failure") call put_device()
> while device_register() fails,give up the last reference
> to the device and allow mdiobus_release to be executed
> ,kfreeing the bus. However in most drives, mdiobus_free
> be called to free the bus while mdiobus_register fails.
> use-after-free occurs when access bus again, this patch
> revert it to let mdiobus_free free the bus.
> 
> KASAN report details as below:
 ...
> Fixes: 0c692d07842a ("drivers/net/phy/mdio_bus.c: call put_device on device_register() failure")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied and queued up for -stable, thanks.
