Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D02C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB8420836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB8420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754273AbeFSXAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:00:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49620 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbeFSXAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:00:20 -0400
Received: from localhost (unknown [61.102.160.116])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0DB1E1438D2B2;
        Tue, 19 Jun 2018 16:00:17 -0700 (PDT)
Date:   Wed, 20 Jun 2018 08:00:16 +0900 (KST)
Message-Id: <20180620.080016.110926650123819013.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     richardcochran@gmail.com, yangbo.lu@nxp.com,
        y2038@lists.linaro.org, fabio.estevam@nxp.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: replace getnstimeofday64() with
 ktime_get_real_ts64()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180618142109.3445025-1-arnd@arndb.de>
References: <20180618142109.3445025-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Jun 2018 16:00:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Jun 2018 16:20:39 +0200

> getnstimeofday64() is deprecated and getting replaced throughout
> the kernel with ktime_get_*() based helpers for a more consistent
> interface.
> 
> The two functions do the exact same thing, so this is just
> a cosmetic change.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
