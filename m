Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F93C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3418220645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Gw8hVVii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfAOQwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:52:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40085 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387622AbfAOQov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:51 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so3053233oth.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 08:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=EpIzBv2JuwiOd+A0KNJW+FqkTH+uuE+Wcdu2A4E7Ku0=;
        b=Gw8hVViiN68Y7xAR86tXDrISMG/bOjOnhZRG8kgYbaN2uhrhuWCprB30UZaekIcD9D
         Ejrq6tOOREeMpW7Brq7OnMq+abi5SsjdEajhVTKtJ7n0OOU3Keiy01oPcNKKXfOqL/Ag
         iabOKKtndFxRX0to/1FJZiclhEZwsGENzSxor14golKdlWPCkOJiZSaZYK7EWVv/t1ph
         JceUGwRwdECmbUfYWEk7pIim6rRgRJUAps8ojYKAebZhRtMP7AFMVVyAHO3AB7ZMy4rJ
         10mGPWtuKuFTLrJDzkr8TCH1wBjh/7Sv6IpLiqHVQtqY2hkEQi6C/qS1KGIAF0pJHQWb
         XJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EpIzBv2JuwiOd+A0KNJW+FqkTH+uuE+Wcdu2A4E7Ku0=;
        b=ksgd9a/6RgiskQv+jiiAyeum4U+Ve4vOMxeN2+K8jTocYamf/BcryZueHfQbOPaOw2
         1sAsh50w35yGfmkObsHgVnfkBVsAPf4KErsS/HXQNXueRQU4d0hyfJCduMbrlv+T0inQ
         8lvJkEeIQBvET6nck/RJJ9AeJJTZzD9YgyaLewPF7M80TbyXjAYgtkAiFZ3+yhEBCeh9
         Z0S8ntPY26ueeiha9p7XsUpZLUaLEw6LKIUR1vLEf5K8oAJHCWTWbv8Y/R2fvuOFE37/
         dmcW6lrHNPJtUgacYd+rgPjzjWIkf0op0ymy9AuZOSK//UFKjyPN7tlYHX9LI7z0m+hP
         41jQ==
X-Gm-Message-State: AJcUukfOTKSdMV2S2/QvSEE0VvidkH2KAIc2g3siy1a/0Zu1jzBP2f57
        U35uNLtTeme22vEPiNtXXC0YoA==
X-Google-Smtp-Source: ALg8bN6ePYYtCm7gM1GaBwvyZhItb5TXdEKJWB/wiA5F0owuWr8SwmgI4ZCeQT5DCjqUD9X/b9Msow==
X-Received: by 2002:a9d:3784:: with SMTP id x4mr2676681otb.89.1547570690600;
        Tue, 15 Jan 2019 08:44:50 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id w4sm1462314otm.46.2019.01.15.08.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 08:44:48 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Olof Johansson <olof@lixom.net>
Subject: [PATCH] mm: Make CONFIG_FRAME_VECTOR a visible option
Date:   Tue, 15 Jan 2019 08:44:35 -0800
Message-Id: <20190115164435.8423-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_FRAME_VECTOR was made an option to avoid including the bloat on
platforms that try to keep footprint down, which makes sense.

The problem with this is external modules that aren't built in-tree.
Since they don't have in-tree Kconfig, whether they can be loaded now
depends on whether your kernel config enabled some completely unrelated
driver that happened to select it. That's a weird and unpredictable
situation, and makes for some awkward requirements for the standalone
modules.

For these reasons, give someone the option to manually enable this when
configuring the kernel.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 mm/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 25c71eb8a7dbd..0d80d06d3715b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -731,7 +731,10 @@ config DEVICE_PUBLIC
 	  the CPU
 
 config FRAME_VECTOR
-	bool
+	bool "Frame vector helper functions"
+	help
+	  Provide some helper functions for frame vectors, to be used
+	  by drivers who operate on userspace memory for DMA.
 
 config ARCH_USES_HIGH_VMA_FLAGS
 	bool
-- 
2.11.0

