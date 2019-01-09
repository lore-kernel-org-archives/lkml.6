Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2A6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3AD206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M95BgvT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfAICLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:11:20 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:40424 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfAICLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:11:20 -0500
Received: by mail-yw1-f73.google.com with SMTP id l69so3088995ywb.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 18:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GcqFANp5ckWbuLhMV9VNr16vsUEUgPzpUCm1otVzg7I=;
        b=M95BgvT2+AfdA9XZAzG1GwDJ8YaCFVyEs4x+GSMxd0Iy6iAbzZIXLk83glEVERstcj
         tjG7lBKsiaECdBIBpUsF+sPlMmOdQ2ofr9mwiNVqYALiqoCaTcbxuyZ6yiEOe/A2afs8
         0uoDy1iViIhAdzmja+B4dsxo0Zzp7UH/pyB+WV7ByIWDtCuqTc2x4uxNsicO7Yx//K0X
         d2/44KPgLtp8lsXV3n0dSVpkYTidSscdiUYjx37r/4emuzhZQPFukuIuUURL+Av2ZtFG
         atpn8xCVA3gKsEdZkXdKc3zripNcJOMhaVByrArlcXHQZfSubwhI8ZAMACiOAOA5VX2N
         ECGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GcqFANp5ckWbuLhMV9VNr16vsUEUgPzpUCm1otVzg7I=;
        b=kpv5pjk9MuZYxMm2/FpAHIc2/YMtxdQv/I5+d/TDApVI/wXhvZmPy69UFnr1QgfZAu
         1U0qeirG/P6/H+arrc9UN7ewNoeuUGIOQQnCEEYG45XIODDp8ToLJwwtAu4SpsEsyQ4N
         t8lV8lNejiJVWxm6MR8u1w/iYZ8Gr7UgiCI31FcT4SNzvGAeSVl9kF03vPrlBWiCoJOx
         AzMcgzD5cUglWij/BopUF2eRkyehoTXQoegDZM6cnY6XdH4LwRvn5iiSt/iXnG3S5clP
         UBM2Ma6tT9MqmetlH1zxXfWRm1FwpUto03l+7DBACYZkCEr87EH2Zow8xu6OAh7aAMdo
         4ZqQ==
X-Gm-Message-State: AJcUuke9qLJahHBCIM8bmJO56IynMASNvLNc50AOgL+4YQti6NQ05vR8
        v0pyYqAwsO4X80VSJ91zYLfqZLkK
X-Google-Smtp-Source: ALg8bN5C0kwJjcfW0K7hxXGS/T0xYSjm7xvnEfTji8lObo5gswQunA/alfsfLtxsL7/0qRpnr2qXARoJ
X-Received: by 2002:a81:7105:: with SMTP id m5mr2343485ywc.26.1546999879543;
 Tue, 08 Jan 2019 18:11:19 -0800 (PST)
Date:   Tue,  8 Jan 2019 18:11:10 -0800
Message-Id: <20190109021112.5836-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v3 1/3] drivers: platform: goldfish: fix the checkpatch
 complain in Kconfig
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

prefer 'help' over '---help---' for new help texts

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No changes.

Changes in v2:
 - New change, a minor cleanup.

 drivers/platform/goldfish/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/goldfish/Kconfig b/drivers/platform/goldfish/Kconfig
index 479031aa4f88..74fdfa68d1f2 100644
--- a/drivers/platform/goldfish/Kconfig
+++ b/drivers/platform/goldfish/Kconfig
@@ -2,7 +2,7 @@ menuconfig GOLDFISH
 	bool "Platform support for Goldfish virtual devices"
 	depends on X86_32 || X86_64 || ARM || ARM64 || MIPS
 	depends on HAS_IOMEM
-	---help---
+	help
 	  Say Y here to get to see options for the Goldfish virtual platform.
 	  This option alone does not add any kernel code.
 
@@ -12,7 +12,7 @@ if GOLDFISH
 
 config GOLDFISH_PIPE
 	tristate "Goldfish virtual device for QEMU pipes"
-	---help---
+	help
 	  This is a virtual device to drive the QEMU pipe interface used by
 	  the Goldfish Android Virtual Device.
 
-- 
2.20.1.97.g81188d93c3-goog

