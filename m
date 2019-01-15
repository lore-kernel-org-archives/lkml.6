Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73699C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3398720645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y7YLEHGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfAOPo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:44:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfAOPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e1aFnV3+AHjLIb3Cl49Jvjsz6oEkrBHz280IMDNEfiE=; b=Y7YLEHGVL0d+HG8AbXeTq/v2m
        ZDbbxEn9Vx61wxgklriGHYq89BXEeUwVDPsVzS3ov/rw8QEay0gM+Ol/Xshbqw4bgVFSMc6k+5cWd
        lFoa8kRB4tTvbDxJvRyOadNn5AG7aF8d5Vorf0CnwCRZcnjNWwJMNltefU/GuL79yBhFZsp5svaBf
        2fy5Ib+qanSjiuDM7g9BeLK45gdP6J2nYn4l1hJheMp9PhjyyAAr0kRi+Czu5QFFK13e+Y1R3oT7Y
        Q1Gc3O/2MpbEh7sNJPMeX9jD2fT+EOScwJeV3O8oVX83E8FEF8fUB6cQ573ZTuCL6+YA/BKbZLJb9
        Km51MH+Bw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjQtb-0008GG-6Z; Tue, 15 Jan 2019 15:44:55 +0000
Date:   Tue, 15 Jan 2019 07:44:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@pwsan.com, palmer@sifive.com, aou@eecs.berkeley.edu
Subject: Re: [PATCH] arch: riscv: support kernel command line forcing when no
 DTB passed
Message-ID: <20190115154455.GA29629@infradead.org>
References: <alpine.DEB.2.21.9999.1812171913510.29609@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1812171913510.29609@viisi.sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 07:15:12PM -0800, Paul Walmsley wrote:
> 
> CONFIG_CMDLINE_FORCE doesn't work on RISC-V when no DTB is passed into
> the kernel.  This is because the code that forces the kernel command
> line only runs if a valid DTB is present at boot.  During debugging,
> it's useful to have the ability to force kernel command lines even
> when no DTB is present.  This patch adds support for doing so.

This looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

I just wish all this command line magic could be moved to common
code somewhere instead of being reinvented badly in every port..
