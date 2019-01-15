Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED30CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1C120651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eqygyFcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfAONoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:44:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729963AbfAONoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H4wzN/RJ7UmYF0eGturJ5/1+AbHr5lQ7DZtosg/VsbY=; b=eqygyFcNDmxYRDRvioz/I948u
        DqIgevm77PbCrZd/bKebmz8jrP63rD38YJaJzKZ0i03SuANxgFqa2fNLIP2kYndE342PgHNH4O7MT
        /3QkVr5TzgycoFtMAdPQB1+LdYSeIwLCTOyTqVgQz4R5hphI3RagCPnROGClviKkToiRej+BooTZ4
        iCDe93WcXTRK5ZMOLH4sFaupqZ3l7HIAehi5MgVViGtiavfVHkHhgMzegDj9U41OvWiKz+rQDBBeo
        PW5t7iciC33ndnXdhWa3CLZElJNHIZJMvH4by96AN/vXlsyctSKkFBHrXwVoEGpa+UZEolk3puVGX
        ttt2chjKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjP0k-0005n9-DI; Tue, 15 Jan 2019 13:44:10 +0000
Date:   Tue, 15 Jan 2019 05:44:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/5] RISC-V: Setup init_mm before parse_early_param()
Message-ID: <20190115134410.GC13216@infradead.org>
References: <20190107161047.10516-1-anup@brainfault.org>
 <20190107161047.10516-3-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107161047.10516-3-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 09:40:44PM +0530, Anup Patel wrote:
> From: Anup Patel <anup.patel@wdc.com>
> 
> We should setup init_mm before doing parse_early_param()
> in setup_arch() to be consistent with setup_arch() of
> other architectures such as x86, ARM, and ARM64.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Is there any good inherent reason why the order matters?  Not that I
really care either way..
