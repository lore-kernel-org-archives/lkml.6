Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED932C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E2820851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cMoJDXUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E2820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeKUHXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:23:30 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11332 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeKUHXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:23:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf474120000>; Tue, 20 Nov 2018 12:52:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Nov 2018 12:52:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Nov 2018 12:52:27 -0800
Received: from [10.24.70.221] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Nov
 2018 20:52:17 +0000
Subject: Re: [PATCH v4 6/8] vfio/mdev: Add iommu place holders in mdev_device
To:     Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, <ashok.raj@intel.com>,
        <sanjay.k.kumar@intel.com>, <jacob.jun.pan@intel.com>,
        <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        <yi.l.liu@intel.com>, <yi.y.sun@intel.com>, <peterx@redhat.com>,
        <tiwei.bie@intel.com>, Zeng Xin <xin.zeng@intel.com>,
        <iommu@lists.linux-foundation.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
 <20181105073408.21815-7-baolu.lu@linux.intel.com>
 <20181106165356.44b59ec3@w520.home>
 <edadb198-e4ab-ac23-4520-28bfcac252c3@linux.intel.com>
 <7bfc2f2b-10e6-b53c-51f3-c6494b686aa3@nvidia.com>
 <25b9a20f-06b5-57ac-81f1-fd933845c77f@linux.intel.com>
 <20181116085714.GA13181@infradead.org>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <339ab9c8-08e1-ce2f-6f71-99a06e4b82f3@nvidia.com>
Date:   Wed, 21 Nov 2018 02:22:08 +0530
MIME-Version: 1.0
In-Reply-To: <20181116085714.GA13181@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542747156; bh=yvM1QKTqFWlH3+qo8PmYd3d93xGe8TcMpDHDlI7pRLs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cMoJDXUk14mEFSRzelZDQw2SeOaPOt1opY1mXK/j9dCEqoPAAwRnWfX1pkt6s5+mt
         i/kLhNJWdRJrg0kGRRbS1GZPsb/Erj3hnp/ta6p2Ti1kiSJ53YL2Cd6XIKhy7y4vAN
         Rx6RX8N7IWtw2tnQxspT/nsoxIlLiLIJn6+ad1wfmy19G/eVI/7ppaNTQnSdiLCS+5
         dbMZdpsPdFnkb9JC1FjnQBaD8F1n2Jb7y0delvT8EK9SwMdLB4RjyqNMOAeMbYl+Vh
         P2hz+kx5HXlUe2PpfN1JYWsf6OTYuFv6+5kpkjYIxcfQYnwNrqhq+ohVKj1qCXjj1l
         SdYShJ4/9Y7tA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2018 2:27 PM, Christoph Hellwig wrote:
> On Fri, Nov 16, 2018 at 09:20:48AM +0800, Lu Baolu wrote:
>>> Please keep symbols mdev_set/get_iommu_device(dev, iommu_device) non-GPL
>>> same as other exported symbols from mdev_core module.
>>
>> Yes. It will be fixed in the next version.
> 
> No.  mdev shall not be used to circumvent the exports in the generic
> vfio code.
> 

It is about how mdev framework can be used by existing drivers. These
symbols doesn't use any other exported symbols.

Thanks,
Kirti
