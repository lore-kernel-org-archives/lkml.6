Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19353C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 02:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A1F20894
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 02:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A1F20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeHUFih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 01:38:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59360 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeHUFih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 01:38:37 -0400
Received: from localhost (75-164-158-175.ptld.qwest.net [75.164.158.175])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 045DF147A522F;
        Mon, 20 Aug 2018 19:20:31 -0700 (PDT)
Date:   Mon, 20 Aug 2018 19:20:31 -0700 (PDT)
Message-Id: <20180820.192031.1137174206399090141.davem@davemloft.net>
To:     Haiqing.Bai@windriver.com
Cc:     jon.maloy@ericsson.com, ying.xue@windriver.com,
        zhenbo.gao@windriver.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tipc: fix issue that tipc_dest neglects of big-endian
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1534760761-30206-1-git-send-email-Haiqing.Bai@windriver.com>
References: <1534760761-30206-1-git-send-email-Haiqing.Bai@windriver.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Aug 2018 19:20:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiqing Bai <Haiqing.Bai@windriver.com>
Date: Mon, 20 Aug 2018 18:26:01 +0800

> The tipc multicast demo in tipcutils fails to work on big-endian hardware.
> The tipc multicast server can not receive the packets sent by the multicast
> client for that the dest port is always zero after tipc_dest_pop, then it
> is found that the struct tipc_dest fails to take big/little endian into
> account.
> 
> Signed-off-by: Haiqing Bai <Haiqing.Bai@windriver.com>
> Signed-off-by: Zhenbo Gao <zhenbo.gao@windriver.com>

Jon and Ying, please review.

thank you.
