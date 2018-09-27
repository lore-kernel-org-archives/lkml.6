Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E616FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA99206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA99206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeI0JXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 05:23:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37416 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeI0JXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 05:23:39 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 38DCD1456FE19;
        Wed, 26 Sep 2018 20:07:37 -0700 (PDT)
Date:   Wed, 26 Sep 2018 20:07:36 -0700 (PDT)
Message-Id: <20180926.200736.587069163330540674.davem@davemloft.net>
To:     laoar.shao@gmail.com
Cc:     edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] tcp: expose sk_state in tcp_retransmit_skb
 tracepoint
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1537793849-32396-1-git-send-email-laoar.shao@gmail.com>
References: <1537793849-32396-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Sep 2018 20:07:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 24 Sep 2018 20:57:29 +0800

> After sk_state exposed, we can get in which state this retransmission
> occurs. That could give us more detail for dignostic.
> For example, if this retransmission occurs in SYN_SENT state, it may
> also indicates that the syn packet may be dropped on the remote peer due
> to syn backlog queue full and then we could check the remote peer.
> 
> BTW,SYNACK retransmission is traced in tcp_retransmit_synack tracepoint.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Applied.
