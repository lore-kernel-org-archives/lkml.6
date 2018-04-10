Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeDJHjS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:39:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751963AbeDJHjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:39:15 -0400
Subject: Re: [PATCH] f2fs: set deadline to drop expired inmem pages
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20180408081312.6190-1-yuchao0@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <09fd3144-d1c5-ca02-178d-b467d6fbe0e1@huawei.com>
Date: Tue, 10 Apr 2018 15:38:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180408081312.6190-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On 2018/4/8 16:13, Chao Yu wrote:
> f2fs doesn't allow abuse on atomic write class interface, so except
> limiting in-mem pages' total memory usage capacity, we need to limit
> start-commit time as well, otherwise we may run into infinite loop
> during foreground GC because target blocks in victim segment are
> belong to atomic opened file for long time.
> 
> Now, we will check the condition with f2fs_balance_fs_bg in
> background threads, once if user doesn't commit data exceeding 30
> seconds, we will drop all cached data, so I expect it can keep our
> system running safely to prevent Dos attack.

Is it worth to add this patch to avoid abuse on atomic write interface by user?
Thanks,
