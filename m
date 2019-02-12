Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4718DC4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183EE2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aXhpJokx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfBLHNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:13:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfBLHNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i9LiTwoHB7wiaMPBTlIeMEVB3AZ/nu1Ha+0496P9Xhw=; b=aXhpJokxKTjHvTenT6G5Sxflt
        crVl4dCRJhO2qySfODgiHnBlCXPBeurSoLChoqtBbinIbJL571iZVHu8N7iAYV7u25pMGxtsfKL0z
        hqlBofz9aq5YdrOtO+vFesTrbvB54ZcitMKucTYR/7cLD57QegBf6/ecR8xwhqMORzQTCes983c5g
        QLZTDf4G1ZmECbiiOxzTP5MzA/OaTI96Gskn41i69yvUkCqxgUqEzNqJw5hkJWWdY2iCE2KQxj5SP
        ClhkEm0LLrvaBZUKJTg9MgbY6MwdOTjanlrP4YBhEafEw3Niacara3Gdp4VPp75dgy0wuu074P2o5
        clwgtjuYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSGB-0003Dv-PZ; Tue, 12 Feb 2019 07:13:39 +0000
Date:   Mon, 11 Feb 2019 23:13:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 5/5] riscv: use for_each_of_cpu_node iterator
Message-ID: <20190212071339.GL26747@infradead.org>
References: <20190118140308.9599-1-johan@kernel.org>
 <20190118140308.9599-6-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118140308.9599-6-johan@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 03:03:08PM +0100, Johan Hovold wrote:
> Use the new for_each_of_cpu_node() helper to iterate over cpu nodes
> instead of open coding. Note that this will allow matching also on the
> node name instead of the (for FDT) deprecated device_type property.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

I think this is going to conflict with the ELF caps changes from
Atish.  Maybe the riscv_fill_hwcap hunk should be included in his
patch?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
