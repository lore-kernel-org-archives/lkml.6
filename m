Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF780C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB5D216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X+n0DCQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB5D216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeHHJ0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:26:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50082 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeHHJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0grWT2KLrJ+rSeyrW7mUDz2TF7fC+ZLsWAoO+0F9nNg=; b=X+n0DCQ+8ptfxchauedsxmAZx
        AMsGNv51ufyXLqIvB/plFDjymOtVbr23P5hiCV1OhiS5GQHSHbHspdDyBeHAw1Knxon5g9ERS7Ne/
        8HfrpjBsdwN+2Wp9vtxeg9+ftfldD2322JRVzqB6PyuM22Xh5YZoam8FJkw0BHcRfUQHBpq1r0t4c
        tGBwJd+lDk6wcqYCY5nKRZo52WlqFT476LilS5y196JcWHYahqyb90LmbS6/SRG65Ts5OPvfj7RuE
        fCyd9GIN24M1F6AFSgo4sWT+AG/7LxP+mYgyrVUPuN4QTY138PzerOPM/XBrWeAsNxkB11ZsFqrzn
        TSaHoyLrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnIZa-0007J9-Ou; Wed, 08 Aug 2018 07:07:58 +0000
Date:   Wed, 8 Aug 2018 00:07:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>,
        Vincent Chen <vincentc@andestech.com>,
        Zong Li <zong@andestech.com>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <greentime@andestech.com>
Subject: Re: [PATCH v4 4/5] Allow to disable FPU support
Message-ID: <20180808070758.GA27402@infradead.org>
References: <1533698685-18022-1-git-send-email-alankao@andestech.com>
 <1533698685-18022-5-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533698685-18022-5-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 11:24:44AM +0800, Alan Kao wrote:
> FPU codes have been separated from common part in previous patches.
> This patch add the CONFIG_FPU option and some stubs, so that a no-FPU
> configuration is allowed.
> 
> Signed-off-by: Alan Kao <alankao@andestech.com>
> Cc: Greentime Hu <greentime@andestech.com>
> Cc: Vincent Chen <vincentc@andestech.com>
> Cc: Zong Li <zong@andestech.com>
> Cc: Nick Hu <nickhu@andestech.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
