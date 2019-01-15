Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0378C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8C320675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cCnvMjzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbfAORwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:52:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbfAORw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ITJoVz+hDVQxBL7bPP0lb4AXLrlKIC+jOg6UU8bME/w=; b=cCnvMjzLSicV8PhPswJ4N9ofq
        6ySM6/WGmOpl8O20jCDv/lPn//iBZx1hUUQYEaPKOezhgw7M95Mu5CL7KyVbXionA5unv3fNBhBKF
        7pOFKOIzJmrnoZGsq91jgk2QZylgJv+01DKTEVmfuEf4rQqdcYLSvzEbUnKEyv6QHNxpP6nSj+aJr
        bQ+KlHyyO9k/qXJcN9WmdBnvSRyYMqxrQC1ukDOAcP+Gwa7KCVR/ovrLrxbrwmg7Y7qXRWbbcHJXK
        u2umN7PDL7ORWSNgmRGk+6sgUsZWqm0LW94zoldBNNL3g1hGWEW9hfMCOOFL0OTUOZyENPISke0UF
        Bghur0oLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjSt2-0002Rb-RM; Tue, 15 Jan 2019 17:52:28 +0000
Date:   Tue, 15 Jan 2019 09:52:28 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Alistair Francis <Alistair.Francis@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] RISC-V: defconfig: Enable Generic PCIE by default
Message-ID: <20190115175228.GA9295@infradead.org>
References: <20190112004117.28265-1-alistair.francis@wdc.com>
 <20190115152607.GA26443@infradead.org>
 <03cbc37636be7fce21cd2af39ad8e322ca8e64e8.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03cbc37636be7fce21cd2af39ad8e322ca8e64e8.camel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 05:45:34PM +0000, Alistair Francis wrote:
> > Alistair, is there a ready-made qemu machine with riscv + pcie?
> > That would be really useful for testing..
> 
> Yep, if you use master QEMU (it isn't in a release yet) the virt
> machine has PCIe support.

Cool.  Time to play around with the latest qemu tree..
