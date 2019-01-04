Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBBDC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5742E21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfADQRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:17:02 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45420 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfADQRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:17:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9865515AD;
        Fri,  4 Jan 2019 08:17:00 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B4BA3F5D4;
        Fri,  4 Jan 2019 08:16:58 -0800 (PST)
Date:   Fri, 4 Jan 2019 16:16:53 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Qian Cai <cai@lca.pw>, sfr@canb.auug.org.au, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, linux-acpi@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ACPI/IORT: fix build when CONFIG_IOMMU_API=n
Message-ID: <20190104161653.GA18795@e107981-ln.cambridge.arm.com>
References: <20181224172058.56206-1-cai@lca.pw>
 <31c013ad-1261-7ca4-2434-69911d5d2cb8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31c013ad-1261-7ca4-2434-69911d5d2cb8@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 10:44:38AM +0800, Hanjun Guo wrote:
> Hi Qian,
> 
> Good catch, minor comments below.
> 
> On 2018/12/25 1:20, Qian Cai wrote:
> > rivers/acpi/arm64/iort.c:880:1: error: expected identifier or '(' before '{' token
>   ^^
>   drivers
> 
> >  { return NULL; }
> >  ^
> > drivers/acpi/arm64/iort.c:879:39: warning: 'iort_fwspec_iommu_ops' used but never defined
> >  static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
> >                                        ^~~~~~~~~~~~~~~~~~~~~
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  drivers/acpi/arm64/iort.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index fdd90ffceb85..5d29783ee5bd 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -876,7 +876,7 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> >  	return (resv == its->its_count) ? resv : -ENODEV;
> >  }
> >  #else
> > -static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
> > +static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
> >  { return NULL; }
> >  static inline int iort_add_device_replay(const struct iommu_ops *ops,
> >  					 struct device *dev)
> 
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Lorenzo, I think this is 4.21-rc1 material if it's OK for you.

It is a bit late for -rc1 but I will send it asap, with a proper Fixes:
tag that points at the commit that introduced the typo.

Lorenzo
