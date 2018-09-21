Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4BAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132A32150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A4A1Ccqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132A32150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389337AbeIUMri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:47:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUMri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SXrrmudpFEY0CDxWBUPK8TFtIMvkZ46ttZ+NXiSWn8M=; b=A4A1Ccqphodkpaq0lZtDq2y9h
        Q0cdZiVy3fpbHo+QZS8RhypmQKh2FKPcom3dWi/1qopkAFmfxe71p75xq4h92RR9YLJN614Bu0t22
        k8g9EcCKeVVY1p6/nVQMt5NWkyYDKaQEeiWGHOgPKGlqXf5jChXq+feUIN2abf9ViHm9ufpQ9ttpp
        +FI6BXctvP0gcKoYYAosMOCnuoyprG/GsJbQ0oiHmIxDBYIVp26lL8ixK59ANtVyiO8iQFMIMATQE
        GsyhVo5LBR7IV2QlMekJNsMhD/IuNWF05C7wk3snM5WTXTNT/5iL0ZGFuKpVYINR/EQWrzdsa6Kt3
        rmYatEIVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3FQ7-0004F5-3q; Fri, 21 Sep 2018 07:00:07 +0000
Date:   Fri, 21 Sep 2018 00:00:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zongbox@gmail.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, vincentc@andestech.com,
        zong@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] lib: Add umoddi3 and udivmoddi4 of GCC library
 routines
Message-ID: <20180921070006.GC8401@infradead.org>
References: <cover.1537260207.git.zongbox@gmail.com>
 <2ccc6c0758624dbb22f6fe451a3e476a000108ef.1537260207.git.zongbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ccc6c0758624dbb22f6fe451a3e476a000108ef.1537260207.git.zongbox@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 05:19:15PM +0800, Zong Li wrote:
> Add umoddi3 and udivmoddi4 support for 32-bit.

This probably wants a better explanation of why you need them.

> index 0000000..69f2d36
> --- /dev/null
> +++ b/lib/udivmoddi4.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0

Who wrote this code, where does it come from?
