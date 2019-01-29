Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1CDC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4DF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfA2QeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:34:17 -0500
Received: from verein.lst.de ([213.95.11.211]:47166 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbfA2QeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:34:16 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 65E9768CEC; Tue, 29 Jan 2019 17:34:15 +0100 (CET)
Date:   Tue, 29 Jan 2019 17:34:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20190129163415.GA14529@lst.de>
References: <20190119140452.GA25198@lst.de> <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de> <8434e281-eb85-51d9-106f-f4faa559e89c@xenosoft.de> <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de> <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de> <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de> <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de> <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de> <20190129161411.GA14022@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129161411.GA14022@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 05:14:11PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 29, 2019 at 04:03:32PM +0100, Christian Zigotzky wrote:
> > Hi Christoph,
> >
> > I compiled kernels for the X5000 and X1000 from your new branch 
> > 'powerpc-dma.6-debug.2' today. The kernels boot and the P.A. Semi Ethernet 
> > works!
> 
> Thanks for testing!  I'll prepare a new series that adds the other
> patches on top of this one.

And that was easier than I thought - we just had a few patches left
in powerpc-dma.6, so I've rebased that branch on top of
powerpc-dma.6-debug.2:

    git://git.infradead.org/users/hch/misc.git powerpc-dma.6

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6

I hope the other patches are simple enough, so just testing the full
branch checkout should be fine for now.
