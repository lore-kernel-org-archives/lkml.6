Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-77256-1526665841-2-2286117045027099846
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526665839; b=ht2/LZ/MIB9NoyArQZMLEhsC1ZCx/wpzdXgNpHmYSPCXB75ezV
    jbPPRCwKPvAyZVBRTHaFs+nO91YBEcqny7Z2GvTuluje6rT7ghH1OBNmPr8v9O40
    bywzkvAijZxX93Zivv1YAMPlYRvsCcki3fFvqv5U3hR6RyJqgmdg6xFazHG8q2jS
    XMdy1oKfpp/GyO9Rhw51o5HB9VP6UcEDzMNmaWYpN4TDsZQjX0E1Q5j4yQyWBPCX
    5d/4zoLrfBBaXG3YC/1SWmSDotkRrCDdwlndgFLge5mIXuAWD0XlvK0MJ9f1hA79
    XpcuPr403f5pWVPXhpr9cmIWTET8yRu7L3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526665839; bh=w26Mcd9/t0aYDyhVFEe2HgthN89vmJ
    WIhOy1q/AaIfU=; b=h89qqr7x0Y3kboXbXAioCFewoccd5YvYNdI2mg1QFUg1a7
    gL216fCBhR3F5GITA9t4MsygPH+gFMFJBxulXUHX6JfnwvbkUzOrsUUYUf1Mf1xa
    qRvhFXC1LGJ/+02pHtHUVpKcTQUeXNSDVAXHqfOzjH595YX0Jg5G2BqPtpIZi8gD
    KVRpesi4a3TtRH1QVZaynRmOSeUTxd11rrYcuKsfGLf1Vfn2JjTtc34VC/uSvykB
    Pn1nPJN5/qsoPKHBZrUpjCi/yx/OvJtlcXrjjA+S1lhPPttAIuVXeRa3z7j1ahAY
    fB+VHLidd/aTHoAzYbZcviODou8vKZbguPRWIVLA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i17r7MKh
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=armlinux.org.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i17r7MKh
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=armlinux.org.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEy6l8cUeZ+xl+GUm5beAhOgZQJSRopYR7PquPuJaWYU3R4THMXky8tDKID48SJ9PsCC2U8UORi8ZLD7zAn6Ud8CstPj0cc1LTW91hdbYlxZ7+Ne3+N1
    2LbJVuwK5+HHmkyBf187UgHoKFMVBI2jR8bJtZBsFy3hS6DwO1aGyQ5FXIX+0sUc5kKOODS6+LgPwki/S73AiJuDD8lbac6XPq5V9RYmZ4Wk1UddPHbT/txK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=PHq6YzTAAAAA:8 a=PMT70qdeAAAA:8 a=_MWnjJkh09QHyX1phz8A:9
    a=CjuIK1q_8ugA:10 a=ZKzU8r6zoKMcqsNulkmm:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeERRuf (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 13:50:35 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51906 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752422AbeERRub (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2018 13:50:31 -0400
Date: Fri, 18 May 2018 18:50:04 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH
 02/20] dma-mapping: provide a generic dma-noncoherent implementation)
Message-ID: <20180518175004.GF17671@n2100.armlinux.org.uk>
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-3-hch@lst.de>
 <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
 <5ac5b1e3-9b96-9c7c-4dfe-f65be45ec179@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ac5b1e3-9b96-9c7c-4dfe-f65be45ec179@synopsys.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 10:20:02AM -0700, Vineet Gupta wrote:
> I never understood the need for this direction. And if memory serves me
> right, at that time I was seeing twice the amount of cache flushing !

It's necessary.  Take a moment to think carefully about this:

	dma_map_single(, dir)

	dma_sync_single_for_cpu(, dir)

	dma_sync_single_for_device(, dir)

	dma_unmap_single(, dir)

In the case of a DMA-incoherent architecture, the operations done at each
stage depend on the direction argument:

	map		for_cpu		for_device	unmap
TO_DEV	writeback	none		writeback	none
TO_CPU	invalidate	invalidate*	invalidate	invalidate*
BIDIR	writeback	invalidate	writeback	invalidate

* - only necessary if the CPU speculatively prefetches.

The multiple invalidations for the TO_CPU case handles different
conditions that can result in data corruption, and for some CPUs, all
four are necessary.

This is what is implemented for 32-bit ARM, depending on the CPU
capabilities, as we have DMA incoherent devices and we have CPUs that
speculatively prefetch data, and so may load data into the caches while
DMA is in operation.


Things get more interesting if the implementation behind the DMA API has
to copy data between the buffer supplied to the mapping and some DMA
accessible buffer:

	map		for_cpu		for_device	unmap
TO_DEV	copy to dma	none		copy to dma	none
TO_CPU	none		copy to cpu	none		copy to cpu
BIDIR	copy to dma	copy to cpu	copy to dma	copy to cpu

So, in both cases, the value of the direction argument defines what you
need to do in each call.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
