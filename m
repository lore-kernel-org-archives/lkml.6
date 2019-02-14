Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901FEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6383B222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394074AbfBNHLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:11:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387523AbfBNHLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:11:03 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4C5D0FB32BBA15E738B9;
        Thu, 14 Feb 2019 15:10:58 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 15:10:52 +0800
Subject: Re: [PATCH v2] staging: erofs: fix memleak of inode's shared xattr
 array
To:     Sheng Yong <shengyong1@huawei.com>
CC:     <yuchao0@huawei.com>, <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>,
        "fangwei (I)" <fangwei1@huawei.com>
References: <20190214064636.30039-1-shengyong1@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <d9aefb6b-e3a9-29c4-c230-391aeec19d97@huawei.com>
Date:   Thu, 14 Feb 2019 15:10:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190214064636.30039-1-shengyong1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/2/14 14:46, Sheng Yong wrote:
> If it fails to read a shared xattr page, the inode's shared xattr array
> is not freed. The next time the inode's xattr is accessed, the previously
> allocated array is leaked.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

LGTM,

Fixes: b17500a0fdba ("staging: erofs: introduce xattr & acl support")
Cc: <stable@vger.kernel.org> # 4.19+
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

[and there is also another race condition in it, but different root cause.
let me fix it later independently...]

Thanks,
Gao Xiang
