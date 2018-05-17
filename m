Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2607644-1526584225-2-16095799529603491362
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526584225; b=SPStJ0/VzzCqj43MEAWHH4nhDZbwcktIopknFQ7anrIk6ZsCoH
    kd5HDkMw25+nbbXzG8chakf4YdN1Q0JKM7CE6Ihy3wqSESHaSKUEVfmXb3tRzt/X
    Ddc9PMmdRxHXYssneP4Kww/YLWkr8MQj8MApNlZTzkHwTj7zZ5piolRw0254s9OU
    alx6Hxz3ZQbhIpSZbahIEa9LNyxUvANTy9A5Cx6NDdzaWvAsp+Usr2+sM3bLHpoi
    QOXq5mazlcTObe8RFqrRE9GLLO6jRipDKfWTy2T6goBX6Vg46J8lWJ7tbIOmX6rr
    lRDWA3RumBR60i6G+g4tTs7b3xkWoKU8p8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526584225; bh=ckeoUQFwzgx1AAp8wXh07MGCsabmqG
    DkUBRV7dldH2A=; b=WoTaz6pIA2mnteqqrzsYt6qvdJf8ZHjss51qB8OnXY6yrN
    B4ylz8MzkoToKezYqaKJdjI8fmhzyudgvhQGm37VfL6yTmpHNekfzGmsuwUNhd0W
    SCl0fnQp2TyfEiUsqHBOxh3Vu5x8q/gCGKLCz1pcDdRoLQJJ+dBvymqhvaY/pbMc
    x3+0kDwGMdmKQH01Ypa9lTG/GMm2ciDM58JN2T2d/CJvSLdICV9+B69CXBs0TcXR
    V0GQp0VnDLFxMz1vHWfsV2tknF6fEW7H7kMBjFQmgeVMu92rM1BC8EINimTzeBFa
    x1WTuIoKszhUx6/zueORdIxPthKyED2qTVocJbCw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=iLEdpJAx x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=iLEdpJAx x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP9SLEUUJkwFJn8l8qnQTO5/HAjhm/7FaOwu4AYIXUIV1Q6dCBOqHklbtoVfeGkwNHGshgh+OyYJVqQ7FVjQ5iaHR2YPRvEhT52rDBIZFKvfHbBJ5etx
    iQBeZIIOKfCITnQneq6yM1lJ+p6fKrZoKNqobVQ+ebgjMNeSbPQC9+ZA33WFrVpaCgY60Nf3PWACPqXRfVUwX1WZkM+MRvYKPh4QXwnOfyd9BAEAz9lsEQRl
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=FOS_WFI1iNJm9nFHTjsA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeEQTKW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 15:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbeEQTKV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 17 May 2018 15:10:21 -0400
Date: Thu, 17 May 2018 21:10:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Joe Jin <joe.jin@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        John Sobecki <john.sobecki@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        ASHISH_B_SRIVASTAVA <ashish.b.srivastava@oracle.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH UPSTREAM] xen-swiotlb: fix the check condition for
 xen_swiotlb_free_coherent
Message-ID: <20180517191003.GD504@kroah.com>
References: <25d8a709-9f2f-fe09-f66c-2a0704ddbbb0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d8a709-9f2f-fe09-f66c-2a0704ddbbb0@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 11:45:57AM -0700, Joe Jin wrote:
> When run raidconfig from Dom0 we found that the Xen DMA heap is reduced,
> but Dom Heap is increased by the same size. Tracing raidconfig we found
> that the related ioctl() in megaraid_sas will call dma_alloc_coherent()
> to apply memory. If the memory allocated by Dom0 is not in the DMA area,
> it will exchange memory with Xen to meet the requiment. Later drivers
> call dma_free_coherent() to free the memory, on xen_swiotlb_free_coherent()
> the check condition (dev_addr + size - 1 <= dma_mask) is always false,
> it prevents calling xen_destroy_contiguous_region() to return the memory
> to the Xen DMA heap.
> 
> This issue introduced by commit 6810df88dcfc2 "xen-swiotlb: When doing
> coherent alloc/dealloc check before swizzling the MFNs.".
> 
> Signed-off-by: Joe Jin <joe.jin@oracle.com>
> Tested-by: John Sobecki <john.sobecki@oracle.com> 
> Reviewed-by: Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/xen/swiotlb-xen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What does "PATCH UPSTREAM" mean?

confused,

greg k-h
