Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BFEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2693A20665
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2693A20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbeK2GNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:13:01 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36620 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbeK2GNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:13:01 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0373B14E0F727;
        Wed, 28 Nov 2018 11:10:20 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:10:20 -0800 (PST)
Message-Id: <20181128.111020.1484129828213212510.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     Shahed.Shaikh@cavium.com, manish.chopra@cavium.com,
        Dept-GELinuxNICDev@cavium.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] qlcnic: remove set but not used variables
 'cur_rings, max_hw_rings, tx_desc_info'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181128122939.28132-1-yuehaibing@huawei.com>
References: <20181128122939.28132-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 28 Nov 2018 11:10:21 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 28 Nov 2018 20:29:39 +0800

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:4011:5:
>  warning: variable 'max_hw_rings' set but not used [-Wunused-but-set-variable]
> drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:4013:6:
>  warning: variable 'cur_rings' set but not used [-Wunused-but-set-variable]
> drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:2996:25:
>  warning: variable 'tx_desc_info' set but not used [-Wunused-but-set-variable]
> 
> 'cur_rings, max_hw_rings' never used since introduction in commit
> 34e8c406fda5 ("qlcnic: refactor Tx/SDS ring calculation and validation in driver.")
> 'tx_desc_info' never used since commit
> 95b3890ae39f ("qlcnic: Enhance Tx timeout debugging.")
> Also 'queue_type' only can be QLCNIC_RX_QUEUE/QLCNIC_TX_QUEUE,
> so make a trival cleanup on if statement.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
