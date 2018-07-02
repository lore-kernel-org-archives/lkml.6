Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1B3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CAF24E4C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CAF24E4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934235AbeGBLgQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:36:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48532 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933039AbeGBLgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:36:14 -0400
Received: from localhost (unknown [59.29.86.96])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AF6D51094D2B3;
        Mon,  2 Jul 2018 04:36:12 -0700 (PDT)
Date:   Mon, 02 Jul 2018 20:36:11 +0900 (KST)
Message-Id: <20180702.203611.801501021039255132.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     jakub.kicinski@netronome.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] netdevsim: fix sa_idx out of bounds check
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180630203924.5121-1-colin.king@canonical.com>
References: <20180630203924.5121-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 02 Jul 2018 04:36:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Sat, 30 Jun 2018 21:39:24 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if sa_idx is equal to NSIM_IPSEC_MAX_SA_COUNT then
> an out-of-bounds read on ipsec->sa will occur. Fix the
> incorrect bounds check by using >= rather than >.
> 
> Detected by CoverityScan, CID#1470226 ("Out-of-bounds-read")
> 
> Fixes: 7699353da875 ("netdevsim: add ipsec offload testing")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.
