Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE5CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2B62098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2B62098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbeISQIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:08:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55539 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728059AbeISQIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:08:34 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1D47D4E331E01;
        Wed, 19 Sep 2018 18:31:17 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 18:31:14 +0800
Message-ID: <5BA22571.1080101@huawei.com>
Date:   Wed, 19 Sep 2018 18:31:13 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <davem@davemloft.net>
CC:     <ubraun@linux.ibm.com>, <jwi@linux.ibm.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: iucv: Use FIELD_SIZEOF directly instead of reimplementing
 its function
References: <1537350733-44276-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1537350733-44276-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/19 17:52, zhong jiang wrote:
> FIELD_SIZEOF is defined as a macro to calculate the specified vaule. Therefore,
> We prefer to use the macro rather than calculating its vaule.
s/vaule/value  .   will resend .

Thanks,
zhong jiang
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  net/iucv/af_iucv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index e2f16a0..5b68ee9 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -48,7 +48,7 @@
>  static const u8 iprm_shutdown[8] =
>  	{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01};
>  
> -#define TRGCLS_SIZE	(sizeof(((struct iucv_message *)0)->class))
> +#define TRGCLS_SIZE	FIELD_SIZEOF(struct iucv_message, class)
>  
>  #define __iucv_sock_wait(sk, condition, timeo, ret)			\
>  do {									\


