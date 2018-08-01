Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9C1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D05208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehJTsJEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D05208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbeHATlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:41:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41049 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390496AbeHATlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:41:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so20991527wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LwwAJz4yw6CPYkDjTBk/oBVIKkUdZ2FP3WMkvbPtdtU=;
        b=ehJTsJEvsBi695exWU/VHLfmpOJXJMFkjqjcsfXoXwQjyYqM93O0EDuvFLe/qeg32B
         eW/iscdOHpJEfUj2qTbXLjz9sPD6TzihD50baeUVqOgL7Ctgo1twPQQtgKVXEIEcFmTt
         cAutV2ItpqLAjPIcY2XPHzmvDhDsSDDafYeaerBOurPoP6pZ2yrZga8LPpmgoUlcsd2M
         oWNMgEf7Ly+h6M0RxZuaJ6XDgt8C3FeqaZfFN2gb56/NwXPtCxfzJ75EZI3JFMwlUUjM
         VxFQkc4SGjrsvv2+1577WABKRQ3RZUTwUfTLjTZtrumIMqssPfymqn+uvF7QhJnTcmrg
         mLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LwwAJz4yw6CPYkDjTBk/oBVIKkUdZ2FP3WMkvbPtdtU=;
        b=ev4f0R/R9IQo9XxN8968fd/2rmHWe7I7MjtVVQRjslU7aMid4+yWwb6WkZRfG4oVa9
         J95Pcfu+2WlACFkY5BvRDF+/jhbQPbIYTimpcyyjINN3tXOSc8NZWCmzcAbLXLvApBls
         UpdpNasI83TGx98+yPjZfvsD3iryG3eC8I7mKz0YVyyMkstkItjCjNQLpVZd8R3gUXVs
         rsqNHmxUsjxonEut25dM8cEyvvUv+ikzLFh16f7D3CB/IyhrcFdaHCehYc0jDtMRUa9R
         G5fgs6ol2cKDYk7wWYcKL87oTE77VBAhX8+l6j2JHMlMU+zEdiWi40/a8h2Hz5820wpl
         vUrQ==
X-Gm-Message-State: AOUpUlGpBVnkfyRH1c4BHc2hhejz6lkEcTGjnS12DexfPJ+XWfL7U9UI
        cL65S5Iu8yK7uMFq3AVF7Nw=
X-Google-Smtp-Source: AAOMgpe3jKbEwiommGxST6as18nZk2VF/4D7wdwKa45qm4dfK3mtFUpSbVuU5cBHyPwoNLVPnzg7nQ==
X-Received: by 2002:adf:93a3:: with SMTP id 32-v6mr24269739wrp.140.1533146086684;
        Wed, 01 Aug 2018 10:54:46 -0700 (PDT)
Received: from gmail.com (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id d12-v6sm17493292wru.36.2018.08.01.10.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 10:54:46 -0700 (PDT)
Date:   Wed, 1 Aug 2018 19:54:33 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>,
        Martin Sebor <msebor@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] Support the nonstring variable attribute (gcc >= 8)
Message-ID: <20180801175433.GA25298@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the GCC manual:

The nonstring variable attribute specifies that an object or member
declaration with type array of char or pointer to char is intended to
store character arrays that do not necessarily contain a terminating NUL
character. This is useful in detecting uses of such arrays or pointers
with functions that expect NUL-terminated strings, and to avoid warnings
when such an array or pointer is used as an argument to a bounded string
manipulation function such as strncpy.

  https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html

Some reports are already coming to the LKML regarding these
warnings. When they are false positives, like this one

  https://lkml.org/lkml/2018/1/16/135

we can use __nonstring to let gcc know a NUL character is not required.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Martin Sebor <msebor@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
Re-sending this since a few months have passed, Martin has improved
GCC's feature and warnings are appearing in Geert's build bot.
Added an example in the second patch as requested by David.

 include/linux/compiler-gcc.h   | 14 ++++++++++++++
 include/linux/compiler_types.h |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 573f5a7d42d4..fab4e904f1fe 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -343,6 +343,20 @@
 #define __designated_init __attribute__((designated_init))
 #endif
 
+#if GCC_VERSION >= 80000
+/*
+ * The nonstring variable attribute specifies that an object or member
+ * declaration with type array of char or pointer to char is intended
+ * to store character arrays that do not necessarily contain a terminating
+ * NUL character. This is useful in detecting uses of such arrays or pointers
+ * with functions that expect NUL-terminated strings, and to avoid warnings
+ * when such an array or pointer is used as an argument to a bounded string
+ * manipulation function such as strncpy.
+ * https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html
+ */
+#define __nonstring __attribute__((nonstring))
+#endif
+
 #endif	/* gcc version >= 40000 specific checks */
 
 #if !defined(__noclone)
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index a8ba6b04152c..9c07be36e86a 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -289,4 +289,8 @@ struct ftrace_likely_data {
 #define __diag_error(compiler, version, option, comment) \
 	__diag_ ## compiler(version, error, option)
 
+#ifndef __nonstring
+# define __nonstring
+#endif
+
 #endif /* __LINUX_COMPILER_TYPES_H */
-- 
2.17.1

