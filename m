Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF02C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9E72086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9E72086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbeKPFpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:45:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45178 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbeKPFpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:45:14 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 89200146E02D0;
        Thu, 15 Nov 2018 11:36:06 -0800 (PST)
Date:   Thu, 15 Nov 2018 11:36:04 -0800 (PST)
Message-Id: <20181115.113604.1754968207196359976.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix life check
From:   David Miller <davem@davemloft.net>
In-Reply-To: <154206200235.19188.1775391172980714293.stgit@warthog.procyon.org.uk>
References: <154206200235.19188.1775391172980714293.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 15 Nov 2018 11:36:06 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Mon, 12 Nov 2018 22:33:22 +0000

> The life-checking function, which is used by kAFS to make sure that a call
> is still live in the event of a pending signal, only samples the received
> packet serial number counter; it doesn't actually provoke a change in the
> counter, rather relying on the server to happen to give us a packet in the
> time window.
> 
> Fix this by adding a function to force a ping to be transmitted.
> 
> kAFS then keeps track of whether there's been a stall, and if so, uses the
> new function to ping the server, resetting the timeout to allow the reply
> to come back.
> 
> If there's a stall, a ping and the call is *still* stalled in the same
> place after another period, then the call will be aborted.
> 
> Fixes: bc5e3a546d55 ("rxrpc: Use MSG_WAITALL to tell sendmsg() to temporarily ignore signals")
> Fixes: f4d15fb6f99a ("rxrpc: Provide functions for allowing cleaner handling of signals")
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied, thank you.
