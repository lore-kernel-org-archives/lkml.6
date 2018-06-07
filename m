Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AbjIF0fBGFtNOQAAmS7hNA
	; Thu, 07 Jun 2018 05:23:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 418266089E; Thu,  7 Jun 2018 05:23:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lUOUn2Ti"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B4BC3607DC;
	Thu,  7 Jun 2018 05:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4BC3607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeFGFXQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:23:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbeFGFXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RZXZY+4rj4BEEYNsmnXTpAWyjOzgQ+7CB2K7br57A9Y=; b=lUOUn2TiDAlcI5m/z+VieR/O8
        oxj6wR0ARwC/MDj/QQm1FFelDLQwF6Lg4cP4KHQIW0COdcGQgho+A0l5ZAhljsIdb+7tZKxbvOGg9
        5ivSkoyWSzxH/NcAJI8T/b2rT/S3qgCbio0oxNFRmGJ+B9+4nXlJoBB8mw/iC79kldHUCJQu+o24l
        YwYBL0v+rIkAzxp9Cvq+k5Xiaz1HwaFvIRegRKfRxa0zgd4NFXilotQSv1A9nOZAZnMJHOANzxOjG
        VfaKLAJvQbtyEhr2pFpkjHNQ4xWQp1pyLr61alrToFCXv8cNtL1UGB/O+ZW2hPgLpT3QGN+hsrrOi
        GrHcB3tDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQnO7-0000Qw-3V; Thu, 07 Jun 2018 05:23:07 +0000
Date: Wed, 6 Jun 2018 22:23:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, robh@kernel.org, aik@ozlabs.ru,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org,
        joe@perches.com, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        cohuck@redhat.com, pawel.moll@arm.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180607052306.GA1532@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531204320-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 08:43:58PM +0300, Michael S. Tsirkin wrote:
> Pls work on a long term solution. Short term needs can be served by
> enabling the iommu platform in qemu.

So, I spent some time looking at converting virtio to dma ops overrides,
and the current virtio spec, and the sad through I have to tell is that
both the spec and the Linux implementation are complete and utterly fucked
up.

Both in the flag naming and the implementation there is an implication
of DMA API == IOMMU, which is fundamentally wrong.

The DMA API does a few different things:

 a) address translation

	This does include IOMMUs.  But it also includes random offsets
	between PCI bars and system memory that we see on various
	platforms.  Worse so some of these offsets might be based on
	banks, e.g. on the broadcom bmips platform.  It also deals
	with bitmask in physical addresses related to memory encryption
	like AMD SEV.  I'd be really curious how for example the
	Intel virtio based NIC is going to work on any of those
	plaforms.

  b) coherency

	On many architectures DMA is not cache coherent, and we need
	to invalidate and/or write back cache lines before doing
	DMA.  Again, I wonder how this is every going to work with
	hardware based virtio implementations.  Even worse I think this
	is actually broken at least for VIVT event for virtualized
	implementations.  E.g. a KVM guest is going to access memory
	using different virtual addresses than qemu, vhost might throw
	in another different address space.

  c) bounce buffering

	Many DMA implementations can not address all physical memory
	due to addressing limitations.  In such cases we copy the
	DMA memory into a known addressable bounc buffer and DMA
	from there.

  d) flushing write combining buffers or similar

	On some hardware platforms we need workarounds to e.g. read
	from a certain mmio address to make sure DMA can actually
	see memory written by the host.

All of this is bypassed by virtio by default despite generally being
platform issues, not particular to a given device.
