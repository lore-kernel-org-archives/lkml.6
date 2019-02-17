Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5E2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B12217D9
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfBQXmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:42:19 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42800 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfBQXmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:42:19 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C5CCA12339A63;
        Sun, 17 Feb 2019 15:42:18 -0800 (PST)
Date:   Sun, 17 Feb 2019 15:42:18 -0800 (PST)
Message-Id: <20190217.154218.1671210082238894003.davem@davemloft.net>
To:     maowenan@huawei.com
Cc:     netdev@vger.kernel.org, xiyou.wangcong@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next] net: crypto set sk to NULL when af_alg_release.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190215142415.149153-1-maowenan@huawei.com>
References: <20190215142415.149153-1-maowenan@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 17 Feb 2019 15:42:19 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>
Date: Fri, 15 Feb 2019 22:24:15 +0800

> KASAN has found use-after-free in sockfs_setattr.
> The existed commit 6d8c50dcb029 ("socket: close race condition between sock_close()
> and sockfs_setattr()") is to fix this simillar issue, but it seems to ignore
> that crypto module forgets to set the sk to NULL after af_alg_release.

Please target this at 'net' since this is a bug fix.
