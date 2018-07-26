Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31F3C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B5220673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B5220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbeGZW3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:29:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47018 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbeGZW3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:29:01 -0400
Received: from localhost (unknown [172.58.43.154])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 05BDE108CAEB7;
        Thu, 26 Jul 2018 14:10:23 -0700 (PDT)
Date:   Thu, 26 Jul 2018 14:10:22 -0700 (PDT)
Message-Id: <20180726.141022.1379401977396818228.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     jiri@mellanox.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sched: cls_api: fix dead code in switch
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180725140724.GA23053@embeddedor.com>
References: <20180725140724.GA23053@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 26 Jul 2018 14:10:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 25 Jul 2018 09:07:24 -0500

> Code at line 1850 is unreachable. Fix this by removing the break
> statement above it, so the code for case RTM_GETCHAIN can be
> properly executed.
> 
> Addresses-Coverity-ID: 1472050 ("Structurally dead code")
> Fixes: 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thanks.

Please use "[PATCH net-next] ..." in your subject lines to indirect
the tree that this change is relevant for and targetted to.

Thank you.
