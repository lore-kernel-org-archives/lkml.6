Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586BCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B562082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B562082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeK1SmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:42:01 -0500
Received: from verein.lst.de ([213.95.11.211]:35246 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbeK1SmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 13:42:01 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CAEDA68B02; Wed, 28 Nov 2018 08:41:17 +0100 (CET)
Date:   Wed, 28 Nov 2018 08:41:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux@armlinux.org.uk,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        xen-devel@lists.xenproject.org, robin.murphy@arm.com,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Message-ID: <20181128074117.GA21126@lst.de>
References: <20181122140320.24080-1-hch@lst.de> <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com> <20181122170715.GI30658@n2100.armlinux.org.uk> <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com> <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com> <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com> <20181123065511.GA17856@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123065511.GA17856@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 07:55:11AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 22, 2018 at 09:55:25AM -0800, Linus Torvalds wrote:
> > No, the big immediate benefit of allowing "return -EINVAL" etc is
> > simply legibility and error avoidance.
> 
> Well, I can tweak the last patch to return -EINVAL from dma_mapping_error
> instead of the old 1 is as bool true.  The callers should all be fine,
> although I'd have to audit them.  Still wouldn't help with being able to
> return different errors.

Any opinions?  I'd really like to make some forward progress on this
series.
