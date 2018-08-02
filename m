Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D424CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D6E208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D6E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeHBGG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 02:06:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbeHBGG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 02:06:27 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 43917A0F69DE6;
        Thu,  2 Aug 2018 12:17:12 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 2 Aug 2018
 12:17:06 +0800
Date:   Thu, 2 Aug 2018 12:15:47 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Kenneth Lee <nek.in.cn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 2/7] iommu: Add share domain interface in iommu for
 spimdev
Message-ID: <20180802041547.GM160746@Turing-Arch-b>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801102221.5308-3-nek.in.cn@gmail.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290F49@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191290F49@SHSMSX101.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 03:17:03AM +0000, Tian, Kevin wrote:
> Date: Thu, 2 Aug 2018 03:17:03 +0000
> From: "Tian, Kevin" <kevin.tian@intel.com>
> To: Kenneth Lee <nek.in.cn@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
>  Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
>  <davem@davemloft.net>, Joerg Roedel <joro@8bytes.org>, Alex Williamson
>  <alex.williamson@redhat.com>, Kenneth Lee <liguozhu@hisilicon.com>, Hao
>  Fang <fanghao11@huawei.com>, Zhou Wang <wangzhou1@hisilicon.com>, Zaibo Xu
>  <xuzaibo@huawei.com>, Philippe Ombredanne <pombredanne@nexb.com>, Greg
>  Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner
>  <tglx@linutronix.de>, "linux-doc@vger.kernel.org"
>  <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
>  <linux-kernel@vger.kernel.org>, "linux-crypto@vger.kernel.org"
>  <linux-crypto@vger.kernel.org>, "iommu@lists.linux-foundation.org"
>  <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org"
>  <kvm@vger.kernel.org>, "linux-accelerators@lists.ozlabs.org"
>  <linux-accelerators@lists.ozlabs.org>, Lu Baolu
>  <baolu.lu@linux.intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>
> CC: "linuxarm@huawei.com" <linuxarm@huawei.com>
> Subject: RE: [RFC PATCH 2/7] iommu: Add share domain interface in iommu for
>  spimdev
> Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191290F49@SHSMSX101.ccr.corp.intel.com>
> 
> > From: Kenneth Lee
> > Sent: Wednesday, August 1, 2018 6:22 PM
> > 
> > From: Kenneth Lee <liguozhu@hisilicon.com>
> > 
> > This patch add sharing interface for a iommu_group. The new interface:
> > 
> > 	iommu_group_share_domain()
> > 	iommu_group_unshare_domain()
> > 
> > can be used by some virtual iommu_group (such as iommu_group for
> > spimdev)
> > to share their parent's iommu_group.
> > 
> > When the domain of the group is shared, it cannot be changed before
> > unshared.  In the future, notification can be added if update is required.
> 
> Is it necessary or just asking VFIO to use parent domain directly? 
> 
Even we add to VFIO, the iommu still need to be changed. We can move the type1
part to VFIO if we have agreement in RFC stage.
> > 
> > Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> > ---
> >  drivers/iommu/iommu.c | 28 +++++++++++++++++++++++++++-
> >  include/linux/iommu.h |  2 ++
> >  2 files changed, 29 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 63b37563db7e..a832aafe660d 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -54,6 +54,9 @@ struct iommu_group {
> >  	int id;
> >  	struct iommu_domain *default_domain;
> >  	struct iommu_domain *domain;
> > +	atomic_t domain_shared_ref; /* Number of user of current domain.
> > +				     * The domain cannot be modified if ref >
> > 0
> > +				     */
> >  };
> > 
> >  struct group_device {
> > @@ -353,6 +356,7 @@ struct iommu_group *iommu_group_alloc(void)
> >  		return ERR_PTR(ret);
> >  	}
> >  	group->id = ret;
> > +	atomic_set(&group->domain_shared_ref, 0);
> > 
> >  	ret = kobject_init_and_add(&group->kobj, &iommu_group_ktype,
> >  				   NULL, "%d", group->id);
> > @@ -482,6 +486,25 @@ int iommu_group_set_name(struct iommu_group
> > *group, const char *name)
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_group_set_name);
> > 
> > +struct iommu_domain *iommu_group_share_domain(struct
> > iommu_group *group)
> > +{
> > +	/* the domain can be shared only when the default domain is used
> > */
> > +	/* todo: more shareable check */
> > +	if (group->domain != group->default_domain)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	atomic_inc(&group->domain_shared_ref);
> > +	return group->domain;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_group_share_domain);
> > +
> > +void iommu_group_unshare_domain(struct iommu_group *group)
> > +{
> > +	atomic_dec(&group->domain_shared_ref);
> > +	WARN_ON(atomic_read(&group->domain_shared_ref) < 0);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_group_unshare_domain);
> > +
> >  static int iommu_group_create_direct_mappings(struct iommu_group
> > *group,
> >  					      struct device *dev)
> >  {
> > @@ -1401,7 +1424,8 @@ static int __iommu_attach_group(struct
> > iommu_domain *domain,
> >  {
> >  	int ret;
> > 
> > -	if (group->default_domain && group->domain != group-
> > >default_domain)
> > +	if ((group->default_domain && group->domain != group-
> > >default_domain) ||
> > +	     atomic_read(&group->domain_shared_ref) > 0)
> >  		return -EBUSY;
> > 
> >  	ret = __iommu_group_for_each_dev(group, domain,
> > @@ -1438,6 +1462,8 @@ static void __iommu_detach_group(struct
> > iommu_domain *domain,
> >  {
> >  	int ret;
> > 
> > +	WARN_ON(atomic_read(&group->domain_shared_ref) > 0);
> > +
> >  	if (!group->default_domain) {
> >  		__iommu_group_for_each_dev(group, domain,
> >  					   iommu_group_do_detach_device);
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 19938ee6eb31..278d60e3ec39 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -349,6 +349,8 @@ extern int iommu_domain_get_attr(struct
> > iommu_domain *domain, enum iommu_attr,
> >  				 void *data);
> >  extern int iommu_domain_set_attr(struct iommu_domain *domain, enum
> > iommu_attr,
> >  				 void *data);
> > +extern struct iommu_domain *iommu_group_share_domain(struct
> > iommu_group *group);
> > +extern void iommu_group_unshare_domain(struct iommu_group *group);
> > 
> >  /* Window handling function prototypes */
> >  extern int iommu_domain_window_enable(struct iommu_domain
> > *domain, u32 wnd_nr,
> > --
> > 2.17.1

-- 
			-Kenneth(Hisilicon)

================================================================================
本邮件及其附件含有华为公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁
止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中
的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！
This e-mail and its attachments contain confidential information from HUAWEI,
which is intended only for the person or entity whose address is listed above.
Any use of the 
information contained herein in any way (including, but not limited to, total or
partial disclosure, reproduction, or dissemination) by persons other than the
intended 
recipient(s) is prohibited. If you receive this e-mail in error, please notify
the sender by phone or email immediately and delete it!

