Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2878C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3C021479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="REFSGg0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3C021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeKUTTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:19:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbeKUTTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ImXntfnjWxLNLwY0vNf6304naOv6EJJCfDzdkT1R29o=; b=REFSGg0yrfFaQsRTtoxDQx3SV
        3uxrwWEzxwdwlPMajZqdtE1z1JAZNfNLtKVIfPceFDY89MVRtRvYkLB/FHwNaVStIoHAOi2U9v4LT
        VS5KdwmjXLVVmGL/rLvoSgmaKOsK27Oqgta7BvbQ80+/tqQrmMosiLanIs2H0+Vk6Sh3LKtsjvFFy
        nsWGxVyPFusXUktYX8aNG9D9MV0muEzRCeS/P8pgSw1JOBhBVXh2mzVxco5RLOyk16svTuLSk3mTj
        3veJQLbrHafwLjprQSjQGooab5iTMEOTbuauPl1JPeA1HEZMGRnLF+Y6hzAwQaY8ek65HS64vphlO
        sNOMpGSiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPO8X-0006wV-LP; Wed, 21 Nov 2018 08:45:29 +0000
Date:   Wed, 21 Nov 2018 00:45:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Kirti Wankhede <kwankhede@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
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
Message-ID: <20181121084529.GA21766@infradead.org>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
 <20181105073408.21815-7-baolu.lu@linux.intel.com>
 <20181106165356.44b59ec3@w520.home>
 <edadb198-e4ab-ac23-4520-28bfcac252c3@linux.intel.com>
 <7bfc2f2b-10e6-b53c-51f3-c6494b686aa3@nvidia.com>
 <25b9a20f-06b5-57ac-81f1-fd933845c77f@linux.intel.com>
 <20181116085714.GA13181@infradead.org>
 <339ab9c8-08e1-ce2f-6f71-99a06e4b82f3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <339ab9c8-08e1-ce2f-6f71-99a06e4b82f3@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 02:22:08AM +0530, Kirti Wankhede wrote:
> It is about how mdev framework can be used by existing drivers. These
> symbols doesn't use any other exported symbols.

That is an unfortunate accident of history, but doesn't extent to new
ones.  It also is another inidicator those drivers probably are derived
works of the Linux kernel and might be in legal trouble one way or
another.
