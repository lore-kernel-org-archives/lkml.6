Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934554AbeBLMeL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:34:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933433AbeBLMeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:34:06 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH 3/3] debug! audit: remove arch_f pointer from struct audit_krule
Date: Mon, 12 Feb 2018 07:29:41 -0500
Message-Id: <bd856b745b53b72fa33f9b0942894ac04a1d092c.1518435853.git.rgb@redhat.com>
In-Reply-To: <cover.1518435853.git.rgb@redhat.com>
References: <cover.1518435853.git.rgb@redhat.com>
In-Reply-To: <cover.1518435853.git.rgb@redhat.com>
References: <cover.1518435853.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditfilter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 48dcb59..3938ad2c 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -228,6 +228,8 @@ static int audit_match_signal(struct audit_entry *entry)
 		if (entry->rule.fields[i].type == AUDIT_ARCH) {
 			arch = &entry->rule.fields[i];
 			archval = arch->val;
+			pr_info("ams_: i=%d arch_f=%px type=%d op=%d val=%x key=\"%s\"",
+				i, arch, arch->type, arch->op, arch->val, entry->rule.filterkey ?: "");
 			break;
 		}
 
-- 
1.8.3.1
