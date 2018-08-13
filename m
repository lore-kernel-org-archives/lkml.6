Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCB4C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4951321763
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4951321763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbeHMShq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:37:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52918 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbeHMShq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:37:46 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 754FE1458045D;
        Mon, 13 Aug 2018 08:54:57 -0700 (PDT)
Date:   Mon, 13 Aug 2018 08:54:56 -0700 (PDT)
Message-Id: <20180813.085456.1905254242911513146.davem@davemloft.net>
To:     salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil.lnk@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linyunsheng@huawei.com
Subject: Re: [PATCH net-next 1/9] net: hns3: Add support for serdes
 loopback selftest
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180812094738.14852-2-salil.mehta@huawei.com>
References: <20180812094738.14852-1-salil.mehta@huawei.com>
        <20180812094738.14852-2-salil.mehta@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 08:54:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Sun, 12 Aug 2018 10:47:30 +0100

> -#define HNS3_SELF_TEST_TPYE_NUM		1
> +#define HNS3_SELF_TEST_TPYE_NUM		2

Is this supposed to be the number of self test "types"?  If so, this CPP
macro should be named "HNS3_SELF_TEST_TYPE_NUM".

> +
> +		count ++;
                     ^

Please remove that unnecessary space.

> +	} while (++i < HCLGE_SERDES_RETRY_NUM  &&
                                             ^^

Only need one space there, not two.
					     
