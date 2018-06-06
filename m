Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 025EA601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933651AbeFFRJO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:09:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753839AbeFFRJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:09:10 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v3 2/6] AUDIT_CONTAINER message type basic support
Date: Wed,  6 Jun 2018 13:07:25 -0400
Message-Id: <1528304849-31826-3-git-send-email-rgb@redhat.com>
In-Reply-To: <1528304849-31826-1-git-send-email-rgb@redhat.com>
References: <1528304849-31826-1-git-send-email-rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines the message number for the audit container identifier
information record should the kernel headers not be up to date and gives
the record number a name for printing.

See: https://github.com/linux-audit/audit-userspace/issues/51
See: https://github.com/linux-audit/audit-kernel/issues/90
See: https://github.com/linux-audit/audit-testsuite/issues/64
See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 lib/libaudit.h    | 4 ++++
 lib/msg_typetab.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/lib/libaudit.h b/lib/libaudit.h
index 6cdd269..2dcd9e5 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -282,6 +282,10 @@ extern "C" {
 #define AUDIT_FANOTIFY		1331 /* Fanotify access decision */
 #endif
 
+#ifndef AUDIT_CONTAINER
+#define AUDIT_CONTAINER		1332 /* Container ID details */
+#endif
+
 #ifndef AUDIT_ANOM_LINK
 #define AUDIT_ANOM_LINK		1702 /* Suspicious use of file links */
 #endif
diff --git a/lib/msg_typetab.h b/lib/msg_typetab.h
index e94bfb2..1ff6605 100644
--- a/lib/msg_typetab.h
+++ b/lib/msg_typetab.h
@@ -124,6 +124,7 @@ _S(AUDIT_PROCTITLE,                  "PROCTITLE"                     )
 _S(AUDIT_FEATURE_CHANGE,             "FEATURE_CHANGE"                )
 _S(AUDIT_KERN_MODULE,                "KERN_MODULE"                   )
 _S(AUDIT_FANOTIFY,                   "FANOTIFY"                      )
+_S(AUDIT_CONTAINER,                  "CONTAINER"                     )
 _S(AUDIT_AVC,                        "AVC"                           )
 _S(AUDIT_SELINUX_ERR,                "SELINUX_ERR"                   )
 _S(AUDIT_AVC_PATH,                   "AVC_PATH"                      )
-- 
1.8.3.1
