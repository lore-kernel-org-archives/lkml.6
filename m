Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF1EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A933721526
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns5uExzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A933721526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeHPXbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeHPXbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:31:46 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4596E214C2;
        Thu, 16 Aug 2018 20:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534451472;
        bh=24eVCuKRBIrQbJRgg5TWyGAJzKw+vH/lOmeUBq9YNm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ns5uExzpfFWECnUMHuGSmZhoBVOE/JM/RFm/dXUsQuNurofwZO6+Xm6Gr6Y4LRQ//
         39TROPT7JNC6FMgcoDcExN38p+TutWJ9CtlZy2nGXOip0q4rny8KlxEFbFC83tfVtW
         CCn4Ns7VXOZJBaRpBmi00oyGrTsP/BeoZy7Ed+js=
Date:   Thu, 16 Aug 2018 15:31:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "liudongdong3@huawei.com" <liudongdong3@huawei.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Add 'nodpc' parameter
Message-ID: <20180816203111.GB10316@bhelgaas-glaptop.roam.corp.google.com>
References: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
 <20180816154940.GD5762@bombadil.infradead.org>
 <1534434641.17819.27.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534434641.17819.27.camel@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 03:50:47PM +0000, Derrick, Jonathan wrote:
> On Thu, 2018-08-16 at 08:49 -0700, Matthew Wilcox wrote:
> > On Wed, Aug 15, 2018 at 03:26:39PM -0600, Jon Derrick wrote:
> > > Some users may want to disable downstream port containment (DPC),
> > > so
> > > give them this option
> > 
> > Is it possible they might only want to disable DPC on a subset of the
> > hierarchy rather than globally?
> 
> Absolutely. I was hoping Logan's pci dev_str would land because I have
> a few others I want to convert to that api for granular tuning

What's the use case here?  I acknowledge there are cases where we need
them, but I'm not a fan of kernel parameters in general because
they're a real hassle for users.

Is there something wrong with DPC?  Is there some way we can make it
smarter so it does the right thing automatically?

I'm more OK with a blanket "nodpc" switch intended for debugging.
If we add the complexity of subsets of the hierarchy it starts
sounding like an administrative thing that makes me more hesitant. 

Could this be done via a sysfs switch instead?  That potentially could
work for hot-added things where a kernel parameter doesn't work so
well.

Please squash the doc patch and the code change so it's easier to keep
them together.

Bjorn
