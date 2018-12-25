Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9753C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 21:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3AC21726
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 21:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="lQRt3g3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbeLYVVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 16:21:19 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:40928 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeLYVVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 16:21:18 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id E9BEBB00
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:21:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aMEuQgHoaXqb for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 15:21:16 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id B9873A84
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 15:21:16 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id s3so11774909iob.15
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 13:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lCkp6jRFzy9ncdV2SMZYnRpt0+yxeG0w4NzonuXqOII=;
        b=lQRt3g3cmqqOu9kVGA57mR4QYjwsM4I7LCv2V5R5iBIhJrjc7Yo17Bcv95IyMY7ZRG
         VcRGKNMXlg9bWuuXAAyaGyEgIFh4+1gHJPKX23tJb7mLrRLVZi/MXn5VGRup8c3flvWY
         2yU1yTWyCALewuuIPz38G0gGwUIPWjr1irIt2eCpDNLpuMDR82wCiRc8QLr/JpTRXSaP
         q7u9fVoEoXUty66CqvHBw0vETrhyjTvKGTkLHICSFQUZFi7bYE1TQEWw1EwuO324c5U3
         L+4tYmBWftrnWS//E/WbOka43bqBQwBd9dJnZaeZtWs1mgXm6ZW8Tib/SmqluDd9vE8H
         nOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lCkp6jRFzy9ncdV2SMZYnRpt0+yxeG0w4NzonuXqOII=;
        b=idypEYf4f+P3OhBeR5XYYWY2BqBHfxwga6ruzjk7ZsbSm+4jDUZdVFq5tq9H15f4Pb
         Yd0zRJMYxk5stUePUPmPz5C4c85yX2nt7gLLp8DTLNmISmaWLcQ4AX+EhhNApY+PP9re
         ztKDQL8NRY14RvAfIPosPM0Bfw2OdgvV9+kvS5/WpXcKmgOrmlj8Hw4DRqmSq6v+FU0F
         /t/t4CY7OKGdBr54XvEjtMMo6oSEpdQlBMyBYYrY+frn8YFVqKlIkl8sUIS/iu4qal7k
         mAsZvq9uh8VoHA88CkkMoJxjpYD2JMh/BThZOA+x+ZSxqlkTBI347pY7i7gn6PimS/yW
         h11A==
X-Gm-Message-State: AJcUukftmJe60MHdU14K3Cm3qgLzHY9g0erMLVBAGLbexfPEF+ZsUw4v
        0D8ZKJryrnBD1WWIRPwivXcSmiw77QDCB6nRYIhVQ15AzlyjS5n2zx0SKzxVQMezgB7wfJpTjBD
        uFb5md+R7/Zv7mdTSR0oPKoNFsY79
X-Received: by 2002:a5e:a708:: with SMTP id b8mr11745292iod.126.1545772876394;
        Tue, 25 Dec 2018 13:21:16 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5q8//ILtV+TPbWWdZ1v4w4J22JwSmUMhyRMtMG3zSjBC2tOldZO13wcjiWv21WQU0kfy9FnA==
X-Received: by 2002:a5e:a708:: with SMTP id b8mr11745284iod.126.1545772876170;
        Tue, 25 Dec 2018 13:21:16 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id m11sm15256673itb.24.2018.12.25.13.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 13:21:15 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: fix a double-fetch bug in adpt_i2o_passthru
Date:   Tue, 25 Dec 2018 15:20:47 -0600
Message-Id: <20181225212048.69782-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

user_msg[0] is a size variable, which is copied in from user space and
checked. It is copied in again from user space after the check, and used
in the following execution. Malicious user programs can race to change
user_msg[0] between the two copies, leading to incorrect size. The fix
ensures to use the checked size.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/scsi/dpt_i2o.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 37de8fb186d7..93bd1d1bd5b5 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -1733,6 +1733,9 @@ static int adpt_i2o_passthru(adpt_hba* pHba, u32 __user *arg)
 	if(copy_from_user(msg, user_msg, size)) {
 		return -EFAULT;
 	}
+	/* Ensure it is not changed in the second copy */
+	msg[0] = size;
+
 	get_user(reply_size, &user_reply[0]);
 	reply_size = reply_size>>16;
 	if(reply_size > REPLY_FRAME_SIZE){
-- 
2.17.2 (Apple Git-113)

