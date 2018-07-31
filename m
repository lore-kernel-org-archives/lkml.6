Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDE2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95697208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95697208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbeGaI6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:58:46 -0400
Received: from verein.lst.de ([213.95.11.211]:55976 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbeGaI6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:58:46 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D3A1B68D40; Tue, 31 Jul 2018 09:24:13 +0200 (CEST)
Date:   Tue, 31 Jul 2018 09:24:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Rich Felker <dalias@libc.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: use the generic dma-noncoherent code for sh V3
Message-ID: <20180731072413.GA22837@lst.de>
References: <20180725094043.32443-1-hch@lst.de> <877elcrlbe.wl-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877elcrlbe.wl-ysato@users.sourceforge.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 03:06:13PM +0900, Yoshinori Sato wrote:
> On Wed, 25 Jul 2018 18:40:38 +0900,
> Christoph Hellwig wrote:
> > 
> > Hi all,
> > 
> > can you review these patches to switch sh to use the generic
> > dma-noncoherent code?  All the requirements are in mainline already
> > and we've switched various architectures over to it already.
> > 
> > Changes since V2:
> >  - drop a now obsolete export
> > 
> > Changes since V1:
> >  - fixed two stupid compile errors and verified them using a local
> >    cross toolchain instead of the 0day buildbot
> 
> Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Do you want to pull this in through the sh tree?  If not I'd be happy
to take it through the dma mapping tree.
