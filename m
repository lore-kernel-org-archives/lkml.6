Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508B7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0595D2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0595D2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbeKTM7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:59:10 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56906 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeKTM7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:59:10 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3B1BD14D70696;
        Mon, 19 Nov 2018 18:32:25 -0800 (PST)
Date:   Mon, 19 Nov 2018 18:32:24 -0800 (PST)
Message-Id: <20181119.183224.87651627805917399.davem@davemloft.net>
To:     tanxiaojun@huawei.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        lipeng321@huawei.com, linyunsheng@huawei.com,
        shenjian15@huawei.com, tanhuazhong@huawei.com,
        liangfuyun1@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: hns3: add common validation in hclge_dcb
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1542632535-18210-1-git-send-email-tanxiaojun@huawei.com>
References: <1542632535-18210-1-git-send-email-tanxiaojun@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 19 Nov 2018 18:32:25 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tan Xiaojun <tanxiaojun@huawei.com>
Date: Mon, 19 Nov 2018 21:02:15 +0800

> From: Yunsheng Lin <linyunsheng@huawei.com>
> 
> Before setting tm related configuration to hardware, driver
> needs to check the configuration provided by user is valid.
> Currently hclge_ieee_setets and hclge_setup_tc both implement
> their own checking, which has a lot in common.
> 
> This patch addes hclge_dcb_common_validate to do the common
> checking. The checking in hclge_tm_prio_tc_info_update
> and hclge_tm_schd_info_update is unnecessary now, so change
> the return type to void, which removes the need to do error
> handling when one of the checking fails.
> 
> Also, ets->prio_tc is indexed by user prio and ets->tc_tsa is
> indexed by tc num, so this patch changes them to use different
> index.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>

Looks good, applied, thanks!
