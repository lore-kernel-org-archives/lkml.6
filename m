Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7790ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC7F2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZXAslM5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC7F2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389332AbeIUMqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:46:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeIUMqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V/Jiw7Wd5UF5WPKYXXWC+1p3CCdMtU2tvRrmQ63tCj0=; b=ZXAslM5CG/BaeMN6yhZkjLRbd
        l+oorDuGuXmMnExfYo+Y0egtAonvYP1j7Yt9MhkcV3+4GQdaqJeS+AqYdtMHfwQLXwpK1RZwZ35/v
        rSm+OrgxQQUBU8FIIuJp2+1aUwYG0NRq3CmuEVld3Go3thK3FE15DMJ7/Mn+nRO9z/ej1/TXHvinu
        O3wum+nLh6ClumRGrXr9mbWMLIxq7v0SO1CXgWI2+D26IrNlU+b2xHdR3yHJsrodJMsqPIxXGHRu9
        dYaphkS0HrEoFLXM9M1n0phdKKFggCJveqOXtCyzATaaufb0speo8ZotUBGmY9eNGJj2tvW6k1ss+
        Uo8iUb94g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3FP2-0003si-DR; Fri, 21 Sep 2018 06:59:00 +0000
Date:   Thu, 20 Sep 2018 23:59:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zongbox@gmail.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, vincentc@andestech.com,
        zong@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] RISC-V: Use swiotlb on RV64 only
Message-ID: <20180921065900.GB8401@infradead.org>
References: <cover.1537260207.git.zongbox@gmail.com>
 <b9b943c21725db9822a787a1e985010012fc33b2.1537260207.git.zongbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b943c21725db9822a787a1e985010012fc33b2.1537260207.git.zongbox@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 05:19:14PM +0800, Zong Li wrote:
> Only RV64 supports swiotlb.
> 
> Signed-off-by: Zong Li <zong@andestech.com>

Reviewed-by: Christoph Hellwig <hch@lst.de>
