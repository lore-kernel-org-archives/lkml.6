Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0B0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5947B2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iO3WJPBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfBLHIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:08:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfBLHIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ku2VCrQiE+4GyFWV3Mm1fZsGmsZAL6FugjgOnoFb5UA=; b=iO3WJPBxaQWGqY7JarPwU0luA
        NCA77ivsRivD4EZBskLVyriOi7C8iXt1t22++R2LV7olv4xPVhI1xtaHFMbV92Xgobv22W6ic6KHo
        5Eu68XMWKnBr3Spo5Dz8NUVHObnOuKQ2cjIIVF2YWeGwygTVp8dqCIMpVT9xz03yyulS/XSgVdoom
        PCaC0+HZ3WCiUamA8ZVQOwESE0QYg03e3p1F+45g2bYj+m9BOpvULiJk4q3d+JWt0Dt4ufKzu9df0
        IBhn0RXJ3INuUiU0Rc8NQW6GG+Bu3GQczfi7RJdJ9STG97nQ95mSIGTK9itgFEw1jqhoNDK/YXhjh
        lcrqzlOZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSAq-0000xf-11; Tue, 12 Feb 2019 07:08:08 +0000
Date:   Mon, 11 Feb 2019 23:08:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 6/6] RISC-V: Implement keepinitrd kernel parameter
Message-ID: <20190212070807.GD26747@infradead.org>
References: <20190119132650.9978-1-anup.patel@wdc.com>
 <20190119132650.9978-7-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119132650.9978-7-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 01:28:59PM +0000, Anup Patel wrote:
> This patch implements keepinitrd kernel parameter. By default,
> keepinitrd=1 but users can pass "keepinitrd=0" to free-up
> initrd memory at boot-time in free_initrd_mem() function.
> 
> The keepinitrd kernel parameter is already implemented by
> unicore32, arm, and arm64 architectures and it is documented
> at: Documentation/admin-guide/kernel-parameters.txt

But why do we need it?  Is there any good reason every not to free
the initrd / initramfs memory when it is not used?
