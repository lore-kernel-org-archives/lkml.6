Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB5FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B60521726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548234784;
	bh=8Enx+9BncfPCChr/HjRpTG0ZOZvtCrx57UOvXZ5Q7SE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mdZd3X7BL6A5soYKlyFjha60qRwzHIsU5rn4jfxDnM4ukYfsv0c2Ynrek8u4jpELr
	 tW2v1gT9Qq1LkAed3lqY9b9XQHA9Zslp6NGSCDq/Hz3E4/tu9Az35P5lkZwqEXuxEy
	 /Pq7gBh36c/F3k4TtxuNZ9jtBLVkAHLf4zGdICPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfAWJND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:13:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbfAWJNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:13:02 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7301B20870;
        Wed, 23 Jan 2019 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548234781;
        bh=8Enx+9BncfPCChr/HjRpTG0ZOZvtCrx57UOvXZ5Q7SE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0uBVJLYwQhM0/DUctNNB5CKB9nZIetZILpcatLt4Q2yhHvkIDi/Ec0ZL/LU53IDsP
         bDnd0RAFv/2AFYbj6xv8P0aERt+8ojaaWxAIYO6llHKhbdq6uc0PkeyjSn5F5eabV4
         B8dYC/cxZVJZBPyZT1/ME9ZLKZyy+XE89uYFOdgI=
Date:   Wed, 23 Jan 2019 10:12:53 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <robert.jarzmik@free.fr>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH -next] mtd: docg3: Fix passing zero to 'PTR_ERR' warning
 in doc_probe_device
Message-ID: <20190123101253.243add9d@bbrezillon>
In-Reply-To: <20190123065827.16748-1-yuehaibing@huawei.com>
References: <20190123065827.16748-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 14:58:27 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> Fix a static code checker warning:
> drivers/mtd/devices/docg3.c:1875
>  doc_probe_device() warn: passing zero to 'ERR_PTR'
> 
> Fixes: ae9d4934b2d7 ("mtd: docg3: add multiple floor support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/mtd/devices/docg3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
> index 4c94fc0..60ddc38 100644
> --- a/drivers/mtd/devices/docg3.c
> +++ b/drivers/mtd/devices/docg3.c
> @@ -1872,7 +1872,7 @@ doc_probe_device(struct docg3_cascade *cascade, int floor, struct device *dev)
>  nomem2:
>  	kfree(docg3);
>  nomem1:
> -	return ERR_PTR(ret);
> +	return ret ? ERR_PTR(ret) : NULL;
>  }
>  

This is not the right fix, you should instead set ret to -EINVAL:

--->8---
diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index 4c94fc096696..6b84db411232 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -1842,7 +1842,7 @@ doc_probe_device(struct docg3_cascade *cascade, int floor, struct device *dev)
        chip_id = doc_register_readw(docg3, DOC_CHIPID);
        chip_id_inv = doc_register_readw(docg3, DOC_CHIPID_INV);
 
-       ret = 0;
+       ret = -ENOMEM;
        if (chip_id != (u16)(~chip_id_inv)) {
                goto nomem4;
        }
