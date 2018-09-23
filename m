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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F00ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A81214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er4HRPei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A81214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeIWUEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 16:04:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37609 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeIWUEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 16:04:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so17107192wrr.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7MBXQB9/hc9z8x7hC5JAvQtfexktjhUxajumS2QHCmI=;
        b=er4HRPeiVgQTY8kBMmz6Ak2BYuXeRPMR5Cvr/pTN5LY7tMCEZuI3R+jKuUUTD4cG7X
         zFrfxddiIiaRJBsQQ7H1mNFTqK1vl5ztdp8pPeKQB85N6P8l4K74PXMKka/L7oMIgPpO
         3EHSTfN9S1mHLUYkoQmw9UNVOtxIltPI1pid/n5z5m7GkCS4x3eIVWZfdSfkept+piv8
         b6za2B7+CmohEIF7fhGghDE65mtlZEfxo1SA8KL4dP9BtgED/sOvx2tUoMu7U+3ltHuC
         yTWmI7bKzfEwsSUtC0Y+CXuCJyq9VokWPYg7vUiRTtLqIxMHMKsUqb9SaXvJqGzthSU4
         KITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7MBXQB9/hc9z8x7hC5JAvQtfexktjhUxajumS2QHCmI=;
        b=XLtOM/SgEcLeAonhn77Ir83e1A5M43lh78m3pn3WEQp7VvG8KFDluYPr7BCNYYcxbc
         sIy8eWFKNzM65pGZS7hR7kstK3Ec2cFnAk4AkivHg6JVnZGVeHY70NLWlF3QNhq8SvKa
         B95PZFRpaJ1pxJygSjcFD9V7oImqUauqFvAWQpmFV/+u1Zd3Z3x2N6PLiJ6tNK00B6/F
         ORXbV4T6yLowWmdTgMyp0Dnm61eFkJKLqnt/gY5380IXSEWvwCzuKV6+HMf5LEv24LfF
         2UEuRRHDU5NKwEf+8yw0SSGw/+RWnfh5/f4GeXdH5PEwuE2NnMDjEEPbB25247dFiGB8
         uVAQ==
X-Gm-Message-State: ABuFfoh79W6o4zIj3LREIWmcb/jfR6SLmZ+ofhx/DD1rEZcQIAmhdc45
        Ab9QbgdQpqylw6led4XUOfk=
X-Google-Smtp-Source: ACcGV630OND4t/XsFCpNlmxvP+9Vtf1P4XL10FQL7nzPKu2WZy+0Z7Ww8+a31KznXzJn2TWTyEbJQA==
X-Received: by 2002:adf:f94e:: with SMTP id q14-v6mr5386553wrr.151.1537711604310;
        Sun, 23 Sep 2018 07:06:44 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:8])
        by smtp.gmail.com with ESMTPSA id j66-v6sm47477498wrj.28.2018.09.23.07.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 07:06:43 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] staging: vc04_services: Add spaces after commas
Date:   Sun, 23 Sep 2018 15:06:18 +0100
Message-Id: <20180923140620.14583-4-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180923140620.14583-1-qader.aymen@gmail.com>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
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

