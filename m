Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9E6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139E821773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="faJjU0r1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfBLHF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:05:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfBLHF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7u9xjmOMAuk27iPJmPyFoypju05cfybxJz2gEHJlVV4=; b=faJjU0r1Wltmsj8vgU7rajLrj
        VPYlZfB/UxLS7RXF0bPKdNsb5SS9mZThybJzmHrTnWYe5QswJnuhwINYtgi6ZaPRfcbibb1KWIkTB
        lVYqs/X/TzlHByFThh8FTEuvAuOpZ21JZUrbVsAcaI5EG2g8jOgoqqZe9gYYEGVEtkfa+iwrGtu1f
        KbRb37gOAktc8Muw1Mb18yKu7kd/q7V99GifrIz6R+geE3wEUuKRAP1SCCCGrZkD69T/+RToOpb09
        X8mZQPpy3KyxYaCxajZBsm3rWaO+PnlvwkWbMiFmhyTUbhkAsAPuuKYmiwDuDno42tWC7lhXZVYvr
        519XPUC3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtS8j-0000Ba-OY; Tue, 12 Feb 2019 07:05:57 +0000
Date:   Mon, 11 Feb 2019 23:05:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 2/6] RISC-V: Setup init_mm before parse_early_param()
Message-ID: <20190212070557.GB26747@infradead.org>
References: <20190119132650.9978-1-anup.patel@wdc.com>
 <20190119132650.9978-3-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119132650.9978-3-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 01:28:07PM +0000, Anup Patel wrote:
> We should setup init_mm before doing parse_early_param()
> in setup_arch() to be consistent with setup_arch() of
> other architectures such as x86, ARM, and ARM64.

Please use up all 72 lines in all your commit logs..

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
