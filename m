Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B82AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420C8208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420C8208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbeGMJpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:45:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbeGMJpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:45:14 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4D895C3726850;
        Fri, 13 Jul 2018 17:31:21 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 17:31:22 +0800
Subject: Re: [PATCH] connector: hide unused procfs helpers
To:     <zbr@ioremap.net>
References: <20180713071141.15996-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <b9d2c823-56c3-b861-b56f-1ea83491e26a@huawei.com>
Date:   Fri, 13 Jul 2018 17:31:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180713071141.15996-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pls ignore this,my bad.

On 2018/7/13 15:11, YueHaibing wrote:
> When CONFIG_PROC_FS isn't set, gcc warning this:
> 
> drivers/connector/connector.c:242:12: warning: ‘cn_proc_show’ defined but not used [-Wunused-function]
>  static int cn_proc_show(struct seq_file *m, void *v)
>             ^
> fix this by adding #ifdef around it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/connector/connector.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
> index e718b8c..e2636d4 100644
> --- a/drivers/connector/connector.c
> +++ b/drivers/connector/connector.c
> @@ -239,6 +239,7 @@ void cn_del_callback(struct cb_id *id)
>  }
>  EXPORT_SYMBOL_GPL(cn_del_callback);
>  
> +#ifdef CONFIG_PROC_FS
>  static int cn_proc_show(struct seq_file *m, void *v)
>  {
>  	struct cn_queue_dev *dev = cdev.cbdev;
> @@ -259,6 +260,7 @@ static int cn_proc_show(struct seq_file *m, void *v)
>  
>  	return 0;
>  }
> +#endif
>  
>  static struct cn_dev cdev = {
>  	.input   = cn_rx_skb,
> 

