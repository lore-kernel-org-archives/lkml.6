Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB23C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9539D20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fDU+tCCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9539D20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733268AbeHAHol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:44:41 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:61419 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbeHAHol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:44:41 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180801060044epoutp03b9d36dc01a12b46d52128082db992cec~GrUc6dIeS2890828908epoutp03J
        for <linux-kernel@vger.kernel.org>; Wed,  1 Aug 2018 06:00:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180801060044epoutp03b9d36dc01a12b46d52128082db992cec~GrUc6dIeS2890828908epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533103244;
        bh=CmMCwk/unhhorxc1ZA4d7EECd9mqxXJ+Dk5vK06seQs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fDU+tCCtTtBw8Lpn6Vw7yQEI4PG94oeBr0NG59Fvnl6kQtt/O9LK0H15/UzYeA5TC
         VoBXh7wt6iZueTWjyI+2xVE+m7Svs+V2YmgV69WPk/PW5Gyc9S7Fo5B/zsHqjM91DA
         f7y1In2xc10KDIsX/l10myUSYdJ/nVxkSUaXdQ1c=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20180801060044epcas5p2560bd2ab4fba53b3c540a752dabb059c~GrUcipJYJ1237912379epcas5p2K;
        Wed,  1 Aug 2018 06:00:44 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.D5.04309.C8C416B5; Wed,  1 Aug 2018 15:00:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20180801055857epcas5p35ac85b8c9c9339eb3080e6d89b1a0ce6~GrS4x1NZj0970809708epcas5p3l;
        Wed,  1 Aug 2018 05:58:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180801055857epsmtrp1c13ccc55e9f4f15706f2066d6b5e62a1~GrS4wd9Rd2967429674epsmtrp1k;
        Wed,  1 Aug 2018 05:58:57 +0000 (GMT)
X-AuditID: b6c32a4a-9cbff700000010d5-3e-5b614c8cb609
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.1E.03759.02C416B5; Wed,  1 Aug 2018 14:58:56 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180801055855epsmtip2f8c0b678b841713f4ca0b8fbeb9e8b21~GrS3dv4-k2166321663epsmtip2o;
        Wed,  1 Aug 2018 05:58:55 +0000 (GMT)
From:   Aashish Lakhwara <aashish.l@samsung.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     himanshu.sh@samssung.com, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, Aashish Lakhwara <aashish.l@samsung.com>,
        Himanshu Shukla <himanshu.sh@samsung.com>
Subject: [PATCH] posix-timers: Remove the stack variable clockid_t
 introduced as part of Protect posix clock array access against speculation
Date:   Wed,  1 Aug 2018 11:24:25 +0530
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWy7bCmhm6PT2K0wcduTouLu1Mtlj3fz2zx
        Yu5dVou9T1pYLS7vmsNmce/NViaLzZumMjuwe7w7d47dY8mcD+wefVtWMXp83iQXwBLFZZOS
        mpNZllqkb5fAlbH6CXvBQ86KA9ufMTUwzuHoYuTkkBAwkVi+aDJTFyMXh5DAbkaJ/asPsoMk
        hAQ+MUpM3cwBkfjGKDFl4xJmmI6VKw+wQyT2Mkq8W76CFcL5wihx89A7sCo2AT2JrunbwUaJ
        AHXcOnMULM4ssJhR4to6PpAGYYF+Roll9yaygSRYBFQlJq+YzQqxQk7i5LHJYFMlBP6ySmye
        3A+W4BUok1h4+ScLRJGLxKTPK5kgbGGJV8e3sEPYUhIv+9vYIZrbgU5auogRwpnCKLFn3W+o
        KnuJBzeOAtkcQDdpSqzfpQ8RlpWYemodE8SpfBK9v59ALeCV2DEPxlaWOPn/K1irhICkRN9+
        bYiwh0TLuhWskMCLlXh6ZzXbBEbZWQgLFjAyrmKUTC0ozk1PLTYtMMpLLdcrTswtLs1L10vO
        z93ECI53La8djMvO+RxiFOBgVOLhPVGdEC3EmlhWXJl7iFGCg1lJhNdGJj5aiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOO8Hv+BoIYH0xJLU7NTUgtQimCwTB6dUA2OrzfxGY/6UKaVxqdr2Wdrx
        kTUxbo4zIvqSPx1m8e6c/rRR2dvjxa9VGVOL2JPNRbqLSnNNjMSfpYQ8WvXwjeImubRN9xz4
        Hl57zLNga/bk4Jr3G3/OjbD6uc9Lvvz7omnPt3WrFO+OZuy40qGxu/5JgcFKm1MJMt4OC11E
        TggI5JeeXLk+VImlOCPRUIu5qDgRAPVkRzvzAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjluLIzCtJLcpLzFFi42LZdlhJXlfBJzHa4Mlva4uLu1Mtlj3fz2zx
        Yu5dVou9T1pYLS7vmsNmce/NViaLzZumMjuwe7w7d47dY8mcD+wefVtWMXp83iQXwBLFZZOS
        mpNZllqkb5fAlbH6CXvBQ86KA9ufMTUwzuHoYuTkkBAwkVi58gB7FyMXh5DAbkaJZ2+a2SES
        khJnlj1khrCFJVb+ew5V9IlRov/nWbAEm4CeRNf07WANIgJmEi1r25lBipgFljNKtEw+CeYI
        C/QyStx/cw+sikVAVWLyitmsXYwcHLwCrhJ/J8pCbJCTOHlsMusERp4FjAyrGCVTC4pz03OL
        DQsM81LL9YoTc4tL89L1kvNzNzGCQ0dLcwfj5SXxhxgFOBiVeHgLKhOihVgTy4orcw8xSnAw
        K4nw2sjERwvxpiRWVqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXA
        aG9r/+Oh1kVugTCd/KM7F5auM+yMLmLmkP+/uN/k4pU1MrcmFYTqa6Xy/fCzWLus6+bNyHVL
        nu4NrQtv3r/Oae/dlmv7Tm1Q+M64a0pG1a3Je7e9MVtUM1nymE/7TfVvD59yJak9tmwtFp3i
        X/iwZXvH+0Xvtky/GxLfpnxUYrXb39NTpjzeN0GJpTgj0VCLuag4EQCSiqfzGQIAAA==
Message-Id: <20180801055857epcas5p35ac85b8c9c9339eb3080e6d89b1a0ce6~GrS4x1NZj0970809708epcas5p3l@epcas5p3.samsung.com>
X-CMS-MailID: 20180801055857epcas5p35ac85b8c9c9339eb3080e6d89b1a0ce6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20180801055857epcas5p35ac85b8c9c9339eb3080e6d89b1a0ce6
References: <CGME20180801055857epcas5p35ac85b8c9c9339eb3080e6d89b1a0ce6@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "array_index_mask_nospec" code has been updated to allow index
argument to have const-qualified type.
Now the stack variable "idx" is no longer required and can be removed.
We should directly pass the const variable "id" to array_index_mask_nospec

Signed-off-by: Aashish Lakhwara <aashish.l@samsung.com>
Signed-off-by: Himanshu Shukla <himanshu.sh@samsung.com>
---
 kernel/time/posix-timers.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e08ce3f..face369 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1357,8 +1357,6 @@ static int common_nsleep(const clockid_t which_clock, int flags,
 
 static const struct k_clock *clockid_to_kclock(const clockid_t id)
 {
-	clockid_t idx = id;
-
 	if (id < 0) {
 		return (id & CLOCKFD_MASK) == CLOCKFD ?
 			&clock_posix_dynamic : &clock_posix_cpu;
@@ -1367,5 +1365,5 @@ static const struct k_clock *clockid_to_kclock(const clockid_t id)
 	if (id >= ARRAY_SIZE(posix_clocks))
 		return NULL;
 
-	return posix_clocks[array_index_nospec(idx, ARRAY_SIZE(posix_clocks))];
+	return posix_clocks[array_index_nospec(id, ARRAY_SIZE(posix_clocks))];
 }
-- 
1.9.1

