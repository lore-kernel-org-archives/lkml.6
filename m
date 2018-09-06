Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8AEC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F80D20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F80D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbeIFTE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:04:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729881AbeIFTE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:04:26 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DBB9FE665C60A;
        Thu,  6 Sep 2018 22:28:29 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Thu, 6 Sep 2018
 22:28:28 +0800
Message-ID: <5B91398B.8060702@huawei.com>
Date:   Thu, 6 Sep 2018 22:28:27 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <jkosina@suse.cz>, <rafael.j.wysocki@intel.com>,
        <rusty@rustcorp.com.au>
Subject: Re: [PATCH] acpi: remove a meaningless null check before debugfs_remove
References: <1534589360-64938-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1534589360-64938-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+to maintainers

On 2018/8/18 18:49, zhong jiang wrote:
> debugfs_remove has taken null pointer into account. So it is safe
> to remove the check before debugfs_remove.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/acpi/custom_method.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index e967c11..4451877 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -92,8 +92,7 @@ static int __init acpi_custom_method_init(void)
>  
>  static void __exit acpi_custom_method_exit(void)
>  {
> -	if (cm_dentry)
> -		debugfs_remove(cm_dentry);
> +	debugfs_remove(cm_dentry);
>  }
>  
>  module_init(acpi_custom_method_init);


