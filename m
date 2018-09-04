Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF01BC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957BF2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TbWHda76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957BF2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeIDXQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:16:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDXQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vX60jJy+cDsoSud9ZqUJ+zhKyuSgUijOmKfSLgTME2o=; b=TbWHda765oPPRFvV9Q68mbtnq
        pZCiHi9wtP8q4kTXCe1Xa7XVAEtlaHXI1OzWV+uHI1qmJuAumtcAMt0Csw0W+dXu2j17h9o1nO0Df
        BH1rLOHaZvTJgg3kGYva+wxYkVKAuBsmA26+wEXx8t/wqJcPdnoYXhj5CPQS8XPZc7QU5DG5e1+S1
        aM1m/YqZLaywB3597CJl/aznOel39AcvHW8Hsy90JH39CzUcoAd3IX8pUKehF4PbZ4MAceqj23Goh
        KvMIIiLFJx1gMqLldIRIiFGVUa+lltcF4MRHBA9nkrw+IMm04bGYjLJDzzKav0k/BWkatvX95O9eY
        8aEC/uflQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxGP9-0007sK-4z; Tue, 04 Sep 2018 18:50:23 +0000
Date:   Tue, 4 Sep 2018 11:50:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] RISC-V: No need to pass scause as arg to do_IRQ()
Message-ID: <20180904185022.GB25119@infradead.org>
References: <20180904124514.6290-1-anup@brainfault.org>
 <20180904124514.6290-3-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904124514.6290-3-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 06:15:11PM +0530, Anup Patel wrote:
> The scause is already part of pt_regs so no need to pass
> scause as separate arg to do_IRQ().
> 
> Signed-off-by: Anup Patel <anup@brainfault.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
