Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FABC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257C5208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257C5208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbeGKB1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:27:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732304AbeGKB1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:27:32 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A635D17161996;
        Wed, 11 Jul 2018 09:25:34 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Wed, 11 Jul 2018
 09:25:28 +0800
Subject: Re: [PATCH] 9p/net/protocol.c: return -ENOMEM when kmalloc() failed
To:     piaojun <piaojun@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        <ericvh@gmail.com>, <rminnich@sandia.gov>, <lucho@ionkov.net>
References: <5B4552C5.60000@huawei.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5B455C87.6090507@huawei.com>
Date:   Wed, 11 Jul 2018 09:25:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <5B4552C5.60000@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/11 8:43, piaojun wrote:
> We should return -ENOMEM to upper user when kmalloc failed to indicate
> accurate errno.
> 
> Signed-off-by: Jun Piao <piaojun@huawei.com>

Reviewed-by: Yiwen Jiang <jiangyiwen@huawei.com>

> ---
>  net/9p/protocol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/9p/protocol.c b/net/9p/protocol.c
> index 931ea00..4a1e1dd 100644
> --- a/net/9p/protocol.c
> +++ b/net/9p/protocol.c
> @@ -156,7 +156,7 @@ static size_t pdu_write(struct p9_fcall *pdu, const void *data, size_t size)
> 
>  				*sptr = kmalloc(len + 1, GFP_NOFS);
>  				if (*sptr == NULL) {
> -					errcode = -EFAULT;
> +					errcode = -ENOMEM;
>  					break;
>  				}
>  				if (pdu_read(pdu, *sptr, len)) {
> 


