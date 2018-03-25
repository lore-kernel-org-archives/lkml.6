Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeCYSDB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 14:03:01 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43744 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753719AbeCYSCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 14:02:53 -0400
X-Google-Smtp-Source: AG47ELvD8pDFk1tIEkDphtsm+n6R7278xe4lTMIvy6VJQyFdLnqhbLlO2WBbzZOwSoyelanofhjnrg==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie,
        seanpaul@chromium.org, gustavo@padovan.org, daniel.vetter@intel.com,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: [PATCH v2 1/2] gpu: drm/lease:: Use list_{next/prev}_entry instead of list_entry
Date: Sun, 25 Mar 2018 23:31:32 +0530
Message-Id: <1522000893-5331-2-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522000893-5331-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1522000893-5331-1-git-send-email-arushisinghal19971997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's better to use list_entry instead of list_{next/prev}_entry
as it makes the code more clear to read.
This patch replace list_entry with list_{next/prev}_entry.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/gpu/drm/drm_lease.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index 1402c0e..4dcfb5f 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -340,7 +340,7 @@ static void _drm_lease_revoke(struct drm_master *top)
 				break;
 
 			/* Over */
-			master = list_entry(master->lessee_list.next, struct drm_master, lessee_list);
+			master = list_next_entry(master, lessee_list);
 		}
 	}
 }
-- 
2.7.4
