Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3162FC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D083320857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D083320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeG0Fjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 01:39:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52044 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeG0Fjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 01:39:52 -0400
Received: from localhost (unknown [172.58.35.173])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C6347108C58AE;
        Thu, 26 Jul 2018 21:19:55 -0700 (PDT)
Date:   Thu, 26 Jul 2018 21:19:52 -0700 (PDT)
Message-Id: <20180726.211952.1172623601033757802.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linyunsheng@huawei.com, matthias.bgg@gmail.com,
        lipeng321@huawei.com
Subject: Re: [PATCH net-next] net: hns: make hns_dsaf_roce_reset non static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180727015312.19256-1-yuehaibing@huawei.com>
References: <20180727015312.19256-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 26 Jul 2018 21:19:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 27 Jul 2018 09:53:12 +0800

> hns_dsaf_roce_reset is exported and used in hns_roce_hw_v1.c
> In commit 336a443bd9dd ("net: hns: Make many functions static") I make
> it static wrongly.
> 
> drivers/infiniband/hw/hns/hns_roce_hw_v1.o: In function `hns_roce_v1_reset':
> hns_roce_hw_v1.c:(.text+0x37ac): undefined reference to `hns_dsaf_roce_reset'
> hns_roce_hw_v1.c:(.text+0x37cc): undefined reference to `hns_dsaf_roce_reset'
> 
> Fixes: 336a443bd9dd ("net: hns: Make many functions static")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Oops, applied.
