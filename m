Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78794C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9AB208DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9AB208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeHBJAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:00:33 -0400
Received: from verein.lst.de ([213.95.11.211]:38221 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbeHBJAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:00:32 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3E51A68D64; Thu,  2 Aug 2018 09:15:25 +0200 (CEST)
Date:   Thu, 2 Aug 2018 09:15:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rich Felker <dalias@libc.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: use the generic dma-noncoherent code for sh V3
Message-ID: <20180802071525.GA11643@lst.de>
References: <20180725094043.32443-1-hch@lst.de> <877elcrlbe.wl-ysato@users.sourceforge.jp> <20180731072413.GA22837@lst.de> <20180802020906.GK1392@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802020906.GK1392@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 10:09:06PM -0400, Rich Felker wrote:
> On Tue, Jul 31, 2018 at 09:24:13AM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 31, 2018 at 03:06:13PM +0900, Yoshinori Sato wrote:
> > > On Wed, 25 Jul 2018 18:40:38 +0900,
> > > Christoph Hellwig wrote:
> > > > 
> > > > Hi all,
> > > > 
> > > > can you review these patches to switch sh to use the generic
> > > > dma-noncoherent code?  All the requirements are in mainline already
> > > > and we've switched various architectures over to it already.
> > > > 
> > > > Changes since V2:
> > > >  - drop a now obsolete export
> > > > 
> > > > Changes since V1:
> > > >  - fixed two stupid compile errors and verified them using a local
> > > >    cross toolchain instead of the 0day buildbot
> > > 
> > > Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > 
> > Do you want to pull this in through the sh tree?  If not I'd be happy
> > to take it through the dma mapping tree.
> 
> Usually I send the pull requests for sh tree, and I'm trying to figure
> out which patches are okay to merge and prepare one now, but if you're
> happy to take it through the dma mapping tree go ahead, and I'll focus
> on other sh stuff that needs attention.

I'd love to take it through the dma mapping tree and save you some work!
