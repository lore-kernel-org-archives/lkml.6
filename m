Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B7AECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693032098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693032098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeISQHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:07:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728059AbeISQHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:07:46 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BBA677738964;
        Wed, 19 Sep 2018 18:30:27 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 18:30:24 +0800
Message-ID: <5BA2253F.4090409@huawei.com>
Date:   Wed, 19 Sep 2018 18:30:23 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <davem@davemloft.net>
CC:     <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: sched: Use FIELD_SIZEOF directly instead of reimplementing
 its function
References: <1537351001-44480-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1537351001-44480-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/19 17:56, zhong jiang wrote:
> FIELD_SIZEOF is defined as a macro to calculate the specified vaule. Therefore,
> We prefer to use the macro rather than calculating its vaule.
s/vaule/value.    will resend. sorry.

Thanks
zhong jiang
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  net/sched/cls_flower.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index 4b8dd37..9aada2d 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -993,7 +993,7 @@ static int fl_init_mask_hashtable(struct fl_flow_mask *mask)
>  }
>  
>  #define FL_KEY_MEMBER_OFFSET(member) offsetof(struct fl_flow_key, member)
> -#define FL_KEY_MEMBER_SIZE(member) (sizeof(((struct fl_flow_key *) 0)->member))
> +#define FL_KEY_MEMBER_SIZE(member) FIELD_SIZEOF(struct fl_flow_key, member)
>  
>  #define FL_KEY_IS_MASKED(mask, member)						\
>  	memchr_inv(((char *)mask) + FL_KEY_MEMBER_OFFSET(member),		\


