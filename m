Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B23C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7607120821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTiKLKvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7607120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeLJUoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:44:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34521 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729571AbeLJUoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:44:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so7479024wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4yAr4oLQB3CnpwnJps09lyoZ5diio3yMi3xmhatAbW4=;
        b=gTiKLKvkzXivXuWasgWojKRJZSxhAhyx8VCi4o6LjXsV2dwBHeWcNsciYpGEiMynOX
         M0Z/EAzR6mvTjCHnOkeOqf7cE9+7Rt02fah7bHN+OL4h162k/JMVceP/gPNXbNtumABx
         Gnzkwf+SlT9jFqEeLAjTrj7FmJs77raUKNuTgU1dp1l9ZmTTtcxutkE2vZfR4nOWd5WM
         aq9Ru14tKAm7Nsl8+1NUp1x3Ctf9btQW3oLY0jaoDLolHVUupoRw0Sz4J9TxMMnCDWC9
         IJcHVRExtbXpE3bUvgmOq/7IVAyVtYG+KJ3mdB5NgKDvoU3cqSTPngq6dHRqFD3hNK5+
         fUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4yAr4oLQB3CnpwnJps09lyoZ5diio3yMi3xmhatAbW4=;
        b=AZwbsgo034cLUvkZE6dv5Mg3D4peG2uaonnDTA6DBTEWQfG/HO6GL8MxzgQ3v+anPS
         o1ZC3NUJ8kVT4WX0QTW/lJlDIv2227rRC1u0ZVqRD28z+qLQUruv6dYWVPOSqgZOd42B
         wOlotEABmsyXJkSODr9+9uk5WZ0dzPpuI+0Q7bYjAo3yLPcOjg1AfLn9LMv45VYANxSs
         bve+K0ogfU1F5a06+aBtPYEzVrYFUi42cLTvkRC5/WvzUwgH4xTUQxpOJx8uCMMDd2QW
         FLVP/ANkHM3CmG9PWtaYAFZa80VBgnld3hZn/U5HNNCpe3e2ImjRaeXRWSn+RR95Baza
         VcCQ==
X-Gm-Message-State: AA+aEWaWESf7QiQ0nPGegflk3WnfU2ODuk7RYr+XfiK1tauUYib8mX9G
        QvE+yIr13zEx9O/9klTfybo=
X-Google-Smtp-Source: AFSGD/XPUWDnMACC9jq9Dh2gzm1bEw6wpaTVQaySzt8qMCXNKHAPx3yMNOqDlAEcsEhCwfr2zyZ4xw==
X-Received: by 2002:a1c:ad45:: with SMTP id w66mr11850114wme.60.1544474641654;
        Mon, 10 Dec 2018 12:44:01 -0800 (PST)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id b131sm26985wma.21.2018.12.10.12.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 12:44:01 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH 1/2] riscv: define NR_syscalls in unistd.h
Date:   Mon, 10 Dec 2018 21:43:54 +0100
Message-Id: <20181210204355.3483-2-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210204355.3483-1-david.abdurachmanov@gmail.com>
References: <20181210204355.3483-1-david.abdurachmanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro is used by kernel/trace/{trace.h,trace_syscalls.c} if we
have CONFIG_FTRACE_SYSCALLS enabled.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Fixes: b78002b395b4 ("riscv: add HAVE_SYSCALL_TRACEPOINTS to Kconfig")
---
 arch/riscv/include/asm/unistd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index fef96f117b4d..073ee80fdf74 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -19,3 +19,5 @@
 #define __ARCH_WANT_SYS_CLONE
 
 #include <uapi/asm/unistd.h>
+
+#define NR_syscalls (__NR_syscalls)
-- 
2.19.2

