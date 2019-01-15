Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5067C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AC420868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QOIoo3ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfAOPgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:36:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbfAOPgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=QOIoo3aegLc0rwJmcNn8m1995
        TAOokrue9dySY2H93GVMe/zs5nZwbbHFBVTEfCUMBBZRLhBrbkykKoG+AJBKT7kSjtJExAkCFC6yl
        UGgKPvcRiZC8DAyXJZkDCOl2pUJxr8GWnhklyrFNsaK2l638x3H5nrGMFJS8KikS8+3e6OIQezhgk
        7JZg0hWVw++HNjACg/wI/V6t1I39+9/qlcapjpgab6n0YUNo/s1AZ3EMtSxwsg66QwmDp8YL1obuw
        p4hp/Grd4KiiFWidHwZFde3Vs9SerAqu4X/erdRM9DSG5Fc7lU/PKz/CH6iFR60pqQpGGoXWTjSQR
        lMvz+6G4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjQlo-0003e3-6w; Tue, 15 Jan 2019 15:36:52 +0000
Date:   Tue, 15 Jan 2019 07:36:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        linux-m68k@lists.linux-m68k.org,
        linux-mediatek@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/9] riscv/vdso: don't clear PG_reserved
Message-ID: <20190115153652.GD26443@infradead.org>
References: <20190114125903.24845-1-david@redhat.com>
 <20190114125903.24845-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114125903.24845-5-david@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
