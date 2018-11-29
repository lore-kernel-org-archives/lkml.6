Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64269C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D503020863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fz9Gfh6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D503020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeK2PYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 10:24:02 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48526 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeK2PYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 10:24:02 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181129042002euoutp0233f3b0476b0331af679573413aab522b~rfWyDONJT3121031210euoutp02W;
        Thu, 29 Nov 2018 04:20:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181129042002euoutp0233f3b0476b0331af679573413aab522b~rfWyDONJT3121031210euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543465202;
        bh=fbpblLZt90xvyLZQGVOknDt0Vh5o5/ZPcblxuPsuGgo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Fz9Gfh6Xmr/wnQqkDyJcZBySqC1DPGjfkegY1jgoMNrMdk5wg3aDo9gagr3jFHre/
         WxzjGMrpauvnvrUJOdpbRcDmbqvYwSLRX1HLZp4mqPU9p+pUa0tOyr07mGLxVCfBSd
         pAtD5qGWE6BzxRSsxbn0AsysBqEJEBm7xFiNif7M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181129042001eucas1p2860c741e1d4c2dae884ee40c3469f9bc~rfWw1zt_O0819708197eucas1p2j;
        Thu, 29 Nov 2018 04:20:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EA.5C.04441.0F86FFB5; Thu, 29
        Nov 2018 04:20:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181129042000eucas1p19a67f367e084ed5d5f37f72e57eb98d5~rfWv9BwTF2480824808eucas1p12;
        Thu, 29 Nov 2018 04:20:00 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-81-5bff68f0781c
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7E.D6.04128.FE86FFB5; Thu, 29
        Nov 2018 04:19:59 +0000 (GMT)
Received: from localhost.localdomain ([10.88.99.240]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PIX00LS2TD58U40@eusync4.samsung.com>; Thu, 29 Nov
        2018 04:19:59 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Huijin Park <huijin.park@samsung.com>, bbanghj.park@gmail.com,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3] mtd: change len type from signed to unsigned type
Date:   Wed, 28 Nov 2018 23:19:51 -0500
Message-id: <1543465191-2100-1-git-send-email-huijin.park@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7djPc7ofMv5HG3St17Z4ufcQs8W+U/0s
        Fh0XXSwu75rDZrG7aRm7xdE995gtDrfvY3Vg95i3ptpj56y77B6bl9R79G1ZxejxeZNcAGsU
        l01Kak5mWWqRvl0CV8b6iz8ZC56xVTydfYK1gXEvaxcjB4eEgInEiYnmXYxcHEICKxgltt4+
        yQzhfGaU+N/WxdbFyAlWtL9tP1RiGaNEx9o77BDOX6CWp5OYQarYBLQlrq/dyghiiwgYSqyc
        2sICUsQscIlR4uTpzSwgCWEBV4nvW2ewg9gsAqoS/fvPMYHYvAJuEnsf32SEWCcncfNcJzOE
        /ZJVYkKLKoTtIvH4YC9UjbDEq+Nb2CFsGYnLk7tZIOxsiV+PWlkgfquQeDtPBSJsLPHu7Vqw
        kcwCfBKTtk1nhijhlehoE4IwPSSa/xWCVAgJxEosnP6UZQKjxAJGhlWM4qmlxbnpqcWGeanl
        esWJucWleel6yfm5mxiBsXX63/FPOxi/Xko6xCjAwajEwyux+l+0EGtiWXFl7iFGCQ5mJRHe
        TZ7/o4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzVjM8iBYSSE8sSc1OTS1ILYLJMnFwSjUw9jFH
        XLkusrMpzvmUy87A11ePHivrMax4t2bKgRD2x4+PqPJ9fe7U/Hzb8dMHreQX9/NkKNxW3H9f
        7rZRy/vouIatOSeNzt1tbmN+uNq89N02w6kvHsp75awutl02d977Bm3GRrZWl/VSWs/ZNE8J
        Xbgjyb459/6mt58i42dPeuNTI/9k2+TAXUosxRmJhlrMRcWJABhXRFapAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJMWRmVeSWpSXmKPExsVy+t/xa7rvM/5HGzR/0LF4ufcQs8W+U/0s
        Fh0XXSwu75rDZrG7aRm7xdE995gtDrfvY3Vg95i3ptpj56y77B6bl9R79G1ZxejxeZNcAGsU
        l01Kak5mWWqRvl0CV8b6iz8ZC56xVTydfYK1gXEvaxcjJ4eEgInE/rb9zF2MXBxCAksYJSZP
        OcoC4fxnlGi/up0RpIpNQFvi+tqtYLaIgKHEyqktYEXMApcYJa5v+8sGkhAWcJX4vnUGO4jN
        IqAq0b//HBOIzSvgJrH38U1GiHVyEjfPdTJPYORawMiwilEktbQ4Nz232EivODG3uDQvXS85
        P3cTIzAQth37uWUHY9e74EOMAhyMSjy8B1b8ixZiTSwrrsw9xCjBwawkwrvJ83+0EG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd7zBpVRQgLpiSWp2ampBalFMFkmDk6pBsauswKblVrj2tgk57S+
        MqoJftNaM/1z8J9c1wrG4sU7S29mPmje8VbB5IHhvnWLxO/PDM9P8eE/HXhn7Xcft7fXUp3N
        ZaJ0g4sUA9r6JO0WW8zcbWazsk7439r6fY8/f1slFHn4stfh3b92i7rvWfzWweNZb6aVePPZ
        eWFaizY0vRbZoVXIwK7EUpyRaKjFXFScCADhfEkKAAIAAA==
X-CMS-MailID: 20181129042000eucas1p19a67f367e084ed5d5f37f72e57eb98d5
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181129042000eucas1p19a67f367e084ed5d5f37f72e57eb98d5
References: <CGME20181129042000eucas1p19a67f367e084ed5d5f37f72e57eb98d5@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huijin.park" <huijin.park@samsung.com>

Callers of erase_write() always pass an unsigned int.
So this patch avoids a cast to an int.

Signed-off-by: huijin.park <huijin.park@samsung.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

---

Changes since v1:
 * Made commit message more clear.
Changes since v2:
 * Made commit message more clear.
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

