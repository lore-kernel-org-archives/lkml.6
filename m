Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3958489-1526649774-2-2249307429837791161
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526649773; b=ZsU3FgUb3Crru+aYTpHsBTdB1RhChrSqudYtPE4LiVGAxyGAZE
    E8tnw0J3bOxXqZqxRN26C/B4i2pf84gwFu3Gx5ylsqF0CjjXGCy5IiaT3wgbaf2O
    qb8jeRrm5IH8b4/LBdBnz6jSJpNedJywmX4aDuG+1uO4iRRVpQRLKhZASwU4VK65
    L6SPtmmy9BjTKm/coa1AftHDjVC6/e8nZ+6g2i4/DHmaZw1VKbF1AFcBd/O+6qc+
    tAQevoGPbBRxOVJgmcTWdhqCsKDmwKl5nq0tELd8cfeoZH4AJgOEr6gjSqjIihTh
    RtFdQJT4KFIY92PSot/rOFIVWBhUjgFa3T2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526649773; bh=NQ3aAM1ebdB6dANrlKPQAlovXGo074
    5IbfAai2YYAEw=; b=dBwJesq3bvbNeTG5RaTmQRlEm0lCtsw63wRpwDGoJcVp52
    jNz+0INO4/aAWSY0z+8Grz4HGLxb/6dqUKd3VMTFs2Vu2bOMJnWTPpgJrym1671R
    hELG80ZQhCZE88Vx2TFRo02TIa2M+4RXTvojmGyacLZOrnzgjxF+KJ/CjpDjQsna
    pNurb9A/xJCSh+55peCsenhv/Ur4Ikfi9JuEtNrgCRVhGrV6zluSduZ+7pPIgQKo
    G1jwXGXJe0DXbKumUcCbbZOv9Xq5J7mpP+tz7KlYzVFXLIaFWMcKO/cq7iUEOZRS
    4HgK8sdCJ3zUcCN9Z74DRIjFQ7PePDKs1waYVmww==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHExMdzAVnVwnhnstHms1WJKR9z8aczgg0alpNBVl55wgvFC6LCbLQ8H/54UhDU87IeLOUIWtEWFoTsHnbyw4Xr2Tr2FbhFOcvV9vPErbrSZYjKXeehm
    mX7Ll6vbMsezwbJgkNqWawlGYRgZkeRdzWu1wdu/A5iDNUfZcomQMS4hMwKYXOOlO+jGtby09il4MVOjKjlM1ORbpp+1jimc585nR1GMPUZmpJlZBoqUQrd0
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=bDqen56-0BUqQZJHxJUA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeERNWu (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 09:22:50 -0400
Received: from verein.lst.de ([213.95.11.211]:59129 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752223AbeERNWt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 May 2018 09:22:49 -0400
Date: Fri, 18 May 2018 15:27:31 +0200
From: "hch@lst.de" <hch@lst.de>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "hch@lst.de" <hch@lst.de>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent
        implementation
Message-ID: <20180518132731.GA31125@lst.de>
References: <20180511075945.16548-1-hch@lst.de> <20180511075945.16548-3-hch@lst.de> <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 01:03:46PM +0000, Alexey Brodkin wrote:
> Note mmc_get_dma_dir() is just "data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE".
> I.e. if we're preparing for sending data dma_noncoherent_map_sg() will have DMA_TO_DEVICE which
> is quite OK for passing to dma_noncoherent_sync_sg_for_device() but in case of reading we'll have
> DMA_FROM_DEVICE which we'll pass to dma_noncoherent_sync_sg_for_device() in dma_noncoherent_map_sg().
> 
> I'd say this is not entirely correct because IMHO arch_sync_dma_for_cpu() is supposed to only be used
> in case of DMA_FROM_DEVICE and arch_sync_dma_for_device() only in case of DMA_TO_DEVICE.

arc overrides the dir paramter of the dma_sync_single_for_device/
dma_sync_single_for_cpu calls.  My patches dropped that, and I have
restored that, and audit for the other architectures is pending.

That being said the existing arc code still looks rather odd as it
didn't do the same thing for the scatterlist versions of the calls.
I've thrown in a few patches into my new tree to make the sg versions
make the normal calls, and to clean up the area a bit.

> You seem to lost an offset in the page so if we happen to have a buffer not aligned to
> a page boundary then we were obviously corrupting data outside our data :)

Oops!  Thank you for all the debugging!
