Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CC4C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97922077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97922077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeIEH3v convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 03:29:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:44324 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeIEH3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 03:29:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 20:01:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,331,1531810800"; 
   d="scan'208";a="71672849"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga006.jf.intel.com with ESMTP; 04 Sep 2018 20:01:42 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 20:01:42 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 20:01:42 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.16]) with mapi id 14.03.0319.002;
 Wed, 5 Sep 2018 11:01:40 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Thread-Topic: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Thread-Index: AQHUQBd63AINefsFr0WaDhgLiguCyqThBixA
Date:   Wed, 5 Sep 2018 03:01:39 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1912F128F@SHSMSX101.ccr.corp.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
In-Reply-To: <20180830040922.30426-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjI0Njc5ZDUtNWJlZS00MDQ0LWFjZWEtNGY3ZmRhMjgwNTUyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNjRFSHlYMXJENXE0S2pTQk9pQmo2cUo5TzZ4a0dEYVAzZ21cL0pOMllSbFwvRHo5WEtwOHJJRWVUb3p6MWQ1bkVYIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Thursday, August 30, 2018 12:09 PM
> 
[...]
> 
> In order to distinguish the IOMMU-capable mediated devices from those
> which still need to rely on parent devices, this patch set adds a
> domain type attribute to each mdev.
> 
> enum mdev_domain_type {
> 	DOMAIN_TYPE_NO_IOMMU,	/* Don't need any IOMMU support.
> 				 * All isolation and protection
> 				 * are handled by the parent
> 				 * device driver with a device
> 				 * specific mechanism.
> 				 */
> 	DOMAIN_TYPE_ATTACH_PARENT, /* IOMMU can isolate and
> protect
> 				    * the mdev, and the isolation
> 				    * domain should be attaced with
> 				    * the parent device.
> 				    */
> };
> 

ATTACH_PARENT is not like a good counterpart to NO_IOMMU.

what about DOMAIN_TYPE_NO_IOMMU/DOMAIN_TYPE_IOMMU? whether
to attach parent device is just internal logic.

Alternatively DOMAIN_TYPE_SOFTWARE/DOMAIN_TYPE_HARDWARE,
where software means iommu_domain is managed by software while
the other means managed by hardware.

One side note to Alex - with multiple domain extension in IOMMU layer,
this version combines IOMMU-capable usages in VFIO: PASID-based (as 
in scalable iov) and RID-based (as the usage of mdev wrapper on any 
device). Both cases share the common path - just binding the domain to the
parent device of mdev. IOMMU layer will handle two cases differently later. 

Thanks
Kevin
