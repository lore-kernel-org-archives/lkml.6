Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC63C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9BF2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfB0Las (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:30:48 -0500
Received: from foss.arm.com ([217.140.101.70]:60600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfB0Las (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 06:30:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8175374;
        Wed, 27 Feb 2019 03:30:47 -0800 (PST)
Received: from [10.1.197.2] (ostrya.cambridge.arm.com [10.1.197.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6E963F575;
        Wed, 27 Feb 2019 03:30:46 -0800 (PST)
Subject: Re: linux-next: manual merge of the vhost tree with the iommu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>
References: <20190227152506.4696a59f@canb.auug.org.au>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <2370af99-9dc1-b694-9f1c-1951d1e70435@arm.com>
Date:   Wed, 27 Feb 2019 11:30:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190227152506.4696a59f@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2019 04:25, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the vhost tree got conflicts in:
> 
>   drivers/iommu/Kconfig
>   drivers/iommu/Makefile
> 
> between commit:
> 
>   004240dcc222 ("iommu/hyper-v: Add Hyper-V stub IOMMU driver")
> 
> from the iommu tree and commit:
> 
>   d906f4225497 ("iommu: Add virtio-iommu driver")
> 
> from the vhost tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
Thanks Stephen, sorry about the extra work. The virtio-iommu driver was
helpfully added to the vhost tree to ensure it doesn't break anything,
but since Joerg has some reservations, only the hyper-v change will be
merged in v5.1. I'd welcome a change of heart however, in which case the
driver should probably go via the iommu tree to avoid conflicts.

Thanks,
Jean
