Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE342ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AB2208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AB2208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbeGMJpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:45:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60749 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbeGMJpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:45:36 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2C2C9AA6334B6;
        Fri, 13 Jul 2018 17:31:43 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 17:31:39 +0800
Subject: Re: [PATCH 03/10] atmel: hide unused procfs helpers
To:     <simon@thekelleys.org.uk>, <kvalo@codeaurora.org>
References: <20180713064658.10340-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <davem@davemloft.net>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <ded55181-e1b0-99e9-ac68-2d93fb6168c0@huawei.com>
Date:   Fri, 13 Jul 2018 17:31:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180713064658.10340-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pls ignore this,my bad.

On 2018/7/13 14:46, YueHaibing wrote:
> When CONFIG_PROC_FS isn't set, gcc warning this:
> 
> drivers/net/wireless/atmel/atmel.c:1402:12: warning: ‘atmel_proc_show’ defined but not used [-Wunused-function]
>  static int atmel_proc_show(struct seq_file *m, void *v)
>             ^
> fix this by adding #ifdef around it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/wireless/atmel/atmel.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
> index b01dc34..3940876 100644
> --- a/drivers/net/wireless/atmel/atmel.c
> +++ b/drivers/net/wireless/atmel/atmel.c
> @@ -1399,6 +1399,7 @@ static int atmel_validate_channel(struct atmel_private *priv, int channel)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PROC_FS
>  static int atmel_proc_show(struct seq_file *m, void *v)
>  {
>  	struct atmel_private *priv = m->private;
> @@ -1481,6 +1482,7 @@ static int atmel_proc_show(struct seq_file *m, void *v)
>  	seq_printf(m, "Current state:\t\t%s\n", s);
>  	return 0;
>  }
> +#endif
>  
>  static const struct net_device_ops atmel_netdev_ops = {
>  	.ndo_open 		= atmel_open,
> 

