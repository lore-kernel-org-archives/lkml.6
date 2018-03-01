Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeCABRH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 20:17:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55965 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750775AbeCABRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 20:17:06 -0500
Subject: Re: [PATCH] f2fs: don't put dentry page in pagecache into highmem
To: Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1519821112-137593-1-git-send-email-yunlong.song@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <dcb20f79-0107-661c-0dec-9251f799ae44@huawei.com>
Date: Thu, 1 Mar 2018 09:20:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1519821112-137593-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/2/28 20:31, Yunlong Song wrote:
> Previous dentry page uses highmem, which will cause panic in platforms
> using highmem (such as arm), since the address space of dentry pages
> from highmem directly goes into the decryption path via the function
> fscrypt_fname_disk_to_usr. But sg_init_one assumes the address is not
> from highmem, and then cause panic since it doesn't call kmap_high but
> kunmap_high is triggered at the end. To fix this problem in a simple
> way, this patch avoids to put dentry page in pagecache into highmem.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
