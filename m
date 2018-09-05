Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49A2C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824702075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XMc8oRU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824702075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeIEXaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:30:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeIEXaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YlEFUv56Ere+pdHVG1ynH+sN3J+NXfrV66vKvwxpCo8=; b=XMc8oRU3yyNqLrZH5WwumJXbO
        CwMsph9lJftwgtmzvwzM6URf1HKp4GhrmECAHNLml97Czlm3gBlmqpE4MmYnUMbwcufWMj+tsxP6n
        MC+mF+QtxgX5s9XYRxr9Lu2lSvhhLGd/G60h1/XApE9k51dqm/e0ijnOwIk5Hw8Zoj04mh7NgJ1LQ
        ZDCePA/u2/6h53amhLam7PGYTddwldLFMyReej3BupVSd1wPypehJVtLcjsUpj9T3vYu6QrCCqojA
        5YDgv9GPbpU+3RvFM81vobilJfsMARVK6vtuXglFi+l8UZ2M3nOg+/4SNcuSAHGhOOpjIBu5nLJ0X
        nzih5iwfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxd0g-0006HL-Q7; Wed, 05 Sep 2018 18:58:38 +0000
Date:   Wed, 5 Sep 2018 11:58:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [RFC PATCH 4/5] irqchip: RISC-V Local Interrupt Controller Driver
Message-ID: <20180905185838.GC15741@infradead.org>
References: <20180904124514.6290-1-anup@brainfault.org>
 <20180904124514.6290-5-anup@brainfault.org>
 <20180904185755.GD25119@infradead.org>
 <CAAhSdy3-mM-zyYOvQBR+JsRTZGZWUF=4Y=0jTKhVMAYPxOfJ6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy3-mM-zyYOvQBR+JsRTZGZWUF=4Y=0jTKhVMAYPxOfJ6Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 11:39:01AM +0530, Anup Patel wrote:
> Previously submitted driver, registered separate irq_domain for
> each CPU and local IRQs were registered as regular IRQs to IRQ
> subsystem.
> (Refer, https://www.spinics.net/lists/devicetree/msg241230.html)

And we reject that driver approach for good reason and are now
doing the architectualy low-level irq handling in common code
without any need whatsover to duplicate information in the
privileged spec in DT. 
