Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD2FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF8220827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF8220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbeKHBem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:34:42 -0500
Received: from 8bytes.org ([81.169.241.247]:40110 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbeKHBem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:34:42 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E6AD0247; Wed,  7 Nov 2018 17:03:42 +0100 (CET)
Date:   Wed, 7 Nov 2018 17:03:41 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix crash on early domain free
Message-ID: <20181107160341.pfpukoqhyhapfzpn@8bytes.org>
References: <20181107131850.11584-1-geert+renesas@glider.be>
 <e4dcd8b2-768e-b11d-b6de-337b7e942050@arm.com>
 <20181107153418.cge2dj5zmztahxrf@8bytes.org>
 <CAMuHMdWPkMtnGrxrtFGmyJ5NEvSSCiMUVXXBWX+NS-J4tQXLAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWPkMtnGrxrtFGmyJ5NEvSSCiMUVXXBWX+NS-J4tQXLAw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 04:50:40PM +0100, Geert Uytterhoeven wrote:
> It only got triggered by the combination of commits 6c2fb2ea76361da9
> ("of/device: Set bus DMA mask as appropriate") and b4ebe6063204da58
> ("dma-direct: implement complete bus_dma_mask handling"), which is being
> fixed by "of/device: Really only set bus DMA mask when
> appropriate" (https://patchwork.kernel.org/patch/10670177/).

Okay, but the bug is triggered since 6c2fb2ea76361da9, so I took this
one for the fixes-tag.

Thanks,

	Joerg
