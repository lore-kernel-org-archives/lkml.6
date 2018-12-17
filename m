Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3D4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B18F20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WbTAbZmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbeLQSZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:25:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeLQSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3gnHnu/b7X8Z/EqkilLx4vCcIK24VR9A6tqq49rKRGU=; b=WbTAbZmyXpc17Hx3eTWkRkWP0
        eUXe63grA4wO6KU6DZPKonkqAq4jj6WDcLYpfUKWhT1YiUIOxB/fdB0ZXyCzvaYNWUiBoWsQDFQBv
        EN6SxsauVDt6oH8F0jYaOANoosugcsH1apQuQIMMNC7DL/UJNIfnndpt5N+xpkNKUMe15LsQSMwGs
        xfUl0M6Offaf7NnXuz/XOFEKupAZOmsuCcnO1xPn7dKIqgKCL2jLvW3LaINxtTIAcMpKiQgNqyjJw
        zvcdPgyl3wRfT+C6cWJSxKa5B/e0qbwUObfSvWpp8Akg5Cp2+Oj+GGImxW6qjAQ4ANkzVkpWrLeks
        +d1B5zDqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYxZw-0003iV-Ar; Mon, 17 Dec 2018 18:25:20 +0000
Date:   Mon, 17 Dec 2018 10:25:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] irqchip: sifive-plic: Pre-compute context hart
 base and enable base
Message-ID: <20181217182520.GB7086@infradead.org>
References: <20181130080207.20505-1-anup@brainfault.org>
 <20181130080207.20505-2-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130080207.20505-2-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 01:32:02PM +0530, Anup Patel wrote:
> This patch does following optimizations:
> 1. Pre-compute hart base for each context handler
> 2. Pre-compute enable base for each context handler
> 3. Have enable lock for each context handler instead
> of global plic_toggle_lock

All of which is pretty obvious from reading the patch.  The big question
that needs to be answered in the changelog is why you do that.
