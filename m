Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6D8ECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E4B206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="SQ8O1D30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E4B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390318AbeGTNdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:33:08 -0400
Received: from 8bytes.org ([81.169.241.247]:33046 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731629AbeGTNdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:33:08 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E01D42DE; Fri, 20 Jul 2018 14:45:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532090701; bh=UwLYLK0IkDKUszhVdivSbtE2OBXrAEDE2ykuS39IjOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQ8O1D30ia+fUY+g+G7v++8B61i6V7QxV2PtmSKJ/ZfyGKysx+JE/cXMEQAViJajU
         6wiCGTC8C7SiX+elmUv8thDQ7PjK3cdWJY9Iy7j5pKxWsDAZYJo+pitamiHmJk8akN
         pBKcJhyG1gMpJjpNW3mf3M3w4idKyExlKfYhfbwtNMTSwsnTKROH/wBx+5du/scO/6
         nqWB9FBSr27mu7fSkieyizJsgLWyO+ZxXqDrdsknwq1bHUn808LjJp3g05dGBfLDSv
         tebVV9zvxaRxBDDajGhDk52VLSTRzwjo/rUEHYPDz4nysZYI9mD8HNmy8uf368QTu7
         BmlFdfJRmNQuQ==
Date:   Fri, 20 Jul 2018 14:45:01 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        peterx@redhat.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] iommu/vt-d: Improve PASID id and table management
Message-ID: <20180720124500.rvtprtyemfmddbbt@8bytes.org>
References: <1531554422-6874-1-git-send-email-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531554422-6874-1-git-send-email-baolu.lu@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 03:46:53PM +0800, Lu Baolu wrote:
> Lu Baolu (9):
>   iommu/vt-d: Global PASID name space
>   iommu/vt-d: Avoid using idr_for_each_entry()
>   iommu/vt-d: Apply global PASID in SVA
>   iommu/vt-d: Move device_domain_info to header
>   iommu/vt-d: Add for_each_device_domain() helper
>   iommu/vt-d: Per PCI device pasid table interfaces
>   iommu/vt-d: Allocate and free pasid table
>   iommu/vt-d: Apply per pci device pasid table in SVA
>   iommu/vt-d: Remove the obsolete per iommu pasid tables

Applied, thanks.

