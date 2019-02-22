Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C15C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DA82070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfBVTui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:50:38 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57158 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVTuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:50:37 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4D72714A872FC;
        Fri, 22 Feb 2019 11:50:37 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:50:36 -0800 (PST)
Message-Id: <20190222.115036.2198036492786822658.davem@davemloft.net>
To:     jannh@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: socket: add check for negative optlen in
 compat setsockopt
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190220213454.244600-1-jannh@google.com>
References: <20190220213454.244600-1-jannh@google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Feb 2019 11:50:37 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>
Date: Wed, 20 Feb 2019 22:34:54 +0100

> __sys_setsockopt() already checks for `optlen < 0`. Add an equivalent check
> to the compat path for robustness. This has to be `> INT_MAX` instead of
> `< 0` because the signedness of `optlen` is different here.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Applied and queued up for -stable, thanks Jann.
