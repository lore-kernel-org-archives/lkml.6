Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754123AbeDBChw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 22:37:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7143 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753992AbeDBChu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 22:37:50 -0400
Subject: Re: [PATCH v2] scsi: Introduce sdev_printk_ratelimited to throttle
 frequent printk
To: Wen Yang <wen.yang99@zte.com.cn>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
References: <1522634332-151328-1-git-send-email-wen.yang99@zte.com.cn>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Bart.VanAssche@wdc.com>, <pmladek@suse.com>,
        <sergey.senozhatsky.work@gmail.com>, <tj@kernel.org>,
        <jiang.biao2@zte.com.cn>, <zhong.weidong@zte.com.cn>,
        Tan Hu <tan.hu@zte.com.cn>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <5AC1976F.1040801@huawei.com>
Date: Mon, 2 Apr 2018 10:37:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1522634332-151328-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yang,

On 2018/4/2 9:58, Wen Yang wrote:
> There would be so many same lines printed by frequent printk if one
> disk went wrong, like,
> [  546.185242] sd 0:1:0:0: rejecting I/O to offline device
> [  546.185258] sd 0:1:0:0: rejecting I/O to offline device
> [  546.185280] sd 0:1:0:0: rejecting I/O to offline device
> [  546.185307] sd 0:1:0:0: rejecting I/O to offline device
> [  546.185334] sd 0:1:0:0: rejecting I/O to offline device
> [  546.185364] sd 0:1:0:0: rejecting I/O to offline device
> [  546.185390] sd 0:1:0:0: rejecting I/O to offline device
> [  546.185410] sd 0:1:0:0: rejecting I/O to offline device
> For slow serial console, the frequent printk may be blocked for a
> long time, and if any spin_lock has been acquired before the printk
> like in scsi_request_fn, watchdog could be triggered.
>
> Related disscussion can be found here,
> https://bugzilla.kernel.org/show_bug.cgi?id=199003
> And Petr brought the idea to throttle the frequent printk, it's
> useless to print the same lines frequently after all.
>

It's true that this print for the same device is useless. But it's
useful for different devices. Is it possible to limit the print only
for the same device?

Thanks,

Jason

>
>
