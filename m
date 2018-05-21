Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeEUSS2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:18:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44398 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeEUSS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:18:26 -0400
X-Google-Smtp-Source: AB8JxZqu6gGK65X21ghD0S/5qPVf3E7pUi6uagUTdJIWfa4lMP2KRt0cwpQJaijO4QwNIakrAaG3Gg==
From: Omar Sandoval <osandov@osandov.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] Documentation: document hung_task_panic kernel parameter
Date: Mon, 21 May 2018 11:18:17 -0700
Message-Id: <53ad4158547699c2d35ba817394750dc2487158a.1526926625.git.osandov@fb.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This parameter has been around since commit e162b39a368f ("softlockup:
decouple hung tasks check from softlockup detection") in 2009 but was
never documented.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11fc28ecdb6d..4e37bebdc3d0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1341,6 +1341,16 @@
 			x86-64 are 2M (when the CPU supports "pse") and 1G
 			(when the CPU supports the "pdpe1gb" cpuinfo flag).
 
+	hung_task_panic=
+			[KNL] Should the hung task detector generate panics.
+			Format: <integer>
+
+			A nonzero value instructs the kernel to panic when a
+			hung task is detected. The default value is controlled
+			by the CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time
+			option. The value selected by this boot parameter can
+			be changed later by the kernel.hung_task_panic sysctl.
+
 	hvc_iucv=	[S390] Number of z/VM IUCV hypervisor console (HVC)
 			       terminal devices. Valid values: 0..8
 	hvc_iucv_allow=	[S390] Comma-separated list of z/VM user IDs.
-- 
2.17.0
