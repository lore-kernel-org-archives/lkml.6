Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C72FC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 07:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DF724B4E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 07:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z3JvS20i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DF724B4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeFWHZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 03:25:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbeFWHZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 03:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j/32hBfwoG/ReT1LmHOqUc31NGnV8GhMIDUVI7fSjcY=; b=Z3JvS20iSQyTdv7EGgcYINUmW
        ETeYsvgXxZNwlQr/o6Pz5pSbKFLdS4cQamgvJq0sersEgt4i7g3/cK9d4lfjn0aPrUwunL5F7nDej
        /o/xGkjQ2xtYuZVnsV7/jGPo72wBgXRu2Vo06i1UbdToKboe70c3KfKFHJByxANCSsvq9KaC7i1ml
        Vn19Q9aTsRg0+mjHMDKJBdPh+yOAKTfoxmzPkOyxa5ZZ+5si18JXBJNWNz+k+XSbpojnSgBDn/QP0
        kzhgbsS0DgFTvYyFUcnyBmkqx+hEm6dKADHMszi6gi4LBL2JYafbHMyDqV+A1DhcJyiFkzjYICttX
        uosxcn9Zg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWcv2-0007LR-H7; Sat, 23 Jun 2018 07:25:12 +0000
Date:   Sat, 23 Jun 2018 00:25:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: Re: [PATCH 1/3] RISC-V: Don't include irq-riscv-intc.h
Message-ID: <20180623072512.GB25573@infradead.org>
References: <20180622232006.12158-1-palmer@sifive.com>
 <20180622232006.12158-2-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622232006.12158-2-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 04:20:04PM -0700, Palmer Dabbelt wrote:
> This file has never existed in the upstream kernel, but it's guarded by
> an #ifdef that's also never existed in the upstream kernel.  As a part
> of our interrupt controller refactoring this header is no longer
> necessary, but this reference managed to sneak in anyway.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
