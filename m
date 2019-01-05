Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03AAC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 14:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660842085A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 14:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="mi5GQckg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfAEOPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 09:15:03 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:39940 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAEOPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 09:15:03 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 6D7A1D78
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 14:15:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d2lfLqQVntIk for <linux-kernel@vger.kernel.org>;
        Sat,  5 Jan 2019 08:15:01 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 344A9B1B
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 08:15:01 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id o22so44733675iob.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 06:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9KuRQiel2Zn5wVqqh38Cb/R7QisvPWdWoN9J8qB0xus=;
        b=mi5GQckgUUNL2DteCUvtzEKDFJR4QVsOWDl+T6S3DcjNtWFBvWG6kci+OrMvF98yMJ
         UXku8oXJzwoGGLaHoZ1kIX47xgAUnQjAnrfQgC2rduF2Iv+0URL8soHxqTepfackSBik
         fHtqCvUnCIqrcoyY+6z/qFVUjfBKRIVXL3W+BFl+5p96M4ctcKAagSWQEqBEGzPRoOsk
         8K1kyXs4znA5B1evZ6Y1LhpGZLiTZdq57aWKHhseboVFrsS9Fl7Gk3q7upjomDBAJZBZ
         VuZFw89b+8rwxkCQiiaxdNrQQaOCfUn1j8tRlF95s+Hv8pyzMx/XbJsGG6b23dKuAPNt
         IO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9KuRQiel2Zn5wVqqh38Cb/R7QisvPWdWoN9J8qB0xus=;
        b=KryqebDq7//BaoVpA7Z6IS2i0uS7BPC40qKF1VY5YSoqGKkyo5Y46Dko7pTzaLHyf0
         OH6Q8DktQqciks2Oj7t0BvCtOa3DFtKAyfZQbJiTNBF7L3P/T8/PkZP0wKO8aLlQx48J
         Weo9wV2siOvCwkr7/ZAIT7kZJ1lVDWaChsI6n593W8S7iJZtRygea/q82d2uOHpgrU1A
         3VvUDhUkCf0c6AlZdvXumGl4xApw3FYjzvz96RPINil7/3gleJlrawwkILkMDz6o8BGx
         Ln80KkauljzGKPIrjvGy591fUL5/FIVNPnOhiguOTm5Pu+YYn2cZB8Mpgfo2MZCKHf3C
         LflA==
X-Gm-Message-State: AJcUukeTKoC4Ijba2XunJdnWSswbSeUsh1dI6nulcxw9Rr2hmQXVtUOm
        5/GsrnvFUfJTPX+rWEqIc3pHfMh82uJGwK/fhfdfFRhEQvyAAkBK93PZQ9TxbDxbBqg+GzTrnh+
        1EAUsHO9eInb79/ElzaxOYMNHccYO
X-Received: by 2002:a6b:7a0a:: with SMTP id h10mr33808379iom.114.1546697700798;
        Sat, 05 Jan 2019 06:15:00 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6/5Pcy1XJFUuXhvb+IA6+pCKyw0QpNfVspK2tt0E/WKd+aGNdHlSq6HFMVfJUGeb22ZDmAiA==
X-Received: by 2002:a6b:7a0a:: with SMTP id h10mr33808370iom.114.1546697700570;
        Sat, 05 Jan 2019 06:15:00 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id j129sm1931666itb.41.2019.01.05.06.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 06:15:00 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kim Bradley <kim.jamie.bradley@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        Aymen Qader <qader.aymen@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rts5208: Fix error handling on rtsx_send_cmd
Date:   Sat,  5 Jan 2019 08:14:41 -0600
Message-Id: <20190105141443.1745-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sd_execute_write_data, the rtsx_send_cmd could fail with ETIMEDOUT
or EIO. The fix adds a check to handle these failures.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/staging/rts5208/sd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index 2c47ae613ea1..c256a2398651 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -4437,7 +4437,12 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		rtsx_init_cmd(chip);
 		rtsx_add_cmd(chip, CHECK_REG_CMD, 0xFD30, 0x02, 0x02);
 
-		rtsx_send_cmd(chip, SD_CARD, 250);
+		retval = rtsx_send_cmd(chip, SD_CARD, 250);
+		if (retval < 0) {
+			write_err = true;
+			rtsx_clear_sd_error(chip);
+			goto sd_execute_write_cmd_failed;
+		}
 
 		retval = sd_update_lock_status(chip);
 		if (retval != STATUS_SUCCESS) {
-- 
2.17.1

