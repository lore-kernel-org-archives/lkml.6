Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8DFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8A92152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8A92152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbeHWOpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:45:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbeHWOpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:45:24 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B8227A2680A90;
        Thu, 23 Aug 2018 19:16:06 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Thu, 23 Aug 2018
 19:16:05 +0800
Message-ID: <5B7E9774.7010500@huawei.com>
Date:   Thu, 23 Aug 2018 19:16:04 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Colin King <colin.king@canonical.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/pl111: add in missing sentinel to a of_device_id
 array
References: <20180821105407.2318-1-colin.king@canonical.com>
In-Reply-To: <20180821105407.2318-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  Colin

I has posted the same patch about a month ago. but it seems to be ignored.:-(

https://lore.kernel.org/patchwork/patch/971652/

Thanks,
zhong jiang

On 2018/8/21 18:54, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Array vexpress_muxfpga_match is missing an end of array sentinel,
> add it.
>
> Detected by Coccinelle: ("vexpress_muxfpga_match is not NULL
> terminated at line")
>
> Fixes: ca454bd42dc2 ("drm/pl111: Support the Versatile Express")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/pl111/pl111_vexpress.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/pl111/pl111_vexpress.c b/drivers/gpu/drm/pl111/pl111_vexpress.c
> index a534b225e31b..48e2afcd4798 100644
> --- a/drivers/gpu/drm/pl111/pl111_vexpress.c
> +++ b/drivers/gpu/drm/pl111/pl111_vexpress.c
> @@ -111,7 +111,8 @@ static int vexpress_muxfpga_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id vexpress_muxfpga_match[] = {
> -	{ .compatible = "arm,vexpress-muxfpga", }
> +	{ .compatible = "arm,vexpress-muxfpga", },
> +	{ /* sentinel */ }
>  };
>  
>  static struct platform_driver vexpress_muxfpga_driver = {


