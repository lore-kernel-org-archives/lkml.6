Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030941AbeEZAhG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 20:37:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38665 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030804AbeEZAhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 20:37:04 -0400
Subject: Re: [PATCH v3] f2fs: Fix deadlock in shutdown ioctl
To: Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC: <linux-kernel@vger.kernel.org>
References: <1526624512-32241-1-git-send-email-stummala@codeaurora.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <64178374-e67c-36a7-62a0-22c4e8ff9358@huawei.com>
Date: Sat, 26 May 2018 08:37:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1526624512-32241-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/18 14:21, Sahitya Tummala wrote:
> f2fs_ioc_shutdown() ioctl gets stuck in the below path
> when issued with F2FS_GOING_DOWN_FULLSYNC option.
> 
> __switch_to+0x90/0xc4
> percpu_down_write+0x8c/0xc0
> freeze_super+0xec/0x1e4
> freeze_bdev+0xc4/0xcc
> f2fs_ioctl+0xc0c/0x1ce0
> f2fs_compat_ioctl+0x98/0x1f0
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
