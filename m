Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651E1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB21E20862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB21E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeHBFGc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 01:06:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:39079 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbeHBFGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 01:06:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 20:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,434,1526367600"; 
   d="scan'208";a="71886148"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2018 20:17:07 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 20:17:07 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 20:17:07 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.124]) with mapi id 14.03.0319.002;
 Thu, 2 Aug 2018 11:17:05 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Kenneth Lee <nek.in.cn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>
CC:     "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [RFC PATCH 2/7] iommu: Add share domain interface in iommu for
 spimdev
Thread-Topic: [RFC PATCH 2/7] iommu: Add share domain interface in iommu for
 spimdev
Thread-Index: AQHUKYHWQk1Lvdz7XEqv7xkSwudUdqSryvAw
Date:   Thu, 2 Aug 2018 03:17:03 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191290F49@SHSMSX101.ccr.corp.intel.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801102221.5308-3-nek.in.cn@gmail.com>
In-Reply-To: <20180801102221.5308-3-nek.in.cn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzJkMWU2MzQtYTg1NS00YWFmLWJkMjctMWQ3YjE3MGU3NDdjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK2FvWVNXTG4zKzVFQUJYK3dZK0lzK0JiZGI2eXNocjZxQlFWZXpYTGk4MnA2Zm5VSDBtNDZSc2UySTJQbkVhaiJ9
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

> From: Kenneth Lee
> Sent: Wednesday, August 1, 2018 6:22 PM
> 
> From: Kenneth Lee <liguozhu@hisilicon.com>
> 
> This patch add sharing interface for a iommu_group. The new interface:
> 
> 	iommu_group_share_domain()
> 	iommu_group_unshare_domain()
> 
> can be used by some virtual iommu_group (such as iommu_group for
> spimdev)
> to share their parent's iommu_group.
> 
> When the domain of the group is shared, it cannot be changed before
> unshared.  In the future, notification can be added if update is required.

Is it necessary or just asking VFIO to use parent domain directly? 

> 
> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> ---
>  drivers/iommu/iommu.c | 28 +++++++++++++++++++++++++++-
>  include/linux/iommu.h |  2 ++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 63b37563db7e..a832aafe660d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -54,6 +54,9 @@ struct iommu_group {
>  	int id;
>  	struct iommu_domain *default_domain;
>  	struct iommu_domain *domain;
> +	atomic_t domain_shared_ref; /* Number of user of current domain.
> +				     * The domain cannot be modified if ref >
> 0
> +				     */
>  };
> 
>  struct group_device {
> @@ -353,6 +356,7 @@ struct iommu_group *iommu_group_alloc(void)
>  		return ERR_PTR(ret);
>  	}
>  	group->id = ret;
> +	atomic_set(&group->domain_shared_ref, 0);
> 
>  	ret = kobject_init_and_add(&group->kobj, &iommu_group_ktype,
>  				   NULL, "%d", group->id);
> @@ -482,6 +486,25 @@ int iommu_group_set_name(struct iommu_group
> *group, const char *name)
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_set_name);
> 
> +struct iommu_domain *iommu_group_share_domain(struct
> iommu_group *group)
> +{
> +	/* the domain can be shared only when the default domain is used
> */
> +	/* todo: more shareable check */
> +	if (group->domain != group->default_domain)
> +		return ERR_PTR(-EINVAL);
> +
> +	atomic_inc(&group->domain_shared_ref);
> +	return group->domain;
> +}
> +EXPORT_SYMBOL_GPL(iommu_group_share_domain);
> +
> +void iommu_group_unshare_domain(struct iommu_group *group)
> +{
> +	atomic_dec(&group->domain_shared_ref);
> +	WARN_ON(atomic_read(&group->domain_shared_ref) < 0);
> +}
> +EXPORT_SYMBOL_GPL(iommu_group_unshare_domain);
> +
>  static int iommu_group_create_direct_mappings(struct iommu_group
> *group,
>  					      struct device *dev)
>  {
> @@ -1401,7 +1424,8 @@ static int __iommu_attach_group(struct
> iommu_domain *domain,
>  {
>  	int ret;
> 
> -	if (group->default_domain && group->domain != group-
> >default_domain)
> +	if ((group->default_domain && group->domain != group-
> >default_domain) ||
> +	     atomic_read(&group->domain_shared_ref) > 0)
>  		return -EBUSY;
> 
>  	ret = __iommu_group_for_each_dev(group, domain,
> @@ -1438,6 +1462,8 @@ static void __iommu_detach_group(struct
> iommu_domain *domain,
>  {
>  	int ret;
> 
> +	WARN_ON(atomic_read(&group->domain_shared_ref) > 0);
> +
>  	if (!group->default_domain) {
>  		__iommu_group_for_each_dev(group, domain,
>  					   iommu_group_do_detach_device);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 19938ee6eb31..278d60e3ec39 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -349,6 +349,8 @@ extern int iommu_domain_get_attr(struct
> iommu_domain *domain, enum iommu_attr,
>  				 void *data);
>  extern int iommu_domain_set_attr(struct iommu_domain *domain, enum
> iommu_attr,
>  				 void *data);
> +extern struct iommu_domain *iommu_group_share_domain(struct
> iommu_group *group);
> +extern void iommu_group_unshare_domain(struct iommu_group *group);
> 
>  /* Window handling function prototypes */
>  extern int iommu_domain_window_enable(struct iommu_domain
> *domain, u32 wnd_nr,
> --
> 2.17.1

