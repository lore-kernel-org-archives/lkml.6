Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E156C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18982081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18982081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeK2JQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:16:10 -0500
Received: from mail5.windriver.com ([192.103.53.11]:59700 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbeK2JQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:16:10 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wASMAmIv018560
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 28 Nov 2018 14:11:40 -0800
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Wed, 28 Nov 2018 14:10:55 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 55B4A2E130B; Wed, 28 Nov 2018 17:10:55 -0500 (EST)
Date:   Wed, 28 Nov 2018 17:10:55 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] iommu: ipmmu-vmsa: make it explicitly non-modular
Message-ID: <20181128221054.GJ14659@windriver.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
 <cdded4c3-4bc5-39b3-ebc9-64fa145c9242@arm.com>
 <20181128153204.GI14659@windriver.com>
 <7671106.x9S16LaZuq@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7671106.x9S16LaZuq@avalon>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 5/9] iommu: ipmmu-vmsa: make it explicitly non-modular] On 28/11/2018 (Wed 19:22) Laurent Pinchart wrote:

> Hi Paul,
> 
> On Wednesday, 28 November 2018 17:32:05 EET Paul Gortmaker wrote:
> > [Re: [PATCH 5/9] iommu: ipmmu-vmsa: make it explicitly non-modular] On 
> 28/11/2018 (Wed 12:50) Robin Murphy wrote:
> > > On 26/11/2018 22:31, Paul Gortmaker wrote:
> > [...]
> > 
> > >> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > >> index 9e2655f1c1bf..de39ef992d8a 100644
> > >> --- a/drivers/iommu/ipmmu-vmsa.c
> > >> +++ b/drivers/iommu/ipmmu-vmsa.c
> > >> @@ -1,6 +1,8 @@
> > >>
> > >>  // SPDX-License-Identifier: GPL-2.0
> > >>  /*
> > >>   * IPMMU VMSA
> > > 
> > > Nit: this line doesn't convey any information that the module description
> > > below doesn't also say far more clearly, so you may as well just replace
> > > it entirely.
> > 
> > No problem. Will do in v2.
> 
> With that change, the blank line after MODULE_DEVICE_TABLE() removed, and 
> <linux/init.h> moved to keep alphabetical order sorting of the includes, 
> please add
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Updated and review tag added for v2.

Paul.
--

> 
> to v2. Thank you for the patch.
> 
> > > >+ * IOMMU API for Renesas VMSA-compatible IPMMU
> > > >+ * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > [...]
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> 
> 
