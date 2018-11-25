Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1008DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4A72087E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4A72087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeKYM1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 07:27:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59530 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeKYM1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 07:27:32 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A177714ECF114;
        Sat, 24 Nov 2018 17:37:41 -0800 (PST)
Date:   Sat, 24 Nov 2018 17:37:40 -0800 (PST)
Message-Id: <20181124.173740.1123522176489874677.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     ganeshgr@chelsio.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] cxgb4: remove set but not used variables
 'multitrc, speed'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181124103621.24280-1-yuehaibing@huawei.com>
References: <20181124103621.24280-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 24 Nov 2018 17:37:41 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 24 Nov 2018 18:36:21 +0800

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:5883:6:
>  warning: variable 'multitrc' set but not used [-Wunused-but-set-variable]
> 
> drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:8585:32:
>  warning: variable 'speed' set but not used [-Wunused-but-set-variable]
> 
> 'multitrc' never used since introduction in
> commit 8e3d04fd7d70 ("cxgb4: Add MPS tracing support")
> 
> 'speed' never used since introduction in
> commit c3168cabe1af ("cxgb4/cxgbvf: Handle 32-bit fw port capabilities")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
