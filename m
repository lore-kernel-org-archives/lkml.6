Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0963C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93892152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93892152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeIZXht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:37:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57494 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeIZXht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:37:49 -0400
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BB2CE10007AC1;
        Wed, 26 Sep 2018 10:23:51 -0700 (PDT)
Date:   Wed, 26 Sep 2018 10:23:50 -0700 (PDT)
Message-Id: <20180926.102350.290135634279870455.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     wei.liu2@citrix.com, paul.durrant@citrix.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH net-next] net: xen-netback: fix return type of
 ndo_start_xmit function
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180926091814.11104-1-yuehaibing@huawei.com>
References: <20180926091814.11104-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Sep 2018 10:23:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 26 Sep 2018 17:18:14 +0800

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Acked-by: Wei Liu <wei.liu2@citrix.com>

Applied.
