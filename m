Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D17C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5656121527
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5656121527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbeITKBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 06:01:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34380 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbeITKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 06:01:09 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 186C110903035;
        Wed, 19 Sep 2018 21:19:48 -0700 (PDT)
Date:   Wed, 19 Sep 2018 21:19:47 -0700 (PDT)
Message-Id: <20180919.211947.1813992126020000943.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     shannon.nelson@oracle.com, alexander.h.duyck@intel.com,
        yanjun.zhu@oracle.com, jeffrey.t.kirsher@intel.com,
        tklauser@distanz.ch, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: sun: fix return type of ndo_start_xmit
 function
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180919112132.26616-1-yuehaibing@huawei.com>
References: <20180919112132.26616-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Sep 2018 21:19:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 19 Sep 2018 19:21:32 +0800

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
