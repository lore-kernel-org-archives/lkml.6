Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A850EC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6120851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED6120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLDAPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:15:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:50756 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLDAPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:15:15 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C6CFD133E98F7;
        Mon,  3 Dec 2018 16:15:14 -0800 (PST)
Date:   Mon, 03 Dec 2018 16:15:14 -0800 (PST)
Message-Id: <20181203.161514.1229179839092578403.davem@davemloft.net>
To:     cai@gmx.us
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com, joe@perches.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/core: tidy up an error message
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181202021119.7737-1-cai@gmx.us>
References: <20181202021119.7737-1-cai@gmx.us>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Dec 2018 16:15:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@gmx.us>
Date: Sat,  1 Dec 2018 21:11:19 -0500

> netif_napi_add() could report an error like this below due to it allows
> to pass a format string for wildcarding before calling
> dev_get_valid_name(),
> 
> "netif_napi_add() called with weight 256 on device eth%d"
> 
> For example, hns_enet_drv module does this.
> 
> hns_nic_try_get_ae
>   hns_nic_init_ring_data
>     netif_napi_add
>   register_netdev
>     dev_get_valid_name
> 
> Hence, make it a bit more human-readable by using netdev_err_once()
> instead.
> 
> Signed-off-by: Qian Cai <cai@gmx.us>

Applied, thanks.
