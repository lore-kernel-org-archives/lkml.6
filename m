Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD7DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8511F2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ7tbSSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8511F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeLKQaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:30:16 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41920 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeLKQaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:30:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so6865635pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 08:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Oe95aZoIS6+9hSESpKYC5KhvQlR52B0Q7iaWWXayf3M=;
        b=GZ7tbSSQKg7hJr2CX44iunIdGBei9Mccto4e+20uRKVT+hVpMDlM1Rf9UFsEdEPlRe
         NhepXXOfFamSS7EjJcIceICVUBC1PfMHs+rv47FJuLyegDixrPAGqW7vdV4xRO8XRmhb
         MD3a27d9A3Nxjv4FYzd08eOfXBJN54/SuYZ2ynUzG3FV6E+jzIvQP2dDq18kmmzigq3a
         sQmYYGfan7TERnUvU8jDmsJT4FFMjsK1rvLZ1xvaDlki5OS/5b8KwDblE6qX1mMQj7Hq
         nQ+i87TLlzLxsl9dGog8AKiFHmnXpAazTI2/zCsGn+hGxFO5pn4c0XHXrg+iHm/7PUZH
         3Sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Oe95aZoIS6+9hSESpKYC5KhvQlR52B0Q7iaWWXayf3M=;
        b=kZgcAGcIdXlJGF3cGyAY3thmyX4DHe7s1lVT/EKGefmvSuVDQHCRi7yF54zVnmjAqP
         5i4EcpiH6ouHGpmxyLaziOXbia3V2VGAmlwGSCq5jhbpbGg8QS5sd8VSrz9I3e7nnolC
         6oSpAbDOB4LcMXc3kE5ekN9kZDDgD39ix2vkY1KlecHvYQ+OaEHu/k7w2nG3et2+1pMc
         jK8Lekhg/aY1D+0XqgQBDZoUkA7iYYXgAfBXISjqrB2hDS8RDD03RUWHNPKUd9bqHHyA
         AZwEj68JhoNOq8UBaB20bKQ0XxZdIVb1937fZuReHiRPeI3tQWFA3WdqnmLjRGqmp6ER
         xMRw==
X-Gm-Message-State: AA+aEWZRu830WVe0lFuPSWoKXRFzgSn+gVdqUo8+pZU6Qos74aAd6ePO
        gSyfl270ebl0J4cPl9SmtcYheet0v7Y=
X-Google-Smtp-Source: AFSGD/WPD2qDGN7jroTf8m+wGeKi7M92wcLhdFmwxd3F+gjL6aIJ13ugVFlx+DiE2gc6mcQqIcqm7Q==
X-Received: by 2002:a63:9a52:: with SMTP id e18mr15140449pgo.14.1544545815218;
        Tue, 11 Dec 2018 08:30:15 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id c7sm34307122pfa.24.2018.12.11.08.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 08:30:14 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] psi: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Tue, 11 Dec 2018 11:30:12 -0500
Message-Id: <20181211163012.22042-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/sched/psi.c | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index fe24de3fbc93..8d13210f88f4 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -714,52 +714,19 @@ static int psi_io_show(struct seq_file *m, void *v)
 {
 	return psi_show(m, &psi_system, PSI_IO);
 }
+DEFINE_SHOW_ATTRIBUTE(psi_io);
 
 static int psi_memory_show(struct seq_file *m, void *v)
 {
 	return psi_show(m, &psi_system, PSI_MEM);
 }
+DEFINE_SHOW_ATTRIBUTE(psi_memory);
 
 static int psi_cpu_show(struct seq_file *m, void *v)
 {
 	return psi_show(m, &psi_system, PSI_CPU);
 }
-
-static int psi_io_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, psi_io_show, NULL);
-}
-
-static int psi_memory_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, psi_memory_show, NULL);
-}
-
-static int psi_cpu_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, psi_cpu_show, NULL);
-}
-
-static const struct file_operations psi_io_fops = {
-	.open           = psi_io_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
-
-static const struct file_operations psi_memory_fops = {
-	.open           = psi_memory_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
-
-static const struct file_operations psi_cpu_fops = {
-	.open           = psi_cpu_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(psi_cpu);
 
 static int __init psi_proc_init(void)
 {
-- 
2.17.0

