Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971F8C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F78B21884
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F78B21884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbeGGLZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:25:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51670 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753358AbeGGLZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:25:58 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 16CB212107104;
        Sat,  7 Jul 2018 04:25:55 -0700 (PDT)
Date:   Sat, 07 Jul 2018 20:25:54 +0900 (KST)
Message-Id: <20180707.202554.176954772644288123.davem@davemloft.net>
To:     ubraun@linux.ibm.com
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org,
        ebiggers3@gmail.com
Subject: Re: [PATCH net 1/1] net/smc: reduce sock_put() for fallback sockets
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180705141530.72728-1-ubraun@linux.ibm.com>
References: <20180705141530.72728-1-ubraun@linux.ibm.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Jul 2018 04:25:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu,  5 Jul 2018 16:15:30 +0200

> smc_release() calls a sock_put() for smc fallback sockets to cover
> the passive closing sock_hold() in __smc_connect() and
> smc_tcp_listen_work(). This does not make sense for sockets in state
> SMC_LISTEN and SMC_INIT.
> An SMC socket stays in state SMC_INIT if connect fails. The sock_put
> in smc_connect_abort() does not cover all failures. Move it into
> smc_connect_decline_fallback().
> 
> Fixes: ee9dfbef02d18 ("net/smc: handle sockopts forcing fallback")
> Reported-by: syzbot+3a0748c8f2f210c0ef9b@syzkaller.appspotmail.com
> Reported-by: syzbot+9e60d2428a42049a592a@syzkaller.appspotmail.com
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>

Applied, thanks.
