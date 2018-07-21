Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529D2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D70820856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+m0Pty3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D70820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbeGUNwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:52:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37252 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbeGUNuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so9016027pgq.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=19/g7fJMwhKFD+tRGYxB57t+9WX7azPDCbZdJLAQrJw=;
        b=D+m0Pty3dgeTJQGz3mzeV3yq8Hhpbja0PL+uueLqZ7PfUG2hA5/F4byVoSKfs7rpX7
         2/pBALGEPOa27Oo89RjyNHiaF0bOoX9G/8+ytGKA9kwdtRXpZEgkROLyALo98M4wax8t
         HWC+lQcDMktOiaf1ZUJ9QJcMwnsI/ZxJYwm5fjXJEuLkKdzwOxBLYF0R1ajS3czToeF7
         eJaPAz4HL0IB6VmPgb0HEVrnUFTc39dUf0EXwjYw8UEJYhq2hFhynA5UtuinVYuvsfsE
         StqiKPCswWFZ4MFm4Oxk7K7f8Wxu+bXNIHzIMRcKO+SffuAM7W+ehp2PLkwLQ6/Y+5z3
         PWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=19/g7fJMwhKFD+tRGYxB57t+9WX7azPDCbZdJLAQrJw=;
        b=YJUMLVfRgk9iLywJIb9KQglKrYI0It0FXW6zejBgx5lOjYZAXaTtR8KNtHsg6b9x/J
         knPlDsiIbjnsd1QS0kZkYMBP/PmMr+e5P7k1QWCVdzRg/wwsZjtek85CGsaSdEY0Sdtb
         Vnnwzqc1X+jD9H5cUKb3suJnECMLqlRZSJyFsKtPpsgNrS+I9sMdtKdch7Mw5jfg7YzZ
         4XgzqWuZSVY2B4F3PoZEAa9Zg8yg8Fek5mm9/4NuZzvtubF/c0ZbSdIFojm7pPnJFAs+
         lb8gGRSBBH5KaN+buvHjqVX4yn94jiSW1avInptzF0DLPc16/rqZZpAZL8YQmpCRrdgt
         eKLg==
X-Gm-Message-State: AOUpUlHMGdLR3VKTQTRGVhHt0e8rBsZ2WmnjwigJt5vYHLYqllouLJSE
        YbXffmBqdmt9RdqZoOEGi98=
X-Google-Smtp-Source: AAOMgpepNl6VYgVmwnNFuttXKQ+OXAKm4pLeKrLEnE5aAFFO0hJLROQ3dCb4uD+6EywROyn4ttxGjQ==
X-Received: by 2002:a62:1603:: with SMTP id 3-v6mr5945201pfw.245.1532177864080;
        Sat, 21 Jul 2018 05:57:44 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:43 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 06/14] staging: gasket: remove unnecessary NULL checks on calls from VFS
Date:   Sat, 21 Jul 2018 05:56:51 -0700
Message-Id: <20180721125713.88501-13-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove unneeded checks for NULL pointers in struct file pointers passed
from the VFS layer or the private_data that must have been properly set
at file open time.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 11ab049854493..e82f8ce39c9fd 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1587,11 +1587,6 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	int num_map_regions = 0;
 	enum do_map_region_status map_status;
 
-	if (!gasket_dev) {
-		gasket_nodev_error("Unable to retrieve device data");
-		trace_gasket_mmap_exit(-EINVAL);
-		return -EINVAL;
-	}
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 
 	if (vma->vm_start & ~PAGE_MASK) {
@@ -1785,17 +1780,7 @@ static long gasket_ioctl(struct file *filp, uint cmd, ulong arg)
 	void __user *argp = (void __user *)arg;
 	char path[256];
 
-	if (!filp)
-		return -ENODEV;
-
 	gasket_dev = (struct gasket_dev *)filp->private_data;
-	if (!gasket_dev) {
-		gasket_nodev_error(
-			"Unable to find Gasket structure for file %s",
-			d_path(&filp->f_path, path, 256));
-		return -ENODEV;
-	}
-
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 	if (!driver_desc) {
 		gasket_log_error(
-- 
2.18.0.233.g985f88cf7e-goog

