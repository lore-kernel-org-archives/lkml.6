Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58F0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E63220874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mv/GYjvD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oYFOsx7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbeLQSmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:42:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44954 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeLQSmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:42:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 68B5B607CA; Mon, 17 Dec 2018 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545072157;
        bh=a1x+f5gH3ExJyZ1XM437NykmuZbrOosHSkWmguBgSBk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Mv/GYjvDu9NpKf6j94iHCqy6udFMAwHQQgKD62EoQ5vdGU5wNQLHFp4PXIB5pyvAw
         CBW6HjrFWSw5HaYxZqin2hcKVNhj+wWJ0a0r6gd+ihG+UUxUdHAYzjyRqTG8+t22uI
         HZ04KTk2u6/xCA2BgCcN3/xxUDLzAYVsQf8lUHCg=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 076E4601D7;
        Mon, 17 Dec 2018 18:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545072156;
        bh=a1x+f5gH3ExJyZ1XM437NykmuZbrOosHSkWmguBgSBk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=oYFOsx7pCOJ2sTFUDFnlfioqORzvQK6iOa/ghQelAm9e5Ktk/AcucMKUHhN6RWRu2
         5LGYdmfmE8TKMdC3SqnfiIrOhEvUnFrAhkm0JHBROeS6J/nzRDC1h51jgfbejnINjt
         hYxB721ROnuqqgAXb7UVEn+gbpIf1ZDSEKOv2S3U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 076E4601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Mon, 17 Dec 2018 10:42:35 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Alexey Skidanov <alexey.skidanov@intel.com>
cc:     Laura Abbott <labbott@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, tkjos@android.com, rve@android.com,
        linux-kernel@vger.kernel.org, maco@android.com,
        sumit.semwal@linaro.org
Subject: Re: [PATCH v3] staging: android: ion: Add implementation of dma_buf_vmap
 and dma_buf_vunmap
In-Reply-To: <67f288db-d9ea-2d45-ddcf-a15dbff316f5@intel.com>
Message-ID: <alpine.DEB.2.10.1812171036080.23226@lmark-linux.qualcomm.com>
References: <1517400222-2854-1-git-send-email-alexey.skidanov@intel.com> <20180131130047.GA22917@kroah.com> <89be45dd-ac0e-4efb-2b21-e6c07b0cd66e@intel.com> <bf909d75-21a4-9d6d-2f72-887492821252@redhat.com> <7d836085-cd8d-300b-56be-e8db4ff37afc@intel.com>
 <alpine.DEB.2.10.1812152119130.2951@lmark-linux.qualcomm.com> <67f288db-d9ea-2d45-ddcf-a15dbff316f5@intel.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2018, Alexey Skidanov wrote:

> 
> 
> On 12/16/18 7:20 AM, Liam Mark wrote:
> > On Tue, 6 Feb 2018, Alexey Skidanov wrote:
> > 
> >>
> >>
> >> On 02/07/2018 01:56 AM, Laura Abbott wrote:
> >>> On 01/31/2018 10:10 PM, Alexey Skidanov wrote:
> >>>>
> >>>> On 01/31/2018 03:00 PM, Greg KH wrote:
> >>>>> On Wed, Jan 31, 2018 at 02:03:42PM +0200, Alexey Skidanov wrote:
> >>>>>> Any driver may access shared buffers, created by ion, using
> >>>>>> dma_buf_vmap and
> >>>>>> dma_buf_vunmap dma-buf API that maps/unmaps previosuly allocated
> >>>>>> buffers into
> >>>>>> the kernel virtual address space. The implementation of these API is
> >>>>>> missing in
> >>>>>> the current ion implementation.
> >>>>>>
> >>>>>> Signed-off-by: Alexey Skidanov <alexey.skidanov@intel.com>
> >>>>>> ---
> >>>>>
> >>>>> No review from any other Intel developers? :(
> >>>> Will add.
> >>>>>
> >>>>> Anyway, what in-tree driver needs access to these functions?
> >>>> I'm not sure that there are the in-tree drivers using these functions
> >>>> and ion as> buffer exporter because they are not implemented in ion :)
> >>>> But there are some in-tre> drivers using these APIs (gpu drivers) with
> >>>> other buffer exporters.
> >>>
> >>> It's still not clear why you need to implement these APIs.
> >> How the importing kernel module may access the content of the buffer? :)
> >> With the current ion implementation it's only possible by dma_buf_kmap,
> >> mapping one page at a time. For pretty large buffers, it might have some
> >> performance impact.
> >> (Probably, the page by page mapping is the only way to access large
> >> buffers on 32 bit systems, where the vmalloc range is very small. By the
> >> way, the current ion dma_map_kmap doesn't really map only 1 page at a
> >> time - it uses the result of vmap() that might fail on 32 bit systems.)
> >>
> >>> Are you planning to use Ion with GPU drivers? I'm especially
> >>> interested in this if you have a non-Android use case.
> >> Yes, my use case is the non-Android one. But not with GPU drivers.
> >>>
> >>> Thanks,
> >>> Laura
> >>
> >> Thanks,
> >> Alexey
> > 
> > I was wondering if we could re-open the discussion on adding support to 
> > ION for dma_buf_vmap.
> > It seems like the patch was not taken as the reviewers wanted more 
> > evidence of an upstream use case.
> > 
> > Here would be my upstream usage argument for including dma_buf_vmap 
> > support in ION.
> > 
> > Currently all calls to ion_dma_buf_begin_cpu_access result in the creation 
> > of a kernel mapping for the buffer, unfortunately the resulting call to 
> > alloc_vmap_area can be quite expensive and this has caused a performance 
> > regression for certain clients when they have moved to the new version of 
> > ION.
> > 
> > The kernel mapping is not actually needed in ion_dma_buf_begin_cpu_access, 
> > and generally isn't needed by clients. So if we remove the creation of the 
> > kernel mapping in ion_dma_buf_begin_cpu_access and only create it when 
> > needed we can speed up the calls to ion_dma_buf_begin_cpu_access.
> > 
> > An additional benefit of removing the creation of kernel mappings from 
> > ion_dma_buf_begin_cpu_access is that it makes the ION code more secure.
> > Currently a malicious client could call the DMA_BUF_IOCTL_SYNC IOCTL with 
> > flags DMA_BUF_SYNC_END multiple times to cause the ION buffer kmap_cnt to 
> > go negative which could lead to undesired behavior.
> > 
> > One disadvantage of the above change is that a kernel mapping is not 
> > already created when a client calls dma_buf_kmap. So the following 
> > dma_buf_kmap contract can't be satisfied.
> > 
> > /**
> > * dma_buf_kmap - Map a page of the buffer object into kernel address 
> > space. The
> > * same restrictions as for kmap and friends apply.
> > * @dmabuf:	[in]	buffer to map page from.
> > * @page_num:	[in]	page in PAGE_SIZE units to map.
> > *
> > * This call must always succeed, any necessary preparations that might 
> > fail
> > * need to be done in begin_cpu_access.
> > */
> > 
> > But hopefully we can work around this by moving clients to dma_buf_vmap.
> I think the problem is with the contract. We can't ensure that the call
> is always succeeds regardless the implementation - any mapping might
> fail. Probably this is why  *all* clients of dma_buf_kmap() check the
> return value (so it's safe to return NULL in case of failure).
> 

I think currently the call to dma_buf_kmap will always succeed since the 
DMA-Buf contract requires that the client first successfully call 
dma_buf_begin_cpu_access(), and if dma_buf_begin_cpu_access() succeeds 
then dma_buf_kmap will succeed.

> I would suggest to fix the contract and to keep the dma_buf_kmap()
> support in ION.

I will leave it to the DMA-Buf maintainers as to whether they want to 
change their contract.

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
