Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDF2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 20:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D9E2075D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 20:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeL3Udw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 15:33:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60358 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeL3Udw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 15:33:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 54F4F14ABCC16;
        Sun, 30 Dec 2018 12:33:51 -0800 (PST)
Date:   Sun, 30 Dec 2018 12:33:50 -0800 (PST)
Message-Id: <20181230.123350.1719727923588813351.davem@davemloft.net>
To:     christophe.jaillet@wanadoo.fr
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, sd@queasysnail.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/ipv6: Fix a test against 'ipv6_find_idev()' return
 value
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181228222821.20332-1-christophe.jaillet@wanadoo.fr>
References: <20181228222821.20332-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 30 Dec 2018 12:33:51 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Fri, 28 Dec 2018 23:28:21 +0100

> 'ipv6_find_idev()' returns NULL on error, not an error pointer.
> Update the test accordingly and return -ENOBUFS, as already done in
> 'addrconf_add_dev()', if NULL is returned.
> 
> Fixes: ("ipv6: allow userspace to add IFA_F_OPTIMISTIC addresses")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied and queued up for -stable.

Please provide the SHA1_ID in the Fixes: tag next time, I fixed it up
for you.
