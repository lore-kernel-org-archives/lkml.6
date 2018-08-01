Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1051C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F12E20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY0+rE9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F12E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbeHAU7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:59:51 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33521 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeHAU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:59:51 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so9231922plb.0;
        Wed, 01 Aug 2018 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1IHcQjmXg+tga/fo51JEr/xbngVdJl7z6YZpA4lt0Rc=;
        b=aY0+rE9UfFmwz03QFiUQUhF2Fmag4Gof4E6Bnor1FhF+/IdHUBM83h3+0x64Yahk7c
         gXfkAxkKNDPI1o+z4/5M3FNl4WLFjTQWgESAv3TdQmKD1++RzRGu5E2mhuWHYVrAGBkG
         YyTMZ6R+1MSxj/bnOW/aMcZBFyWCpRflFjUvQom/hu/RbPkZyNfLLR5lagc5x/j1pCki
         bPzxx9yjuUM7TNbU+uSDf8I+KhTlFBUW98XMnKVAWOIQolb/tnf1WNQr97+dpFNDEXFw
         E5NcfFINXfEPs1g9C9YlUkVurUG5nigRHJudxT6rKxt4Tb9MmBHt5S7+bj73ZVfbgiBp
         UdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1IHcQjmXg+tga/fo51JEr/xbngVdJl7z6YZpA4lt0Rc=;
        b=sZ3CAtIv4ac/FcL2QUTe41nHOL6e/U30C3zrR34ypvH6rKZ5JfUPxn8i9OL71izrsN
         etqfNjbGTlLESsqXqqriLK27hAOuxXFrxaecQIg96GELuT6s2HQpR4jPZ7a4spv9r45Y
         g7iYtKJDqIP6jEiKKJ+glkiVTMohAHYNLNcHmM+Uq86WNthZiuoY2wb/G/XA/zeoYjer
         ikA+C5rp7r3pSMVWFHQEb2mX2qbs4UUc95465JY4E6U+g0jMdl6zlnTvcEhZTm/CKcnu
         hS0Bv071insgPBfQFDC2RRPice0cnwxSNqoDNgbRV9iBDDWmin5izPT3fwu7xeayVk/c
         Mi8A==
X-Gm-Message-State: AOUpUlH0hdRlifX/EHlbV1X45vOp3plVCC5zTBnHjGkN5zCQx0zEJjX+
        vdNfs35YIGr4f+gx+k4GofJWvp/0
X-Google-Smtp-Source: AAOMgpdQrETeJ+pjEpj86RqY8HYw/Z2dQiREYTIpep6s1z9gl1Fe1vAhLt/1/ShR8eKEXOkKImFJCg==
X-Received: by 2002:a17:902:1121:: with SMTP id d30-v6mr26303365pla.247.1533150757269;
        Wed, 01 Aug 2018 12:12:37 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-24-5-209-231.hsd1.ca.comcast.net. [24.5.209.231])
        by smtp.googlemail.com with ESMTPSA id u42-v6sm31171336pgn.1.2018.08.01.12.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 12:12:36 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 01/14] media: videodev2.h: Add more field helper macros
Date:   Wed,  1 Aug 2018 12:12:14 -0700
Message-Id: <1533150747-30677-2-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
References: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
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

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
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
index d8b3309..d7007ba 100644
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
2.7.4

