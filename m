Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D5BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BEA20837
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BEA20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeKHFSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:18:49 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43252 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeKHFSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:18:48 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BF5CE1454D5BB;
        Wed,  7 Nov 2018 11:46:59 -0800 (PST)
Date:   Wed, 07 Nov 2018 11:46:59 -0800 (PST)
Message-Id: <20181107.114659.1188865327587221643.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        shiju.jose@huawei.com, colin.king@canonical.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: hns3: Remove set but not used variable
 'reset_level'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1541558033-100068-1-git-send-email-yuehaibing@huawei.com>
References: <1541558033-100068-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 07 Nov 2018 11:47:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 7 Nov 2018 02:33:53 +0000

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c: In function 'hclge_log_and_clear_ppp_error':
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c:821:24: warning:
>  variable 'reset_level' set but not used [-Wunused-but-set-variable]
>   enum hnae3_reset_type reset_level = HNAE3_NONE_RESET;
> 
> It never used since introduction in commit
> 01865a50d78f ("net: hns3: Add enable and process hw errors of TM scheduler")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
