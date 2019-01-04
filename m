Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FBCC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7200218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b9PjUlbt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IJR+G2sI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfADRmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:42:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfADRmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:42:05 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 323D4608C6; Fri,  4 Jan 2019 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546623723;
        bh=zca2SsK3nw3O37+eqanDCtOSt04ycSV0pycfbAUlwnI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=b9PjUlbtJ2QlUpybN3OBem5d0O9WUYXMoSAXC7N3zW0aG8y8p0QvKPdG0sjPvDZuZ
         6DvTTFDO60kawEQT5yizdZ2UMpxQo/Se15zytYP1BWBEZ9ypfz6bTKIArK6Iy4QlDT
         MWvPfUkzxZH+bTe73cwoD4ODg1Mq7in4blGePNz4=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98AED6087F;
        Fri,  4 Jan 2019 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546623719;
        bh=zca2SsK3nw3O37+eqanDCtOSt04ycSV0pycfbAUlwnI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=IJR+G2sINhxdvmzAbMxLh5+weluEm2lBDAh1E/lf9Nn1mcd4eG2m6y4CE7CbY3COG
         iWM2tFd6tSd5LR2uu3JkcFczsFHpZY87BjkOYjPQBmk8x3k85PkDM92RBgfKwcZjtU
         RLtUdx+niAyuKkPHzkKKoK3eK5XYvWlQ19Uhc42M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98AED6087F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Fri, 4 Jan 2019 09:41:57 -0800 (PST)
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
In-Reply-To: <3740948f-02be-cf7a-bc41-54b4fd195103@intel.com>
Message-ID: <alpine.DEB.2.10.1901040940260.19175@lmark-linux.qualcomm.com>
References: <1517400222-2854-1-git-send-email-alexey.skidanov@intel.com> <20180131130047.GA22917@kroah.com> <89be45dd-ac0e-4efb-2b21-e6c07b0cd66e@intel.com> <bf909d75-21a4-9d6d-2f72-887492821252@redhat.com> <7d836085-cd8d-300b-56be-e8db4ff37afc@intel.com>
 <alpine.DEB.2.10.1812152119130.2951@lmark-linux.qualcomm.com> <67f288db-d9ea-2d45-ddcf-a15dbff316f5@intel.com> <alpine.DEB.2.10.1812171036080.23226@lmark-linux.qualcomm.com> <3740948f-02be-cf7a-bc41-54b4fd195103@intel.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Alexey Skidanov wrote:

> >>> I was wondering if we could re-open the discussion on adding support to 
> >>> ION for dma_buf_vmap.
> >>> It seems like the patch was not taken as the reviewers wanted more 
> >>> evidence of an upstream use case.
> >>>
> >>> Here would be my upstream usage argument for including dma_buf_vmap 
> >>> support in ION.
> >>>
> >>> Currently all calls to ion_dma_buf_begin_cpu_access result in the creation 
> >>> of a kernel mapping for the buffer, unfortunately the resulting call to 
> >>> alloc_vmap_area can be quite expensive and this has caused a performance 
> >>> regression for certain clients when they have moved to the new version of 
> >>> ION.
> >>>
> >>> The kernel mapping is not actually needed in ion_dma_buf_begin_cpu_access, 
> >>> and generally isn't needed by clients. So if we remove the creation of the 
> >>> kernel mapping in ion_dma_buf_begin_cpu_access and only create it when 
> >>> needed we can speed up the calls to ion_dma_buf_begin_cpu_access.
> >>>
> >>> An additional benefit of removing the creation of kernel mappings from 
> >>> ion_dma_buf_begin_cpu_access is that it makes the ION code more secure.
> >>> Currently a malicious client could call the DMA_BUF_IOCTL_SYNC IOCTL with 
> >>> flags DMA_BUF_SYNC_END multiple times to cause the ION buffer kmap_cnt to 
> >>> go negative which could lead to undesired behavior.
> >>>
> >>> One disadvantage of the above change is that a kernel mapping is not 
> >>> already created when a client calls dma_buf_kmap. So the following 
> >>> dma_buf_kmap contract can't be satisfied.
> >>>
> >>> /**
> >>> * dma_buf_kmap - Map a page of the buffer object into kernel address 
> >>> space. The
> >>> * same restrictions as for kmap and friends apply.
> >>> * @dmabuf:	[in]	buffer to map page from.
> >>> * @page_num:	[in]	page in PAGE_SIZE units to map.
> >>> *
> >>> * This call must always succeed, any necessary preparations that might 
> >>> fail
> >>> * need to be done in begin_cpu_access.
> >>> */
> >>>
> >>> But hopefully we can work around this by moving clients to dma_buf_vmap.
> >> I think the problem is with the contract. We can't ensure that the call
> >> is always succeeds regardless the implementation - any mapping might
> >> fail. Probably this is why  *all* clients of dma_buf_kmap() check the
> >> return value (so it's safe to return NULL in case of failure).
> >>
> > 
> > I think currently the call to dma_buf_kmap will always succeed since the 
> > DMA-Buf contract requires that the client first successfully call 
> > dma_buf_begin_cpu_access(), and if dma_buf_begin_cpu_access() succeeds 
> > then dma_buf_kmap will succeed.
> > 
> >> I would suggest to fix the contract and to keep the dma_buf_kmap()
> >> support in ION.
> > 
> > I will leave it to the DMA-Buf maintainers as to whether they want to 
> > change their contract.
> > 
> > Liam
> > 
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> > 
> 
> Ok. We need the list of the clients using the ION in the mainline tree.
> 

Looks to me like the only functions which might be calling 
dma_buf_kmap/dma_buf_kunmap on ION buffers are 
tegra_bo_kmap/tegra_bo_kunmap, I assume Tegra is used in some Android 
automotive products.

Looks like these functions could be moved over to using 
dma_buf_vmap/dma_buf_vunmap but it wouldn't be very clean and would add a 
performance hit.

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
