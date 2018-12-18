Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6900EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D4A217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeLRNPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:15:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55929 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbeLRNPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:15:15 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 28B233CC43FCA;
        Tue, 18 Dec 2018 21:15:12 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 21:15:10 +0800
Subject: Re: [PATCH -next] staging: fbtft: use strcmp() instead of strncmp()
 for subsystem lookup
To:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <leobras.c@gmail.co>, <radek.dostal@streamunlimited.co>
References: <20181218130932.17684-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <477c3a7a-b0dd-f3f5-223c-da4e8e19d44a@huawei.com>
Date:   Tue, 18 Dec 2018 21:15:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181218130932.17684-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, Pls ignore this.  The title need fix.

On 2018/12/18 21:09, YueHaibing wrote:
> strncmp() stops comparing when either the end of one of the first two 
> arguments is reached or when 'n' characters have been compared, whichever
> comes first.That means that strncmp(s1, s2, n) is equivalent to 
> strcmp(s1, s2) if n exceeds the length of s1 or the length of s2.
> 
> This patch avoids that the following warning is reported by smatch:
> 
> drivers/staging/fbtft/fbtft_device.c:1458
>  fbtft_device_init() error: strncmp() '"list"' too small (5 vs 32)
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/staging/fbtft/fbtft_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft_device.c b/drivers/staging/fbtft/fbtft_device.c
> index 50e97da..0e995028 100644
> --- a/drivers/staging/fbtft/fbtft_device.c
> +++ b/drivers/staging/fbtft/fbtft_device.c
> @@ -1455,7 +1455,7 @@ static int __init fbtft_device_init(void)
>  	}
>  
>  	/* name=list lists all supported displays */
> -	if (strncmp(name, "list", FBTFT_GPIO_NAME_SIZE) == 0) {
> +	if (strcmp(name, "list") == 0) {
>  		pr_info("Supported displays:\n");
>  
>  		for (i = 0; i < ARRAY_SIZE(displays); i++)
> 

