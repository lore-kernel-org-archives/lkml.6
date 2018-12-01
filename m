Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CAFC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBC120867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBC120867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeLAMhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:37:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37012 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeLAMhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:37:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 37F5E14F2407F;
        Fri, 30 Nov 2018 17:25:47 -0800 (PST)
Date:   Fri, 30 Nov 2018 17:25:46 -0800 (PST)
Message-Id: <20181130.172546.127269245503154590.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: keep vnet header zeroed after
 processing XDP
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181129055316.24090-1-jasowang@redhat.com>
References: <20181129055316.24090-1-jasowang@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 30 Nov 2018 17:25:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Nov 2018 13:53:16 +0800

> We copy vnet header unconditionally in page_to_skb() this is wrong
> since XDP may modify the packet data. So let's keep a zeroed vnet
> header for not confusing the conversion between vnet header and skb
> metadata.
> 
> In the future, we should able to detect whether or not the packet was
> modified and keep using the vnet header when packet was not touched.
> 
> Fixes: f600b6905015 ("virtio_net: Add XDP support")
> Reported-by: Pavel Popa <pashinho1990@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable, thanks.
