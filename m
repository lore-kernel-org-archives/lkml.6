Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5182C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7DA2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7DA2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeJKNU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 09:20:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49230 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeJKNU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 09:20:29 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 570D412139FF0;
        Wed, 10 Oct 2018 22:54:48 -0700 (PDT)
Date:   Wed, 10 Oct 2018 22:54:47 -0700 (PDT)
Message-Id: <20181010.225447.2264091665828087261.davem@davemloft.net>
To:     weiyongjun1@huawei.com
Cc:     kishon@ti.com, quentin.schulz@bootlin.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH -next] phy: phy-ocelot-serdes: fix return value check
 in serdes_probe()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1539136824-44940-1-git-send-email-weiyongjun1@huawei.com>
References: <1539136824-44940-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 10 Oct 2018 22:54:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Wed, 10 Oct 2018 02:00:24 +0000

> In case of error, the function syscon_node_to_regmap() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Fixes: 51f6b410fc22 ("phy: add driver for Microsemi Ocelot SerDes muxing")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied.
