Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F520C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BBF20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BBF20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388530AbeGYArV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:47:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40056 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbeGYArU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:47:20 -0400
Received: from localhost (unknown [172.58.43.160])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D57F5108A8B7F;
        Tue, 24 Jul 2018 16:38:28 -0700 (PDT)
Date:   Tue, 24 Jul 2018 16:38:28 -0700 (PDT)
Message-Id: <20180724.163828.608956839426957886.davem@davemloft.net>
To:     shubhrajyoti.datta@gmail.com
Cc:     netdev@vger.kernel.org, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, shubhrajyoti.datta@xilinx.com
Subject: Re: [PATCH] net: axienet: Fix double deregister of mdio
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1532407193-21637-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1532407193-21637-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 24 Jul 2018 16:38:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <shubhrajyoti.datta@gmail.com>
Date: Tue, 24 Jul 2018 10:09:53 +0530

> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> If the registration fails then mdio_unregister is called.
> However at unbind the unregister ia attempted again resulting
> in the below crash
 ...
> Fix the same by making the bus NULL on unregister.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Applied, thank you.
