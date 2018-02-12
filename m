Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934572AbeBLMeh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:34:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932925AbeBLMeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:34:05 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH 2/3] fixup! audit: remove arch_f pointer from struct audit_krule
Date: Mon, 12 Feb 2018 07:29:40 -0500
Message-Id: <5f742621971f0267cf5854a6a5054746ef3ab95f.1518435853.git.rgb@redhat.com>
In-Reply-To: <cover.1518435853.git.rgb@redhat.com>
References: <cover.1518435853.git.rgb@redhat.com>
In-Reply-To: <cover.1518435853.git.rgb@redhat.com>
References: <cover.1518435853.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditfilter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 3343d1c..48dcb59 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -221,11 +221,13 @@ static inline int audit_match_class_bits(int class, u32 *mask)
 static int audit_match_signal(struct audit_entry *entry)
 {
 	int i;
+	u32 archval;
 	struct audit_field *arch;
 
 	for (i = 0; i < entry->rule.field_count; i++)
 		if (entry->rule.fields[i].type == AUDIT_ARCH) {
 			arch = &entry->rule.fields[i];
+			archval = arch->val;
 			break;
 		}
 
@@ -238,7 +240,7 @@ static int audit_match_signal(struct audit_entry *entry)
 					       entry->rule.mask));
 	}
 
-	switch(audit_classify_arch(arch->val)) {
+	switch(audit_classify_arch(archval)) {
 	case 0: /* native */
 		return (audit_match_class_bits(AUDIT_CLASS_SIGNAL,
 					       entry->rule.mask));
-- 
1.8.3.1
