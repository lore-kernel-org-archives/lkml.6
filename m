Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAE0C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171EB20821
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfBCTkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 14:40:07 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43094 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbfBCTkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 14:40:07 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DC54214C18E4B;
        Sun,  3 Feb 2019 11:40:05 -0800 (PST)
Date:   Sun, 03 Feb 2019 11:40:05 -0800 (PST)
Message-Id: <20190203.114005.1068563409105929462.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, linus.luessing@c0d3.blue, andrew@lunn.ch,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, sbrivio@redhat.com,
        liuhangbin@gmail.com, linux-kernel@vger.kernel.org,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH net-next] net: Fix ip_mc_{dec,inc}_group allocation
 context
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190202042055.27202-1-f.fainelli@gmail.com>
References: <20190202042055.27202-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Feb 2019 11:40:06 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri,  1 Feb 2019 20:20:52 -0800

> After 4effd28c1245 ("bridge: join all-snoopers multicast address"), I
> started seeing the following sleep in atomic warnings:
 ...
> while toggling the bridge's multicast_snooping attribute dynamically.
> 
> Pass a gfp_t down to igmpv3_add_delrec(), introduce
> __igmp_group_dropped() and introduce __ip_mc_dec_group() to take a gfp_t
> argument.
> 
> Similarly introduce ____ip_mc_inc_group() and __ip_mc_inc_group() to
> allow caller to specify gfp_t.
> 
> IPv6 part of the patch appears fine.
> 
> Fixes: 4effd28c1245 ("bridge: join all-snoopers multicast address")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.

Maybe you could submit a quick test case since you had a reproducer?
