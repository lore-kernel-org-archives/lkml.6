Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D929ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212F4214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPDOESqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212F4214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbeIWTG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:06:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39010 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeIWTGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:06:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id s14-v6so17025511wrw.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=woFvUYwj8BBUHcUvpHe/b1ZVibxeWyq3E5LYghki1Tw=;
        b=RPDOESqLgb2Iyo+FBKpDUsOdW3ld7QrXeR0Y4OP0bKpOuQlFciAKRc77LkzUoxblZS
         wHiEXOdMjDg4DEwfdrmtQci7sumbopf+OjchwT8pPfP0oyMVqRRFkSdajDeb088HyvZe
         Cupqbznb42xkWla68qcxOTgG2payY7qOWh/StotgECkBKumHEgfEiUZKR4+lr6gWPFwl
         2YEiFw3Nf1+q5g3qfX6k6Xlx5UEio5ImKDh5Ua1q5qEcWFhp0fxFpZZmlDmPoYDBoVUo
         4uNXJJKjDggR51rXGOcZ90Z/c+koiXR2rMvkBSNprDcX3DPqbPfAppNKNKOgDwTgHg73
         vbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=woFvUYwj8BBUHcUvpHe/b1ZVibxeWyq3E5LYghki1Tw=;
        b=M0Pe0BbvqpYlWnxP4wRprMYqbCtgsAnHqQWmDoLF44tHzLMbAg9yX1T+kaR1k7MGvN
         jDuH9DWHIfclKiarQ1yao0dn10REYfkTnff5Uc7hZfe9aftSN7yODHm5VRE3cR+goz5b
         iTvXvwR+Ft1movo0KpQTJTrRJrQ2ZXoIOlBt7NoXER43BYYy2nykAjzG1zBsQiilM3qM
         M/sN1ez1MIQ52DIUNvg3RbCOp5RI3xas95716dMM73ZFKpmP6xRkNSL0z3x2FKljZ5/2
         pBzNZMi3vzGmKQyuJbKtBnD0MJxgw37OU/hn2yW7EXvelGQvNpGyjTyPMEOggA9KHBoz
         AF+Q==
X-Gm-Message-State: ABuFfogHvDwL1+KJn7zFCgNC72RGnxrMT1TBs5g6B/635d7QCV1ms9Rb
        x3pUJtPCDu1W4NPldRzzU74=
X-Google-Smtp-Source: ACcGV601PpjmFrCHbmpaA+tJsl7P9oMd626fZO1Yqz+aRxdqiWWOAMpOHKTyLQ66mizXjSDokF5leg==
X-Received: by 2002:adf:9101:: with SMTP id j1-v6mr4864865wrj.3.1537708167632;
        Sun, 23 Sep 2018 06:09:27 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:8])
        by smtp.gmail.com with ESMTPSA id 75-v6sm19115718wml.21.2018.09.23.06.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 06:09:27 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: vc04_services: Surround complex macros
Date:   Sun, 23 Sep 2018 14:07:30 +0100
Message-Id: <20180923130733.4128-4-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180923130733.4128-1-qader.aymen@gmail.com>
References: <20180923130733.4128-1-qader.aymen@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

ERROR: Macros with complex values should be enclosed in parentheses

in the interface/vchi directory

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/vc04_services/interface/vchi/vchi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index d8e660240a44..f818cf2e27e1 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -92,14 +92,14 @@ typedef struct vchi_msg_vector_ex {
 } VCHI_MSG_VECTOR_EX_T;
 
 // Construct an entry in a msg vector for a pointer (p) of length (l)
-#define VCHI_VEC_POINTER(p, l)  VCHI_VEC_POINTER, { { (VCHI_MEM_HANDLE_T)(p), (l) } }
+#define VCHI_VEC_POINTER(p, l)  (VCHI_VEC_POINTER, { { (VCHI_MEM_HANDLE_T)(p), (l) } })
 
 // Construct an entry in a msg vector for a message handle (h), starting at offset (o) of length (l)
-#define VCHI_VEC_HANDLE(h, o, l) VCHI_VEC_HANDLE,  { { (h), (o), (l) } }
+#define VCHI_VEC_HANDLE(h, o, l) (VCHI_VEC_HANDLE,  { { (h), (o), (l) } })
 
 // Macros to manipulate 'FOURCC' values
 #define MAKE_FOURCC(x) ((int32_t)((x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3]))
-#define FOURCC_TO_CHAR(x) (x >> 24) & 0xFF, (x >> 16) & 0xFF, (x >> 8) & 0xFF, x & 0xFF
+#define FOURCC_TO_CHAR(x) ((x >> 24) & 0xFF, (x >> 16) & 0xFF, (x >> 8) & 0xFF, x & 0xFF)
 
 // Opaque service information
 struct opaque_vchi_service_t;
-- 
2.17.1

