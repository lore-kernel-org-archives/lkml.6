Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FD4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4E720841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATGTU17m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4E720841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeIADMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:12:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37010 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeIADMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:12:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so12511880wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7feZ3++nKRI9dJWVODLHTDL8ne7HJEqDC76Z2JNfZc8=;
        b=ATGTU17my7+adqs1SvU2ACx8JI9/FTBZvLMkw3IPr7icnRDu0e2eXihCsA8K29WjPx
         J9eXTG5+dZWJP6JubBKsOrw+3Sx4NO8Il9XV4IwY39YJoVeEP03+hdJKzygedGjHCbck
         iuqZVnPOXVS7FQ8f3EBXJhzN5ImTGqpSr3fyMdQl7zxMd9hG0dk1Q1u03fuPTuawPXha
         JDOGADct+fM9myn7J3Z+DzfYQGELY8UGzXAUmsQQSM7JA+aE1XH+colKbu1YxfI8D6m5
         Un9+OvCAFz79p9eOi4xylGVZWjlPn3Cc2ObJZBBQXnYaZUkAHQJgdlWUh5tGt9O5PTaU
         nndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7feZ3++nKRI9dJWVODLHTDL8ne7HJEqDC76Z2JNfZc8=;
        b=d1UoE71DPEzh8Pf08jY+goj+QIUsTG1klO4cgc8Bg3ZqE0wwTLhgytKnR2O3epk8+P
         jdazV0MC2Wo89ZN57MFuQ39zkpjZwszCNyz1/kD4iigr+3VqdGg1ha86hviYY9Z4gfU6
         n+6UOx1bm+ieOqGgvsr0PfPh5TN1eew2qrEK59wQ8Jk3CyJnyeaiRhMm+QWay/244TjX
         q3D81C/Rk+NtAV7fCL1Oww6CQ+ph9LI4i/xyE/4dPDxM3K+RkJKbFOItk0j0Nf1eC55f
         83d/KzKO3ZctiIUY1KR2t0gLpx1zWKG0+wlTYHU3IBRJ84ojb/bXKIKwSwc2C+c6omKe
         VPTw==
X-Gm-Message-State: APzg51AOCzijXm+NqZf9lobcLucnyq0xeITECkoIlar9cJ1U4j0etPG/
        yDtdVdGcbwrWEGh+XDDa4tv+cwfMZsA=
X-Google-Smtp-Source: ANB0VdZtn9zB0fe7blZFYzGOcFBlbsJ+FzsNUWsvZNf/7SNbD+Yi+SJuYo4Qaf+5TEVasTre/cPSNQ==
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr11315880wra.19.1535756582898;
        Fri, 31 Aug 2018 16:03:02 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/20] staging:rtl8192u: Rename RTL819xU_MODULE_NAME - Style
Date:   Sat,  1 Sep 2018 00:02:35 +0100
Message-Id: <20180831230250.16810-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the MACRO RTL819xU_MODULE_NAME to RTL819XU_MODULE_NAME, this
clears the checkpatch issue with CamelCase naming.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      | 2 +-
 drivers/staging/rtl8192u/r8192U_core.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 4dcfcb4d3911..81a7072a6285 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -40,7 +40,7 @@
 #include "ieee80211/ieee80211.h"
 
 #define RTL8192U
-#define RTL819xU_MODULE_NAME "rtl819xU"
+#define RTL819XU_MODULE_NAME "rtl819xU"
 /* HW security */
 #define MAX_KEY_LEN     61
 #define KEY_BUF_SIZE    5
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 98bb40c50f40..b3d32ea29fee 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -128,7 +128,7 @@ static void rtl8192_usb_disconnect(struct usb_interface *intf);
 
 
 static struct usb_driver rtl8192_usb_driver = {
-	.name		= RTL819xU_MODULE_NAME,		  /* Driver name   */
+	.name		= RTL819XU_MODULE_NAME,		  /* Driver name   */
 	.id_table	= rtl8192_usb_id_tbl,		  /* PCI_ID table  */
 	.probe		= rtl8192_usb_probe,		  /* probe fn      */
 	.disconnect	= rtl8192_usb_disconnect,	  /* remove fn     */
@@ -627,7 +627,7 @@ static int __maybe_unused proc_get_stats_rx(struct seq_file *m, void *v)
 static void rtl8192_proc_module_init(void)
 {
 	RT_TRACE(COMP_INIT, "Initializing proc filesystem");
-	rtl8192_proc = proc_mkdir(RTL819xU_MODULE_NAME, init_net.proc_net);
+	rtl8192_proc = proc_mkdir(RTL819XU_MODULE_NAME, init_net.proc_net);
 }
 
 static void rtl8192_proc_init_one(struct net_device *dev)
-- 
2.18.0

