Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294FFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77032184D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeLRCOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:14:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16145 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbeLRCOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:14:20 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2C3B6DAE31A9E;
        Tue, 18 Dec 2018 10:14:17 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 10:14:15 +0800
Subject: Re: [PATCH v10 6/6] ACPI/IORT: Stub out ACS functions when CONFIG_PCI
 is not set
To:     Sinan Kaya <okaya@kernel.org>, <linux-acpi@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181215010247.26101-1-okaya@kernel.org>
 <20181215010247.26101-7-okaya@kernel.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <40e31e86-a4ac-d9a6-d752-b04203d5ced7@huawei.com>
Date:   Tue, 18 Dec 2018 10:14:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20181215010247.26101-7-okaya@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sinan,

On 2018/12/15 9:02, Sinan Kaya wrote:
> Remove PCI dependent code out of iort.c when CONFIG_PCI is not defined.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/arm64/iort.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 70f4e80b9246..d0f68607efe6 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1437,6 +1437,7 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>  
>  static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  {
> +#ifdef CONFIG_PCI
>  	if (iort_node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
>  		struct acpi_iort_node *parent;
>  		struct acpi_iort_id_mapping *map;
> @@ -1462,6 +1463,7 @@ static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  			}
>  		}
>  	}
> +#endif

I prefer stub function for iort_enable_acs(), not adding #ifdef/#endif pair inside
this function.

By the way, there are other pci function called in iort.c, could you explain a
little bit why no need to update other function calls in commit message?

Thanks
Hanjun

