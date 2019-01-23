Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F73AC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F73217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfAWEnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 23:43:10 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40576 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfAWEnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 23:43:09 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 41C0014D7330F;
        Tue, 22 Jan 2019 20:43:09 -0800 (PST)
Date:   Tue, 22 Jan 2019 20:43:08 -0800 (PST)
Message-Id: <20190122.204308.162543596275068081.davem@davemloft.net>
To:     lkundrak@v3.sk
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thaller@redhat.com
Subject: Re: [PATCH] net/ipv6: lower the level of "link is not ready"
 messages
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190121135419.615989-1-lkundrak@v3.sk>
References: <20190121135419.615989-1-lkundrak@v3.sk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 22 Jan 2019 20:43:09 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>
Date: Mon, 21 Jan 2019 14:54:20 +0100

> This message gets logged far too often for how interesting is it.
> 
> Most distributions nowadays configure NetworkManager to use randomly
> generated MAC addresses for Wi-Fi network scans. The interfaces end up
> being periodically brought down for the address change. When they're
> subsequently brought back up, the message is logged, eventually flooding
> the log.
> 
> Perhaps the message is not all that helpful: it seems to be more
> interesting to hear when the addrconf actually start, not when it does
> not. Let's lower its level.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

This has always bugged me too.

Applied, thanks!
