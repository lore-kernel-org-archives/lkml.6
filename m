Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC6FECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794F020854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW4KRYno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794F020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388604AbeGWOWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:22:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46783 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388398AbeGWOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:22:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id h14-v6so667710wrw.13;
        Mon, 23 Jul 2018 06:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pxiUBWT6StcisgZzLlqRhxNfzDdkkF/jCBxlbL42Z2A=;
        b=AW4KRYnoQOGUx1XBgdosv7O27ajgAbPYNSYNqND9unDnYcZjcDDLSw70F2c027S8ht
         57Z4UgUCYSJZHrwi3bcITOQhxmJc45yBROY4EOFmVbPyhhlSKtsdjypUuGN+h7vJAxC3
         d2TPPqg2Wic1czm9iys+B9/G21JafS1mZie0KQG+qT/dFGhlJydQwq366PFBFzjEsd1t
         jb6hm2dQZO+SZmKo2BEUGFHSyO4p/M2qrxGorm96ySzw9/mnVNRCybXc29FT0pE9LV6s
         vNBIH5h+ZOrrQGGuKKYtmrCYyfeq17Q+JSDeS1nF4d0Fvd68dI5w0aX6xd6xObRvWLni
         Cjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pxiUBWT6StcisgZzLlqRhxNfzDdkkF/jCBxlbL42Z2A=;
        b=PuqPX16mkfqi1Z6qvVMSIbAXOJdulJPd72CIOKj6uQO9rasc2+cGOLqsjae6NYubND
         Uz6j1MrAje7YJLRBswKcyimAdTB0AFXkPTnc7ity+4i93agbmqUtfpEnka1h8R6NTDfr
         kbkQ+pcfWNlJ589CcyrDlJyREzGL4/mSu4fyndMhMMGFPQDSuc5xPWBaXjID1zlnztAx
         /xOlvW21HhCKRvet/4li2USxNKfbj5qoCHPcnYzuGxSLJFOjUUZvtA9WJkrHIjTnq+mY
         /2JzK6WqttcEygvoRugnRo9hSbbtxBlRhZRD4bn0XJDuXoKMYrnidkpgwEOiR0Foe/Rr
         WqSg==
X-Gm-Message-State: AOUpUlHne+vXY2NokmlfwsD+kZM/nQiwJNyN4fZ39nvRVHj0Ph3QniVr
        fRL1Chg69l7373k+pQqBOCk=
X-Google-Smtp-Source: AAOMgpfAJDu2j+JSKY8fg8gV0p4NCK7ELMBB2drrFdiWpFnQ+7xEKDCoHcqje4ef8rUB1M4vMCEe3Q==
X-Received: by 2002:adf:bb08:: with SMTP id r8-v6mr8189205wrg.244.1532352046311;
        Mon, 23 Jul 2018 06:20:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id t184-v6sm8368459wmf.18.2018.07.23.06.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:20:45 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Harshit Jain <harshitjain6751@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andi Shyti <andi@etezian.org>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] touchscreen: ft5x06: Use octal permissions
Date:   Mon, 23 Jul 2018 18:49:27 +0530
Message-Id: <20180723131954.30739-11-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723131954.30739-1-harshitjain6751@gmail.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
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

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
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

