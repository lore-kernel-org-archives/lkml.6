Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17DFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3D2206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbeLQTNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:13:04 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42076 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732996AbeLQTNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:13:04 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8039310199D44;
        Mon, 17 Dec 2018 11:13:03 -0800 (PST)
Date:   Mon, 17 Dec 2018 11:13:02 -0800 (PST)
Message-Id: <20181217.111302.105056511088497169.davem@davemloft.net>
To:     xuechaojing@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        wulike1@huawei.com, chiqijun@huawei.com, fy.wang@huawei.com,
        tony.qu@huawei.com, luoshaokai@huawei.com, nhorman@redhat.com
Subject: Re: [PATCH 1/1] net-next/hinic:optmize rx refill buffer mechanism
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181216223234.24031-1-xuechaojing@huawei.com>
References: <20181216223234.24031-1-xuechaojing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Dec 2018 11:13:03 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xue Chaojing <xuechaojing@huawei.com>
Date: Sun, 16 Dec 2018 22:32:34 +0000

> In rx_alloc_pkts(), there is no need to schedule a different tasklet for
> refill and it will cause some extra overhead. this patch remove it.
> 
> Suggested-by: Neil Horman <nhorman@redhat.com>
> Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>

In future submissions please formation your Subject line properly.

First, there should always be a space character after the ":" following
the subsystem prefix.

Next, "net-next" belongs inside of the '[]' so "[PATCH net-next N/M] ".

However, when you have a single patch, there is no reason to give the
"N/M" part, so you can just drop it in this situation.

Please also capitalize the text after the subsystem prefix string.

Therefore this Subject must be formatted exactly like this:

	Subject: "[PATCH net-next] hinic: Optimize RX refill buffer mechanism"

But meanwhile you must address the feedback given to you by Neil and myself.

You absolutely MUST NOT receive a RX packet if you cannot successfully
allocate a replacement buffer for the RX ring in that slot.  It allows
the RX ring to become empty, which many cards respond to by hanging.

It would really serve you poorly if you continue to ignore our
feedback because addressing it is a requirement before we will be able
to consider integrating your work.

Thank you.

