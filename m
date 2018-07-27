Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0278BC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05A920673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="beUjnGbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05A920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbeG0Jmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:42:36 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:34533 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbeG0Jmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:42:35 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180727082148epoutp016c2d8cf3018a793438ee59d44ce86d84~FLBL7QtP02083820838epoutp01g
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 08:21:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180727082148epoutp016c2d8cf3018a793438ee59d44ce86d84~FLBL7QtP02083820838epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532679708;
        bh=L9mURoy14dcXz2qvbZYOtFxQNxBYk2OLD65Rz0/mfkc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=beUjnGbetHEs4nKKRxJ/AOwkUbtLiPhCjCLrCUK1ezAKMM5TAexBPH5SYxM20fPza
         dFu0qdjc84CTV6f6zqOkZ7vqIOb639a3nDFdTjyKV0zr1ZHx6ZifJlH7fCbx2w4Yte
         y0b/T+Bl1dxs/6LctNWt1+9R/eZqK3lDd9uN5tCc=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.197]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20180727082147epcas5p156337dbc7e462b17bd9d92190b447855~FLBLEDJRo1823218232epcas5p16;
        Fri, 27 Jul 2018 08:21:47 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.93.04304.A16DA5B5; Fri, 27 Jul 2018 17:21:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20180727082146epcas5p10374c04f0767dbbe409c8171c49d7c9a~FLBKL7utW2249922499epcas5p1c;
        Fri, 27 Jul 2018 08:21:46 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180727082146epsmtrp15dbf17a7cfe4d533cf5edd1a61df3dd6~FLBKKYfbr1606416064epsmtrp1c;
        Fri, 27 Jul 2018 08:21:46 +0000 (GMT)
X-AuditID: b6c32a4b-239ff700000010d0-83-5b5ad61a4fc3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.40.03889.A16DA5B5; Fri, 27 Jul 2018 17:21:46 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.161.94]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180727082144epsmtip15734590d9b8265d74145c679612b57fb~FLBIUy6Wl2346623466epsmtip1T;
        Fri, 27 Jul 2018 08:21:44 +0000 (GMT)
From:   Satendra Singh Thakur <satendra.t@samsung.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Satendra Singh Thakur <satendra.t@samsung.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com, sst2005@gmail.com
Subject: [PATCH] videobuf2/vb2_buffer_done: Changing the position of
 spinlock to protect only the required code
Date:   Fri, 27 Jul 2018 13:51:36 +0530
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmpq7UtahogxmndS2W/NzFZPHq/Btm
        i8u75rBZ9GzYymqxbNMfJotPW74xWaw938pisfz0dWaLY1svsVuc/3uc1YHLY8rvjaweO2fd
        ZffYtKqTzWPeyUCPvi2rGD0+b5Lz2PTkLVMAe1SqTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7yp
        mYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QeUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6Vo
        Q0MjPUMDcz0jIyBtGmtlZApUkpCa8fHmPpaCa3wVH9/9ZG9g3M3TxcjJISFgIrF5wznmLkYu
        DiGB3YwSD3Z9YoJwPjFKHLy/mQ3C+cYo8fjfIVaYlkftZ9ghEnsZJXY/XA3lfGGUeHr4CVgV
        G1DV8zkzWEESIgIzmCT2T2tjB0kwCzhL3Ly8k6WLkYNDWKBQ4vieQJAwi4CqRMOyyYwQG+Qk
        bp7rBDtKQmAFm8SzM3+YQBK8AmUSO+/tZYMocpE4PfUIM4QtLPHq+BZ2CFtK4mV/G5Q9mVGi
        +awfxKDVjBJnL/ZCJewlWqYcADuCWUBTYv0ufYjb+CR6fz9hAglLCPBKdLQJQVSrSKx8cZgZ
        ZvyfBV3QkPCQ+NZ9FOwcIYFYiQ93brJNYJSZhTB0ASPjKkbJ1ILi3PTUYtMC47zUcr3ixNzi
        0rx0veT83E2M4ESm5b2DcdM5n0OMAhyMSjy8Aa8jo4VYE8uKK3MPMUpwMCuJ8K65DhTiTUms
        rEotyo8vKs1JLT7EaAoMtInMUqLJ+cAkm1cSb2hqZGZmYGlgamxhZqgkzvvBLzhaSCA9sSQ1
        OzW1ILUIpo+Jg1OqgTHmAl9X3MTur4VadULt+m8epdZ+3a22tU5i/Q7XHVr+lkf9XQRY+yoN
        UyU8HwefjIrItbS0+Mq3bsWL/eYzLh3krTpw0lE4cXmrauRMX3714HcS7Kn9W/g/2NSl3Fgm
        kTuZ+8aqDfppZ8Xilx8JW+j3UOPui/SEuYY9597qMZzz2v/w5hoHKSWW4oxEQy3mouJEADT+
        9/J6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSnK7Utahog0uT+SyW/NzFZPHq/Btm
        i8u75rBZ9GzYymqxbNMfJotPW74xWaw938pisfz0dWaLY1svsVuc/3uc1YHLY8rvjaweO2fd
        ZffYtKqTzWPeyUCPvi2rGD0+b5Lz2PTkLVMAexSXTUpqTmZZapG+XQJXxseb+1gKrvFVfHz3
        k72BcTdPFyMnh4SAicSj9jPsXYxcHEICuxklnuz+zAaRkJJY9mYblC0ssfLfc3YQW0jgE6NE
        66kCEJsNqPn5nBmsILaIwBwmiYf3RUFsZgF3iblnvoHVCwvkS1xpPQ82h0VAVaJh2WRGEJtX
        wE3i2t8TrBDz5SRunutknsDIs4CRYRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnDQ
        aWntYDxxIv4QowAHoxIPb8DryGgh1sSy4srcQ4wSHMxKIrxrrgOFeFMSK6tSi/Lji0pzUosP
        MUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MHrvqlvpE/jUQDn7nuoWDe2rNp9krqp9
        dxfjXquh5S07bcHsp8eZHfnUeXW+/3rXrht3oGbO7bzN9teuL3sU/GB2arR4DctL12nJzzIz
        7K238azawveo3JZ31oSdd4+wessczm47lJ31dJHGnNyDbWtfCxXoNajlXGNe9cB0y/VfM997
        n98267USS3FGoqEWc1FxIgD0gvpWNgIAAA==
Message-Id: <20180727082146epcas5p10374c04f0767dbbe409c8171c49d7c9a~FLBKL7utW2249922499epcas5p1c@epcas5p1.samsung.com>
X-CMS-MailID: 20180727082146epcas5p10374c04f0767dbbe409c8171c49d7c9a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180727082146epcas5p10374c04f0767dbbe409c8171c49d7c9a
References: <CGME20180727082146epcas5p10374c04f0767dbbe409c8171c49d7c9a@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Currently, in the func vb2_buffer_done, spinlock protects
following code
vb->state = VB2_BUF_STATE_QUEUED;
list_add_tail(&vb->done_entry, &q->done_list);
spin_unlock_irqrestore(&q->done_lock, flags);
vb->state = state;
atomic_dec(&q->owned_by_drv_count);
2.The spinlock is mainly needed to protect list related ops and
vb->state = STATE_ERROR or STATE_DONE as in other funcs
vb2_discard_done
__vb2_get_done_vb
vb2_core_poll.
3. Therefore, spinlock is mainly needed for
   list_add, list_del, list_first_entry ops
   and state = STATE_DONE and STATE_ERROR to protect
   done_list queue.
3. Hence, state = STATE_QUEUED doesn't need spinlock protection.
4. Also atomic_dec dones't require the same as its already atomic.

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index f32ec73..968b403 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -923,17 +923,17 @@ void vb2_buffer_done(struct vb2_buffer *vb, enum vb2_buffer_state state)
 			call_void_memop(vb, finish, vb->planes[plane].mem_priv);
 	}
 
-	spin_lock_irqsave(&q->done_lock, flags);
 	if (state == VB2_BUF_STATE_QUEUED ||
 	    state == VB2_BUF_STATE_REQUEUEING) {
 		vb->state = VB2_BUF_STATE_QUEUED;
 	} else {
 		/* Add the buffer to the done buffers list */
+		spin_lock_irqsave(&q->done_lock, flags);
 		list_add_tail(&vb->done_entry, &q->done_list);
 		vb->state = state;
+		spin_unlock_irqrestore(&q->done_lock, flags);
 	}
 	atomic_dec(&q->owned_by_drv_count);
-	spin_unlock_irqrestore(&q->done_lock, flags);
 
 	trace_vb2_buf_done(q, vb);
 
-- 
2.7.4

