Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A53C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BAF2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfAGRKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:10:33 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:58676 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfAGRKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:10:33 -0500
Received: from localhost (unknown [144.121.20.163])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5E99C1015DD06;
        Mon,  7 Jan 2019 09:10:32 -0800 (PST)
Date:   Mon, 07 Jan 2019 09:10:31 -0800 (PST)
Message-Id: <20190107.091031.100384065611982323.davem@davemloft.net>
To:     kchen@synology.com
Cc:     nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: bridge: fix a bug on using a neighbour cache
 entry without checking its state
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1546745293-5678-1-git-send-email-kchen@synology.com>
References: <1546745293-5678-1-git-send-email-kchen@synology.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 07 Jan 2019 09:10:32 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kchen <kchen@synology.com>
Date: Sun,  6 Jan 2019 11:28:13 +0800

> From: JianJhen Chen <kchen@synology.com>
> 
> When handling DNAT'ed packets on a bridge device, the neighbour cache entry
> from lookup was used without checking its state. It means that a cache entry
> in the NUD_STALE state will be used directly instead of entering the NUD_DELAY
> state to confirm the reachability of the neighbor.
> 
> This problem becomes worse after commit 2724680bceee ("neigh: Keep neighbour
> cache entries if number of them is small enough."), since all neighbour cache
> entries in the NUD_STALE state will be kept in the neighbour table as long as
> the number of cache entries does not exceed the value specified in gc_thresh1.
> 
> This commit validates the state of a neighbour cache entry before using
> the entry.
> 
> Signed-off-by: JianJhen Chen <kchen@synology.com>
> Reviewed-by: JinLin Chen <jlchen@synology.com>

Indeed, this looks correct.

Applied and queued up for -stable, thanks.
