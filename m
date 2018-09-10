Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A0AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B062086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a6SSzBUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B062086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeIJSaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:30:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeIJSaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=88FOgxFtd7WX6v/k8eTG2EJvBzWVTb+VfX4xJEyDWH0=; b=a6SSzBUD4YrGZF1sWltotR9e+
        di93GZIDWeemTCE5GknD2+KDHUuTuTPOLv62JbC47mGsCx1W4035rwX6dBNgk2sIjBiJr7baXXOYg
        s8/fR6jNgpDjbm6bfPaCywXPq2XnLRC9StBQuevF8NVJ/Cz5Kz4sZl33o0rITO2Q1npegZ+n4DNui
        LMl7kUsYdHV3XBIGFWoI0ORUX1SLKuTVj7jJww5Mz0E9fl2rnvl3L3EK2qwj8keQHCcufAbsnPabr
        8FkymMqLvZfHQ/9OivCz0tGY3ioxgtJPDwvOesRfeElX0bNJc8v6zUwBMZRFSV7ceEcX5oG/Clpis
        eZwsIVAMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzMM1-0005Ud-PQ; Mon, 10 Sep 2018 13:35:49 +0000
Date:   Mon, 10 Sep 2018 06:35:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH 4/5] irqchip: RISC-V Local Interrupt Controller Driver
Message-ID: <20180910133549.GA15730@infradead.org>
References: <20180904124514.6290-1-anup@brainfault.org>
 <20180904124514.6290-5-anup@brainfault.org>
 <20180904185755.GD25119@infradead.org>
 <CAAhSdy3-mM-zyYOvQBR+JsRTZGZWUF=4Y=0jTKhVMAYPxOfJ6Q@mail.gmail.com>
 <20180905185838.GC15741@infradead.org>
 <CAAhSdy2B3RTYKTsm+HrJfsC3dP3vZyT0VYi80h3pDVUxDCONwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy2B3RTYKTsm+HrJfsC3dP3vZyT0VYi80h3pDVUxDCONwA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 05:23:07PM +0530, Anup Patel wrote:
> > And we reject that driver approach for good reason and are now
> > doing the architectualy low-level irq handling in common code
> > without any need whatsover to duplicate information in the
> > privileged spec in DT.
> 
> In other words, the whole idea of separate RISCV local interrupt
> controller driver was dropped due duplicate information in privilege
> spec DT ??

No.  We came to the conflusion that a few registers on a cpu
that allow enabling/disabling local vs external vs timer intterupts
aren't worth writing an irqchip (or DT entries) for.
