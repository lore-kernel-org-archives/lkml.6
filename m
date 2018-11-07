Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E765C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D042620989
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D042620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeKHHAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:00:00 -0500
Received: from ozlabs.org ([203.11.71.1]:51643 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbeKHHAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:00:00 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42qzz607sKz9sCX; Thu,  8 Nov 2018 08:27:45 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3182215dd0b2120fb942ed88430cfb7c12d583e0
In-Reply-To: <20181030110203.27257-1-alistair@popple.id.au>
To:     Alistair Popple <alistair@popple.id.au>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Alistair Popple <alistair@popple.id.au>, hch@lst.de,
        linux-kernel@vger.kernel.org
Subject: Re: powerpc/npu-dma: Remove NPU DMA ops
Message-Id: <42qzz607sKz9sCX@ozlabs.org>
Date:   Thu,  8 Nov 2018 08:27:45 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-30 at 11:02:03 UTC, Alistair Popple wrote:
> The NPU IOMMU is setup to mirror the parent PCIe device IOMMU
> setup. Therefore it does not make sense to call dma operations such as
> dma_map_page, etc. directly on these devices. The existing dma-ops
> simply print a warning if they are ever called, however this is
> unnecessary and the warnings are likely to go unnoticed.
> 
> It is instead simpler to remove these operations and let the generic
> DMA code print warnings (eg. via a NULL pointer deref) in cases of
> buggy drivers attempting dma operations on NVLink devices.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/3182215dd0b2120fb942ed88430cfb

cheers
