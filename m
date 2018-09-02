Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D1BC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E49320843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 19:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E49320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeICAB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 20:01:58 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:50104 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeICAB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 20:01:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 967C86060960;
        Sun,  2 Sep 2018 21:45:05 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bQaiggD5qgUH; Sun,  2 Sep 2018 21:45:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3FCD2605A933;
        Sun,  2 Sep 2018 21:45:05 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4WW7e6NxkWFB; Sun,  2 Sep 2018 21:45:05 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id DEA0F6060960;
        Sun,  2 Sep 2018 21:45:04 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/25] ubifs: Add authentication nodes to journal
Date:   Sun, 02 Sep 2018 21:45:04 +0200
Message-ID: <5120826.olsX7Y6fYh@blindfold>
In-Reply-To: <20180829143834.wwojzrwmpadxqiqk@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de> <1901352.nUraZMrBkh@blindfold> <20180829143834.wwojzrwmpadxqiqk@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 29. August 2018, 16:38:34 CEST schrieb Sascha Hauer:
> I assumed that make_reservation would align len anyway. I can't find the
> place that led me to that assumption anymore and even if this is true
> it's probably safer to just stick to the original len for the
> non-authenticated case, so I'll change this and other places to use
> the non aligned len.
> 
> BTW could you have a look at ubifs_jnl_change_xattr()? Unlike other
> function in this file it explicitly calls make_reservation() with the
> length of the last node aligned. Do you have an idea why?

Well, this is not the only call site. Other call sites do so implicitly
since most UBIFS nodes sizes are aligned to 8.
But yes, there are some inconsistencies which need a cleanup. I've scheduled
that for the upcoming week.

Thanks,
//richard 


