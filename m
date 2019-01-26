Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4236CC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEFC218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="dVUxA+ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfAZKX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:23:29 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45471 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfAZKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:23:28 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so9232819edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 02:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pzFhJSS4KW5LhUkWfBQejbUA4Kwx9M/fuV2wEpFVbBQ=;
        b=dVUxA+kiTzlSdxLRDlhm1WlMsF6jc1VyE8Mr9eynhZfeKGBGbvOrQ9KdrYWwO5abjA
         U9j1nRpNbxkczS8ES+TSbbUKT/WSJ0TBWfKaHclICyb0rEEVulJvn/4O/mpB9L2I5A/x
         pXjRfCeRXZm8M/bL6zHAx+wbu+R2JnR90Kp74PewwtfzJ02ifhlvfm6xuBPe+FG+GOMs
         fqRuqZFW+hliKCvs39rfrfq5nAZJWG3R3/8FjVRkoMl/vSiyANpOG0TN22Eg2pienB+1
         JviDl3Iwik64rbyd/eAMW1xXmi1Zt4o8zGjkvMtjSQOB9Zy0W9DR5QFclHKwSjwA1sL6
         MevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pzFhJSS4KW5LhUkWfBQejbUA4Kwx9M/fuV2wEpFVbBQ=;
        b=agUCHoTtcjnreLIbdLOaTvzpBXukV7kOPC3iWyVENnG4bcgv4+PCgYOBV9gpY0V4Hc
         MrT5L9mc/p3PllRfS8STz/5xUVIUldOKawDfi7L7nJSNPhFf/DNqshLGC8HzeIkH4IF2
         gNf/rWgCCpI8akKC99eg8jD4/BFid6t4yINzJdlDqDWitsUpbd2EoVk5AqKnAkGUQZnV
         LHQKf3YfM7HsYZjhRJAQRxwwte65FwxUY55t3xv6P70/yJLiagcS0NsQZFif5Jj5ZRgC
         yibQPo2Ewhhe5mJfup7U+hRLLeAsEMxPhhhDJOVbkJV4c5PL5VHG3YVC1AGYVwnSPpvA
         vN6w==
X-Gm-Message-State: AJcUukfz4OgI/xzuLwsEEH8oXUNYecZsW9AngcGOxKoTtVN0skw9H5m7
        sTEfmxhv3Ko6KGcRPLghvnIsLQ==
X-Google-Smtp-Source: ALg8bN4aOlk6E4lQluOWEXihkYIbYKawmoBTtY6lMDxq/JGZu2RrXK2Q8HbCFHW8IATEWvtXx+r65A==
X-Received: by 2002:a50:9063:: with SMTP id z32mr14108965edz.133.1548498205875;
        Sat, 26 Jan 2019 02:23:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6bf:f9e4:6c97:81a6:a1a2:5bb2])
        by smtp.gmail.com with ESMTPSA id b46sm12677656edc.57.2019.01.26.02.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 02:23:25 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, Christian Brauner <christian@brauner.io>,
        Martijn Coenen <maco@google.com>
Subject: [PATCH] binder: fix CONFIG_ANDROID_BINDER_DEVICES
Date:   Sat, 26 Jan 2019 11:23:20 +0100
Message-Id: <20190126102320.14120-1-christian@brauner.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several users have tried to only rely on binderfs to provide binder devices
and set CONFIG_ANDROID_BINDER_DEVICES="" empty. This is a great use-case of
binderfs and one that was always intended to work. However, this is
currently not possible since setting CONFIG_ANDROID_BINDER_DEVICES="" emtpy
will simply panic the kernel:

kobject: (00000000028c2f79): attempted to be registered with empty name!
WARNING: CPU: 7 PID: 1703 at lib/kobject.c:228 kobject_add_internal+0x288/0x2b0
Modules linked in: binder_linux(+) bridge stp llc ipmi_ssif gpio_ich dcdbas coretemp kvm_intel kvm irqbypass serio_raw input_leds lpc_ich i5100_edac mac_hid ipmi_si ipmi_devintf ipmi_msghandler sch_fq_codel ib_i
CPU: 7 PID: 1703 Comm: modprobe Not tainted 5.0.0-rc2-brauner-binderfs #263
Hardware name: Dell      DCS XS24-SC2          /XS24-SC2              , BIOS S59_3C20 04/07/2011
RIP: 0010:kobject_add_internal+0x288/0x2b0
Code: 12 95 48 c7 c7 78 63 3b 95 e8 77 35 71 ff e9 91 fe ff ff 0f 0b eb a7 0f 0b eb 9a 48 89 de 48 c7 c7 00 63 3b 95 e8 f8 95 6a ff <0f> 0b 41 bc ea ff ff ff e9 6d fe ff ff 41 bc fe ff ff ff e9 62 fe
RSP: 0018:ffff973f84237a30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8b53e2472010 RCX: 0000000000000006
RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff8b53edbd63a0
RBP: ffff973f84237a60 R08: 0000000000000342 R09: 0000000000000004
R10: ffff973f84237af0 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8b53e9f1a1e0 R14: 00000000e9f1a1e0 R15: 0000000000a00037
FS:  00007fbac36f7540(0000) GS:ffff8b53edbc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbac364cfa7 CR3: 00000004a6d48000 CR4: 00000000000406e0
Call Trace:
 kobject_add+0x71/0xd0
 ? _cond_resched+0x19/0x40
 ? mutex_lock+0x12/0x40
 device_add+0x12e/0x6b0
 device_create_groups_vargs+0xe4/0xf0
 device_create_with_groups+0x3f/0x60
 ? _cond_resched+0x19/0x40
 misc_register+0x140/0x180
 binder_init+0x1ed/0x2d4 [binder_linux]
 ? trace_event_define_fields_binder_transaction_fd_send+0x8e/0x8e [binder_linux]
 do_one_initcall+0x4a/0x1c9
 ? _cond_resched+0x19/0x40
 ? kmem_cache_alloc_trace+0x151/0x1c0
 do_init_module+0x5f/0x216
 load_module+0x223d/0x2b20
 __do_sys_finit_module+0xfc/0x120
 ? __do_sys_finit_module+0xfc/0x120
 __x64_sys_finit_module+0x1a/0x20
 do_syscall_64+0x5a/0x120
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fbac3202839
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd1494a908 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055b629ebec60 RCX: 00007fbac3202839
RDX: 0000000000000000 RSI: 000055b629c20d2e RDI: 0000000000000003
RBP: 000055b629c20d2e R08: 0000000000000000 R09: 000055b629ec2310
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
R13: 000055b629ebed70 R14: 0000000000040000 R15: 000055b629ebec60

So check for the empty string since strsep() will otherwise return the
emtpy string which will cause kobject_add_internal() to panic when trying
to add a kobject with an emtpy name.

Fixes: ac4812c5ffbb ("binder: Support multiple /dev instances")
Cc: Martijn Coenen <maco@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 drivers/android/binder.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 751d76173f81..5f7d6fe06eec 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5898,21 +5898,23 @@ static int __init binder_init(void)
 				    &transaction_log_fops);
 	}
 
-	/*
-	 * Copy the module_parameter string, because we don't want to
-	 * tokenize it in-place.
-	 */
-	device_names = kstrdup(binder_devices_param, GFP_KERNEL);
-	if (!device_names) {
-		ret = -ENOMEM;
-		goto err_alloc_device_names_failed;
-	}
+	if (strcmp(binder_devices_param, "") != 0) {
+		/*
+		* Copy the module_parameter string, because we don't want to
+		* tokenize it in-place.
+		 */
+		device_names = kstrdup(binder_devices_param, GFP_KERNEL);
+		if (!device_names) {
+			ret = -ENOMEM;
+			goto err_alloc_device_names_failed;
+		}
 
-	device_tmp = device_names;
-	while ((device_name = strsep(&device_tmp, ","))) {
-		ret = init_binder_device(device_name);
-		if (ret)
-			goto err_init_binder_device_failed;
+		device_tmp = device_names;
+		while ((device_name = strsep(&device_tmp, ","))) {
+			ret = init_binder_device(device_name);
+			if (ret)
+				goto err_init_binder_device_failed;
+		}
 	}
 
 	ret = init_binderfs();
-- 
2.20.1

