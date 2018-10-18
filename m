Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBD8ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D7A21486
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2xFXCnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D7A21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeJSA2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:28:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41841 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJSA2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:28:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23-v6so14419657pgc.8;
        Thu, 18 Oct 2018 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0hktjCZJ2dqRy2QJwHBnkarA09c1smLgcR1htixFWS0=;
        b=T2xFXCnFJSDwACvOM4jAnuW9am2LBNodpOwLcwDVkznJNd7WWJWEYK2bC2eLBKAeJe
         s3k/FJ5J3l5+CpTSDi99CXmHkhW+qk8d9/6W7NKzzFxAHfAYKoqjnkYC0RVppVUotII6
         oBYzHu/0Dxp1Si24WLbBO4SX+qPBuaYW8VoI/9CBtQRnJFkE5eyiJB2iy5owmI6YSO/+
         9POds5Y6yhKHAPnDI1u8Uh1VewdB95Ng51L70wc+CaNzuG8I3jBlwGACpC+jQW814yW1
         8TXtvCHmKMjHk9vQR/xVAOzPKsTnoVGCae+vHevzYKNkHuTq4MYsFp6JBjZKWqU/fFIv
         6ZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0hktjCZJ2dqRy2QJwHBnkarA09c1smLgcR1htixFWS0=;
        b=Hgu9DFpoXKP523iwt/NUj2Wlayl9c/mL/xK+hmiPnPIyoKPqLSh558eIKf91u6PDcW
         YbC+y1QLs2cn92NLaxhY5WqVc/WPllB/L9ts7BHqbPKrAqjeBDMz9Zb7yLk32jPcl8iW
         GG0b5VojplvtrTQ5PQv3f/BnkoaYDkvCC87j2dA2HuI8JasS/YWwfNYXddulKtMskerN
         NiInf3FBSyZFVzU3AjcRX8ni6lfB8KmkmfInc+Of4XECUbQLFz84P/w8LoEoS5A6wjTo
         2Dgf7ivJ1JYZls/rM0QaOCoIc6Y33r1i1ZVqJIHPkL8DE22zI4FWwUBsX1mklHWTjOsG
         JnQg==
X-Gm-Message-State: ABuFfoh5XjFsmnAPrMrk8jWyePWTK/MDHZ2asOYbqnJ9A5FEpfqzY0Ui
        uq221GNId8vQ8Tk3WTQ0DXw=
X-Google-Smtp-Source: ACcGV62sgfwcwopmBgSgQjtntve/8dNwdOYl35Y4pL2fFgCLCaZRln+rZVS329JSlPL7lCRxGg4EHQ==
X-Received: by 2002:a63:5b14:: with SMTP id p20-v6mr28912816pgb.56.1539879978004;
        Thu, 18 Oct 2018 09:26:18 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id 5-v6sm27813420pgt.83.2018.10.18.09.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 09:26:17 -0700 (PDT)
From:   Du Changbin <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 2/4] kernel hacking: new config NO_AUTO_INLINE to disable compiler auto-inline optimizations
Date:   Thu, 18 Oct 2018 16:25:46 +0000
Message-Id: <20181018162548.6399-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018162548.6399-1-changbin.du@gmail.com>
References: <20181018162548.6399-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
this option will prevent the compiler from optimizing the kernel by
auto-inlining functions not marked with the inline keyword.

With this option, only functions explicitly marked with "inline" will
be inlined. This will allow the function tracer to trace more functions
because it only traces functions that the compiler has not inlined.

Signed-off-by: Changbin Du <changbin.du@intel.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Makefile          |  6 ++++++
 lib/Kconfig.debug | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Makefile b/Makefile
index e8b599b4dcde..757d6507cb5c 100644
--- a/Makefile
+++ b/Makefile
@@ -749,6 +749,12 @@ KBUILD_CFLAGS 	+= $(call cc-option, -femit-struct-debug-baseonly) \
 		   $(call cc-option,-fno-var-tracking)
 endif
 
+ifdef CONFIG_NO_AUTO_INLINE
+KBUILD_CFLAGS   += $(call cc-option, -fno-inline-functions) \
+		   $(call cc-option, -fno-inline-small-functions) \
+		   $(call cc-option, -fno-inline-functions-called-once)
+endif
+
 ifdef CONFIG_FUNCTION_TRACER
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
   # gcc 5 supports generating the mcount tables directly
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4966c4fbe7f7..0f9b4fa78b1c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -211,6 +211,31 @@ config GDB_SCRIPTS
 	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
 	  for further details.
 
+config NO_AUTO_INLINE
+	bool "Disable compiler auto-inline optimizations"
+	help
+	  This will prevent the compiler from optimizing the kernel by
+	  auto-inlining functions not marked with the inline keyword.
+	  With this option, only functions explicitly marked with
+	  "inline" will be inlined. This will allow the function tracer
+	  to trace more functions because it only traces functions that
+	  the compiler has not inlined.
+
+	  Enabling this function can help debugging a kernel if using
+	  the function tracer. But it can also change how the kernel
+	  works, because inlining functions may change the timing,
+	  which could make it difficult while debugging race conditions.
+
+	  If unsure, select N.
+
+config ENABLE_WARN_DEPRECATED
+	bool "Enable __deprecated logic"
+	default y
+	help
+	  Enable the __deprecated logic in the kernel build.
+	  Disable this to suppress the "warning: 'foo' is deprecated
+	  (declared at kernel/power/somefile.c:1234)" messages.
+
 config ENABLE_MUST_CHECK
 	bool "Enable __must_check logic"
 	default y
-- 
2.17.1

