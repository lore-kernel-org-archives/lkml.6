Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30422C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99A12086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rkvztLiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99A12086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeK2EYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:24:35 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:38452 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbeK2EYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:24:35 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A612755A;
        Wed, 28 Nov 2018 18:22:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1543425732;
        bh=nal1Z8C/5OE4fmqGcBipZfvdVtllhIp4Hz+ipNIeoVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkvztLiAT4wvRQpjEjZnpAxzVLY1zceRGYDXlpeEwpndbzWOuKrk+sccsr3ERpo2y
         U59+GDzZ4XWlhWjtrBjqFs6ipJWogtyUg2cBuC9+s+c6lnjRbLYXnENocmdnuQTuKC
         H/6M/gmaMA3eLoUQ2obchbHMq5AX09DJVfqyvyeA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] iommu: ipmmu-vmsa: make it explicitly non-modular
Date:   Wed, 28 Nov 2018 19:22:37 +0200
Message-ID: <7671106.x9S16LaZuq@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181128153204.GI14659@windriver.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com> <cdded4c3-4bc5-39b3-ebc9-64fa145c9242@arm.com> <20181128153204.GI14659@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wednesday, 28 November 2018 17:32:05 EET Paul Gortmaker wrote:
> [Re: [PATCH 5/9] iommu: ipmmu-vmsa: make it explicitly non-modular] On 
28/11/2018 (Wed 12:50) Robin Murphy wrote:
> > On 26/11/2018 22:31, Paul Gortmaker wrote:
> [...]
> 
> >> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> >> index 9e2655f1c1bf..de39ef992d8a 100644
> >> --- a/drivers/iommu/ipmmu-vmsa.c
> >> +++ b/drivers/iommu/ipmmu-vmsa.c
> >> @@ -1,6 +1,8 @@
> >>
> >>  // SPDX-License-Identifier: GPL-2.0
> >>  /*
> >>   * IPMMU VMSA
> > 
> > Nit: this line doesn't convey any information that the module description
> > below doesn't also say far more clearly, so you may as well just replace
> > it entirely.
> 
> No problem. Will do in v2.

With that change, the blank line after MODULE_DEVICE_TABLE() removed, and 
<linux/init.h> moved to keep alphabetical order sorting of the includes, 
please add

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

to v2. Thank you for the patch.

> > >+ * IOMMU API for Renesas VMSA-compatible IPMMU
> > >+ * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> [...]

-- 
Regards,

Laurent Pinchart



