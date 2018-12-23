Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954B0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522992229F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6CIWCuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeLWPc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 10:32:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38656 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbeLWPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 10:32:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so4665736pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 07:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/yl7yD8531dQAr+4IA2CAhKhyKJ3AEPgtSs1TJxnYfo=;
        b=l6CIWCuHjARMIGRHcUj+OQlkkdjHbbZeVF+JoVW2cRU+kC/18hizNbcPKsbTNidZtd
         1kPt3DkwS/OBVFDmf6a3QeWbaUceQ19kz/hAQ35DvHSg/QAHJ/5K9ab8eSaHHZXkYeVN
         tOa25GUx6vOqIAlmdlu8bTYvehy/ckQ0jog7WihVx6fr004t5GG7ZXYEd8Anw3pVRsWZ
         AnGox1fsMqA7QsP3wn5RJyrqW9zyYgJEtqJggbQ19ah0tEFgNEtAi5ntE4b4EZGc9lu9
         7EUv5+6gjeR4mODhqk7uXFEkzdgFUtFP+CTA4PgqbG5QHoHF/i0EvWZuT8Nc8CYYqpf2
         Spyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/yl7yD8531dQAr+4IA2CAhKhyKJ3AEPgtSs1TJxnYfo=;
        b=slq0SCrlGldQLTTPpvuBpekb0dM66Wi+zZsk56bwkutirZrtMEtfy684YkeRKGA5hE
         2S6rAqWBVDLIqhI51Y4kVzcD7xEPdqdh4X9U8dbwINVVt1zhzmM4+H+YKiiyv4h2Pa8S
         nQt7t0hTgOzYdTi2FCaAj6xkC2A0DnmY4q2iRH0ebEXHmPvhzi40UkBVmJRF63aqsK4H
         9nr7u02CZbJnAawRFPiC6qu7sj6dhoPqo41+X2dZrr+7n9bUztyiUlDjwB6A8Ptg6sb2
         M6i+AcWunZFog+P8kf38xOaTvI19DUrHkzN8MMF7Mfw/xc3xgD2sAU6o1gJ0IPC7BT9g
         8zuQ==
X-Gm-Message-State: AJcUukfVXfUhBVgdPALSPq3FAP/GuuFNf7h9Hj9MFzv5pL6cd0JmEi+d
        JJdXrmDEMHRwrUgo5NSOAG4=
X-Google-Smtp-Source: ALg8bN79CmOBovGiouvim/nS6nPSsVB5XFhdwff7b5rV3LprnU++t1cgJAkIckXIGikTLgZqOx7pFQ==
X-Received: by 2002:a63:c00b:: with SMTP id h11mr9619074pgg.429.1545579148043;
        Sun, 23 Dec 2018 07:32:28 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b68sm42945737pfg.160.2018.12.23.07.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Dec 2018 07:32:27 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     linus.walleij@linaro.org, lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESNED] mfd: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sun, 23 Dec 2018 10:32:24 -0500
Message-Id: <20181223153224.2037-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/ab3100-core.c | 15 ++-------------
 drivers/mfd/ab3100-otp.c  | 16 +++-------------
 drivers/mfd/tps65010.c    | 14 ++------------
 3 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index 099635bed188..3fe448a29389 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -451,7 +451,7 @@ static irqreturn_t ab3100_irq_handler(int irq, void *data)
 /*
  * Some debugfs entries only exposed if we're using debug
  */
-static int ab3100_registers_print(struct seq_file *s, void *p)
+static int ab3100_registers_show(struct seq_file *s, void *p)
 {
 	struct ab3100 *ab3100 = s->private;
 	u8 value;
@@ -466,18 +466,7 @@ static int ab3100_registers_print(struct seq_file *s, void *p)
 	return 0;
 }
 
-static int ab3100_registers_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ab3100_registers_print, inode->i_private);
-}
-
-static const struct file_operations ab3100_registers_fops = {
-	.open = ab3100_registers_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(ab3100_registers);
 
 struct ab3100_get_set_reg_priv {
 	struct ab3100 *ab3100;
diff --git a/drivers/mfd/ab3100-otp.c b/drivers/mfd/ab3100-otp.c
index 55b207a4b336..24873e1ae865 100644
--- a/drivers/mfd/ab3100-otp.c
+++ b/drivers/mfd/ab3100-otp.c
@@ -96,7 +96,7 @@ static int __init ab3100_otp_read(struct ab3100_otp *otp)
  * the contents of the OTP.
  */
 #ifdef CONFIG_DEBUG_FS
-static int ab3100_show_otp(struct seq_file *s, void *v)
+static int ab3100_otp_show(struct seq_file *s, void *v)
 {
 	struct ab3100_otp *otp = s->private;
 
@@ -110,24 +110,14 @@ static int ab3100_show_otp(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int ab3100_otp_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ab3100_show_otp, inode->i_private);
-}
-
-static const struct file_operations ab3100_otp_operations = {
-	.open		= ab3100_otp_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ab3100_otp);
 
 static int __init ab3100_otp_init_debugfs(struct device *dev,
 					  struct ab3100_otp *otp)
 {
 	otp->debugfs = debugfs_create_file("ab3100_otp", S_IFREG | S_IRUGO,
 					   NULL, otp,
-					   &ab3100_otp_operations);
+					   &ab3100_otp_fops);
 	if (!otp->debugfs) {
 		dev_err(dev, "AB3100 debugfs OTP file registration failed!\n");
 		return -ENOENT;
diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 2ab67386b4ef..4202b5c40f18 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -192,7 +192,7 @@ static inline void show_chgconfig(int por, const char *label, u8 chgconfig) { }
 
 #ifdef	CONFIG_DEBUG_FS
 
-static int dbg_show(struct seq_file *s, void *_)
+static int debug_show(struct seq_file *s, void *_)
 {
 	struct tps65010	*tps = s->private;
 	u8		value, v2;
@@ -296,17 +296,7 @@ static int dbg_show(struct seq_file *s, void *_)
 	return 0;
 }
 
-static int dbg_tps_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dbg_show, inode->i_private);
-}
-
-static const struct file_operations debug_fops = {
-	.open		= dbg_tps_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(debug);
 
 #define	DEBUG_FOPS	&debug_fops
 
-- 
2.17.0

