Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8BDC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623C0208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623C0208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeKYMap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 07:30:45 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59588 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeKYMao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 07:30:44 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D46CF14ECF118;
        Sat, 24 Nov 2018 17:40:53 -0800 (PST)
Date:   Sat, 24 Nov 2018 17:40:53 -0800 (PST)
Message-Id: <20181124.174053.2148461318593755323.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     subashab@codeaurora.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qualcomm: rmnet: move null check on dev before
 dereferecing it
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181124150302.20339-1-colin.king@canonical.com>
References: <20181124150302.20339-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 24 Nov 2018 17:40:54 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Sat, 24 Nov 2018 15:03:02 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently dev is dereferenced by the call dev_net(dev) before dev is null
> checked.  Fix this by null checking dev before the potential null
> pointer dereference.
> 
> Detected by CoverityScan, CID#1462955 ("Dereference before null check")
> 
> Fixes: 23790ef12082 ("net: qualcomm: rmnet: Allow to configure flags for existing devices")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next.
