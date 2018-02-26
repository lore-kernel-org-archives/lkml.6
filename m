Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeBZCXs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 21:23:48 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35313 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeBZCXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 21:23:31 -0500
X-Google-Smtp-Source: AH8x226mLh65SB3r7BhbpTrf7fAn6jW5DepzrAztWaE5Oa+wCTm9hD5uSIbB0qLcXWcKXhom3RtKFg==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: [PATCH 6/6] of: remove kbasename(of->full_name) from platform.c
Date: Sun, 25 Feb 2018 18:22:30 -0800
Message-Id: <1519611750-22355-7-git-send-email-frowand.list@gmail.com>
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
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c00d81dfac0b..17116f5ce6ba 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -94,7 +94,7 @@ static void of_device_make_bus_id(struct device *dev)
 
 		/* format arguments only used if dev_name() resolves to NULL */
 		dev_set_name(dev, dev_name(dev) ? "%s:%s" : "%s",
-			     kbasename(node->full_name), dev_name(dev));
+			     node->full_name, dev_name(dev));
 		node = node->parent;
 	}
 }
-- 
Frank Rowand <frank.rowand@sony.com>
