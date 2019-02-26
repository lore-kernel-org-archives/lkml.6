Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B51C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30C7217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfBZKQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:16:39 -0500
Received: from 8bytes.org ([81.169.241.247]:41380 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfBZKQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:16:39 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5C6AA41A; Tue, 26 Feb 2019 11:16:37 +0100 (CET)
Date:   Tue, 26 Feb 2019 11:16:35 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix IOMMU debugfs fallout
Message-ID: <20190226101635.GE20740@8bytes.org>
References: <20190220130505.1188-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220130505.1188-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 02:05:05PM +0100, Geert Uytterhoeven wrote:
> A change made in the final version of IOMMU debugfs support replaced the
> public function iommu_debugfs_new_driver_dir() by the public dentry
> iommu_debugfs_dir in <linux/iommu.h>, but forgot to update both the
> implementation in iommu-debugfs.c, and the patch description.
> 
> Fix this by exporting iommu_debugfs_dir, and removing the reference to
> and implementation of iommu_debugfs_new_driver_dir().
> 
> Fixes: bad614b24293ae46 ("iommu: Enable debugfs exposure of IOMMU driver internals")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/iommu-debugfs.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)

Applied, thanks.
