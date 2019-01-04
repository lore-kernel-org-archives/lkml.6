Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D412C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D663521871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfADH0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 02:26:52 -0500
Received: from verein.lst.de ([213.95.11.211]:38251 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADH0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 02:26:52 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0DC6F68AFE; Fri,  4 Jan 2019 08:26:51 +0100 (CET)
Date:   Fri, 4 Jan 2019 08:26:51 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Huaisheng HS1 Ye <yehs1@lenovo.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NingTing Cheng <chengnt@lenovo.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Huaisheng Ye <yehs2007@zoho.com>
Subject: Re: [PATCH] dma-mapping: remove unused attrs parameter to
 dma_common_get_sgtable
Message-ID: <20190104072651.GA14560@lst.de>
References: <HK2PR03MB44183AC87F67594E93F31E75928E0@HK2PR03MB4418.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR03MB44183AC87F67594E93F31E75928E0@HK2PR03MB4418.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 01:45:26AM +0000, Huaisheng HS1 Ye wrote:
> From: Stefano Stabellini <sstabellini@kernel.org>
> Sent: Friday, January 04, 2019 1:55 AM
> > On Thu, 3 Jan 2019, Huaisheng Ye wrote:
> > > From: Huaisheng Ye <yehs1@lenovo.com>
> > >
> > > dma_common_get_sgtable has parameter attrs which is not used at all.
> > > Remove it.
> > >
> > > Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> > 
> > Acked-by: Stefano Stabellini <sstabellini@kernel.org>
> > 
> > FYI the patch doesn't apply cleanly to master.
> 
> Got it, I will rebase it to branch master and resend the patch later.

I think we can skip it.  For the next merge window I plan to remove
the fallbacks for get_sgtable and mmap and instead wire everything up
explicitly.  And to be a possible method instance it will have to match
the prototype and thus keep the unused argument.
