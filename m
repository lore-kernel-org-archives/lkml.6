Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CC7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D4420854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL5VwlfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D4420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeGUUFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:05:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40700 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUUFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:05:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6-v6so14119759wrn.7;
        Sat, 21 Jul 2018 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rhCfgoM7pHxyUL+b1AT2trWpZrz6IBzdErHmsi71GfY=;
        b=ZL5VwlfUh6LZ0Y0P8Jc/3vCaaOsNrgFqNyJWt2mIgUEqgRmkwg1/sI9VE3sJ03uwz6
         8ZPbXaMqYCI70FN28T1egh3I3VSsXOTLBbrxUbtf4LKtJhY6ANbUni8Oc1CxCF/8nJNG
         lLmp7f6x05Ql/M5KpTE773YGpJsoWohbew92TWSHP5P3cpCz43K/qJp/kjX0ynPojpbE
         W7eCR9fr/ROcK6qBRITeIRLUBdFr2Uor1wR8n335/wKDSvn1AzL1nsA2GDBMk6/+AJR8
         oSiozxJPCaEZrNRRV1BtjxbUAD9bzjRUx1A5ggLPdksChlGjsEr46/1ULhoBUcvSRjRB
         AGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rhCfgoM7pHxyUL+b1AT2trWpZrz6IBzdErHmsi71GfY=;
        b=r9VcWVtfnFUHAAc8V4d2R3tZRZYSvt34lc9Lal0lUb9UjdLFgIn8M+2ke0/RYGgbWV
         PkmSDu92UWJRAe9elLP+WvrMVI48e1Nu3Q54LpeK5saHeWw/OMSoyZqG027fvCrxXtyf
         O0/ZkT+vD3q9odGnwISikXvqJ5TuINdDe02xkDH3kzvfDukPSsGzZW4XFZV3VOtPc4VQ
         wu0TkQO9gsUhXNZHe8fJK6YuzAJh4rIbq7gh83jng+PyIEuFf433T6S6nMs6Kh0P9sPa
         04YJ+PJDnSk+WGmjZ3Hd8mc3M/5ExAgEs73JHpH9gfIqNMciNlvoV1B/8EAp94vs65VZ
         4a+w==
X-Gm-Message-State: AOUpUlH/Ascsc/KY3MpjfMM/Oc73UEPlv8Pw7JFn2w+1anuCSpSW+R1B
        v2oWd9jRyTJ29nFknVelXSI=
X-Google-Smtp-Source: AAOMgpeYt//6GpDpF30p1UXHiayMT28UcAJqcvbH1xFJ9JS+jAnidC40NigYdh/SQkcMwIWXyQ7m1g==
X-Received: by 2002:adf:f188:: with SMTP id h8-v6mr4776571wro.214.1532200273892;
        Sat, 21 Jul 2018 12:11:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id x19-v6sm4241933wrd.32.2018.07.21.12.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:11:13 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andi Shyti <andi@etezian.org>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] touchscreen: ft5x06: Use octal permissions
Date:   Sun, 22 Jul 2018 00:39:52 +0530
Message-Id: <20180721191029.25658-11-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred. Consider using octal permissions '0644'.
+static EDT_ATTR(gain, S_IWUSR | S_IRUGO, WORK_REGISTER_GAIN,

WARNING: Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred. Consider using octal permissions '0644'.
+static EDT_ATTR(offset, S_IWUSR | S_IRUGO, WORK_REGISTER_OFFSET,

WARNING: Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred. Consider using octal permissions '0644'.
+static EDT_ATTR(threshold, S_IWUSR | S_IRUGO, WORK_REGISTER_THRESHOLD,

WARNING: Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred. Consider using octal permissions '0644'.
+static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO, WORK_REGISTER_REPORT_RATE,

WARNING: Symbolic permissions 'S_IRUSR' are not preferred. Consider using octal permissions '0400'.
+	debugfs_create_u16("num_x", S_IRUSR, tsdata->debug_dir, &tsdata->num_x);

WARNING: Symbolic permissions 'S_IRUSR' are not preferred. Consider using octal permissions '0400'.
+	debugfs_create_u16("num_y", S_IRUSR, tsdata->debug_dir, &tsdata->num_y);

WARNING: Symbolic permissions 'S_IRUSR | S_IWUSR' are not preferred. Consider using octal permissions '0600'.
+	debugfs_create_file("mode", S_IRUSR | S_IWUSR,

WARNING: Symbolic permissions 'S_IRUSR' are not preferred. Consider using octal permissions '0400'.
+	debugfs_create_file("raw_data", S_IRUSR,

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 1e18ca0d1b4e..ea4026682e79 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -479,16 +479,16 @@ static ssize_t edt_ft5x06_setting_store(struct device *dev,
 }
 
 /* m06, m09: range 0-31, m12: range 0-5 */
-static EDT_ATTR(gain, S_IWUSR | S_IRUGO, WORK_REGISTER_GAIN,
+static EDT_ATTR(gain, 0644, WORK_REGISTER_GAIN,
 		M09_REGISTER_GAIN, 0, 31);
 /* m06, m09: range 0-31, m12: range 0-16 */
-static EDT_ATTR(offset, S_IWUSR | S_IRUGO, WORK_REGISTER_OFFSET,
+static EDT_ATTR(offset, 0644, WORK_REGISTER_OFFSET,
 		M09_REGISTER_OFFSET, 0, 31);
 /* m06: range 20 to 80, m09: range 0 to 30, m12: range 1 to 255... */
-static EDT_ATTR(threshold, S_IWUSR | S_IRUGO, WORK_REGISTER_THRESHOLD,
+static EDT_ATTR(threshold, 0644, WORK_REGISTER_THRESHOLD,
 		M09_REGISTER_THRESHOLD, 0, 255);
 /* m06: range 3 to 14, m12: (0x64: 100Hz) */
-static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO, WORK_REGISTER_REPORT_RATE,
+static EDT_ATTR(report_rate, 0644, WORK_REGISTER_REPORT_RATE,
 		NO_REGISTER, 0, 255);
 
 static struct attribute *edt_ft5x06_attrs[] = {
@@ -739,12 +739,12 @@ edt_ft5x06_ts_prepare_debugfs(struct edt_ft5x06_ts_data *tsdata,
 	if (!tsdata->debug_dir)
 		return;
 
-	debugfs_create_u16("num_x", S_IRUSR, tsdata->debug_dir, &tsdata->num_x);
-	debugfs_create_u16("num_y", S_IRUSR, tsdata->debug_dir, &tsdata->num_y);
+	debugfs_create_u16("num_x", 0400, tsdata->debug_dir, &tsdata->num_x);
+	debugfs_create_u16("num_y", 0400, tsdata->debug_dir, &tsdata->num_y);
 
-	debugfs_create_file("mode", S_IRUSR | S_IWUSR,
+	debugfs_create_file("mode", 0600,
 			    tsdata->debug_dir, tsdata, &debugfs_mode_fops);
-	debugfs_create_file("raw_data", S_IRUSR,
+	debugfs_create_file("raw_data", 0400,
 			    tsdata->debug_dir, tsdata, &debugfs_raw_data_fops);
 }
 
-- 
2.17.1

