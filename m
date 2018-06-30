Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA15C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 11:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FA423DBA
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 11:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FA423DBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030261AbeF3LTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 07:19:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37260 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754852AbeF3LTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 07:19:20 -0400
Received: from localhost (unknown [183.108.164.149])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4BFD9143A3494;
        Sat, 30 Jun 2018 04:19:19 -0700 (PDT)
Date:   Sat, 30 Jun 2018 20:19:17 +0900 (KST)
Message-Id: <20180630.201917.1237479559141460617.davem@davemloft.net>
To:     mhocko@kernel.org
Cc:     edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com
Subject: Re: [PATCH] net: cleanup gfp mask in alloc_skb_with_frags
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180628155306.29038-1-mhocko@kernel.org>
References: <20180628155306.29038-1-mhocko@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 30 Jun 2018 04:19:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@kernel.org>
Date: Thu, 28 Jun 2018 17:53:06 +0200

> From: Michal Hocko <mhocko@suse.com>
> 
> alloc_skb_with_frags uses __GFP_NORETRY for non-sleeping allocations
> which is just a noop and a little bit confusing.
> 
> __GFP_NORETRY was added by ed98df3361f0 ("net: use __GFP_NORETRY for
> high order allocations") to prevent from the OOM killer. Yet this was
> not enough because fb05e7a89f50 ("net: don't wait for order-3 page
> allocation") didn't want an excessive reclaim for non-costly orders
> so it made it completely NOWAIT while it preserved __GFP_NORETRY in
> place which is now redundant.
> 
> Drop the pointless __GFP_NORETRY because this function is used as
> copy&paste source for other places.
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Applied.
