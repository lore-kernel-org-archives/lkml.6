Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8875C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09A32081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfBVJsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:48:02 -0500
Received: from ozlabs.org ([203.11.71.1]:56199 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbfBVJr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:47:58 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 445RND0KxYz9sNT; Fri, 22 Feb 2019 20:47:56 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 74ebe3e733b791f37415b3a1b917ee5035bc7364
X-Patchwork-Hint: ignore
In-Reply-To: <20190213070133.11259-2-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [01/32] net: pasemi: set a 64-bit DMA mask on the DMA device
Message-Id: <445RND0KxYz9sNT@ozlabs.org>
Date:   Fri, 22 Feb 2019 20:47:56 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-13 at 07:01:02 UTC, Christoph Hellwig wrote:
> The pasemi driver never set a DMA mask, and given that the powerpc
> DMA mapping routines never check it this worked ok so far.  But the
> generic dma-direct code which I plan to switch on for powerpc checks
> the DMA mask and fails unsupported mapping requests, so we need to
> make sure the proper 64-bit mask is set.
> 
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/74ebe3e733b791f37415b3a1b917ee50

cheers
