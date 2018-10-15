Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F7AC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032592064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032592064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeJOTpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:45:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46868 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726498AbeJOTpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:45:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B44DACCD1DD9B;
        Mon, 15 Oct 2018 20:00:04 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Mon, 15 Oct 2018
 20:00:03 +0800
Subject: Re: [PATCH 2/2] f2fs: update REQ_TIME in f2fs_cross_rename()
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1538716660-31572-1-git-send-email-stummala@codeaurora.org>
 <1538716660-31572-2-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fa825846-ba41-31d2-c819-476e9245b7a8@huawei.com>
Date:   Mon, 15 Oct 2018 20:00:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538716660-31572-2-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/5 13:17, Sahitya Tummala wrote:
> Update REQ_TIME in the missing path - f2fs_cross_rename().

Needs to cover f2fs_rename() as well?

Thanks,

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/namei.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index a146327..e37af23 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -1154,6 +1154,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  
>  	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
>  		f2fs_sync_fs(sbi->sb, 1);
> +
> +	f2fs_update_time(sbi, REQ_TIME);
>  	return 0;
>  out_new_dir:
>  	if (new_dir_entry) {
> 

