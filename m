Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA72C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587D420B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfBAHzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:55:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfBAHzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:55:42 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 89DD2BE272CC32C53AA0;
        Fri,  1 Feb 2019 15:55:39 +0800 (CST)
Received: from [127.0.0.1] (10.142.193.64) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 15:55:29 +0800
Subject: Re: [PATCH] staging: android: ion: fix sys heap pool's gfp_flags
To:     Qing Xia <saberlily.xia@hisilicon.com>, <labbott@redhat.com>,
        <sumit.semwal@linaro.org>, <gregkh@linuxfoundation.org>,
        <arve@android.com>, <tkjos@android.com>, <maco@android.com>
References: <1549004386-38778-1-git-send-email-saberlily.xia@hisilicon.com>
CC:     <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devel@driverdev.osuosl.org>,
        <daniel.liuyi@hisilicon.com>, <yudongbin@hisilicon.com>,
        <kongfei@hisilicon.com>
From:   Chen Feng <puck.chen@hisilicon.com>
Message-ID: <5C53FB63.8040502@hisilicon.com>
Date:   Fri, 1 Feb 2019 15:55:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1549004386-38778-1-git-send-email-saberlily.xia@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.193.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

On 2019/2/1 14:59, Qing Xia wrote:
> In the first loop, gfp_flags will be modified to high_order_gfp_flags,
> and there will be no chance to change back to low_order_gfp_flags.
> 
> Fixes: e7f63771 ("ION: Sys_heap: Add cached pool to spead up cached buffer alloc")
> Signed-off-by: Qing Xia <saberlily.xia@hisilicon.com>
> ---
>  drivers/staging/android/ion/ion_system_heap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> index 0383f75..20f2103 100644
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -223,10 +223,10 @@ static void ion_system_heap_destroy_pools(struct ion_page_pool **pools)
>  static int ion_system_heap_create_pools(struct ion_page_pool **pools)
>  {
>  	int i;
> -	gfp_t gfp_flags = low_order_gfp_flags;
>  
>  	for (i = 0; i < NUM_ORDERS; i++) {
>  		struct ion_page_pool *pool;
> +		gfp_t gfp_flags = low_order_gfp_flags;
>  
>  		if (orders[i] > 4)
>  			gfp_flags = high_order_gfp_flags;
> 

-- 
Cheers,
- Feng

