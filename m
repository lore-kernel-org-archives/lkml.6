Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22F7C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15052085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15052085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeJHMZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 08:25:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:51974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbeJHMZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 08:25:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 507F1ADBF;
        Mon,  8 Oct 2018 05:15:24 +0000 (UTC)
Date:   Mon, 8 Oct 2018 07:15:22 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     David Miller <davem@davemloft.net>
cc:     yoshfuji@linux-ipv6.org, pabeni@redhat.com, edumazet@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udp: Unbreak modules that rely on external __skb_recv_udp()
 availability
In-Reply-To: <20181007.203421.1496534902899406968.davem@davemloft.net>
Message-ID: <nycvar.YFH.7.76.1810080705530.14430@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1810041335180.14430@cbobk.fhfr.pm> <20181007.203421.1496534902899406968.davem@davemloft.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Oct 2018, David Miller wrote:

> > From: Jiri Kosina <jkosina@suse.cz>
> > 
> > Commit 2276f58ac589 ("udp: use a separate rx queue for packet reception")
> > turned static inline __skb_recv_udp() from being a trivial helper around
> > __skb_recv_datagram() into a UDP specific implementaion, making it
> > EXPORT_SYMBOL_GPL() at the same time.
> > 
> > There are external modules that got broken by __skb_recv_udp() not being
> > visible to them. Let's unbreak them by making __skb_recv_udp EXPORT_SYMBOL().
> > 
> > Rationale (one of those) why this is actually "technically correct" thing 
> > to do: __skb_recv_udp() used to be an inline wrapper around 
> > __skb_recv_datagram(), which itself (still, and correctly so, I believe) 
> > is EXPORT_SYMBOL().
> > 
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Fixes: 2276f58ac589 ("udp: use a separate rx queue for packet reception")
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> Applied...

Thanks.

> But waiting from 4.13 until now to bring this up is really pushing it...

Well, we been hit by this in distro kernel that got 2276f58ac589 
backported only recently, so that's why.

Thanks again,

-- 
Jiri Kosina
SUSE Labs

