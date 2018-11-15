Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00705C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1D921582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DmJ+biDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1D921582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbeKOPNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:13:45 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41075 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeKOPNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:13:45 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181115050726euoutp02b3fb91d7fe4565f9a3653c706000b7a7~nM_KtBW-Z0693406934euoutp02i;
        Thu, 15 Nov 2018 05:07:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181115050726euoutp02b3fb91d7fe4565f9a3653c706000b7a7~nM_KtBW-Z0693406934euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542258446;
        bh=LPYjoS+0C2a3HV7byJ6VT2FylEsFyxNdcYoi+EuMbvE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=DmJ+biDEEfD/VZ3EBA523Bz7sMG6vvViF288MTbti2BePix5PiKGf+vFspZ9yp6Xo
         o3+HAZVgFsmLBKzt6SG6+CYZNZtaYgxN1uaQjoStAZ4EmiG1tx3lWx8QEpc0GQR82l
         o5NKTFa8yIkoPNBI9P52S/olwCndDNzWGUfyDFhA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181115050725eucas1p15364624bca3f4eedcb89fe5083404a09~nM_KCr5P20922809228eucas1p1K;
        Thu, 15 Nov 2018 05:07:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B9.74.04294.D0FFCEB5; Thu, 15
        Nov 2018 05:07:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181115050724eucas1p169b2046c03e108035199a4481a82a560~nM_JSFA7O0711707117eucas1p1S;
        Thu, 15 Nov 2018 05:07:24 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-74-5becff0df5ff
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D3.CC.04284.C0FFCEB5; Thu, 15
        Nov 2018 05:07:24 +0000 (GMT)
Received: from localhost.localdomain ([10.88.99.240]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PI7004S0Y805630@eusync4.samsung.com>; Thu, 15 Nov
        2018 05:07:24 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Huijin Park <huijin.park@samsung.com>, bbanghj.park@gmail.com
Subject: [PATCH v2] mtd: change len type from signed to unsigned type
Date:   Thu, 15 Nov 2018 00:07:10 -0500
Message-id: <1542258430-19885-1-git-send-email-huijin.park@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7djPc7q8/99EG5y9zGLxcu8hZot9p/pZ
        LDouulhc3jWHzWJ30zJ2i6N77jE7sHnMW1PtsXPWXXaPzUvqPfq2rGL0+LxJLoA1issmJTUn
        syy1SN8ugSvj7srfjAW3WCuu/1rL2MB4gaWLkZNDQsBE4sunTuYuRi4OIYEVjBJPHm1hhXA+
        M0pM6gFxIKp+Lm2EqlrGKPHp/RkmCOcvo8Tf19fBZrEJaEtcX7uVEcQWETCUWDm1hQWkiFlg
        OaPEuxMzwBLCAq4SN/4fZgOxWQRUJW42bWMGsXkF3CU2/N3HDLFOTuLmuU4o+y6rxOPH/F2M
        HEC2i8Sj/SIQYWGJV8e3sEPYMhKdHQeZIOxsiV+PWlkgyisk3s5TgQgbS7x7uxZsIrMAn8Sk
        bdOZIUp4JTrahCBKPCTevr/JBhIWEoiVuPhTewKjxAJGhlWM4qmlxbnpqcVGeanlesWJucWl
        eel6yfm5mxiBEXX63/EvOxh3/Uk6xCjAwajEw3vC6k20EGtiWXFl7iFGCQ5mJRHeBTVAId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYw6V85Nz9WM1vCe
        ss1otlWaOwcny5F/vx//+8p44UaIUO2CKQ9ftO5d1nPgdmjxot+f22v9pHj90xPZT9967L3H
        cMn1JVGK7tWBaZ8FLtvdZDNh+5ppVSDfbGL0dtHcnvYCw5cHNc9K1e38b/rSd9HNH8vORFaz
        lW7sZzWW//3P5fGh3qWNL4KUWIozEg21mIuKEwE0u73CpAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJMWRmVeSWpSXmKPExsVy+t/xa7o8/99EGzz9L23xcu8hZot9p/pZ
        LDouulhc3jWHzWJ30zJ2i6N77jE7sHnMW1PtsXPWXXaPzUvqPfq2rGL0+LxJLoA1issmJTUn
        syy1SN8ugSvj7srfjAW3WCuu/1rL2MB4gaWLkZNDQsBE4ufSRuYuRi4OIYEljBLv26awQDj/
        GSUOr9zKBlLFJqAtcX3tVkYQW0TAUGLl1BawbmaB5YwSF67YgNjCAq4SN/4fBqtnEVCVuNm0
        jRnE5hVwl9jwdx8zxDY5iZvnOpknMHItYGRYxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJEej9
        bcd+bt7BeGlj8CFGAQ5GJR7eE1ZvooVYE8uKK3MPMUpwMCuJ8C6oAQrxpiRWVqUW5ccXleak
        Fh9ilOZgURLnPW9QGSUkkJ5YkpqdmlqQWgSTZeLglGpgzKp/kH268ulV01e9Judncm3Z/F2J
        MdXOMm+tWe/y33xpso4fTY5UXripwiviYVoQ4K/dejte6Yj7nTSr34lmAeXHRQxmLn3zO+Rh
        3JKlNZOiWO//Fd5r+tKOz6TD7srvy001yXG5V08/kf0UPHO5T+82h3bD9jPL++Zu2+19U4/p
        ebXmLu5FSizFGYmGWsxFxYkAUasv8voBAAA=
X-CMS-MailID: 20181115050724eucas1p169b2046c03e108035199a4481a82a560
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181115050724eucas1p169b2046c03e108035199a4481a82a560
References: <CGME20181115050724eucas1p169b2046c03e108035199a4481a82a560@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huijin.park" <huijin.park@samsung.com>

This patch casts the "len" parameter to an unsigned int.
The callers of erase_write() pass the "len" parameter as unsigned int.

Signed-off-by: huijin.park <huijin.park@samsung.com>
---
 drivers/mtd/mtdblock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
index a5b1933..b2d5ed1 100644
--- a/drivers/mtd/mtdblock.c
+++ b/drivers/mtd/mtdblock.c
@@ -56,7 +56,7 @@ struct mtdblk_dev {
  */
 
 static int erase_write (struct mtd_info *mtd, unsigned long pos,
-			int len, const char *buf)
+			unsigned int len, const char *buf)
 {
 	struct erase_info erase;
 	size_t retlen;
-- 
1.7.9.5

