Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B176C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76432084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76432084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbeGSIhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:37:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728071AbeGSIhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:37:54 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 694E2353985F5;
        Thu, 19 Jul 2018 15:55:56 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.382.0; Thu, 19 Jul 2018
 15:55:56 +0800
Subject: Re: [PATCH bpf-next] bpfilter: Fix mismatch in function argument
 types
To:     <ast@kernel.org>, <daniel@iogearbox.net>
References: <20180719072556.20076-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <66c14347-6006-08f8-1b32-b3ba6b9fa6bb@huawei.com>
Date:   Thu, 19 Jul 2018 15:55:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180719072556.20076-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

send wrong patch ,pls ignore it.

On 2018/7/19 15:25, YueHaibing wrote:
> Fix following warning:
> net/ipv4/bpfilter/sockopt.c:28:5: error: symbol 'bpfilter_ip_set_sockopt' redeclared with different type
> net/ipv4/bpfilter/sockopt.c:34:5: error: symbol 'bpfilter_ip_get_sockopt' redeclared with different type
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/bpfilter.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
> index 687b176..43acfa8 100644
> --- a/include/linux/bpfilter.h
> +++ b/include/linux/bpfilter.h
> @@ -5,9 +5,9 @@
>  #include <uapi/linux/bpfilter.h>
>  
>  struct sock;
> -int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char *optval,
> +int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *optval,
>  			    unsigned int optlen);
> -int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char *optval,
> +int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
>  			    int *optlen);
>  extern int (*bpfilter_process_sockopt)(struct sock *sk, int optname,
>  				       char __user *optval,
> 

