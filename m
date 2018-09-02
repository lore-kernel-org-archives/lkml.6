Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7987AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 23:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2296820837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 23:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2296820837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeICDam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 23:30:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35834 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeICDam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 23:30:42 -0400
Received: from localhost (168-64-212-66.spl.org [66.212.64.168])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EC0121262C4F6;
        Sun,  2 Sep 2018 16:13:16 -0700 (PDT)
Date:   Sun, 02 Sep 2018 16:13:16 -0700 (PDT)
Message-Id: <20180902.161316.1787939948176707232.davem@davemloft.net>
To:     laoar.shao@gmail.com
Cc:     edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: remove useless add operation when init
 sysctl_max_tw_buckets
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1535804465-11795-2-git-send-email-laoar.shao@gmail.com>
References: <1535804465-11795-1-git-send-email-laoar.shao@gmail.com>
        <1535804465-11795-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Sep 2018 16:13:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat,  1 Sep 2018 20:21:05 +0800

> cp_hashinfo.ehash_mask is always an odd number, which is set in function
> alloc_large_system_hash(). See bellow,
>         if (_hash_mask)
>                 *_hash_mask = (1 << log2qty) - 1; <<< always odd number
> 
> Hence the local variable 'cnt' is a even number, as a result of that it is
> no difference to do the incrementation here.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Applied.
