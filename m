Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030883AbeEZApg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 20:45:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7747 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030802AbeEZApf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 20:45:35 -0400
Subject: Re: [PATCH v2] f2fs: let fstrim issue discard commands in lower
 priority
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180525051031.36443-1-jaegeuk@kernel.org>
 <20180525194916.GA52740@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <9a7e1ff0-f4b1-52b2-9849-6d2ec0a9307d@huawei.com>
Date: Sat, 26 May 2018 08:45:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180525194916.GA52740@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/26 3:49, Jaegeuk Kim wrote:
> The fstrim gathers huge number of large discard commands, and tries to issue
> without IO awareness, which results in long user-perceive IO latencies on
> READ, WRITE, and FLUSH in UFS. We've observed some of commands take several
> seconds due to long discard latency.
> 
> This patch limits the maximum size to 2MB per candidate, and check IO congestion
> when issuing them to disk.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

It looks good to me. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
