Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730D3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4C7208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhhCQ9pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4C7208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbeIXXbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:31:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38525 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732196AbeIXXbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:31:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id j8-v6so16785540wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=50ttWf6TNwpzVefVWfGj3hW2UTb502fx5iA4gscVRFM=;
        b=KhhCQ9pjPhjMjpAinn/eJ2aS7k1cfbDRtCjPbhukcdj099twL4bpblw+PsQAmzE/Ur
         Jbv+aJU3gY3E2LAYLlVr5/rL8Mtf8j388X3LjIQ1uLMwM8yvd5pJHUlH9flxpn7VfIFR
         UxqPeP8qHYWHRsEEbDA2ve7mv6+O4v1pNEf6pm4cvo5nyG+74fQPN5jws6tw+Dfnfv6m
         kLAo9+8HJAxc7iKvhv/cCarrUU5LzezdZK7bDsU00knXDkk2QQRYezFNPUlpNveBh/W8
         x4wQF54w88faU39NkFwiVTOjqWAS9qYm8SBJafPRcTqz3zvK2/xeikpWOcK1HOpgah4v
         VIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=50ttWf6TNwpzVefVWfGj3hW2UTb502fx5iA4gscVRFM=;
        b=Ej+8lqvnJSUlgamuobVLu+UvS9ZKo1fSuwxhCiYat6DA9y35w2qhoHben5uHTYlioe
         ccE+T9mh3/nhsuLRjiSgeLGyE9qocK15p7rSDXoq4hj+8/X52JPJBbXv9hA2F8AokVCI
         cWYt82QWzdm3KF47x6xE8dlhm7dUrYL4s9XacqWChBlJxTPAgLRMB+nlWD6d6ZE/n9R9
         VGKrTa0Pta9Yk/6aeyWSCxkQ+VUaxJH+jVLx0nhGIiIToP3KjAp4e+9crVtqSKqjxM94
         wMGw7Y5f0q/3yPlzi0wA0X02rFYFicdJ3qHVfrW1pZWjQtM7JB991qPYL2Ucg9BeXqgs
         7TYQ==
X-Gm-Message-State: ABuFfojqsrILCyMjwIhkYbRuEhmxwW4i/wir77vzPgVnvPphln7REtUk
        Y7uQuOb5p8TIG2sCqPX4c44=
X-Google-Smtp-Source: ACcGV60pGlPcJod8YQaMeNdyzkBkUY+XOGI9MhYNuu5CQxxr+S3jvaqOz0A+Qz0Dy9BuieBslucgLA==
X-Received: by 2002:adf:c78e:: with SMTP id l14-v6mr9819261wrg.230.1537810110558;
        Mon, 24 Sep 2018 10:28:30 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id y206-v6sm15998258wmg.14.2018.09.24.10.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:28:29 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] staging: vc04_services: Remove unused macros
Date:   Mon, 24 Sep 2018 18:27:42 +0100
Message-Id: <20180924172743.21153-4-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924172743.21153-1-qader.aymen@gmail.com>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
 <20180924172743.21153-1-qader.aymen@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the macros and structs associated with the
"vchi_msg_queuev_ex" function, which was previously removed in 49bec49.
Also fixes the checkpatch.pl errors:

ERROR: Macros with complex values should be enclosed in parentheses
ERROR: space required after that ','

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 .../vc04_services/interface/vchi/vchi.h       | 38 -------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index cb2582a4eb6a..f96676227ddc 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -60,46 +60,8 @@ struct vchi_version {
 #define VCHI_VERSION(v_) { v_, v_ }
 #define VCHI_VERSION_EX(v_, m_) { v_, m_ }
 
-typedef enum {
-   VCHI_VEC_POINTER,
-   VCHI_VEC_HANDLE,
-   VCHI_VEC_LIST
-} VCHI_MSG_VECTOR_TYPE_T;
-
-typedef struct vchi_msg_vector_ex {
-
-   VCHI_MSG_VECTOR_TYPE_T type;
-   union {
-      // a memory handle
-	struct {
-		VCHI_MEM_HANDLE_T handle;
-		uint32_t offset;
-		int32_t vec_len;
-	} handle;
-
-      // an ordinary data pointer
-	struct {
-		const void *vec_base;
-		int32_t vec_len;
-      } ptr;
-
-      // a nested vector list
-	struct {
-		struct vchi_msg_vector_ex *vec;
-		uint32_t vec_len;
-	} list;
-   } u;
-} VCHI_MSG_VECTOR_EX_T;
-
-// Construct an entry in a msg vector for a pointer (p) of length (l)
-#define VCHI_VEC_POINTER(p,l)  VCHI_VEC_POINTER, { { (VCHI_MEM_HANDLE_T)(p), (l) } }
-
-// Construct an entry in a msg vector for a message handle (h), starting at offset (o) of length (l)
-#define VCHI_VEC_HANDLE(h,o,l) VCHI_VEC_HANDLE,  { { (h), (o), (l) } }
-
 // Macros to manipulate 'FOURCC' values
 #define MAKE_FOURCC(x) ((int32_t)((x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3]))
-#define FOURCC_TO_CHAR(x) (x >> 24) & 0xFF,(x >> 16) & 0xFF,(x >> 8) & 0xFF, x & 0xFF
 
 // Opaque service information
 struct opaque_vchi_service_t;
-- 
2.17.1

