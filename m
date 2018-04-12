Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeDLQBf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:01:35 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38060 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDLQBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:01:32 -0400
X-Google-Smtp-Source: AIpwx49jHl9b9JT1a4EKZ3M7ZAPwe5KUvH5gYzG5SPqZ/QizdUPQHUWR8jqyvn9BpkckInlh/KUdoA==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
X-Google-Original-From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: boris.ostrovsky@oracle.com, jgross@suse.com,
        iurii.konovalenko@globallogic.com,
        oleksandr.dmytryshyn@globallogic.com, konrad.wilk@oracle.com,
        tiwai@suse.de, andr2000@gmail.com
Subject: [PATCH 3/5] xen/sndif: Make requests and responses 64 octets long
Date: Thu, 12 Apr 2018 19:01:00 +0300
Message-Id: <20180412160102.15833-4-oleksandr_andrushchenko@epam.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
References: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the size of the requests and responses to 64 octets.
Bump protocol version to 2.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 include/xen/interface/io/sndif.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/xen/interface/io/sndif.h b/include/xen/interface/io/sndif.h
index b775df96f021..d48175f1a3d2 100644
--- a/include/xen/interface/io/sndif.h
+++ b/include/xen/interface/io/sndif.h
@@ -41,7 +41,7 @@
  *                           Protocol version
  ******************************************************************************
  */
-#define XENSND_PROTOCOL_VERSION	1
+#define XENSND_PROTOCOL_VERSION	2
 
 /*
  ******************************************************************************
@@ -533,7 +533,7 @@
  *
  *---------------------------------- Requests ---------------------------------
  *
- * All request packets have the same length (32 octets)
+ * All request packets have the same length (64 octets)
  * All request packets have common header:
  *         0                1                 2               3        octet
  * +----------------+----------------+----------------+----------------+
@@ -570,7 +570,7 @@
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 32
+ * |                             reserved                              | 64
  * +----------------+----------------+----------------+----------------+
  *
  * pcm_rate - uint32_t, stream data rate, Hz
@@ -639,7 +639,7 @@ struct xensnd_page_directory {
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 32
+ * |                             reserved                              | 64
  * +----------------+----------------+----------------+----------------+
  *
  * Request read/write - used for read (for capture) or write (for playback):
@@ -657,7 +657,7 @@ struct xensnd_page_directory {
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 32
+ * |                             reserved                              | 64
  * +----------------+----------------+----------------+----------------+
  *
  * operation - XENSND_OP_READ for read or XENSND_OP_WRITE for write
@@ -684,7 +684,7 @@ struct xensnd_rw_req {
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 32
+ * |                             reserved                              | 64
  * +----------------+----------------+----------------+----------------+
  *
  * operation - XENSND_OP_SET_VOLUME for volume set
@@ -726,7 +726,7 @@ struct xensnd_rw_req {
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 32
+ * |                             reserved                              | 64
  * +----------------+----------------+----------------+----------------+
  *
  * operation - XENSND_OP_MUTE for mute or XENSND_OP_UNMUTE for unmute
@@ -759,7 +759,7 @@ struct xensnd_rw_req {
 /*
  *---------------------------------- Responses --------------------------------
  *
- * All response packets have the same length (32 octets)
+ * All response packets have the same length (64 octets)
  *
  * Response for all requests:
  *         0                1                 2               3        octet
@@ -772,7 +772,7 @@ struct xensnd_rw_req {
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 32
+ * |                             reserved                              | 64
  * +----------------+----------------+----------------+----------------+
  *
  * id - uint16_t, copied from the request
@@ -787,7 +787,7 @@ struct xensnd_req {
 	union {
 		struct xensnd_open_req open;
 		struct xensnd_rw_req rw;
-		uint8_t reserved[24];
+		uint8_t reserved[56];
 	} op;
 };
 
@@ -796,7 +796,7 @@ struct xensnd_resp {
 	uint8_t operation;
 	uint8_t reserved;
 	int32_t status;
-	uint8_t reserved1[24];
+	uint8_t reserved1[56];
 };
 
 DEFINE_RING_TYPES(xen_sndif, struct xensnd_req, struct xensnd_resp);
-- 
2.17.0
