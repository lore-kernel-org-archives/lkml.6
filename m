Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB3AC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DAF2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p74/WgGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DAF2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732971AbeHWMM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:12:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56328 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeHWMM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:12:26 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180823084349euoutp010c1a83a808a2761d58665cb6ffd4e72d~NdvHjzppd2027220272euoutp01a;
        Thu, 23 Aug 2018 08:43:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180823084349euoutp010c1a83a808a2761d58665cb6ffd4e72d~NdvHjzppd2027220272euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535013829;
        bh=Aozi4G9TLjAEgBOXBeb6M4GZcq+eFucf7SG4h7JLEAc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=p74/WgGpqCzQGOygj5Qsg050YZIQpQ9ENvLOaQfeFMbYTdCPFccGFTqjrW6zLcUSX
         juh5P/gL+uVmBQ2Ilnnqwe4vBcQIHocYeFWmH398/1/NXYpT5K9edlWuM03v3K+Pck
         Xkkc2PZVcNeobhwfPigg1WPg6WMwG23oD1jjlIZo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180823084348eucas1p18a165172b1d3a0714dbfd923af877c0a~NdvHNkk3_1787517875eucas1p13;
        Thu, 23 Aug 2018 08:43:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AC.64.04441.4C37E7B5; Thu, 23
        Aug 2018 09:43:48 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180823084348eucas1p2157ab1089290298cf43647e522b8be4f~NdvGf-nWj3186731867eucas1p2M;
        Thu, 23 Aug 2018 08:43:48 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-ee-5b7e73c4841d
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EF.C5.04284.4C37E7B5; Thu, 23
        Aug 2018 09:43:48 +0100 (BST)
Received: from localhost.localdomain ([10.88.99.240]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PDW00I26O8TO920@eusync4.samsung.com>; Thu, 23 Aug
        2018 09:43:48 +0100 (BST)
From:   Huijin Park <huijin.park@samsung.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Huijin Park <huijin.park@samsung.com>, bbanghj.park@gmail.com
Subject: [PATCH] mtd: change len type from signed to unsigned type
Date:   Thu, 23 Aug 2018 04:43:39 -0400
Message-id: <1535013819-1646-1-git-send-email-huijin.park@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7djPc7pHiuuiDf4sV7V4ufcQs8W+U/0s
        Fh0XXSwu75rDZrG7aRm7xdE995gd2Dzmran22DnrLrvH5iX1Hn1bVjF6fN4kF8AaxWWTkpqT
        WZZapG+XwJXxbuMkpoIZ7BXbuuYxNTC+YO1i5OSQEDCR+HRuBXMXIxeHkMAKRokt2z6zQTif
        GSX6Fnezw1RNm/iDCSKxjFHizrebrBDOX0aJFVfmgc1iE9CWuL52KyOILSJgKLFyagsLSBGz
        wHJGiXcnZoAlhAWcJKYv3swEYrMIqEq8vtQLFucVcJP4+P8j1FFyEjfPdTJD2HdZJW5eM+9i
        5ACyXST6rjlBhIUlXh3fAnWdjERnx0EmCDtb4tejVhaI8gqJt/NUIMLGEu/ergWbyCzAJzFp
        23RmiBJeiY42IYgSD4lT886DdQoJxEqs+24zgVFiASPDKkbx1NLi3PTUYsO81HK94sTc4tK8
        dL3k/NxNjMCIOv3v+KcdjF8vJR1iFOBgVOLhFSisjRZiTSwrrsw9xCjBwawkwvt8c020EG9K
        YmVValF+fFFpTmrxIUZpDhYlcV4+rbRoIYH0xJLU7NTUgtQimCwTB6dUA2O3popHu8Gx9ULz
        7rxbMqVAdN5OWy7jwsnMuyRmMqy6MC8vpjH31l4lOfEkg0e9vhpPHvDtUfH9uUGj9deEM0s3
        BDb2H/px9teVRzwhh57vaGJq31XZN301R/GSSQXZP9ZPV13Oe8Dlo8qbRu/4XhWWf8vmizRO
        4/3TyM51MzR77tNPspWBlQVKLMUZiYZazEXFiQBciQWopAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJMWRmVeSWpSXmKPExsVy+t/xa7pHiuuiDR5NY7V4ufcQs8W+U/0s
        Fh0XXSwu75rDZrG7aRm7xdE995gd2Dzmran22DnrLrvH5iX1Hn1bVjF6fN4kF8AaxWWTkpqT
        WZZapG+XwJXxbuMkpoIZ7BXbuuYxNTC+YO1i5OSQEDCRmDbxB1MXIxeHkMASRok9x/+yQDj/
        GSUendoNVsUmoC1xfe1WRhBbRMBQYuXUFhYQm1lgOaPEhSs2ILawgJPE9MWbmUBsFgFVideX
        esHqeQXcJD7+/wi1TU7i5rlO5gmMXAsYGVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIEen/b
        sZ+bdzBe2hh8iFGAg1GJhzejuDZaiDWxrLgy9xCjBAezkgjv88010UK8KYmVValF+fFFpTmp
        xYcYpTlYlMR5zxtURgkJpCeWpGanphakFsFkmTg4pRoYjfvWdygVXzj3UOrr2fWqxevNGhd8
        8vseaKe8tCRFV93HS3Ste+j1RMMDm6ofJB7rsJq6b/F1vwd6SeFWuUrtR38eOam/aWPm3AXB
        Nxhfn3plEr1H59fmA9/Fq7sVdq+eLtH5z6Ds6PT+qKi7QgdnNf+tWRAw0fNABNvFxK8Oi3OX
        TN/t/CuWR4mlOCPRUIu5qDgRACYkhz76AQAA
X-CMS-MailID: 20180823084348eucas1p2157ab1089290298cf43647e522b8be4f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180823084348eucas1p2157ab1089290298cf43647e522b8be4f
References: <CGME20180823084348eucas1p2157ab1089290298cf43647e522b8be4f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huijin.park" <huijin.park@samsung.com>

assign of a signed value which has type 'int' to a variable of
a bigger unsigned integer type 'uint64_t'.
this is ok most of the time, but can lead to unexpectedly large
resulting value if the original signed value is negative.
in addtion, the callers of the erase_write() pass the len parameter
as unsigned type.

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

