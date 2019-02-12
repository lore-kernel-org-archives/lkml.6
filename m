Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41710C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F087222BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfBLRzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:55:22 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55516 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbfBLRzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:55:21 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F348414C4CC82;
        Tue, 12 Feb 2019 09:55:20 -0800 (PST)
Date:   Tue, 12 Feb 2019 09:55:20 -0800 (PST)
Message-Id: <20190212.095520.2293054975357585380.davem@davemloft.net>
To:     briannorris@chromium.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/skbuff: fix up kernel-doc placement
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190211210225.132282-1-briannorris@chromium.org>
References: <20190211210225.132282-1-briannorris@chromium.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Feb 2019 09:55:21 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>
Date: Mon, 11 Feb 2019 13:02:25 -0800

> There are several skb_* functions where the locked and unlocked
> functions are confusingly documented. For several of them, the
> kernel-doc for the unlocked version is placed above the locked version,
> which to the casual reader makes it seems like the locked version "takes
> no locks and you must therefore hold required locks before calling it."
> 
> One can see, for example, that this link claims to document
> skb_queue_head(), while instead describing __skb_queue_head().
> 
> https://www.kernel.org/doc/html/latest/networking/kapi.html#c.skb_queue_head
> 
> The correct documentation for skb_queue_head() is also included further
> down the page.
> 
> This diff tested via:
> 
>   $ scripts/kernel-doc -rst include/linux/skbuff.h net/core/skbuff.c
> 
> No new warnings were seen, and the output makes a little more sense.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied, thanks Brian.
