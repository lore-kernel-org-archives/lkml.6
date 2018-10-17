Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA64C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E51214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fch5ZbLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E51214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeJQHxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:53:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43715 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeJQHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:53:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id p24-v6so12230360pff.10;
        Tue, 16 Oct 2018 17:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2w39VPGeACVECakpqzPDeuelU4Bi3JR8Jg1vqW985jw=;
        b=fch5ZbLDtkRdqeCuC6PK0FaH/6+3muOuSRQ0SAYOZD6DHjRqq/nAlDE1t97Q6V1Cwx
         EdliQ3GvyMQa5Gz3H/jBieLgENFC0XkXL1WI/hS0RrmOyMeO/vlrsSkzxx1W21Wuo9pS
         Irg+W6nQYDEg71J9aKbcPJpZnFzqwafE2SMOi2uxbzJfnlzhW5fURzyZh/QwiFvIr2x0
         WgQRj/gJ3JXN1tzx2DURCgh4vCOgdHLp/wXf6z8K7E0dMPt5wcHMwQRkEyg2xGz3egeS
         NI3kRglgmIkB8O4idDnw/IdOl28NFROCxq7m5aEt/E9XUDMKyri1UHGtS9XbYw9BJ/rU
         OclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2w39VPGeACVECakpqzPDeuelU4Bi3JR8Jg1vqW985jw=;
        b=ue2F/oDx6oUfv/R3PXXCHjquUH8eshjA/D8+8PN9EQ1VPTcFbsjmVVOsaFlazis1Bg
         5T+kno314r6e8g/VmDNpWbsntt4Jt4ft592J6eLDTaP97JNTJ96OjKuLM5aJY3ivTRNA
         /s1H8QPaasiKQtck4YCjUbrTxiGIvxkvpHdqn4WYSMVTR2YGBOB/xb5+OX5cZO5sUNnV
         6vuJyOvZ4Sug7rj81l5iUIJBfR5OPPrt6gUtiDNfGLVnpg/G4TIgp5NPsydToLUTydlq
         vBd9F37mfsbTuMSg9UfOQINxyiUxnkt6PYvpGSn6zY2GKzyd2QVy5ULFnr/eFvgsnSVP
         1/UA==
X-Gm-Message-State: ABuFfojTJ6Rj9ClADq9Et+9RW1TCoATBwQVvVelN8k70YCzrdXtUvAJL
        LwMuGvMZ+sjif3yhWIB0KyYsmlh8
X-Google-Smtp-Source: ACcGV63MxODiuLg+UXUunUCWi0wBI9D2Gckah0ba2SyB1SLsXTsCFrC3gdMgDfUHAxcV7gBJe0Fl2g==
X-Received: by 2002:a62:f553:: with SMTP id n80-v6mr24097025pfh.59.1539734437830;
        Tue, 16 Oct 2018 17:00:37 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id o12-v6sm17033117pgv.7.2018.10.16.17.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 17:00:36 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 01/12] media: videodev2.h: Add more field helper macros
Date:   Tue, 16 Oct 2018 17:00:16 -0700
Message-Id: <20181017000027.23696-2-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017000027.23696-1-slongerbeam@gmail.com>
References: <20181017000027.23696-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds two helper macros:

V4L2_FIELD_IS_SEQUENTIAL: returns true if the given field type is
'sequential', that is a full frame is transmitted, or exists in
memory, as all top field lines followed by all bottom field lines,
or vice-versa.

V4L2_FIELD_IS_INTERLACED: returns true if the given field type is
'interlaced', that is a full frame is transmitted, or exists in
memory, as top field lines interlaced with bottom field lines.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes since v3:
- none
Changes since v2:
- none
Changes since v1:
- add the complement macro V4L2_FIELD_IS_INTERLACED
- remove V4L2_FIELD_ALTERNATE from V4L2_FIELD_IS_SEQUENTIAL macro.
- moved new macros past end of existing V4L2_FIELD_HAS_* macros.
---
 include/uapi/linux/videodev2.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 29729d580452..f7f031736d91 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -130,6 +130,13 @@ enum v4l2_field {
 	((field) == V4L2_FIELD_BOTTOM ||\
 	 (field) == V4L2_FIELD_TOP ||\
 	 (field) == V4L2_FIELD_ALTERNATE)
+#define V4L2_FIELD_IS_INTERLACED(field) \
+	((field) == V4L2_FIELD_INTERLACED ||\
+	 (field) == V4L2_FIELD_INTERLACED_TB ||\
+	 (field) == V4L2_FIELD_INTERLACED_BT)
+#define V4L2_FIELD_IS_SEQUENTIAL(field) \
+	((field) == V4L2_FIELD_SEQ_TB ||\
+	 (field) == V4L2_FIELD_SEQ_BT)
 
 enum v4l2_buf_type {
 	V4L2_BUF_TYPE_VIDEO_CAPTURE        = 1,
-- 
2.17.1

