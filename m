Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06829C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B9F2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B9F2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeLJR7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:59:00 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41114 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeLJR7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:59:00 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4338014732B37;
        Mon, 10 Dec 2018 09:58:59 -0800 (PST)
Date:   Mon, 10 Dec 2018 09:58:56 -0800 (PST)
Message-Id: <20181210.095856.580441946779980596.davem@davemloft.net>
To:     fw@strlen.de
Cc:     syzbot+592df0494801b6648ec6@syzkaller.appspotmail.com,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: rcu detected stall in xfrm_hash_rebuild
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181210124724.iuver2va3yjdsokf@breakpoint.cc>
References: <00000000000075fe86057ca6367e@google.com>
        <20181210124724.iuver2va3yjdsokf@breakpoint.cc>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 10 Dec 2018 09:58:59 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>
Date: Mon, 10 Dec 2018 13:47:24 +0100

> After recent tree conversion, we could probably make the exact policies
> part of the 'inexact tree' (which would be renamed to 'policy tree' or
> some such).
> 
> Special-casing the exact policies made a lot of sense when we had
> a single list for the inexact policies (to keep its length down).
> 
> But now I think we could try to unify all of this and only maintain
> the existing tree-based storage.
> 
> Would also remove the need to do lookups in two different
> data structures (bydst-hash-then-inexact-tree).
> 
> What do you think?

I think this makes a lot of sense.
