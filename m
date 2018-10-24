Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2D0C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D177B2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D177B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeJXNK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 09:10:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbeJXNK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 09:10:27 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DB4E4C6A33F53;
        Wed, 24 Oct 2018 08:57:12 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Wed, 24 Oct 2018
 08:57:04 +0800
Subject: Re: [PATCH] ocfs2: dlmfs: remove set but not used variable 'status'
To:     zhong jiang <zhongjiang@huawei.com>, <akpm@linux-foundation.org>,
        <mark@fasheh.com>, <jlbec@evilplan.org>
References: <1540300179-26697-1-git-send-email-zhongjiang@huawei.com>
CC:     <jiangqi903@gmail.com>, <dhowells@redhat.com>,
        <viro@zeniv.linux.org.uk>, <ocfs2-devel@oss.oracle.com>,
        <linux-kernel@vger.kernel.org>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5BCFC35C.2080802@huawei.com>
Date:   Wed, 24 Oct 2018 08:57:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1540300179-26697-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM

On 2018/10/23 21:09, zhong jiang wrote:
> status is not used after setting its value. It is safe to remove
> the unused variable.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Reviewed-by: Jun Piao <piaojun@huawei.com>
> ---
>  fs/ocfs2/dlmfs/dlmfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index 642e471..b03dd46 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -179,7 +179,7 @@ static int dlmfs_file_open(struct inode *inode,
>  static int dlmfs_file_release(struct inode *inode,
>  			      struct file *file)
>  {
> -	int level, status;
> +	int level;
>  	struct dlmfs_inode_private *ip = DLMFS_I(inode);
>  	struct dlmfs_filp_private *fp = file->private_data;
>  
> @@ -188,7 +188,6 @@ static int dlmfs_file_release(struct inode *inode,
>  
>  	mlog(0, "close called on inode %lu\n", inode->i_ino);
>  
> -	status = 0;
>  	if (fp) {
>  		level = fp->fp_lock_level;
>  		if (level != DLM_LOCK_IV)
> 
