Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB62C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2152080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbeLNTFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:05:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59290 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbeLNTFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:05:32 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5C8B214DF1C9A;
        Fri, 14 Dec 2018 11:05:31 -0800 (PST)
Date:   Fri, 14 Dec 2018 11:05:30 -0800 (PST)
Message-Id: <20181214.110530.1362956449531434869.davem@davemloft.net>
To:     cpaasch@apple.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, bhole_prashant_q7@lab.ntt.co.jp,
        tyhicks@canonical.com, eric.dumazet@gmail.com, edumazet@google.com
Subject: Re: [PATCH 4.14 09/89] net: Prevent invalid access to skb->prev in
 __qdisc_drop_all
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181214155226.GJ41383@MacBook-Pro-19.local>
References: <20181214115729.658859279@linuxfoundation.org>
        <20181214115730.135586551@linuxfoundation.org>
        <20181214155226.GJ41383@MacBook-Pro-19.local>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Dec 2018 11:05:31 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Paasch <cpaasch@apple.com>
Date: Fri, 14 Dec 2018 07:52:26 -0800

> I don't think this patch needs to be backported. I haven't hit this panic on
> v4.14.x (although, I only have been using v4.14.79 for now - not yet the
> latest one). And the commits that seem to have introduced the issue haven't
> been backported either AFAICS. That being said, I don't think a backport
> would cause any side-effects.
> 
> Or have you seen reports of this panic in the stable branches?
> 
> (same for the other stable branches v4.4,... - cfr., the other mails
> regarding this patch here)

I was being ultra paranoid when I decided to submit this to 4.14 too,
and as Eric says it does not harm.
