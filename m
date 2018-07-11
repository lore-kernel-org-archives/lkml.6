Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC976C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DCF20881
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jmCpiQAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DCF20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeGKG72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:59:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeGKG72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ePsF86RfBm9KlJk6HkO8sqsuPBV7pw/yT5/Pb12gx2Q=; b=jmCpiQATag3E6ZKwnA+yG3XCE
        qyrZ9/xJ1FUTfJHBlFNmi+HYZIRKx0kVuUZkV0DuhRn1LcBi8ZDAUClcN1Ay/+BKEaYp5BPRFv8AK
        pdD2vPVtJeI3Xzgdob5x/sESwHaf2MPvTaClEeZQtbyeWitP7rnJiD15Qi02VVoYi/c4uDXhssdB6
        c/R2fYvuF/CUHKJDMonZPMLXmQU29+nUwgehvHFoXEkrvlLgLipiXs/Owv3rA4UeX9Bh1UOGR4iSq
        U3AfSe3f7lqAg5rG2a34N2GibwDbJAO8JuO/V359f++5dsmm0Ecqqicj4CNqqprRlXuv3V9QZNwZr
        IrlQnKtEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fd939-0007vU-H0; Wed, 11 Jul 2018 06:56:31 +0000
Date:   Tue, 10 Jul 2018 23:56:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        okaya@codeaurora.org, chenhc@lemote.com,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated()
 method
Message-ID: <20180711065631.GA21948@infradead.org>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
 <20180709135713.8083-2-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709135713.8083-2-fancer.lancer@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> + * This is a MIPS specific ioremap variant. ioremap_cacheable_cow
> + * requests a cachable mapping with CWB attribute enabled.
>   */
>  #define ioremap_cacheable_cow(offset, size)				\
>  	__ioremap_mode((offset), (size), _CACHE_CACHABLE_COW)

This isn't actually used anywhere in the kernel tree.  Please remove it
as well.
