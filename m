Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EC1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B2F2080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfBFPPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:15:08 -0500
Received: from verein.lst.de ([213.95.11.211]:60192 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729636AbfBFPPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:15:07 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 111A568D93; Wed,  6 Feb 2019 16:15:06 +0100 (CET)
Date:   Wed, 6 Feb 2019 16:15:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Christoph Hellwig <hch@lst.de>, Olof Johansson <olof@lixom.net>,
        linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20190206151505.GA31065@lst.de>
References: <20190129163415.GA14529@lst.de> <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de> <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de> <20190201080456.GA15456@lst.de> <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de> <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de> <20190204075616.GA5408@lst.de> <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de> <20190204123852.GA10428@lst.de> <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 02:45:34PM +0100, Christian Zigotzky wrote:
> I patched the source code from the Git 'powerpc-dma.6' with your patch 
> today. Unfortunately the P.A. Semi Ethernet doesn't work with the patched 
> Git kernel.
>
> After that I tried it with the patch applied over the working setup again 
> (powerpc/dma: use the dma_direct mapping routines). Unfortunately after 
> compiling
> and booting, the P.A. Semi Ethernet doesn't work either.

The last good one was 29e7e2287e196f48fe5d2a6e017617723ea979bf
("dma-direct: we might need GFP_DMA for 32-bit dma masks"), if I
remember correctly.  powerpc/dma: use the dma_direct mapping routines
was the one that you said makes the pasemi ethernet stop working.

Can you post the dmesg from the failing runs?
