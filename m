Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE91C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F6320878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F6320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbeGJHTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:19:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750998AbeGJHTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:19:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6488228DD2667;
        Tue, 10 Jul 2018 15:19:13 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Tue, 10 Jul 2018
 15:19:04 +0800
Subject: Re: [PATCH] net/9p/client.c: add missing '\n' at the end of
 p9_debug()
To:     piaojun <piaojun@huawei.com>, <akpm@linux-foundation.org>,
        <ericvh@gmail.com>, <rminnich@sandia.gov>, <lucho@ionkov.net>
References: <5B44589A.50302@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5B445DE7.3070607@huawei.com>
Date:   Tue, 10 Jul 2018 15:19:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <5B44589A.50302@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/10 14:56, piaojun wrote:
> In p9_client_getattr_dotl(), we should add '\n' at the end of printing
> log.
> 
> Signed-off-by: Jun Piao <piaojun@huawei.com>

Reviewed-by: Yiwen Jiang <jiangyiwen@huawei.com>

> ---
>  net/9p/client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 5c13431..8bc8b3e 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -1790,7 +1790,7 @@ struct p9_stat_dotl *p9_client_getattr_dotl(struct p9_fid *fid,
>  		"<<< st_mtime_sec=%lld st_mtime_nsec=%lld\n"
>  		"<<< st_ctime_sec=%lld st_ctime_nsec=%lld\n"
>  		"<<< st_btime_sec=%lld st_btime_nsec=%lld\n"
> -		"<<< st_gen=%lld st_data_version=%lld",
> +		"<<< st_gen=%lld st_data_version=%lld\n",
>  		ret->st_result_mask, ret->qid.type, ret->qid.path,
>  		ret->qid.version, ret->st_mode, ret->st_nlink,
>  		from_kuid(&init_user_ns, ret->st_uid),
> 


