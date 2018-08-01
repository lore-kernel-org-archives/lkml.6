Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B890C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A4620851
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A4620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbeHADBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:01:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732906AbeHADBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:01:54 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F0D15F76B2524;
        Wed,  1 Aug 2018 09:18:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 09:18:49 +0800
Message-ID: <5B610A7A.5000909@huawei.com>
Date:   Wed, 1 Aug 2018 09:18:50 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/bpf/libbpf: Simplify the code by using PTR_ERR_OR_ZERO
References: <1533054656-36134-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1533054656-36134-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/1 0:30, zhong jiang wrote:
> Use PTR_ERR_OR_ZERO is better than the open code.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  tools/lib/bpf/libbpf.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 40211b5..9b61468 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2271,9 +2271,7 @@ struct bpf_map *
>  
>  long libbpf_get_error(const void *ptr)
>  {
> -	if (IS_ERR(ptr))
> -		return PTR_ERR(ptr);
> -	return 0;
> +	return PTR_ERR_OR_ZERO(ptr);
>  }
>  
>  int bpf_prog_load(const char *file, enum bpf_prog_type type,
I am so sorry for that.  I will repost it after check it correct carefully.

Thanks
zhong jiang

