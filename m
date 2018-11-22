Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A885AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE8920820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj/mCTf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE8920820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391701AbeKWAoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:44:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39046 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732770AbeKWAox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:44:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id c72so2004413pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ywbaYog3estOo2L8NdlXrVaiAnHO+YFiiunSV/kDEME=;
        b=hj/mCTf6eXBbzWnYkRzjqgQXK4Asq4ejztrg3hFQq18mrY/L6W/dzFDvM722oAFN5N
         NvmcoKLsGNjQu0ILDmh3MfRNePNlx6PIgRFHlnEthO1UQnTDf5QyQkkTYa7ZcAhUjftg
         jmdMf11ZyIV+Xm7CwjmjcTmN8N2WLiR+n7I5fcB6xQsVTZ9Jvq0iBftAJq/GFMesevgb
         NmHzFC//d6U28z0eWubzcm/0rdHPxOGwg5oW+rq6qKtmK6ckgSBuXMwfMwyoNW5kdXF9
         vHG1BpTnVPzDUxY3sBcGkI07Dsuh7KRQjc4GSP1tu8fkUZxjYwXvg+WZVya9n12Mm8PE
         zznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ywbaYog3estOo2L8NdlXrVaiAnHO+YFiiunSV/kDEME=;
        b=lbk96Gg7FrqShpKCw62JbGtPx7nfX8eUqfuiwzC/0i7tI3KgWAHJ87BG2Dx3UWNmpP
         ym3gTsNciy/5fNBrIi5sdGhE3ZL4xdIM+dr3ZqfjWaxeM4wfWidLjYhu5xHVS5VBtmRv
         LZeqkA8/3Adu8lRUCXmxIeyFvPMJnd8HKRsL2IGZygFmivbrz5x0jRlR8A9i7bgyLYT1
         vjP5pKRker0Zhq7WEI6OLtXq8f/+GzQTJTOYconLSWcH+s15JJD//5Ts84XEMW0N3wqK
         T1rXOZTDXhXb94aAw5k2BNaQwkLcQ0hNGnt/m0/oYvwMtg8ppZeUNEFBR6QwbDLNIfks
         PM0g==
X-Gm-Message-State: AGRZ1gKTxJWrIyWuxL79o5qiwP6FNY0czzrnFxfgDgN8RaJO2m9OoJGZ
        r0o2wKPxkyEGXVBL6QeR9Jg=
X-Google-Smtp-Source: AJdET5e7eSK3XcknLiz9vjGA2goGQE6J73MS2h1Q6PgpIjN3Pca3GPlqBTaaHopUyshTV+99/299qA==
X-Received: by 2002:a62:1043:: with SMTP id y64-v6mr11759822pfi.79.1542895523586;
        Thu, 22 Nov 2018 06:05:23 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id x63-v6sm68615906pfk.14.2018.11.22.06.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 06:05:22 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     nm@ti.com, t-kristo@ti.com, ssantosh@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] firmware: ti_sci: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Thu, 22 Nov 2018 09:05:19 -0500
Message-Id: <20181122140519.25166-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/firmware/ti_sci.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 69ed1464175c..3fbbb61012c4 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -146,25 +146,8 @@ static int ti_sci_debug_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-/**
- * ti_sci_debug_open() - debug file open
- * @inode:	inode pointer
- * @file:	file pointer
- *
- * Return: result of single_open
- */
-static int ti_sci_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ti_sci_debug_show, inode->i_private);
-}
-
-/* log file operations */
-static const struct file_operations ti_sci_debug_fops = {
-	.open = ti_sci_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+/* Provide the log file operations interface*/
+DEFINE_SHOW_ATTRIBUTE(ti_sci_debug);
 
 /**
  * ti_sci_debugfs_create() - Create log debug file
-- 
2.17.0

