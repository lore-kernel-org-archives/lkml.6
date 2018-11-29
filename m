Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83EAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B5D2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B5D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeK3EJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:09:06 -0500
Received: from verein.lst.de ([213.95.11.211]:44733 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729818AbeK3EJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:09:06 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7C1EC68B02; Thu, 29 Nov 2018 18:03:02 +0100 (CET)
Date:   Thu, 29 Nov 2018 18:03:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181129170302.GB27951@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de> <87zhttfonk.fsf@concordia.ellerman.id.au> <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de> <20181128213510.543259e3@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128213510.543259e3@kitsune.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Please don't apply the new DMA mapping code if you don't be sure if it 
> > works on all supported PowerPC machines. Is the new DMA mapping code 
> > really necessary? It's not really nice, to rewrote code if the old code 
> > works perfect. We must not forget, that we work for the end users. Does 
> > the end user have advantages with this new code? Is it faster? The old 
> > code works without any problems. 
> 
> There is another service provided to the users as well: new code that is
> cleaner and simpler which allows easier bug fixes and new features.
> Without being familiar with the DMA mapping code I cannot really say if
> that's the case here.

Yes, the main point is to move all architecturs to common code for the
dma direct mapping code.  This means we have one code bases that sees
bugs fixed and features introduced the same way for everyone.
