Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeBZCXm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 21:23:42 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38569 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbeBZCX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 21:23:29 -0500
X-Google-Smtp-Source: AH8x224/sbwbt4jkqULwpkj3OPq5Iklj1g2yeph0sKJSpWBUmr4NPj94jThtWa9F7purFywkIVN2qQ==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: [PATCH 4/6] of: remove kbasename(of->full_name) from kobj.c
Date: Sun, 25 Feb 2018 18:22:28 -0800
Message-Id: <1519611750-22355-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519611750-22355-1-git-send-email-frowand.list@gmail.com>
References: <1519611750-22355-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

struct device_node full_name has been changed to include the
basename instead of the full path.  kbasename() is no longer
needed to extract the basename from full_name.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/kobj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index 7a0a18980b98..b0aecea35706 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -128,7 +128,7 @@ int __of_attach_node_sysfs(struct device_node *np)
 		name = safe_name(&of_kset->kobj, "base");
 		parent = NULL;
 	} else {
-		name = safe_name(&np->parent->kobj, kbasename(np->full_name));
+		name = safe_name(&np->parent->kobj, np->full_name);
 		parent = &np->parent->kobj;
 	}
 	if (!name)
-- 
Frank Rowand <frank.rowand@sony.com>
