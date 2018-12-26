Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B556CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B8C20873
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="p3C8VNFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeLZS4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 13:56:37 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:57264 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeLZS4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 13:56:37 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id EC95F983
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 18:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xf85sRMS57Yh for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 12:56:35 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id BC3367B3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 12:56:35 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id f7so6628632ioo.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 10:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+rYvvJW5xjF1LCAJPBFZMyotpDfuiyvU5uEtKBUkrn4=;
        b=p3C8VNFjKZ2VcKFBagc6GsBDF4OPm1gxBF22AObx4P1aXItK2uAHYYWBd49cbmX79T
         mqriBgw4a7LzIINa5W61UYR1dDF6XBy3dvMem/KIorNw1XAsBGQcRXl/nrZYi10DG8VL
         +zLLlhBpUkzpF5KwBX0ICfo/jdH5x7vu7hVwZ7L/dXD/RpMnsKBeGwwaY12wbJ+dLa05
         QtW1oFKar6EanzFOGVpTXb5aGwU0kyfHIJ4b5v1cbgCmmQoxS63oDR6F5il0Kx8sJQ+Q
         jskvFZgJifnHpnLFaM5xgPEhaWEYQDLP4PlWViFqlNxJR15lE9KRSdKPKMR8y0sXkm5I
         3eIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+rYvvJW5xjF1LCAJPBFZMyotpDfuiyvU5uEtKBUkrn4=;
        b=dcSkkOCtOGY3GctpAIyRVTDkZPW/m+XOO+Zwew67A/oVR5JJitvLLbsFTvenP4wyxP
         1SLOTEbNTY2OX2ftBqBhD5WlE/ncB+x9nJeSP8h7d595ZGXBMtEN9xWno0OzHlPIPi+V
         j2E+oJ9kVcefo7dK6Yyzr+runhnYtWRF0iMgop7gzUzHVw4WXxPEpT9V943sUSadcCrE
         sGyWkwyvPIgiIp+eQZBe3WFAaPRCmMUn/Yj6iI8OtJf0x3BdzvvpdRkfBOtChowFs1AC
         QzAppYTGoSXxEH3mjpbUooX6Am9DCnN3bhxpFSgskyIjUPwogGDfVH9JmGPpVBIheHCE
         8ROw==
X-Gm-Message-State: AA+aEWZKBz6X+n7OBiKQnpcoNjP9oVpDt41ahoyyOGJX1DDQv1XoO7Wp
        /a4qkjGWMWpt85vx6fK4u9zUhXXd3OUTPVHcmPNsIp9xlqkzRq8LrSX2M1+8l4STxjRIQaAiGuT
        dowaWPmmC6ExzESZT1c2OC0JeUoHE
X-Received: by 2002:a02:970b:: with SMTP id x11mr13498369jai.67.1545850595339;
        Wed, 26 Dec 2018 10:56:35 -0800 (PST)
X-Google-Smtp-Source: AFSGD/Ukq8fsvws5Mr5ELLn2bTwvruCF14tAvgjHKpOUI3Yly6MCIUZU3FsINNFsQrFjklDDufdgwA==
X-Received: by 2002:a02:970b:: with SMTP id x11mr13498358jai.67.1545850595078;
        Wed, 26 Dec 2018 10:56:35 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id 197sm13273065itx.21.2018.12.26.10.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 10:56:34 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] infiniband: bnxt_re: qplib: Check the return value of send_message
Date:   Wed, 26 Dec 2018 12:56:22 -0600
Message-Id: <20181226185623.9324-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In bnxt_qplib_map_tc2cos(), bnxt_qplib_rcfw_send_message() can return
an error value. The fix returns the error from the latter function
upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 5216b5f844cc..adb8eae5193c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -778,9 +778,8 @@ int bnxt_qplib_map_tc2cos(struct bnxt_qplib_res *res, u16 *cids)
 	req.cos0 = cpu_to_le16(cids[0]);
 	req.cos1 = cpu_to_le16(cids[1]);
 
-	bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp, NULL,
-				     0);
-	return 0;
+	return bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
+						NULL, 0);
 }
 
 int bnxt_qplib_get_roce_stats(struct bnxt_qplib_rcfw *rcfw,
-- 
2.17.1

