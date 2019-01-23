Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C5C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01166218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548287029;
	bh=Ht9d9bSQHb38KEouKFbK/xZBFFodlVBzidb47a3vGe4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=lOVWnd2sL7w4K/DWnnR+dCGB23Sz9saIcYgPTskZcnk8DU2Q4DUgPRPxi9zAsJTQ/
	 KwTDjwgxQGr6YoR0TXNCyzs5OsUCDVb19xSXUoMTaxCEVPTSBaWroDZMrj0FqduvUe
	 NhbxIq/iaZwYls5T3LaIPX3lZ2L02IG81WBwF6YE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfAWXnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbfAWXnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:43:47 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E45A21019;
        Wed, 23 Jan 2019 23:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548287025;
        bh=Ht9d9bSQHb38KEouKFbK/xZBFFodlVBzidb47a3vGe4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=z4K0WRQYPBPv7/USmZMqF0to2B7agbO545aVbnNfz1oGFwOLRjDg/sy9bPKEq87Mu
         k2r4tlgQDfIMGXcCcIOxTVw1JvrHMWJ7DJ53ucHTvYsUKeVBKxHbITgaou1H/ZvBTn
         NUtu5yK7uZrfSQe2dGhe3pAUhU0U5M3zHHzlsy80=
Date:   Wed, 23 Jan 2019 15:43:45 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     "hch@infradead.org" <hch@infradead.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>, luto@kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        bjorn.andersson@linaro.org, jliang@xilinx.com
Subject: Re: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
In-Reply-To: <20190123211405.GA4971@infradead.org>
Message-ID: <alpine.DEB.2.10.1901231427010.17936@sstabellini-ThinkPad-X260>
References: <20190121050056.14325-1-peng.fan@nxp.com> <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260> <20190123071232.GA20526@infradead.org> <alpine.DEB.2.10.1901230935280.17936@sstabellini-ThinkPad-X260>
 <20190123211405.GA4971@infradead.org>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1172143826-1548282487=:17936"
Content-ID: <alpine.DEB.2.10.1901231428550.17936@sstabellini-ThinkPad-X260>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1172143826-1548282487=:17936
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.10.1901231428551.17936@sstabellini-ThinkPad-X260>

On Wed, 23 Jan 2019, hch@infradead.org wrote:
> On Wed, Jan 23, 2019 at 01:04:33PM -0800, Stefano Stabellini wrote:
> > If vring_use_dma_api is actually supposed to return true when
> > dma_dev->dma_mem is set, then both Peng's patch and the patch I wrote
> > are not fixing the real issue here.
> > 
> > I don't know enough about remoteproc to know where the problem actually
> > lies though.
> 
> The problem is the following:
> 
> Devices can declare a specific memory region that they want to use when
> the driver calls dma_alloc_coherent for the device, this is done using
> the shared-dma-pool DT attribute, which comes in two variants that
> would be a little to much to explain here.
> 
> remoteproc makes use of that because apparently the device can
> only communicate using that region.  But it then feeds back memory
> obtained with dma_alloc_coherent into the virtio code.  For that
> it calls vmalloc_to_page on the dma_alloc_coherent, which is a huge
> no-go for the ĐMA API and only worked accidentally on a few platform,
> and apparently arm64 just changed a few internals that made it stop
> working for remoteproc.
> 
> The right answer is to not use the DMA API to allocate memory from
> a device-speficic region, but to tie the driver directly into the
> DT reserved memory API in a way that allows it to easilt obtain
> a struct device for it.

If I understand correctly, Peng should be able to reproduce the problem
on native Linux without any Xen involvement simply by forcing
vring_use_dma_api to return true. Peng, can you confirm?

And the right fix is not to call vmalloc_to_page on a dma_alloc_coherent
buffer -- I don't know about the recent changes on arm64, but that's not
going to work with arm32 either AFAIK. Given that I don't have a repro,
I'll leave it to Peng and/or others to send the appropriate patch for
remoteproc.


> This is orthogonal to another issue, and that is that hardware
> virtio devices really always need to use the DMA API, otherwise
> we'll bypass such features as the device specific DMA pools,
> DMA offsets, cache flushing, etc, etc.

I understand, I'll drop my patch.
--8323329-1172143826-1548282487=:17936--
