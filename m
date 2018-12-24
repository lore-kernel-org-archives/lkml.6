Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F56C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10E121720
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbeLXWtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:49:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37764 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXWtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:49:13 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6860A1416F334;
        Mon, 24 Dec 2018 14:49:12 -0800 (PST)
Date:   Mon, 24 Dec 2018 14:49:11 -0800 (PST)
Message-Id: <20181224.144911.772423671168046343.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] drivers/net: appletalk/cops: remove redundant if
 statement and mask
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181224194146.11511-1-colin.king@canonical.com>
References: <20181224194146.11511-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Dec 2018 14:49:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon, 24 Dec 2018 19:41:46 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> The two different assignments for pkt_len are actually the same and
> so the if statement is redundant and can be removed.  Masking a u8
> return value from inb() with 0xFF is also redundant and can also be
> emoved.
> 
> Similarly, the two different outb calls are identical as the mask
> of 0xff on the second outb is redundant since a u8 is being written,
> so the if statement is also redundant and can be also removed.
> 
> Detected by CoverityScan, CID#1475639 ("Identical code for different
> branches")
> 
> ---
> 
> V2: Remove the if statement for the outb calls, thanks to David
> Miller for spotting this.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Colin, I almost didn't notice how the "---" there is in the wrong spot
and therefore was cutting out your changelog and signoff.

I fixed it up, but please be more careful in the future.

Thanks.
