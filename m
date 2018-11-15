Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647FAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3736D208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3736D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbeKPEFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:05:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43182 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeKPEFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:05:13 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7E8C714779F59;
        Thu, 15 Nov 2018 09:56:24 -0800 (PST)
Date:   Thu, 15 Nov 2018 09:56:22 -0800 (PST)
Message-Id: <20181115.095622.889070618474069350.davem@davemloft.net>
To:     xuechaojing@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        wulike1@huawei.com, chiqijun@huawei.com, fy.wang@huawei.com,
        tony.qu@huawei.com, luoshaokai@huawei.com
Subject: Re: [PATCH 1/1] net-next/hinic:fix three problems in HiNIC Driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181115052327.2859-1-xuechaojing@huawei.com>
References: <20181115052327.2859-1-xuechaojing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 15 Nov 2018 09:56:24 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xue Chaojing <xuechaojing@huawei.com>
Date: Thu, 15 Nov 2018 05:23:27 +0000

> This patch fixes these problems:
> 1. In order to improve performance, this patch add rx checksum offload
> for the HiNIC driver. Performance test(Iperf) shows more than 95%
> improvement in TCP streams.
> 2. In add_mac_addr(), if the MAC address is a muliticast address, it
> will not be set, which causes the network card fail to receive the
> multicast packet. This patch fixes this bug.
> 3. In rx_alloc_pkts(), there is a loop call of tasklet, which causes
> 100% cpu utilization, even no packets are being received. This patch
> fixes this bug.
> 
> Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>

Each patch should do one thing.

Please don't combine multiple changes into one patch like this.

Post a proper patches series, one change per patch, with a proper
"[PATCH 0/N] " header posting preceeding the series.

Thanks.
