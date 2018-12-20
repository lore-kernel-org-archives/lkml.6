Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B19C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95A720815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LftjvIsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbeLTH5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:57:41 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:43226 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLTH5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:57:40 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id D8F6AC23
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 07:57:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3MlLwajPUYhD for <linux-kernel@vger.kernel.org>;
        Thu, 20 Dec 2018 01:57:38 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id A82A3C19
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 01:57:38 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id j202so9928455itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 23:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rgxy5YsC49ef42vOCYF9uZ6jLzkAf/Ors+1y6IIcB5g=;
        b=LftjvIslbG3vC6zNTMqugln27D8+5RDxMBvTE911qqxyLUKTSjzwiVHsheoP2oY9D5
         n9zyKQy2MXygB/Lh423j9Q4MJAA6QesL2ZQXl1zyyTuM/hE7YhYZZsCWJGKVOjPuVSJB
         DcmMPJ1aSiHW0IkMi+qCC3pcPOZlBSmSq7F4Tjx1Ok7LvFD5Z/PNcheHkzbejAUSxsep
         BuDSjVGPUL4vqkVzKbIdJV96jpMyPDKgK91J/z3s0TMNrGNik3ao2PAw9OMsscBGzPlQ
         pN1TKJM158nRx/f/Fo3NUauWOFxnSYO90LxS8SH3kfyhPBw7H3qtHmu7E2vULSpnugjg
         7AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rgxy5YsC49ef42vOCYF9uZ6jLzkAf/Ors+1y6IIcB5g=;
        b=qaYUvBKYToJjd3+ndJwtXy/LWSrh56pfSMLTdv8LyJhAvdw79SWEV/Pt/T3d0nbSy+
         OiEgsffzLK4TBPgbYY9tcChJkHtYCrhmjAo+rs5leb5afx1q/A+0qyCkj8aVgXUy18qB
         Fekx4+G81pHnK86RAVNrHI2M/4lZEEXeAQFVm4ZfnAM5kIYarf514zVrBV81kviyz1SG
         aCvsLUfBoQoD8+fGvrYdbLDquikVencSBb9AGAHmN+23YleMFe6IGFvulEzJX/irxNFJ
         Nc8CTfFzXLUAef8ROM9FBA442rrww8vNQtyQeyiBqFT1XvzBXtQdJ5ULszvuZCDPRqGx
         BSpQ==
X-Gm-Message-State: AA+aEWY5wF+cIZFMtg5KHRWecYrKRDku+nFMGTNlkNOmrS0XSZg32Sxe
        W9q3FMJ3g8xVgwB+v5QNAQ4MhU+TlgADnqAOixlxtRsGjoorA8BiHlYT4zPpjx9ZDFoWcFWrds9
        9LTKa6ndLw5TltHC2HPPIWPGoKeBT
X-Received: by 2002:a24:cfc1:: with SMTP id y184mr8629064itf.72.1545292658260;
        Wed, 19 Dec 2018 23:57:38 -0800 (PST)
X-Google-Smtp-Source: AFSGD/XwuX+VR7vD5JRPbSmJoBv42yJk8qXOUfV8/bos+yRkYebnuMPO6gqGZlpxfpg4e9S726MW8g==
X-Received: by 2002:a24:cfc1:: with SMTP id y184mr8629055itf.72.1545292658027;
        Wed, 19 Dec 2018 23:57:38 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-24.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.24])
        by smtp.gmail.com with ESMTPSA id w186sm4604189itb.15.2018.12.19.23.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 23:57:37 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Aymen Qader <qader.aymen@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rts5208: add a missing check for the status of command sending
Date:   Thu, 20 Dec 2018 01:57:01 -0600
Message-Id: <20181220075704.40732-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ms_send_cmd() may fail. The fix checks the return value of it, and if it
fails, returns the error "STATUS_FAIL" upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/staging/rts5208/ms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index f53adf15c685..5a9e562465e9 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -2731,7 +2731,9 @@ static int mspro_rw_multi_sector(struct scsi_cmnd *srb,
 		}
 
 		if (val & MS_INT_BREQ)
-			ms_send_cmd(chip, PRO_STOP, WAIT_INT);
+			retval = ms_send_cmd(chip, PRO_STOP, WAIT_INT);
+			if (retval != STATUS_SUCCESS)
+				return STATUS_FAIL;
 
 		if (val & (MS_CRC16_ERR | MS_RDY_TIMEOUT)) {
 			dev_dbg(rtsx_dev(chip), "MSPro CRC error, tune clock!\n");
-- 
2.17.2 (Apple Git-113)

