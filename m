Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbeE1HMP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:12:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33926 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753786AbeE1HMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:12:08 -0400
Subject: Re: [PATCH v2] f2fs-tools: fix to match with the start_sector
To: Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1525425645-127945-1-git-send-email-yunlong.song@huawei.com>
 <1525659336-145433-1-git-send-email-yunlong.song@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <bf595a86-700e-9225-6a5e-a245dbc027ad@huawei.com>
Date: Mon, 28 May 2018 15:11:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1525659336-145433-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/7 10:15, Yunlong Song wrote:
> f2fs-tools uses ioctl BLKSSZGET to get sector_size, however, this ioctl
> will return a value which may be larger than 512 (according to the value
> of q->limits.logical_block_size), then this will be inconsistent with
> the start_sector, since start_sector is got from ioctl HDIO_GETGEO and
> is always in 512 size unit for a sector. To fix this problem, just
> change the sector_size to the default value when computing with
> start_sector. And fix sectors_per_blk as well.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
