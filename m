Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD8CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3D120821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3D120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbeLJV0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:26:40 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34444 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbeLJV0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:26:39 -0500
Received: from p4fea4820.dip0.t-ipconnect.de ([79.234.72.32] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gWT4R-0004eE-R4; Mon, 10 Dec 2018 22:26:32 +0100
Date:   Mon, 10 Dec 2018 22:26:30 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v3 5/7] x86/dma/amd-gart: Stop resizing dma_debug_entry
 pool
In-Reply-To: <a967f11a3a4a862287c7dc180946df0067bdcf80.1544447601.git.robin.murphy@arm.com>
Message-ID: <alpine.DEB.2.21.1812102226140.1667@nanos.tec.linutronix.de>
References: <cover.1544447601.git.robin.murphy@arm.com> <a967f11a3a4a862287c7dc180946df0067bdcf80.1544447601.git.robin.murphy@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018, Robin Murphy wrote:

> dma-debug is now capable of adding new entries to its pool on-demand if
> the initial preallocation was insufficient, so the IOMMU_LEAK logic no
> longer needs to explicitly change the pool size. This does lose it the
> ability to save a couple of megabytes of RAM by reducing the pool size
> below its default, but it seems unlikely that that is a realistic
> concern these days (or indeed that anyone is actively debugging AGP
> drivers' DMA usage any more). Getting rid of dma_debug_resize_entries()
> will make room for further streamlining in the dma-debug code itself.
> 
> Removing the call reveals quite a lot of cruft which has been useless
> for nearly a decade since commit 19c1a6f5764d ("x86 gart: reimplement
> IOMMU_LEAK feature by using DMA_API_DEBUG"), including the entire
> 'iommu=leak' parameter, which controlled nothing except whether
> dma_debug_resize_entries() was called or not.
> 
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: x86@kernel.org
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
