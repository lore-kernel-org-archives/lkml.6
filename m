Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DF1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBA0208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOYCKUmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBA0208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbeIXXjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:39:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51843 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733173AbeIXXjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:39:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id y25-v6so3178968wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=50ttWf6TNwpzVefVWfGj3hW2UTb502fx5iA4gscVRFM=;
        b=tOYCKUmM9tyTcRIMs8rGniPBuew/+E2H1wuaxcoRr/dwiVP8KVVvSzbJwPf/Kmia+T
         W2DFNNWKgwHOm7eeNBS/3Oa7kTRq4ygdC8TPzuTG+CCGpQrUsDC0EBJZKINg/iFEy472
         cUsIcEf7OUdtyJWi1hr/ALUsnbBtuPe4H42WoEUhiu8i6dIZ9iocSN0jRqAVQUQnCZDL
         Isx/Iy1Y1xJGFHpHWmRRKoQMzpLG9TBqZV59aM8FLZsYGJ+w6vM+URiVUQyF9845a2mJ
         nBG332VMqztvICdki5A9pcT3zrMxJpbNQpZnE5am0azInsd775LtrXQYPXg0rEEbuJbI
         kaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=50ttWf6TNwpzVefVWfGj3hW2UTb502fx5iA4gscVRFM=;
        b=cnHAp23tshmUYTgdVvC/PwrxMMkm2l8Su4db3GZqmfIGqQCdD6rRP6TQyb+1UlsG2R
         Q4sJd/wfawhs+1gmZUyLv9+i6egDc6R1tv77DJkj7uRskOLvrQBuE7F9uL8zJ4PnQHNf
         LJg53eoPJ4R9YYASUrDlpFgdRMUPHPzIqYQt2DNlJUYiW1ulponxVhQHiUdBSC3jMcGM
         qbbwdAMkZX6u59XETZydGckcVH9LzdcM6IH9HBh279+x7G3ye7R6VE49EmGxdQ8AfN0R
         Zfcp+HauTzR48TwiLUDRBNk91EBXijdcTG8WX7BCr6odxFJTcuv/cLC+a5W/RBN0Gzxn
         s9rg==
X-Gm-Message-State: APzg51AfoIvhzpxD75MjgKi6G3mzfwOBhWgrw1oFdsOJLI7/1i8jOdZM
        OAt3zJNBQ3xfDmE0qpyeQLY=
X-Google-Smtp-Source: ANB0VdZaenrVYysUUkBecPRioNgD6FyVD3VAdecOzEjjY2tif3AcB5T5ptEnCyBjF9nhL5xAT+LlsA==
X-Received: by 2002:a1c:1609:: with SMTP id 9-v6mr8630302wmw.12.1537810567281;
        Mon, 24 Sep 2018 10:36:07 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id k34-v6sm52138834wre.18.2018.09.24.10.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:36:06 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] staging: vc04_services: Remove unused macros
Date:   Mon, 24 Sep 2018 18:35:46 +0100
Message-Id: <20180924173547.23393-4-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924173547.23393-1-qader.aymen@gmail.com>
References: <20180924173547.23393-1-qader.aymen@gmail.com>
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

