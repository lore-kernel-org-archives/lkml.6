Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933723AbeBMI1H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 03:27:07 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:16662 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbeBMI1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 03:27:04 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180213082702epoutp038517cb48c74803baba249ce139671ff9~S1S8CjMF40171801718epoutp03j
X-AuditID: b6c32a39-47fff70000000fc5-4e-5a82a155d8b3
From: Nitesh Shetty <nj.shetty@samsung.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, axboe@fb.com, linux-nvme@lists.infradead.org,
        nj.shetty@samsung.com, joshi.k@samsung.com
Subject: [PATCH v2 RESENT] blk: optimization for classic polling
Date: Wed, 14 Feb 2018 00:26:46 +0530
Message-id: <1518548206-4766-1-git-send-email-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCmgW7owqYogwMPTS3+7znGZrH6bj+b
        xdH/b9ks9t7Stri8aw6bxfxlT9kttv2ez+zA7jGx+R27x+WzpR6bl9R79G1ZxejxeZNcAGsU
        l01Kak5mWWqRvl0CV0Z7y2P2ggXsFddXL2BsYPzD2sXIySEhYCLxeM4hIJuLQ0hgB6PEp/en
        2SGc74wSf08dYIGpunLvLlTVbkaJrSdWM0I47UwSD3f/BKri4GAT0JY4/Z8DpEFEwFZi7rFr
        YGFmgXyJr4vEQMLCAg4SX5ZeYASxWQRUJXYcP8wOYvMKuEjsWfyOEWKXnMTNc53MIDangKvE
        n7cgNhdQvINN4sm0ycwQRS4S546+ZoewhSVeHd/CDrJLQkBa4tJRW4j6bkaJG62roYZOYZSY
        MVcfwraXuLjnLxOIzSzAJ/Huaw8rRC+vREebEESJh8S1T71MELajxJYlk6GBMoNRYvurKYwT
        GKUWMDKsYhRLLSjOTU8tNiww1StOzC0uzUvXS87P3cQIjkYtyx2Mx875HGIU4GBU4uHtmN0Y
        JcSaWFZcmXuIUYKDWUmEd0tlU5QQb0piZVVqUX58UWlOavEhRmkOFiVx3oAAlyghgfTEktTs
        1NSC1CKYLBMHp1QD48794SUXS8vXfnXbo/U9atclr8IbvPefKt27acD3/6HgBAU5/02y2Yte
        aj350N6itSTrzCa+3kXqv7U+cd6tkihZ1jo7jj3qfe3HPOdcxcuC2yqc4lMu/v7Z11x4eu+7
        jq1aqg46d8Kelv9gfrZMWOi6ubTtFbG+PVs3N0ZN+mByblrXolx5PyWW4oxEQy3mouJEAO4f
        VCDCAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnluLIzCtJLcpLzFFi42I5/e+xgG7owqYog38vlSz+7znGZrH6bj+b
        xdH/b9ks9t7Stri8aw6bxfxlT9kttv2ez+zA7jGx+R27x+WzpR6bl9R79G1ZxejxeZNcAGsU
        l01Kak5mWWqRvl0CV0Z7y2P2ggXsFddXL2BsYPzD2sXIySEhYCJx5d5dMFtIYCejRH9PVBcj
        F5DdySRxYPlf9i5GDg42AW2J0/85QGpEBGwl5h67xgJiMwvkS3T9+MAEYgsLOEh8WXqBEcRm
        EVCV2HH8MDuIzSvgIrFn8TtGiF1yEjfPdTKD2JwCrhJ/3kLYQkA1J9Y3sU5g5FnAyLCKUTK1
        oDg3PbfYqMAwL7Vcrzgxt7g0L10vOT93EyMweLYd1urbwXh/SfwhRgEORiUe3o7ZjVFCrIll
        xZW5hxglOJiVRHi3VDZFCfGmJFZWpRblxxeV5qQWH2KU5mBREue9nXcsUkggPbEkNTs1tSC1
        CCbLxMEp1cBYKfn00WttKXWmSUpXy7l4hY0epKw669Z9LfBZ96WEdlWlfM3/lnsObJj5sUep
        /N5nB+4VN1yutzfd9uFXZfRxsb547OSErtxY9cDNarrSm91XKWaGCiQdWb9JxvDojhkLA35O
        r5WpdL1geT4/5eL3XQuPGE/+u6m90/lJUFLSIoPp16awdZcosRRnJBpqMRcVJwIAW7+v3hoC
        AAA=
X-CMS-MailID: 20180213082701epcas1p4d92a86f127a0918fb9d62120bd121cb6
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180213082701epcas1p4d92a86f127a0918fb9d62120bd121cb6
X-RootMTR: 20180213082701epcas1p4d92a86f127a0918fb9d62120bd121cb6
References: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
        <CGME20180213082701epcas1p4d92a86f127a0918fb9d62120bd121cb6@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the dependency on interrupts to wake up task. Set task
state as TASK_RUNNING, if need_resched() returns true,
while polling for IO completion.
Earlier, polling task used to sleep, relying on interrupt to wake it up.
This made some IO take very long when interrupt-coalescing is enabled in
NVMe.

Reference:
http://lists.infradead.org/pipermail/linux-nvme/2018-February/015435.html

Changes since v1:
	-setting task state once in blk_poll, instead of multiple
callers.
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df93102..40285fe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3164,6 +3164,7 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 		cpu_relax();
 	}
 
+	set_current_state(TASK_RUNNING);
 	return false;
 }
 
-- 
2.7.4
