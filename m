Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1021AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A714F20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IikqCr5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A714F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeLCQ2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:28:09 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9386 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeLCQ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:28:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c0559980001>; Mon, 03 Dec 2018 08:28:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Dec 2018 08:28:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Dec 2018 08:28:06 -0800
Received: from [10.24.70.32] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 3 Dec
 2018 16:27:57 +0000
Subject: Re: [PATCH v4 6/8] vfio/mdev: Add iommu place holders in mdev_device
To:     Christoph Hellwig <hch@infradead.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
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
 <339ab9c8-08e1-ce2f-6f71-99a06e4b82f3@nvidia.com>
 <20181121084529.GA21766@infradead.org>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <fa1bdd92-c4c1-8ed4-a06a-13bc253ceed6@nvidia.com>
Date:   Mon, 3 Dec 2018 21:57:49 +0530
MIME-Version: 1.0
In-Reply-To: <20181121084529.GA21766@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543854489; bh=b4DkH+vuCTwYtgytDBxVHRcaPrIJH0q5/BjSkcGcvFM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=IikqCr5fVqXYDx9uFeTTxMn5N2q1jTZV0AzWZAxPdX2QCd8szwQVe/tLpmqm4h/3I
         2o7o99T/2QY4eVDxQ/KQjrzNsBkyryRnZGIEMBqbQZ9COWmilXBwEhfAoBGdV0hSuq
         aAW5nBwOJx9BdDtU1AFla/49EVh03jQQhlMIAGvHA6OOLUcqLcd8mnExB8Q4U/POAI
         qYKx1p3VcBZZjF+FJ1EPEhU1WO/XO7yZ+lkna99fE4XQP+RigHVx95Ev4GUQcMW2C9
         3GKKU8iBDGN2lN59eonQkiid1pebZgDe0dYQaumZcI7/Ojt8ng2hBKXFQh2fiyUUa9
         PztZPo1ClKnYw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2018 2:15 PM, Christoph Hellwig wrote:
> On Wed, Nov 21, 2018 at 02:22:08AM +0530, Kirti Wankhede wrote:
>> It is about how mdev framework can be used by existing drivers. These
>> symbols doesn't use any other exported symbols.
> 
> That is an unfortunate accident of history, but doesn't extent to new
> ones.  It also is another inidicator those drivers probably are derived
> works of the Linux kernel and might be in legal trouble one way or
> another.
> 

These symbols are just to associate iommu properties of a physical
device with a mdev device, doesn't include low-level information.

Thanks,	
Kirti
