Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7587FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 20:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4885D21019
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 20:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfAAUOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 15:14:35 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59320 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAAUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 15:14:35 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 41B2D14BF078B;
        Tue,  1 Jan 2019 12:14:34 -0800 (PST)
Date:   Tue, 01 Jan 2019 12:14:33 -0800 (PST)
Message-Id: <20190101.121433.555886101356875696.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, mehta.salil@opnsrc.net
Subject: Re: [PATCH net] net: hns3: call hns3_nic_net_open() while doing
 HNAE3_UP_CLIENT
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1546225109-19631-1-git-send-email-tanhuazhong@huawei.com>
References: <1546225109-19631-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 01 Jan 2019 12:14:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Mon, 31 Dec 2018 10:58:29 +0800

> For HNAE3_DOWN_CLIENT calling hns3_nic_net_stop(), HNAE3_UP_CLIENT
> should call hns3_nic_net_open(), since if the number of queue or
> the map of TC has is changed before HHAE3_UP_CLIENT is called,
> it will cause problem.
> 
> Also the HNS3_NIC_STATE_RESETTING flag needs to be cleared before
> hns3_nic_net_open() called, and set it back while hns3_nic_net_open()
> failed.
> 
> Fixes: bb6b94a896d4 ("net: hns3: Add reset interface implementation in client")
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Signed-off-by: Peng Li <lipeng321@huawei.com>

Applied and queued up for -stable.
