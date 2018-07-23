Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C07ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BC920875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BC920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeGWFnW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:43:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:44545 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbeGWFnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:43:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2018 21:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,392,1526367600"; 
   d="scan'208";a="74613922"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jul 2018 21:44:05 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 22 Jul 2018 21:44:05 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 22 Jul 2018 21:44:04 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.81]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.100]) with mapi id 14.03.0319.002;
 Mon, 23 Jul 2018 12:44:02 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [RFC PATCH 01/10] iommu/vt-d: Get iommu device for a mediated
 device
Thread-Topic: [RFC PATCH 01/10] iommu/vt-d: Get iommu device for a mediated
 device
Thread-Index: AQHUIYLQvaMsWWgebE2FI8WhWuxkaqScJFbg
Date:   Mon, 23 Jul 2018 04:44:02 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439CA141D@SHSMSX104.ccr.corp.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-2-git-send-email-baolu.lu@linux.intel.com>
In-Reply-To: <1532239773-15325-2-git-send-email-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGMyNzc0YTYtMDhhMy00NTNkLThjZmItMjdjOGU2Y2JlODg2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieGlSaEJBUW1nR2U0ZjBaMzUwVUtLcGRqcjlYY3hKWWk5RG9OaUtVaTNBT2Q0WFVaNWZVUG95U25rY1RadVM0cyJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

Per my understanding, the subject is not accurate. I think this patch is
to get parent device structure for a mediate device instead of iommu
device. This may be misleading for reviewers.

Thanks,
Yi Liu

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Sunday, July 22, 2018 2:09 PM
> 
> This patch adds the support to get the iommu device for a mediated device. The
> assumption is that each mediated device is a minimal assignable set of a physical PCI
> device. Hence, we should use the iommu device of the parent PCI device to manage
> the translation.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c |  6 ++++++  drivers/iommu/intel-pasid.h | 16
> ++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
> 7d198ea..fc3ac1c 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -767,6 +767,12 @@ static struct intel_iommu *device_to_iommu(struct device
> *dev, u8 *bus, u8 *devf
>  	if (iommu_dummy(dev))
>  		return NULL;
> 
> +	if (dev_is_mdev(dev)) {
> +		dev = dev_mdev_parent(dev);
> +		if (WARN_ON(!dev_is_pci(dev)))
> +			return NULL;
> +	}
> +
>  	if (dev_is_pci(dev)) {
>  		struct pci_dev *pf_pdev;
> 
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h index
> 518df72..46cde66 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -35,6 +35,22 @@ struct pasid_table {
>  	struct list_head	dev;		/* device list */
>  };
> 
> +static inline bool dev_is_mdev(struct device *dev) {
> +	if (!dev)
> +		return false;
> +
> +	return !strcmp(dev->bus->name, "mdev"); }
> +
> +static inline struct device *dev_mdev_parent(struct device *dev) {
> +	if (WARN_ON(!dev_is_mdev(dev)))
> +		return NULL;
> +
> +	return dev->parent;
> +}
> +
>  extern u32 intel_pasid_max_id;
>  int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);  void
> intel_pasid_free_id(int pasid);
> --
> 2.7.4

