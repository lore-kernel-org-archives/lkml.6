Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32739C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4E2208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="VJ3okr6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4E2208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJBAkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:40:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35411 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeJBAkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:40:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so9809329pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=COOftGCHS9Nvs+MaqTej8LtTQeX/KosYEseJ+G3aMxk=;
        b=VJ3okr6xDxbdqaWXg0DnrCXLtCHEZeyVEc6y4NyoyhlqO5G9hRR0ZVoJ5umlmnXrMd
         BOVgud2mB+BgRgOJlkND20wwgR9A7kZxDClmbz2CYUv6ANrdlBAoWU+IQgrB3gpJ/Ruw
         1WnrBzGru8Hn2gVQbmjKNLDl75ALypKeeIFgj32TiAY77ksbIn68jwlShldUI4aokWu2
         Y/GyeRlaeGfF2eF4CMerlB1ORPnxS/r+GjrnmZIKuv/VqUWyZKMv0HFEdXvyZoPLzg7q
         Y/YzdQMk7lniSKThGxKOhs66u4c9jWweidRMLHE2IqnFGZMJqVZAYSC3MAexe7aVsFvv
         Cr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COOftGCHS9Nvs+MaqTej8LtTQeX/KosYEseJ+G3aMxk=;
        b=lmWyCrZWt1pIyrvrUf/vxBTXqm9voZzsisbmPB6CBa7djhEcvUlgnp0GhpqrMaKBxv
         pxJ1YGMi1V1TpSfaMkhRGC70zKXl3iXMC+4Ydy9ohEGT34EPmh0+ggrfVeCE4S3ZZwQT
         S2QNBKQGe07nwYIWe1Ee5+yVBudhWu6l7U9R8udqKM3G32B1+Nvl160BEFJmX1H4gviT
         u/3X33F2qZzhMFCLX+7Wyze50YbYWTH25WSI6uLwtgvruuVY8WaUtVKQhg+HKrBmTbbC
         xVvzCN9eHacEYoPKLL7A16AE7hS4uBxnW1sHDnjEy+RQXeFoDRV2vsWIxfnpaFiEDjUj
         hc/Q==
X-Gm-Message-State: ABuFfojWm3RYYOPQ4drRhuu+GEkqwOSnxnE6tIMGb0ND2IjsCORvV/J3
        C9aWFuj8SvsI7d0Iq6w/kY0EDrei4ZA=
X-Google-Smtp-Source: ACcGV62ItB8b5E04dZz0KZrIsV786uyK4nI8Tf8ReNaEq9mA9JbIa80YsG0FYTHh+BCfIzMVwyDJFA==
X-Received: by 2002:a63:9612:: with SMTP id c18-v6mr10979192pge.21.1538416878491;
        Mon, 01 Oct 2018 11:01:18 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:01:18 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salyzyn <salyzyn@android.com>,
        James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        android-kernel@android.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RESEND [PATCH v5 07/12] arm: vdso: disable profiling
Date:   Mon,  1 Oct 2018 10:58:27 -0700
Message-Id: <20181001175845.168430-8-salyzyn@android.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take an effort to recode the arm64 vdso code from assembler to C
previously submitted by Andrew Pinski <apinski@cavium.com>, rework
it for use in both arm and arm64, overlapping any optimizations
for each architecture. But instead of landing it in arm64, land the
result into lib/vdso and unify both implementations to simplify
future maintenance.

Make sure kasan and ubsan profiling, and kcov instrumentation,
is turned off for VDSO code.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Tested-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: android-kernel@android.com

v2:
- Added this to the split up of first CL, based on comments in second CL

v4:
- update commit message to reflect overall reasoning

v5:
- rebase
---
 arch/arm/vdso/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index f4efff9d3afb..1125e3fb8006 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -27,8 +27,11 @@ CFLAGS_REMOVE_vdso.o = -pg
 CFLAGS_REMOVE_vgettimeofday.o = -pg -Os
 CFLAGS_vgettimeofday.o = -O2
 
-# Disable gcov profiling for VDSO code
+# Disable gcov, kasan, ubsan and kcov profiling for VDSO code
 GCOV_PROFILE := n
+KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT := n
-- 
2.19.0.605.g01d371f741-goog

