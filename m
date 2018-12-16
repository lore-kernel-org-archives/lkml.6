Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F30C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2442084A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbeLPUlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 15:41:22 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48124 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeLPUlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 15:41:22 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2CF7A14EF614A;
        Sun, 16 Dec 2018 12:41:21 -0800 (PST)
Date:   Sun, 16 Dec 2018 12:41:20 -0800 (PST)
Message-Id: <20181216.124120.731491122771817496.davem@davemloft.net>
To:     mw@semihalf.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux@armlinux.org.uk,
        maxime.chevallier@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, antoine.tenart@bootlin.com,
        stefanc@marvell.com, nadavh@marvell.com, jaz@semihalf.com
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1544533009-12425-1-git-send-email-mw@semihalf.com>
References: <1544533009-12425-1-git-send-email-mw@semihalf.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 16 Dec 2018 12:41:21 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcin Wojtas <mw@semihalf.com>
Date: Tue, 11 Dec 2018 13:56:49 +0100

> Recent changes in the mvneta driver reworked allocation
> and handling of the ingress buffers to use entire pages.
> Apart from that in SW BM scenario the HW must be informed
> via PRXDQS about the biggest possible incoming buffer
> that can be propagated by RX descriptors.
> 
> The BufferSize field was filled according to the MTU-dependent
> pkt_size value. Later change to PAGE_SIZE broke RX operation
> when usin 64K pages, as the field is simply too small.
> 
> This patch conditionally limits the value passed to the BufferSize
> of the PRXDQS register, depending on the PAGE_SIZE used.
> On the occasion remove now unused frag_size field of the mvneta_port
> structure.
> 
> Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

The discussion died on this, but the bug should be fixed.

So in the short term I am applying this and queueing it up for v4.19
-stable.

Thanks.
