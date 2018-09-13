Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B740EC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6546820866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6546820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeIMWxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:53:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51538 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeIMWxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:53:25 -0400
Received: from localhost (unknown [24.18.143.0])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0A0871401CC47;
        Thu, 13 Sep 2018 10:42:55 -0700 (PDT)
Date:   Thu, 13 Sep 2018 10:42:54 -0700 (PDT)
Message-Id: <20180913.104254.1048729520825977993.davem@davemloft.net>
To:     zhongjiang@huawei.com
Cc:     edumazet@google.com, kuznet@ms2.inr.ac.ru, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] net: ipv4: Use BUG_ON directly instead of a if
 condition followed by BUG
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1536671593-14746-1-git-send-email-zhongjiang@huawei.com>
References: <1536671593-14746-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Sep 2018 10:42:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>
Date: Tue, 11 Sep 2018 21:13:13 +0800

> The if condition can be removed if we use BUG_ON directly.
> The issule is detected with the help of Coccinelle.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Taking Simon's feedback into consideration...

I very often see changes like this and have to check the implementation
of BUG_ON() et al. to make sure it evaluates it's arguments even when
debugging is disabled.

Even if it is always guaranteed to do so, like me people will be unsure
forever and have to check.

That makes auditing code and validating things more time consuming and
hard.

I also think the code as written now looks a lot nicer.

So I'm not applying this, sorry.
