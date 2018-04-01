Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754627AbeDAUoD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:44:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754042AbeDAUn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:43:58 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 37/45] C++: Fix page_zonenum() int->enum
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:43:57 +0100
Message-ID: <152261543771.30503.8464564611508417569.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make page_zonenum() cast the int it derives to the enum return type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/mm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42adb1a..f91087e1ece6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -797,7 +797,7 @@ int finish_mkwrite_fault(struct vm_fault *vmf);
 
 static inline enum zone_type page_zonenum(const struct page *page)
 {
-	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
+	return (enum zone_type)((page->flags >> ZONES_PGSHIFT) & ZONES_MASK);
 }
 
 #ifdef CONFIG_ZONE_DEVICE
