Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5E2C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228C820685
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228C820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeIYXwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:52:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38658 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeIYXwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:52:12 -0400
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 44F5014229673;
        Tue, 25 Sep 2018 10:43:37 -0700 (PDT)
Date:   Tue, 25 Sep 2018 10:43:36 -0700 (PDT)
Message-Id: <20180925.104336.2276354373880447447.davem@davemloft.net>
To:     salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linyunsheng@huawei.com
Subject: Re: [PATCH net] net: hns: fix for unmapping problem when SMMU is on
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180925092155.11024-1-salil.mehta@huawei.com>
References: <20180925092155.11024-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 25 Sep 2018 10:43:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Tue, 25 Sep 2018 10:21:55 +0100

> From: Yunsheng Lin <linyunsheng@huawei.com>
> 
> If SMMU is on, there is more likely that skb_shinfo(skb)->frags[i]
> can not send by a single BD. when this happen, the
> hns_nic_net_xmit_hw function map the whole data in a frags using
> skb_frag_dma_map, but unmap each BD' data individually when tx is
> done, which causes problem when SMMU is on.
> 
> This patch fixes this problem by ummapping the whole data in a
> frags when tx is done.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Signed-off-by: Peng Li <lipeng321@huawei.com>
> Reviewed-by: Yisen Zhuang <yisen.zhuang@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

Applied, thank you.
