Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E0AECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35872208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35872208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbeGMJnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:43:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59880 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbeGMJnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:43:14 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CECD1A99D97F7;
        Fri, 13 Jul 2018 17:29:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 17:29:19 +0800
Subject: Re: [PATCH] ACPI: button: hide unused procfs helpers
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
References: <20180713071959.11220-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <ade2d23b-bfc9-b828-aa18-ff5e1c87a40d@huawei.com>
Date:   Fri, 13 Jul 2018 17:29:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180713071959.11220-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for noise,there has a fix:

[PATCH] acpi/button.c: fix defined but not used warning
https://lkml.org/lkml/2018/7/11/231

On 2018/7/13 15:19, YueHaibing wrote:
> When CONFIG_PROC_FS isn't set, gcc warning this:
> 
> drivers/acpi/button.c:255:12: warning: ‘acpi_button_state_seq_show’ defined but not used [-Wunused-function]
>  static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
>             ^
> fix this by adding #ifdef around it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/acpi/button.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 2345a5e..8538e25 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -252,6 +252,7 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PROC_FS
>  static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
>  {
>  	struct acpi_device *device = seq->private;
> @@ -262,6 +263,7 @@ static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
>  		   state < 0 ? "unsupported" : (state ? "open" : "closed"));
>  	return 0;
>  }
> +#endif
>  
>  static int acpi_button_add_fs(struct acpi_device *device)
>  {
> 

