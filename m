Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB02C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F908222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FVkSqv5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbfBLWYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:24:35 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43129 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBLWYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:24:34 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190212222433euoutp021465e49fe7a150fd5bf394f3205ef5a1~CviGhoBKM2689326893euoutp02b
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 22:24:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190212222433euoutp021465e49fe7a150fd5bf394f3205ef5a1~CviGhoBKM2689326893euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550010273;
        bh=lHA2/rqEByAHivG24SIu3k7EO9RgSTrK+vi4XMITJ34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVkSqv5GPIdpOB5lwCpsGFjbgw/5gLEM4NMOJMOQ3CgP1bR2IyNZXn2woB86mOfPY
         QVvfkitvVEv6XF+SKrZkNDilWBy7YBBl0xri7sMACxh+kHHT1vbncjgGCZNQ0vnbHq
         rQSF3VTHmjF+qE+vbSK8jWsCiQl9KVlOFA6jb8qo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212222431eucas1p23802362779a048333c66d59af25d4f06~CviE_2JE91608916089eucas1p2v;
        Tue, 12 Feb 2019 22:24:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CF.35.04294.F97436C5; Tue, 12
        Feb 2019 22:24:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190212222430eucas1p1ad7992e29d224790c1e20ef7442e62fe~CviDaqkvY1210112101eucas1p1z;
        Tue, 12 Feb 2019 22:24:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190212222429eusmtrp1815221f601600105e798420aa3d6ff87~CviDLycD_2311323113eusmtrp1f;
        Tue, 12 Feb 2019 22:24:29 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-fb-5c63479fac1b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E8.93.04128.D97436C5; Tue, 12
        Feb 2019 22:24:29 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190212222428eusmtip1091316f65cf88e58985c83afdf41ecf1~CviCScvdN0525605256eusmtip14;
        Tue, 12 Feb 2019 22:24:28 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 1/7] drivers: devfreq: change deferred work into delayed
Date:   Tue, 12 Feb 2019 23:23:52 +0100
Message-Id: <1550010238-24002-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO3d3u3ej6W1KHlSUBoo9nCYFl5IoCLsW9KB/MoWc86Kim3av
        Wmp/TAtnusJS1MpnSa5lLUVMLIfvZ4omI+eSzHwhvtoWIorkvFr/fc739/nyOxwOzpMY+O54
        nCqZZlTyBKlAhDZ2rw/5V1xQRAQaSjzIuhIDnyyyjqLkN/scn3yt9iEHsxYxclztSY42lwpI
        26NOQL7rnMDIr62VCGn78AuQlkydgDTmTCJkx6KGT64UsGedqdryWkC9UI+g1APjOEZV1qdQ
        VdY/fKpt+TNCrRhNAupxgx5Qtnqvq8KbouBoOiEulWYCzkSKYgtNM4KkVtHdzPuoGtjwXCDE
        IXECDuWPg1wgwiWEDsCf2g0+d7ADONaRL3BYEsIGoGEmda+RV7CKcFINgLNWI/jXqNZNo7kA
        xwWEDDbpbzsKrsQpOK9ZwBwOj+hGoLWlkOcYuBCXoPb3R9TBKOEDy0otO10xcRF26VTcMi9o
        Hnq4owu39S9Fb3ZuB4l2DGom2wAnnYer63MCjl3gQk8DxrEnHCjQohyzcDBHv+vcg5q+pl3n
        NOzoGeE79vKIw9DQHMDF52Dmph1xxJBwgmNLBxwxbxufNhbzuFgMc7IlnO0HG7TDCMcHYU1t
        EcYpFNSbd1+qHMAJUx2WD7yf/99VCYAeuNEprDKGZoNU9B0ZK1eyKaoYmSJRWQ+2v9HAVo+9
        CTRvRrUDAgfS/WJdV1SEhC9PZdOU7QDiPKmrODRYESERR8vT0mkm8RaTkkCz7cADR6Vu4ox9
        k+ESIkaeTMfTdBLN7E0RXOiuBtj39PzEloXGoxrz8lZIL3ats3/FUmIP2wjcYsa1ef6068uw
        Wm93X+eTPdInoWmW+aobXZEhY8NZ5ut4Z0CoTFFhctb2ZowJj/nai6d+HDLgU2uVb8PTgxRr
        V6KmVl59Ki5dKpgp63vvc9m2Nu3U/8xYPQvlfgkoYvRnsuMZKcrGyo8f4TGs/C/kS6PxQgMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xu7pz3ZNjDNouy1lsnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xa0GGYvLu+awWXzuPcJosfbIXXaLSwcWMFl83vCY0eJ24wo2i30d
        D5gsDr9pZ7V4P7nYgd9jzbw1jB6zGy6yeLTsu8XusWBTqcfCT19ZPQ6+28Pk8X7fVTaPvi2r
        GD0+b5IL4IzSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3S
        t0vQy5hy9SlbwQGuisZmlgbGzxxdjJwcEgImEt2TPzB1MXJxCAksZZSYu/ciE0RCTGLSvu3s
        ELawxJ9rXWwQRZ8YJTZd/AKU4OBgE9CT2LGqEKRGRMBG4v3cMywgNcwC15gkbnfcZwVJCAt4
        S/R83M4CYrMIqErMnXObBaSXV8BL4uiKPIj5chI3z3Uyg9icQOVnpq1kBSkRAippOmgwgZFv
        ASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMD42Hbs55YdjF3vgg8xCnAwKvHwrjiaFCPE
        mlhWXJl7iFGCg1lJhNfTJjlGiDclsbIqtSg/vqg0J7X4EKMp0EkTmaVEk/OBsZtXEm9oamhu
        YWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoHxuPq1P367pXh/l2XZr9Vpnqou
        YHenXyb2rP2jjYKPQgK0AnJ3rnfgqlz8ekl0uBHXrUtSLIJb1y2+4HspXJjPg2fDytb7X1W3
        yMk/YZ4pEX3k6Wcp+Zdb68pW/fuxPmjR8T9rLOzZj8kYMX1LWfCFba1dxx3vjTNS1iytyW1a
        toXnYRyn+mkHJZbijERDLeai4kQAR73YgaUCAAA=
X-CMS-MailID: 20190212222430eucas1p1ad7992e29d224790c1e20ef7442e62fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212222430eucas1p1ad7992e29d224790c1e20ef7442e62fe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212222430eucas1p1ad7992e29d224790c1e20ef7442e62fe
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222430eucas1p1ad7992e29d224790c1e20ef7442e62fe@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes deferred work to delayed work, which is now not missed
when timer is put on CPU that entered idle state.
The devfreq framework governor was not called, thus changing the device's
frequency did not happen.
Benchmarks for stressing Dynamic Memory Controller show x2 (in edge cases
even x5) performance boost with this patch when 'simpleondemand_governor'
is responsible for monitoring the device load and frequency changes.

With this patch, the delayed work is done no mater CPUs' idle.
All of the drivers in devfreq which rely on periodic, guaranteed wakeup
intervals should benefit from it.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de7..0c9bff8 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -407,7 +407,7 @@ static void devfreq_monitor(struct work_struct *work)
  */
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
-	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
+	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
 	if (devfreq->profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
-- 
2.7.4

