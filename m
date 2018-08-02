Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604B6C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBA620894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBA620894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeHBEkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:40:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47519 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbeHBEkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:40:49 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4C9A1878113B2;
        Thu,  2 Aug 2018 10:51:52 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Thu, 2 Aug 2018
 10:51:52 +0800
Message-ID: <5B6271C6.7030104@huawei.com>
Date:   Thu, 2 Aug 2018 10:51:50 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/binfmt_elf_fdpic: remove redundant condition check
 in writenote
References: <1533175474-17785-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1533175474-17785-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

plese ingore  it. 
On 2018/8/2 10:04, zhong jiang wrote:
> It is unncessary to use double test for a expression. so just
> remove one of them.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  fs/binfmt_elf_fdpic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index b53bb37..5162372 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -1288,7 +1288,7 @@ static int writenote(struct memelfnote *men, struct coredump_params *cprm)
>  
>  	return dump_emit(cprm, &en, sizeof(en)) &&
>  		dump_emit(cprm, men->name, en.n_namesz) && dump_align(cprm, 4) &&
> -		dump_emit(cprm, men->data, men->datasz) && dump_align(cprm, 4);
> +		dump_emit(cprm, men->data, men->datasz);
>  }
>  
>  static inline void fill_elf_fdpic_header(struct elfhdr *elf, int segs)


