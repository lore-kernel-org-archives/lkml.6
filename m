Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97DCC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8857120851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8857120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeLKGBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:01:09 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53784 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeLKGBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:01:08 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 328331000B09D;
        Mon, 10 Dec 2018 22:01:08 -0800 (PST)
Date:   Mon, 10 Dec 2018 22:01:07 -0800 (PST)
Message-Id: <20181210.220107.751606140724107779.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     h.morris@cascoda.com, alex.aring@gmail.com,
        stefan@datenfreihafen.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-wpan@vger.kernel.org
Subject: Re: [PATCH net-next] ieee802154: ca8210: fix possible u8 overflow
 in ca8210_rx_done
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181211031339.21048-1-yuehaibing@huawei.com>
References: <20181211031339.21048-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 10 Dec 2018 22:01:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 11 Dec 2018 11:13:39 +0800

> gcc warning this:
> 
> drivers/net/ieee802154/ca8210.c:730:10: warning:
>  comparison is always false due to limited range of data type [-Wtype-limits]
> 
> 'len' is u8 type, we get it from buf[1] adding 2, which can overflow.
> This patch change the type of 'len' to unsigned int to avoid this,also fix
> the gcc warning.
> 
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

WPAN maintainers, I am assuming that as maintainers you will be
picking this up and sending it to me.
