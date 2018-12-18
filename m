Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C09C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5278217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeLRIiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:38:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16589 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbeLRIiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:38:01 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 30302A5447EB7;
        Tue, 18 Dec 2018 16:37:58 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 16:37:58 +0800
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: use kvmalloc, if kmalloc is failed
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20181214050127.45025-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a56ea91f-892d-a663-d4f2-6da8b851ec22@huawei.com>
Date:   Tue, 18 Dec 2018 16:37:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181214050127.45025-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/14 13:01, Jaegeuk Kim wrote:
> One report says memalloc failure during mount.
> 
>  (unwind_backtrace) from [<c010cd4c>] (show_stack+0x10/0x14)
>  (show_stack) from [<c049c6b8>] (dump_stack+0x8c/0xa0)
>  (dump_stack) from [<c024fcf0>] (warn_alloc+0xc4/0x160)
>  (warn_alloc) from [<c0250218>] (__alloc_pages_nodemask+0x3f4/0x10d0)
>  (__alloc_pages_nodemask) from [<c0270450>] (kmalloc_order_trace+0x2c/0x120)
>  (kmalloc_order_trace) from [<c03fa748>] (build_node_manager+0x35c/0x688)
>  (build_node_manager) from [<c03de494>] (f2fs_fill_super+0xf0c/0x16cc)
>  (f2fs_fill_super) from [<c02a5864>] (mount_bdev+0x15c/0x188)
>  (mount_bdev) from [<c03da624>] (f2fs_mount+0x18/0x20)
>  (f2fs_mount) from [<c02a68b8>] (mount_fs+0x158/0x19c)
>  (mount_fs) from [<c02c3c9c>] (vfs_kern_mount+0x78/0x134)
>  (vfs_kern_mount) from [<c02c76ac>] (do_mount+0x474/0xca4)
>  (do_mount) from [<c02c8264>] (SyS_mount+0x94/0xbc)
>  (SyS_mount) from [<c0108180>] (ret_fast_syscall+0x0/0x48)
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

