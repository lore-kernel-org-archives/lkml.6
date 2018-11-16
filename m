Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E272AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A478B208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cd5MRSmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A478B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389421AbeKPTIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:08:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeKPTIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jNRgUV73qYR9qD/4068w+PW/ZWPCC7t7UkmuthIlIvU=; b=Cd5MRSmEm1QtI8vTDZeo7noYB
        LUMqJImkSOZpDLEL2tnaT0O9Zgl+gsWJe7JektFj7BvD/EHpA7NEZqNsct05IfW+ymrAbNSDflDEs
        ZpKozLLTNm8MVbNZYJSI7EzUnp9C2TsYiUhGuSnksJdJuuiwMAVySMn2tg0EbzbWeS4BZCcU0Hp0Y
        zIHNvI7fj4VY7lJXFbmRXdatftC7QhOv0GUVijZQxOHwBIruU+/qxnLePrSU5PdlbMD1t+bXDtGl7
        Du3GR8dS7+z1kbb+pcZC4W5r0ikjDw5684njoLl5+lHz/d82pYZm6xcFaGFSevk9hKgdmEiHUUn5D
        st+NZi5gw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZwA-0003UI-60; Fri, 16 Nov 2018 08:57:14 +0000
Date:   Fri, 16 Nov 2018 00:57:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 6/8] vfio/mdev: Add iommu place holders in mdev_device
Message-ID: <20181116085714.GA13181@infradead.org>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
 <20181105073408.21815-7-baolu.lu@linux.intel.com>
 <20181106165356.44b59ec3@w520.home>
 <edadb198-e4ab-ac23-4520-28bfcac252c3@linux.intel.com>
 <7bfc2f2b-10e6-b53c-51f3-c6494b686aa3@nvidia.com>
 <25b9a20f-06b5-57ac-81f1-fd933845c77f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25b9a20f-06b5-57ac-81f1-fd933845c77f@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 09:20:48AM +0800, Lu Baolu wrote:
> > Please keep symbols mdev_set/get_iommu_device(dev, iommu_device) non-GPL
> > same as other exported symbols from mdev_core module.
> 
> Yes. It will be fixed in the next version.

No.  mdev shall not be used to circumvent the exports in the generic
vfio code.
