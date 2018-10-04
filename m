Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29521C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E311821470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sfg36PRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E311821470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJDUbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:31:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41283 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeJDUbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:31:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so9959179wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pCj28CRvgyFj8nBDilPRp3NO1b4DMPxUjB+GMX86NpI=;
        b=sfg36PRWaCHzd0You3Y+GqU/0wJhwRsu9YH42H4hNlBBTTO1gRKn3TxV7nu/11Uxyj
         Uut3vIoR5hgNsiSsdPx6nxs81Lq4VbqQPUCoudu+1ucs2ibKOiQknSdZrUydoCuTP0gk
         KKHplM6RcSssSjlipt0M3xx/5tgAsKSV0zkMu1b8Ci6qGqVUJ9gaFBu6bDygyJDPl5G8
         TicSAkb9L7xh3896lCoKP74aQ4lbB9WuwWXGfUAU1chKHWWaru8KdinVT6isqC7/IpRP
         1eul1lCjiKy2HiJU1GhfA3/Ou1ZcHe2AJLE93MICx5wC9hqJp6mKeOLYLFqHlRquOkEb
         YKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pCj28CRvgyFj8nBDilPRp3NO1b4DMPxUjB+GMX86NpI=;
        b=BjeACf9dVUA3/je4gUXPmLjTsE+qjxIYm3pMej3IZWl8OiOBEOivYs4oX0DD2ronjj
         0miBaoCWAqGdGMgvXpI/UHPL0LQ5p8raS43XLKiuGM6HOG9ukJwsVnYdI5YMnrD1MsUT
         3WrfKzCdZsviJibf1178qzemwi+UNiiVG4JojxJ/qcWCQwUYhCeISLQ7soi7bFeBhV7U
         YjdN2DJ5mzH5p5jOoUwv0MWaDiG2unZB4wAoPAYrugZg8ByJQnOh2mmRnxexKUb3l9qn
         7g9MnTgKqxIaRLf8dVlIuUGBgHAVhBQttd9z1vmvQvso+SKe5bjyyjQVvsT2y37U+uDQ
         dKCw==
X-Gm-Message-State: ABuFfohgteLhpP/XOelCB8KMNK5jYBxUnVQaqt62D+6419PEg9Jgq0xP
        3ls2BHTZUc/WxA161JdF/zVRHQ==
X-Google-Smtp-Source: ACcGV61NR26y72m0mxZdgF6ePGGFrceDmn146dzKhXpNWRaaJEB8K9vMaweqtNEUCOGaEaP3IpJR0w==
X-Received: by 2002:a5d:61ca:: with SMTP id q10-v6mr4317720wrv.33.1538660294224;
        Thu, 04 Oct 2018 06:38:14 -0700 (PDT)
Received: from localhost.localdomain (ip-123.net-89-3-157.rev.numericable.fr. [89.3.157.123])
        by smtp.gmail.com with ESMTPSA id g10-v6sm3165483wrv.49.2018.10.04.06.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 06:38:13 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: videodev2: add V4L2_FMT_FLAG_NO_SOURCE_CHANGE
Date:   Thu,  4 Oct 2018 15:37:39 +0200
Message-Id: <20181004133739.19086-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a v4l2 driver exposes V4L2_EVENT_SOURCE_CHANGE, some (usually
OUTPUT) formats may not be able to trigger this event.

Add a enum_fmt format flag to tag those specific formats.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 Documentation/media/uapi/v4l/vidioc-enum-fmt.rst | 5 +++++
 include/uapi/linux/videodev2.h                   | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst b/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
index 019c513df217..e0040b36ac43 100644
--- a/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
+++ b/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
@@ -116,6 +116,11 @@ one until ``EINVAL`` is returned.
       - This format is not native to the device but emulated through
 	software (usually libv4l2), where possible try to use a native
 	format instead for better performance.
+    * - ``V4L2_FMT_FLAG_NO_SOURCE_CHANGE``
+      - 0x0004
+      - The event ``V4L2_EVENT_SOURCE_CHANGE`` is not supported
+	for this format.
+
 
 
 Return Value
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3a65951ca51e..a28acee1cb52 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -723,8 +723,9 @@ struct v4l2_fmtdesc {
 	__u32		    reserved[4];
 };
 
-#define V4L2_FMT_FLAG_COMPRESSED 0x0001
-#define V4L2_FMT_FLAG_EMULATED   0x0002
+#define V4L2_FMT_FLAG_COMPRESSED	0x0001
+#define V4L2_FMT_FLAG_EMULATED		0x0002
+#define V4L2_FMT_FLAG_NO_SOURCE_CHANGE	0x0004
 
 	/* Frame Size and frame rate enumeration */
 /*
-- 
2.19.0

