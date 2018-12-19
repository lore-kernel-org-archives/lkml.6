Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FA9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD962184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeLSGD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:03:59 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49676 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeLSGDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 01:03:55 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 67935146F2BCA;
        Tue, 18 Dec 2018 22:03:55 -0800 (PST)
Date:   Tue, 18 Dec 2018 22:03:54 -0800 (PST)
Message-Id: <20181218.220354.1029594559259847304.davem@davemloft.net>
To:     mhjungk@gmail.com
Cc:     ubraun@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net/smc: fix TCP fallback socket release
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181218170221.GA21835@myunghoj-Precision-5530>
References: <20181218170221.GA21835@myunghoj-Precision-5530>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Dec 2018 22:03:55 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Myungho Jung <mhjungk@gmail.com>
Date: Tue, 18 Dec 2018 09:02:25 -0800

> clcsock can be released while kernel_accept() references it in TCP
> listen worker. Also, clcsock needs to wake up before released if TCP
> fallback is used and the clcsock is blocked by accept. Add a lock to
> safely release clcsock and call kernel_sock_shutdown() to wake up
> clcsock from accept in smc_release().
> 
> Reported-by: syzbot+0bf2e01269f1274b4b03@syzkaller.appspotmail.com
> Reported-by: syzbot+e3132895630f957306bc@syzkaller.appspotmail.com
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>

Applied, thanks.
