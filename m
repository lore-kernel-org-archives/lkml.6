Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12420ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A7720673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A7720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeGTHPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:15:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42104 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeGTHPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:15:05 -0400
Received: from localhost (unknown [172.58.43.55])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6A07114812059;
        Thu, 19 Jul 2018 23:28:25 -0700 (PDT)
Date:   Thu, 19 Jul 2018 23:28:24 -0700 (PDT)
Message-Id: <20180719.232824.2267856623115325271.davem@davemloft.net>
To:     zhaochen6@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        aviad.krawczyk@huawei.com, tony.qu@huawei.com,
        yin.yinshi@huawei.com, luoshaokai@huawei.com
Subject: Re: [PATCH 1/1] net-next/hinic: fix a problem in hinic_xmit_frame()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180718043318.3211-1-zhaochen6@huawei.com>
References: <20180718043318.3211-1-zhaochen6@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 19 Jul 2018 23:28:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Chen <zhaochen6@huawei.com>
Date: Wed, 18 Jul 2018 00:33:18 -0400

> The calculation of "wqe_size" is not correct when the tx queue is busy in
> hinic_xmit_frame().
> 
> When there are no free WQEs, the tx flow will unmap the skb buffer, then
> ring the doobell for the pending packets. But the "wqe_size" which used
> to calculate the doorbell address is not correct. The wqe size should be
> cleared to 0, otherwise, it will cause a doorbell error.
> 
> This patch fixes the problem.
> 
> Reported-by: Zhou Wang <wangzhou1@hisilicon.com>
> Signed-off-by: Zhao Chen <zhaochen6@huawei.com>

Applied and queued up for -stable.
