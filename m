Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFDEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A6C2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O8G6gY1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A6C2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeKMPNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:13:44 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52347 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMPNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:13:44 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181113051719euoutp017b4d3b9c97427c5bc5444ccf5e2320f5~ml0PEhiwb0533205332euoutp01p;
        Tue, 13 Nov 2018 05:17:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181113051719euoutp017b4d3b9c97427c5bc5444ccf5e2320f5~ml0PEhiwb0533205332euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542086239;
        bh=LPYjoS+0C2a3HV7byJ6VT2FylEsFyxNdcYoi+EuMbvE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=O8G6gY1HUr09urjD9rTW6pQo5m9nKVquKQlNuB5bJjrMmpBlxuGA/U2iYjBnnpse+
         gTIAE6+wpmOaTvkEalaLywZr6FEslt6B9Z28+5ZGL1qX/WqE6Vn0GXpuura7Fxne1I
         miyllmznEl6NSoSSSjOKZ2uiyikEtG0nYrYOgXQ4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181113051719eucas1p11b9c2286b1c48d53b96c91cadc890724~ml0OrHHws1639016390eucas1p1D;
        Tue, 13 Nov 2018 05:17:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 45.DC.04806.E5E5AEB5; Tue, 13
        Nov 2018 05:17:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181113051718eucas1p22fafec2dc4d5ea4eedb3686f6d566fad~ml0NdtWfS2220222202eucas1p2v;
        Tue, 13 Nov 2018 05:17:18 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-7b-5bea5e5e70bb
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AE.B3.04284.D5E5AEB5; Tue, 13
        Nov 2018 05:17:17 +0000 (GMT)
Received: from localhost.localdomain ([10.88.99.240]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PI40020E9CLYX60@eusync1.samsung.com>; Tue, 13 Nov
        2018 05:17:17 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Huijin Park <huijin.park@samsung.com>, bbanghj.park@gmail.com
Subject: [PATCH] mtd: change len type from signed to unsigned type
Date:   Tue, 13 Nov 2018 00:16:41 -0500
Message-id: <1542086201-18319-1-git-send-email-huijin.park@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7djP87rxca+iDV7OYbJ4ufcQs8W+U/0s
        Fh0XXSwu75rDZrG7aRm7xdE995gd2Dzmran22DnrLrvH5iX1Hn1bVjF6fN4kF8AaxWWTkpqT
        WZZapG+XwJVxd+VvxoJbrBXXf61lbGC8wNLFyMkhIWAi0bH/I5DNxSEksIJR4sn3S8wQzmdG
        iaNf1jHBVK16uoMJIrGMUeLS1MXsEM5fRonuhrnsIFVsAtoS19duZQSxRQQMJVZObQGbyyyw
        nFHi3YkZYAlhASeJ6Ys3g41lEVCV6H57HSzOK+Au0T3hDTvEOjmJm+c6we6QELjLKrH3/0JG
        iISLxOK2e1A3CUu8Or4FqkFGorPjIFQ8W+LXo1agzRxAdoXE23kqEGFjiXdv1zKD2MwCfBKT
        tk1nhijhlehoE4IwPSTubgIbIiQQKzHjwD+mCYwSCxgZVjGKp5YW56anFhvnpZbrFSfmFpfm
        pesl5+duYgRG1el/x7/uYNz3J+kQowAHoxIP74npL6OFWBPLiitzDzFKcDArifDuNHkVLcSb
        klhZlVqUH19UmpNafIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNTqoGxnSPzW0Xb/4vz
        dtxuY5r7L3aDuOzfJevk30zvbH6TV+E933RD/oa627P2X559TnPDrx9ZJXqtJ31uFSjP9JMV
        t5ir8a9w3X3NHAaFmTZin+NWSp3LP29sOiGqec+GfL+t0vqC/PoN3E+62qZKrPy1X+BdS+qz
        Gb8T/HZ+6BLPiPHjMisWvSCvxFKckWioxVxUnAgADNigZKYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJMWRmVeSWpSXmKPExsVy+t/xy7qxca+iDe7OsrF4ufcQs8W+U/0s
        Fh0XXSwu75rDZrG7aRm7xdE995gd2Dzmran22DnrLrvH5iX1Hn1bVjF6fN4kF8AaxWWTkpqT
        WZZapG+XwJVxd+VvxoJbrBXXf61lbGC8wNLFyMkhIWAiserpDqYuRi4OIYEljBL73jYwQzj/
        GSUm3jrNCFLFJqAtcX3tVjBbRMBQYuXUFrBuZoHljBIXrtiA2MICThLTF29mArFZBFQlut9e
        B6vnFXCX6J7whh1im5zEzXOdzBMYuRYwMqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQI9P62
        Yz8372C8tDH4EKMAB6MSD++J6S+jhVgTy4orcw8xSnAwK4nw7jR5FS3Em5JYWZValB9fVJqT
        WnyIUZqDRUmc97xBZZSQQHpiSWp2ampBahFMlomDU6qB0eT12V7nLe8f7/9j/Mmv7vnCtZ92
        KFm21J84b2ve4eq0uubfGnnthiPMrr3bjpY//hhTpfKz+1ng9yU1Oz+Jxj0/Ue1gYrL+RrNi
        wZIvJ+Y5X5ywcNHOlshLb5xvTTle112R5hMdsKTF9+CU9oKzLDUvJgfw389wY9pd8Gin7iyF
        jvUR1yvr85RYijMSDbWYi4oTAcKvtZ76AQAA
X-CMS-MailID: 20181113051718eucas1p22fafec2dc4d5ea4eedb3686f6d566fad
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181113051718eucas1p22fafec2dc4d5ea4eedb3686f6d566fad
References: <CGME20181113051718eucas1p22fafec2dc4d5ea4eedb3686f6d566fad@eucas1p2.samsung.com>
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

