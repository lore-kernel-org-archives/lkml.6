Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92164C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5447720871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5447720871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbeKLEPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:15:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37978 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeKLEPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:15:47 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DBB81141E1411;
        Sun, 11 Nov 2018 10:26:31 -0800 (PST)
Date:   Sun, 11 Nov 2018 10:26:31 -0800 (PST)
Message-Id: <20181111.102631.2180605944722637653.davem@davemloft.net>
To:     laoar.shao@gmail.com
Cc:     edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com
Subject: Re: [PATCH net-next v2] tcp: minor optimization in tcp ack fast
 path processing
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1541938210-11797-1-git-send-email-laoar.shao@gmail.com>
References: <1541938210-11797-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 11 Nov 2018 10:26:32 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 11 Nov 2018 20:10:10 +0800

> Bitwise operation is a little faster.
> So I replace after() with using the flag FLAG_SND_UNA_ADVANCED as it is
> already set before.
> 
> In addtion, there's another similar improvement in tcp_cwnd_reduction().
> 
> Cc: Joe Perches <joe@perches.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Applied.
