Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4B8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35E320685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35E320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391793AbeKXGrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:47:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33938 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389203AbeKXGrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:47:15 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 952B214EA4729;
        Fri, 23 Nov 2018 12:01:32 -0800 (PST)
Date:   Fri, 23 Nov 2018 12:01:32 -0800 (PST)
Message-Id: <20181123.120132.2137332799436496001.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        brouer@redhat.com, pashinho1990@gmail.com, dsahern@gmail.com
Subject: Re: [PATCH net 2/2] virtio-net: fail XDP set if guest csum is
 negotiated
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181122063631.14452-2-jasowang@redhat.com>
References: <20181122063631.14452-1-jasowang@redhat.com>
        <20181122063631.14452-2-jasowang@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 23 Nov 2018 12:01:32 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Thu, 22 Nov 2018 14:36:31 +0800

> We don't support partial csumed packet since its metadata will be lost
> or incorrect during XDP processing. So fail the XDP set if guest_csum
> feature is negotiated.
> 
> Fixes: f600b6905015 ("virtio_net: Add XDP support")
> Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Pavel Popa <pashinho1990@gmail.com>
> Cc: David Ahern <dsahern@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable.

Same comments as for patch #1.
