Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6B1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FE02084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeLOTyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 14:54:45 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:54418 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeLOTyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 14:54:44 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 01FA514E8C6E7;
        Sat, 15 Dec 2018 11:54:43 -0800 (PST)
Date:   Sat, 15 Dec 2018 11:54:43 -0800 (PST)
Message-Id: <20181215.115443.1744275952795502150.davem@davemloft.net>
To:     mkubecek@suse.cz
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        posk@google.com, eric.dumazet@gmail.com, gfigueira@suse.com
Subject: Re: [PATCH net v2] net: ipv4: do not handle duplicate fragments as
 overlapping
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181213162332.E426FE1116@unicorn.suse.cz>
References: <20181213162332.E426FE1116@unicorn.suse.cz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Dec 2018 11:54:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>
Date: Thu, 13 Dec 2018 17:23:32 +0100 (CET)

> Since commit 7969e5c40dfd ("ip: discard IPv4 datagrams with overlapping
> segments.") IPv4 reassembly code drops the whole queue whenever an
> overlapping fragment is received. However, the test is written in a way
> which detects duplicate fragments as overlapping so that in environments
> with many duplicate packets, fragmented packets may be undeliverable.
> 
> Add an extra test and for (potentially) duplicate fragment, only drop the
> new fragment rather than the whole queue. Only starting offset and length
> are checked, not the contents of the fragments as that would be too
> expensive. For similar reason, linear list ("run") of a rbtree node is not
> iterated, we only check if the new fragment is a subset of the interval
> covered by existing consecutive fragments.
> 
> Fixes: 7969e5c40dfd ("ip: discard IPv4 datagrams with overlapping segments.")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> 
> v2: instead of an exact check iterating through linear list of an rbtree
> node, only check if the new fragment is subset of the "run" (suggested
> by Eric Dumazet)

Applied and queued up for -stable, thank you.
