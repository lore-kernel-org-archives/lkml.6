Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CD1C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465752082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="stj32mac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465752082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeJBVbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:31:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbeJBVbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=stj32macxeMuC66wLps34OGwv
        6HDes8quQwxO9juluipoDxWQbeo1wX6gSdvEiPc9dGp6x/Edxp5g/TcjXy2QsjUBp3dOePtA3bTWq
        SmAJOd646WA1perPPL8Qm2GZ+VdQZ6jVt6LvHFOTZclX0gsHgZ6XKxcgEGiHmxv/B9t8XejqOsrd+
        YIHr5iNnS0pniehWQVRGnIYLaFy4QYrq4y9zQofxE7QFwknANjMm2Ff8HV0nf9UDIbc2piEHk9roo
        CglmSnDEiuWKRM1bII3Halb2uNy63928UmOR72jJiMxEHVPz6ffjTmJulbUsImygZ+/cbc/v9M9ej
        JcCfP3IjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7LxS-00014H-D8; Tue, 02 Oct 2018 14:47:30 +0000
Date:   Tue, 2 Oct 2018 07:47:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zongbox@gmail.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, hch@infradead.org,
        zong@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] RISC-V: Use swiotlb on RV64 only
Message-ID: <20181002144730.GB3889@infradead.org>
References: <cover.1538470103.git.zongbox@gmail.com>
 <a2ae9d4b7cd1d97cafe8161ec28f46e4a7968776.1538470103.git.zongbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2ae9d4b7cd1d97cafe8161ec28f46e4a7968776.1538470103.git.zongbox@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
