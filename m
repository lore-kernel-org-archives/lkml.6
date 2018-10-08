Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF91C6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C0E2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C0E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJHKn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:43:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47160 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeJHKn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 06:43:59 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6D3D01426D6AF;
        Sun,  7 Oct 2018 20:34:24 -0700 (PDT)
Date:   Sun, 07 Oct 2018 20:34:21 -0700 (PDT)
Message-Id: <20181007.203421.1496534902899406968.davem@davemloft.net>
To:     jikos@kernel.org
Cc:     yoshfuji@linux-ipv6.org, pabeni@redhat.com, edumazet@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udp: Unbreak modules that rely on external
 __skb_recv_udp() availability
From:   David Miller <davem@davemloft.net>
In-Reply-To: <nycvar.YFH.7.76.1810041335180.14430@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1810041335180.14430@cbobk.fhfr.pm>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 07 Oct 2018 20:34:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jikos@kernel.org>
Date: Thu, 4 Oct 2018 13:37:32 +0200 (CEST)

> From: Jiri Kosina <jkosina@suse.cz>
> 
> Commit 2276f58ac589 ("udp: use a separate rx queue for packet reception")
> turned static inline __skb_recv_udp() from being a trivial helper around
> __skb_recv_datagram() into a UDP specific implementaion, making it
> EXPORT_SYMBOL_GPL() at the same time.
> 
> There are external modules that got broken by __skb_recv_udp() not being
> visible to them. Let's unbreak them by making __skb_recv_udp EXPORT_SYMBOL().
> 
> Rationale (one of those) why this is actually "technically correct" thing 
> to do: __skb_recv_udp() used to be an inline wrapper around 
> __skb_recv_datagram(), which itself (still, and correctly so, I believe) 
> is EXPORT_SYMBOL().
> 
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Fixes: 2276f58ac589 ("udp: use a separate rx queue for packet reception")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Applied...

But waiting from 4.13 until now to bring this up is really pushing it...
