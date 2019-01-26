Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E0EC282C6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 06:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49527218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 06:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfAZGnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 01:43:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48590 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726991AbfAZGnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 01:43:11 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B5933DC93ADBCBFD0707;
        Sat, 26 Jan 2019 14:43:08 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Sat, 26 Jan 2019
 14:43:01 +0800
Subject: Re: [PATCH v3 2/2] staging: erofs: complete POSIX ACL support
To:     Gao Xiang <hsiangkao@aol.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        <weidu.du@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
References: <20190126034829.11586-1-hsiangkao@aol.com>
 <20190126034829.11586-2-hsiangkao@aol.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6240fd8c-f575-5fb7-6a4c-7d6f59063527@huawei.com>
Date:   Sat, 26 Jan 2019 14:43:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190126034829.11586-2-hsiangkao@aol.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/26 11:48, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> Let's add .get_acl() to read the file's acl from its xattrs
> to make POSIX ACL usable.
> 
> Here is the on-disk detail,
> fullname: system.posix_acl_access
> struct erofs_xattr_entry:
>         .e_name_len = 0
>         .e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS (2)
> 
> fullname: system.posix_acl_default
> struct erofs_xattr_entry:
> 	.e_name_len = 0
> 	.e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT (3)
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> change log v3:
>  - kvmalloc -> erofs_kmalloc suggested by Chao;
>  - update SB_POSIXACL for the remount case as well;

Oh, correct, remount case, I missed that one.

It looks good to me now. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

