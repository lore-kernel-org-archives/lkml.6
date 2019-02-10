Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB620C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 13:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA1121A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 13:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="HeWKcGOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfBJNGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 08:06:39 -0500
Received: from tomli.me ([153.92.126.73]:56248 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfBJNGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 08:06:39 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 606e43c9;
        Sun, 10 Feb 2019 13:06:36 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:7b76:76e8)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sun, 10 Feb 2019 13:06:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=/JYXTtWtfEbCfkwuRyyx+yLPD29cYbuI1bGzDpentNg=; b=HeWKcGORjr2aQtt/Co/o6wa+h83EUc+SPd5HDzqBZdcDj9sveFT4Jl9vzKAJSVhKyjw08jHYwqlvtGBAcHaYKGLaS27N+ljqvwp3O8IJodaDhyJtoaXyQt8XATlEdNlWuEYhdLPxskIFmZPHU15yju1XN1PZ+SZGWgiqziF4Ltd+DBe+K70xNuV9swD81QULhVJ3KEnT6hxK6T/CHSeOiDXRFgbFJoVhJBLMsRop+e7bjUZ5YvC8GaGdZ3uWNoamQjdpZ+RPW0VxH0F98RfFxKPSriBIz9PX2EDc63DJKeuNvLAHK37TKe/vVrsJQASy+gB0gaDdQ1hFWykCFIF/YA==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, Yifeng Li <tomli@tomli.me>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mips: loongson64: move EC header to include/asm/mach-loongson64
Date:   Sun, 10 Feb 2019 21:06:17 +0800
Message-Id: <20190210130617.8392-2-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210130617.8392-1-tomli@tomli.me>
References: <20190210130617.8392-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to operate the Embedded Controller from multiple platform
drivers, it should be possible to include lemote-2f/ec_kb3310b.h
from everywhere. This commits move it from lemote-2f/ec_kb3310b.h
to include/asm/mach-loongson64/.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 .../lemote-2f => include/asm/mach-loongson64}/ec_kb3310b.h      | 0
 arch/mips/loongson64/lemote-2f/ec_kb3310b.c                     | 2 +-
 arch/mips/loongson64/lemote-2f/reset.c                          | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/mips/{loongson64/lemote-2f => include/asm/mach-loongson64}/ec_kb3310b.h (100%)

diff --git a/arch/mips/loongson64/lemote-2f/ec_kb3310b.h b/arch/mips/include/asm/mach-loongson64/ec_kb3310b.h
similarity index 100%
rename from arch/mips/loongson64/lemote-2f/ec_kb3310b.h
rename to arch/mips/include/asm/mach-loongson64/ec_kb3310b.h
diff --git a/arch/mips/loongson64/lemote-2f/ec_kb3310b.c b/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
index 321822997e76..6e416d55b42a 100644
--- a/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
+++ b/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
@@ -15,7 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/delay.h>
 
-#include "ec_kb3310b.h"
+#include <ec_kb3310b.h>
 
 static DEFINE_SPINLOCK(index_access_lock);
 static DEFINE_SPINLOCK(port_access_lock);
diff --git a/arch/mips/loongson64/lemote-2f/reset.c b/arch/mips/loongson64/lemote-2f/reset.c
index a26ca7fcd7e0..6c615c7b08d0 100644
--- a/arch/mips/loongson64/lemote-2f/reset.c
+++ b/arch/mips/loongson64/lemote-2f/reset.c
@@ -20,7 +20,7 @@
 #include <loongson.h>
 
 #include <cs5536/cs5536.h>
-#include "ec_kb3310b.h"
+#include <ec_kb3310b.h>
 
 static void reset_cpu(void)
 {
-- 
2.20.1

