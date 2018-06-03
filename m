Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeFCMd5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751402AbeFCM1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:27:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 05/29] tools: enable endian checks for all sparse builds
Date: Sun,  3 Jun 2018 14:26:28 +0200
Message-Id: <20180603122652.17453-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>

commit 376a5fb34b04524af501a0c5979c5920be940e05 upstream.

We dropped need for __CHECK_ENDIAN__ for linux,
this mirrors this for tools.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/include/linux/types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 8ebf6278b2ef..c24b3e3ae296 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -42,11 +42,7 @@ typedef __s8  s8;
 #else
 #define __bitwise__
 #endif
-#ifdef __CHECK_ENDIAN__
 #define __bitwise __bitwise__
-#else
-#define __bitwise
-#endif
 
 #define __force
 #define __user
-- 
2.17.1
