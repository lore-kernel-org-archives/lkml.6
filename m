Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE182C71123
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 08:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFD620876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 08:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFD620876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeJNPy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 11:54:57 -0400
Received: from verein.lst.de ([213.95.11.211]:33878 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbeJNPy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 11:54:57 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B37CE68C73; Sun, 14 Oct 2018 10:14:43 +0200 (CEST)
Date:   Sun, 14 Oct 2018 10:14:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        tedheadster@gmail.com, konrad.wilk@oracle.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: enable swiotlb for > 4GiG ram on 32-bit kernels
Message-ID: <20181014081443.GA17889@lst.de>
References: <20181014075208.2715-1-hch@lst.de> <alpine.DEB.2.21.1810141012510.1438@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810141012510.1438@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 10:13:31AM +0200, Thomas Gleixner wrote:
> On Sun, 14 Oct 2018, Christoph Hellwig wrote:
> 
> > We already build the swiotlb code for 32b-t kernels with PAE support,
> > but the code to actually use swiotlb has only been enabled for 64-bit
> > kernel for an unknown reason.
> > 
> > Before Linux 4.18 we papers over this fact because the networking code,
> > the scsi layer and some random block drivers implenented their own
> > bounce buffering scheme.
> > 
> > Fixes: 21e07dba ("scsi: reduce use of block bounce buffers")
> > Fixes: ab74cfeb ("net: remove the PCI_DMA_BUS_IS_PHYS check in illegal_highdma")
> > Reported-by: tedheadster <tedheadster@gmail.com>
> > Tested-by: tedheadster <tedheadster@gmail.com>
> 
> I'll add your SOB when picking this up :)

Thanks.  Here it is in writing:

Signed-off-by: Christoph Hellwig <hch@lst.de>
