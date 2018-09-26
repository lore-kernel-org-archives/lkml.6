Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31549C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAFD214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KM33zOJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAFD214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeIZUZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:25:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbeIZUZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hZ52ygBMlFoD8bPvzFpyWVqrCC2R1SvadCEhHpo+XMU=; b=KM33zOJ72m1oKPSTq80xIo9xD
        YoH186K780QYxR8125SpLM9M7UmQnEYntWAF80VgJqtgN9TO4V9ZB3kaFkYpKvjDr5HYimUxVmo92
        xy1njRPYwgImRyd9dELMhT0azJrYrX/5mHUFsf0YfCD/qvD4VYy+/FmK+VHd7BOHKpdQGB6yRO8TX
        mjRpeeWNvEMtFOPqlXm+4LIWL6ZG6nQpJ3tjQR5HzvxMFuO3AHdpazGEfSzxQASBuBIHwyK/iICcu
        4mIjCCWVjLJ9CdbmaYPZyhuwItMNr2e+I5NBHUNV22/s/jbbrUxMdleRwus17f/WvFDmKZGMv/q97
        YBWEqBlJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5AXn-0007kS-Tl; Wed, 26 Sep 2018 14:11:59 +0000
Date:   Wed, 26 Sep 2018 07:11:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zongbox@gmail.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, hch@infradead.org,
        zong@andestech.com, vincentc@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] lib: Add umoddi3 and udivmoddi4 of GCC library
 routines
Message-ID: <20180926141159.GA28142@infradead.org>
References: <cover.1537949825.git.zongbox@gmail.com>
 <7a24493868f29559a1628eed44af15dc10a9940a.1537949825.git.zongbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a24493868f29559a1628eed44af15dc10a9940a.1537949825.git.zongbox@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 04:31:12PM +0800, Zong Li wrote:
> diff --git a/lib/udivmoddi4.c b/lib/udivmoddi4.c
> new file mode 100644
> index 0000000..6518b3a
> --- /dev/null
> +++ b/lib/udivmoddi4.c
> @@ -0,0 +1,309 @@

needs and SPDX tag.

> +/*
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 3, or (at your option) any later
> + * version.

We can't take GPLv3 code for the kernel.

> + * Under Section 7 of GPL version 3, you are granted additional
> + * permissions described in the GCC Runtime Library Exception, version
> + * 3.1, as published by the Free Software Foundation.
> + *
> + * You should have received a copy of the GNU General Public License and
> + * a copy of the GCC Runtime Library Exception along with this program;
> + * see the files COPYING3 and COPYING.RUNTIME respectively.

unless this exception somehow counts (which I doubt), but for that we'd
actually need it in the tree.
