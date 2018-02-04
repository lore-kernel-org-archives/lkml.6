Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750860AbeBDF1q (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 00:27:46 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45240 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbeBDF1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 00:27:42 -0500
X-Google-Smtp-Source: AH8x224A4bQ5lHuu3fD5zOBoWzeY3HOdZ1hx01Dr2LjgkL7ztfABBqJQgBpcW9+m7586d5B4u6WLzQ==
From: devesh.pradhan1@gmail.com
To: viro@zeniv.linux.org.uk
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        devesh pradhan <devesh.pradhan1@gmail.com>
Subject: [PATCH 2/2] kernel: compat: fixed a trailing whitespaces code style issue
Date: Sun,  4 Feb 2018 10:57:32 +0530
Message-Id: <20180204052732.3538-1-devesh.pradhan1@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: devesh pradhan <devesh.pradhan1@gmail.com>

Fixed a coding style issue.

Signed-off-by: devesh pradhan <devesh.pradhan1@gmail.com>
---
 kernel/compat.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/compat.c b/kernel/compat.c
index d1cee656a7ed..d40c83792ae9 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -475,10 +475,14 @@ get_compat_sigset(sigset_t *set, const compat_sigset_t __user *compat)
 	if (copy_from_user(&v, compat, sizeof(compat_sigset_t)))
 		return -EFAULT;
 	switch (_NSIG_WORDS) {
-	case 4: set->sig[3] = v.sig[6] | (((long)v.sig[7]) << 32 );
-	case 3: set->sig[2] = v.sig[4] | (((long)v.sig[5]) << 32 );
-	case 2: set->sig[1] = v.sig[2] | (((long)v.sig[3]) << 32 );
-	case 1: set->sig[0] = v.sig[0] | (((long)v.sig[1]) << 32 );
+	case 4:
+		set->sig[3] = v.sig[6] | (((long)v.sig[7]) << 32);
+	case 3:
+		set->sig[2] = v.sig[4] | (((long)v.sig[5]) << 32);
+	case 2:
+		set->sig[1] = v.sig[2] | (((long)v.sig[3]) << 32);
+	case 1:
+		set->sig[0] = v.sig[0] | (((long)v.sig[1]) << 32);
 	}
 #else
 	if (copy_from_user(set, compat, sizeof(compat_sigset_t)))
@@ -496,10 +500,14 @@ put_compat_sigset(compat_sigset_t __user *compat, const sigset_t *set,
 #ifdef __BIG_ENDIAN
 	compat_sigset_t v;
 	switch (_NSIG_WORDS) {
-	case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
-	case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
-	case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
-	case 1: v.sig[1] = (set->sig[0] >> 32); v.sig[0] = set->sig[0];
+	case 4:
+		v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
+	case 3:
+		v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
+	case 2:
+		v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
+	case 1:
+		v.sig[1] = (set->sig[0] >> 32); v.sig[0] = set->sig[0];
 	}
 	return copy_to_user(compat, &v, size) ? -EFAULT : 0;
 #else
-- 
2.14.1
