Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A2FECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E436214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvkYirQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E436214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeIWTGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:06:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37186 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeIWTGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:06:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so17025783wrr.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7MBXQB9/hc9z8x7hC5JAvQtfexktjhUxajumS2QHCmI=;
        b=KvkYirQDaPfR1sH+3V53MOoH49udxukUpShRqMriltg16Po3qSl2/65Q8+WJVf+QQ+
         6KdqhxMs8IhiTtl21evC8x9COuwnlJcQUqYLbk1zJWKj/P3o9EvQy6xrNh1s/KmYSc9y
         kp8DoB/Azxt9FuarmlBNJgMWkYH/jnlhUMAK4gYlqHGvAJDZvJFBjhh1piu8vIKQQkBO
         cdVyrecNlmF5Ry5gYbkFE9rw9T422mVs6qB/7w/pB8UDlTRKje1K9fYWAGyMZ53vdnzS
         jRPbYpuI/jYDw84KsmDmkgknI9fKVXlkukeYr3qLmfRz0Fnzd5U7URp9xPNudycwBSvW
         vXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7MBXQB9/hc9z8x7hC5JAvQtfexktjhUxajumS2QHCmI=;
        b=b4wdqyHyTHeKV/iMNkhNVF72AkwClCSttMFm+LChmHAOMy4fnM0OB/dqYbF6FUcvsv
         hn4XhHlsW6GroOmEyNGSV7/BSsTfUm16Na6NtfvLOWzNLE0ze5QXjxWXu9EB8C7URvBH
         0TsZsvtN3oW5eobGSx9kp+L5icbQk9glKRzq/nHX1HapgLXZWnW6/qdHvKKzv6K/eoF4
         UJMRVFnDiHmgclQ2hadWYIyqIJSneIToa+Rph7jpOUSlzsOQrxPiD/kAmEIZD2EyJ6aZ
         3QMkjDv3WJE7MZNjKInRBFGTetHCFo9qQvV9D2s7sCEeO3sTE3CaG4+2XfjBKAcA4o8T
         YaKg==
X-Gm-Message-State: ABuFfoh6Eq/Yjne67zIDLvVj63A2zpuLs5shXlFztWvn9j3XFhPn7y0I
        3+f0UYsiVQmCRalPMVpbHog=
X-Google-Smtp-Source: ACcGV63GCZG5OIJnMp9qZXtJ5q/OcFpnv7ChZqGXKgu4kPRC8WcA1wf8MJgVJMkcTHtqjvaW0VTYcA==
X-Received: by 2002:adf:eaca:: with SMTP id o10-v6mr4507907wrn.98.1537708164106;
        Sun, 23 Sep 2018 06:09:24 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:8])
        by smtp.gmail.com with ESMTPSA id 75-v6sm19115718wml.21.2018.09.23.06.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 06:09:23 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: vc04_services: Add spaces after commas
Date:   Sun, 23 Sep 2018 14:07:29 +0100
Message-Id: <20180923130733.4128-3-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180923130733.4128-1-qader.aymen@gmail.com>
References: <20180923130733.4128-1-qader.aymen@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

ERROR: space required after that ','

in the interface/vchi directory

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/vc04_services/interface/vchi/vchi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index cb2582a4eb6a..d8e660240a44 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -92,14 +92,14 @@ typedef struct vchi_msg_vector_ex {
 } VCHI_MSG_VECTOR_EX_T;
 
 // Construct an entry in a msg vector for a pointer (p) of length (l)
-#define VCHI_VEC_POINTER(p,l)  VCHI_VEC_POINTER, { { (VCHI_MEM_HANDLE_T)(p), (l) } }
+#define VCHI_VEC_POINTER(p, l)  VCHI_VEC_POINTER, { { (VCHI_MEM_HANDLE_T)(p), (l) } }
 
 // Construct an entry in a msg vector for a message handle (h), starting at offset (o) of length (l)
-#define VCHI_VEC_HANDLE(h,o,l) VCHI_VEC_HANDLE,  { { (h), (o), (l) } }
+#define VCHI_VEC_HANDLE(h, o, l) VCHI_VEC_HANDLE,  { { (h), (o), (l) } }
 
 // Macros to manipulate 'FOURCC' values
 #define MAKE_FOURCC(x) ((int32_t)((x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3]))
-#define FOURCC_TO_CHAR(x) (x >> 24) & 0xFF,(x >> 16) & 0xFF,(x >> 8) & 0xFF, x & 0xFF
+#define FOURCC_TO_CHAR(x) (x >> 24) & 0xFF, (x >> 16) & 0xFF, (x >> 8) & 0xFF, x & 0xFF
 
 // Opaque service information
 struct opaque_vchi_service_t;
-- 
2.17.1

