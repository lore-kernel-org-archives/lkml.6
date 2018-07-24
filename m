Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3736ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BF120874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BF120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbeGXMqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:46:10 -0400
Received: from verein.lst.de ([213.95.11.211]:54309 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388196AbeGXMqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:46:10 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 969B468D64; Tue, 24 Jul 2018 13:43:34 +0200 (CEST)
Date:   Tue, 24 Jul 2018 13:43:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@intel.com
Subject: Re: [PATCH 4/5] sh: split arch/sh/mm/consistent.c
Message-ID: <20180724114334.GA21973@lst.de>
References: <20180719130516.1989-1-hch@lst.de> <20180719130516.1989-5-hch@lst.de> <20180723084207.GI6784@w540> <CAMuHMdX=b0iAnDw1=85MXNBSMD=MxZb27QrO3rEWHYq0vB+3ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX=b0iAnDw1=85MXNBSMD=MxZb27QrO3rEWHYq0vB+3ow@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:49:39AM +0200, Geert Uytterhoeven wrote:
> > > +     *dma_handle = virt_to_phys(ret);
> > > +     if (!WARN_ON(!dev))
> > > +             *dma_handle - PFN_PHYS(dev->dma_pfn_offset);
> > vs
> > > -     *dma_handle = virt_to_phys(ret);
> > > -     if (!WARN_ON(!dev))
> > > -             *dma_handle -= PFN_PHYS(dev->dma_pfn_offset);
> 
> Doesn't look right to me, neither.
> 
> No complaints for 0day? My gcc says:
> 
>     error: statement with no effect [-Werror=unused-value]

For some reason 0day has failed me multiple times for sh.  Does the
0day bot even cover sh at all?
