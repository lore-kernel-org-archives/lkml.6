Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B112DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71136208B6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71136208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbeHBD6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:58:06 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:55316 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732352AbeHBD6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:58:06 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1fl334-0007fE-00; Thu, 02 Aug 2018 02:09:06 +0000
Date:   Wed, 1 Aug 2018 22:09:06 -0400
From:   Rich Felker <dalias@libc.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: use the generic dma-noncoherent code for sh V3
Message-ID: <20180802020906.GK1392@brightrain.aerifal.cx>
References: <20180725094043.32443-1-hch@lst.de>
 <877elcrlbe.wl-ysato@users.sourceforge.jp>
 <20180731072413.GA22837@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731072413.GA22837@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 09:24:13AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 31, 2018 at 03:06:13PM +0900, Yoshinori Sato wrote:
> > On Wed, 25 Jul 2018 18:40:38 +0900,
> > Christoph Hellwig wrote:
> > > 
> > > Hi all,
> > > 
> > > can you review these patches to switch sh to use the generic
> > > dma-noncoherent code?  All the requirements are in mainline already
> > > and we've switched various architectures over to it already.
> > > 
> > > Changes since V2:
> > >  - drop a now obsolete export
> > > 
> > > Changes since V1:
> > >  - fixed two stupid compile errors and verified them using a local
> > >    cross toolchain instead of the 0day buildbot
> > 
> > Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
> Do you want to pull this in through the sh tree?  If not I'd be happy
> to take it through the dma mapping tree.

Usually I send the pull requests for sh tree, and I'm trying to figure
out which patches are okay to merge and prepare one now, but if you're
happy to take it through the dma mapping tree go ahead, and I'll focus
on other sh stuff that needs attention.

Rich
