Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC36DC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFBF21A32
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFBF21A32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeHHTHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:07:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39542 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeHHTHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:07:33 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 59875140B6C41;
        Wed,  8 Aug 2018 09:47:02 -0700 (PDT)
Date:   Wed, 08 Aug 2018 09:46:59 -0700 (PDT)
Message-Id: <20180808.094659.1009423470300519644.davem@davemloft.net>
To:     zhaochen6@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        tony.qu@huawei.com, yin.yinshi@huawei.com, luoshaokai@huawei.com,
        fy.wang@huawei.com, luoxianjun@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH 1/1] net-next: hinic: fix a problem in free_tx_poll()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180808063730.12198-1-zhaochen6@huawei.com>
References: <20180808063730.12198-1-zhaochen6@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 Aug 2018 09:47:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Chen <zhaochen6@huawei.com>
Date: Wed, 8 Aug 2018 06:37:30 +0000

> This patch fixes the problem below. The problem can be reproduced by the
> following steps:
> 1) Connecting all HiNIC interfaces
> 2) On server side
>     # sudo ifconfig eth0 192.168.100.1 up #Using MLX CX4 card
>     # iperf -s
> 3) On client side
>     # sudo ifconfig eth0 192.168.100.2 up #Using our HiNIC card
>     # iperf -c 192.168.101.1 -P 10 -t 100000
> 
> after hours of testing, we will see errors:
 ...
> Signed-off-by: Zhao Chen <zhaochen6@huawei.com>

Applied, thank you.
