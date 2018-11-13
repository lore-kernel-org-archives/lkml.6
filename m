Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95FBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F59223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F59223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeKMJ6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:58:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54952 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbeKMJ6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 04:58:18 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0DAC247793FC3;
        Tue, 13 Nov 2018 08:02:50 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 08:02:45 +0800
Subject: Re: [PATCH 2/3] staging: erofs: unzip_vle.c: Constant in comparison
 on right side
To:     Cristian Sicilia <sicilia.cristian@gmail.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <1542055439-24444-1-git-send-email-sicilia.cristian@gmail.com>
 <1542055439-24444-3-git-send-email-sicilia.cristian@gmail.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <8e50cc41-5204-c64c-9b63-964e16334622@huawei.com>
Date:   Tue, 13 Nov 2018 08:02:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1542055439-24444-3-git-send-email-sicilia.cristian@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/11/13 4:43, Cristian Sicilia wrote:
> Comparisons should place the constant
> on the right side of the test.
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/unzip_vle.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> index 1ffeeaa..35add4e 100644
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@ -250,8 +250,8 @@ static inline bool try_to_claim_workgroup(
>  retry:
>  	if (grp->next == Z_EROFS_VLE_WORKGRP_NIL) {
>  		/* type 1, nil workgroup */
> -		if (Z_EROFS_VLE_WORKGRP_NIL != cmpxchg(&grp->next,
> -			Z_EROFS_VLE_WORKGRP_NIL, *owned_head))
> +		if (cmpxchg(&grp->next, Z_EROFS_VLE_WORKGRP_NIL,
> +			    *owned_head) != Z_EROFS_VLE_WORKGRP_NIL)
>  			goto retry;
>  
>  		*owned_head = grp;
> @@ -262,8 +262,8 @@ static inline bool try_to_claim_workgroup(
>  		 * be careful that its submission itself is governed
>  		 * by the original owned chain.
>  		 */
> -		if (Z_EROFS_VLE_WORKGRP_TAIL != cmpxchg(&grp->next,
> -			Z_EROFS_VLE_WORKGRP_TAIL, *owned_head))
> +		if (cmpxchg(&grp->next, Z_EROFS_VLE_WORKGRP_TAIL,
> +			    *owned_head) != Z_EROFS_VLE_WORKGRP_TAIL)
>  			goto retry;
>  
>  		*owned_head = Z_EROFS_VLE_WORKGRP_TAIL;
> 
