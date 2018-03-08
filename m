Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934759AbeCHCCx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:02:53 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43778 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeCHCCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:02:51 -0500
X-Google-Smtp-Source: AG47ELuGl6mq6nloNJvG8ppYBVQSn13NCQYXqvZynqxVMqZ/GILRTlm0nHapSoLe76FdjDAYfvIDBw==
Date: Wed, 7 Mar 2018 23:02:48 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm/vgem: Indent switch and case at the same level
Message-ID: <c67b45979965cb1f1e80c3baa06814d14a0662bf.1520474055.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520474055.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520474055.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl errors:

vgem_drv.c:97: ERROR: switch and case should be at the same indent
vgem_drv.c:97: ERROR: trailing statements should be on next line

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index 2524ff116f00..5767030d04a8 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -94,7 +94,8 @@ static int vgem_gem_fault(struct vm_fault *vmf)
 		if (!IS_ERR(page)) {
 			vmf->page = page;
 			ret = 0;
-		} else switch (PTR_ERR(page)) {
+		} else {
+			switch (PTR_ERR(page)) {
 			case -ENOSPC:
 			case -ENOMEM:
 				ret = VM_FAULT_OOM;
@@ -110,8 +111,8 @@ static int vgem_gem_fault(struct vm_fault *vmf)
 				WARN_ON(PTR_ERR(page));
 				ret = VM_FAULT_SIGBUS;
 				break;
+			}
 		}
-
 	}
 	return ret;
 }
-- 
2.16.2
