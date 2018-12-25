Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0429C64E75
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 02:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DF4218CD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 02:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbeLYCpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 21:45:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17057 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbeLYCpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 21:45:25 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AB89C44D25E17;
        Tue, 25 Dec 2018 10:45:21 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Tue, 25 Dec 2018
 10:45:18 +0800
Subject: Re: [PATCH -next] ACPI/IORT: fix build when CONFIG_IOMMU_API=n
To:     Qian Cai <cai@lca.pw>, <sfr@canb.auug.org.au>,
        <lorenzo.pieralisi@arm.com>, <hanjun.guo@linaro.org>,
        <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-next@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181224172058.56206-1-cai@lca.pw>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <31c013ad-1261-7ca4-2434-69911d5d2cb8@huawei.com>
Date:   Tue, 25 Dec 2018 10:44:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20181224172058.56206-1-cai@lca.pw>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

Good catch, minor comments below.

On 2018/12/25 1:20, Qian Cai wrote:
> rivers/acpi/arm64/iort.c:880:1: error: expected identifier or '(' before '{' token
  ^^
  drivers

>  { return NULL; }
>  ^
> drivers/acpi/arm64/iort.c:879:39: warning: 'iort_fwspec_iommu_ops' used but never defined
>  static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
>                                        ^~~~~~~~~~~~~~~~~~~~~
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/acpi/arm64/iort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index fdd90ffceb85..5d29783ee5bd 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -876,7 +876,7 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  	return (resv == its->its_count) ? resv : -ENODEV;
>  }
>  #else
> -static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
> +static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
>  { return NULL; }
>  static inline int iort_add_device_replay(const struct iommu_ops *ops,
>  					 struct device *dev)

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Lorenzo, I think this is 4.21-rc1 material if it's OK for you.

Thanks
Hanjun

