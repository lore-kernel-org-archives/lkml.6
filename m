Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F908C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A792089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A792089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJQBBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:01:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53572 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbeJQBBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:01:35 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A352C12DE5805;
        Tue, 16 Oct 2018 10:10:12 -0700 (PDT)
Date:   Tue, 16 Oct 2018 10:10:11 -0700 (PDT)
Message-Id: <20181016.101011.368948030874381665.davem@davemloft.net>
To:     linyunsheng@huawei.com
Cc:     huangdaode@hisilicon.com, xuwei5@hisilicon.com,
        liguozhu@hisilicon.com, Yisen.Zhuang@huawei.com,
        john.garry@huawei.com, linuxarm@huawei.com, salil.mehta@huawei.com,
        lipeng321@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] Some cleanup and bugfix for desc filling
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1539691132-158455-1-git-send-email-linyunsheng@huawei.com>
References: <1539691132-158455-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 16 Oct 2018 10:10:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Tue, 16 Oct 2018 19:58:47 +0800

> When retransmiting packets, skb_cow_head which is called in
> hns3_set_tso may clone a new header. And driver will clear the
> checksum of the header after doing DMA map, so HW will read the
> old header whose L3 checksum is not cleared and calculate a
> wrong L3 checksum.
> 
> Also When sending a big fragment using multiple buffer descriptor,
> hns3 does one maping, but do multiple unmapping when tx is done,
> which may cause unmapping problem.
> 
> This patchset does some cleanup before fixing the above problem.

Series applied.
