Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC02C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A9E20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVCj1D8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A9E20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbeKAEit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:38:49 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:54392 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeKAEit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:38:49 -0400
Received: by mail-vs1-f73.google.com with SMTP id p192so4686561vsd.21
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S4StwFAZ366ZnRgXCI3AmpTwGH+p/yXC9iLRZIQpyXg=;
        b=dVCj1D8CYV8i+rXMFlZ+7UdcAwg73jxnmdj/3gnm2VcI+SobAD44WjIxGle1kjf02c
         6n5GeHebCCXj3TNEZS2IZcjh+5Hq0W0VoYIij9z3XfCGObCzxrssq5iqyb4d/+jNFEOz
         orAaO7PzeIEQUtU32cXi7zMKQ5U34q29DHDrz3gphb1zBc4miVSCcC7TDtdPgYpX8gAf
         t/elsfLNcJNmCfJK3hvbOT9yShxSOv2bS5SN/rtDzZG0+8dgm4DMEoUJ83IMGGu+hE18
         OdWVkhv4wSZTfZke6kn3BGSFUlEO4XyMh79bDi1ehcolOQtRlXrFZgvfMnkQEsY7Bsnz
         +u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S4StwFAZ366ZnRgXCI3AmpTwGH+p/yXC9iLRZIQpyXg=;
        b=D7jKrmr1UyzFqflVtVehiS312FTw+PiWQE5vZ7evVsnC5dOqOhhpwONlqN+uYc1UVr
         44S5WanOp52NAr/elVWgJITooMt/OC+7dBtKUOWy3a6wtMZZhnDW0ctb1swe31bDhGsA
         +KUQeN/XxAa2HjEaYgpjJpwU12CrJ7/ULvstzHQBMEA1A8TvK8z2dACxLNWqHgJgf5iq
         QEof6jiq8rLwfg6zZZtx3Y5T3jyl+7XLRDFMgDgtHQPD4C+i4PXtIhYLX7OzUxc1sSfy
         0W0vtyV9nTWbS4Ic8ojUHmNjKJjDLFxUrF/CRAn5sVBsy6ObYwCPCQR+gQ1gTUf3KdBw
         EwUg==
X-Gm-Message-State: AGRZ1gJ4oj+C1k1kfVrYhca9c2SbubZiBrXQJrX5d1w1RLd5BhW9B9X1
        gyk9Ilq5f6GbPUsl73ev+JcxC7BHooSxcbGOXlE=
X-Google-Smtp-Source: AJdET5eELx+rUrx5XeBq4oy40KgTFRmc57u5vHRGax6trJTTmHeEZL/wsEvqfjxmyksBB4XCHbTCIyWUF1IJ5MZC7cw=
X-Received: by 2002:a1f:980b:: with SMTP id a11mr3739057vke.15.1541014760800;
 Wed, 31 Oct 2018 12:39:20 -0700 (PDT)
Date:   Wed, 31 Oct 2018 12:39:01 -0700
In-Reply-To: <CAHk-=wj-17w3-m9EGVZGeWYpuYM8V=x8py2s5EcAHeinF24TQg@mail.gmail.com>
Message-Id: <20181031193903.203914-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAHk-=wj-17w3-m9EGVZGeWYpuYM8V=x8py2s5EcAHeinF24TQg@mail.gmail.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH v3] include/linux/compiler*.h: define asm_volatile_goto
From:   ndesaulniers@google.com
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, miguel.ojeda.sandonis@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm_volatile_goto should also be defined for other compilers that support
asm goto.

Fixes commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
mutually exclusive").

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
V2 -> V3: update subject line & add reference to fixed commit.
V1 -> V2: drop changes to include/linux/compiler-gcc.h.


 include/linux/compiler_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 97cfe29b3f0a..6f1cb84a687b 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -151,6 +151,10 @@ struct ftrace_likely_data {
 #define __assume_aligned(a, ...)
 #endif
 
+#ifndef asm_volatile_goto
+#define asm_volatile_goto(x...) asm goto(x)
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
-- 
2.19.1.568.g152ad8e336-goog

