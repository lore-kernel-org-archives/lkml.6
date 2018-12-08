Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C83C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01D120989
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayLx5CYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01D120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbeLHMgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 07:36:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55988 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeLHMgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 07:36:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so6696655wmc.5;
        Sat, 08 Dec 2018 04:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=36A3eDckkylrGVjY8X8hZlZOGZ+jr4cIWWns9IB8/iA=;
        b=ayLx5CYMymWpDPmeKkE9IFR7gRSFBjVtezz9ztwUzSKRQvRW0iI1Lye0FW4LCS2M1J
         qpujtsa9DmSFyJ+sGaNZ+6+Q0r6yrGdndu7FlMufM2rYgtez7Yqs1SHlvHOr329meyBt
         ab4D1dFalGxUdvZXcOrTRskpNgddXHhGAjVtycNVMTOkEZff9yIgdY6eRshZ8NivPGId
         ol0TyFfVouQ22NIGGSpilpz3nn+57iPY0GEE48LEQtQOM5Ep5OWqHqzH0hXwyIbAqkA4
         YYqbkv1ZZHO6sQjL4Suw1qQqYHlCcqRCSwMR/Vh/GQlr+d4enqWEA51GWq07aDjB3v8p
         Nlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=36A3eDckkylrGVjY8X8hZlZOGZ+jr4cIWWns9IB8/iA=;
        b=d1nVT52bUje8XjYdqwqoFOyGPMi4BwuCz+ppTQBAm2fofp9IZLlL9U4IBmOE90DJdX
         +wIJLP+C4+nvni5Kv+XgC9rp367kEkDAucYbx4roCoOyQ/b6KtxSQDLjAIlkSY+rtf5c
         +IzM1Nw8bTOQU6PFn6DMADEGBqllxHbhLClFyK7aSE+ZSoLTWOZEk/fgqOarU9O867A5
         ef5J5ITXZIcAMKF+NhTkOoAGooaMF7ONn3IpHgq/hsdT1QNJ+wENtDBeROQtUI0Bn3qX
         imTwEiom4G+lGWNUcWIvkepAP+RzTNRlBIgcU1iV1o5nuYdiW0hfqyzCAhEi90BqqETB
         DEHw==
X-Gm-Message-State: AA+aEWaXaUM9D9h1H6iJnrzSoEIJcRIdtjgJ+FLZmVQMsg2+Ytrdpj8m
        VEUi4ZPshiEpX6uF7QxDNLw=
X-Google-Smtp-Source: AFSGD/XbU93sX6ciFMyjitYymu4GOA/aX0ML4+O/r4hGq0GImw7kn0bEm41/xRvBLVAdyIs5mYXQ9A==
X-Received: by 2002:a1c:414:: with SMTP id 20mr5012082wme.67.1544272581318;
        Sat, 08 Dec 2018 04:36:21 -0800 (PST)
Received: from gentoo0.localdomain (x4d06ba91.dyn.telefonica.de. [77.6.186.145])
        by smtp.gmail.com with ESMTPSA id x76sm15769870wmd.27.2018.12.08.04.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 04:36:20 -0800 (PST)
From:   Kirill Marinushkin <k.marinushkin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Kirill Marinushkin <k.marinushkin@gmail.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] x86/retpoline: Fix forcing me to update my compiler
Date:   Sat,  8 Dec 2018 13:38:16 +0100
Message-Id: <20181208123816.22952-1-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First problem: I cannot compile the kernel with my version of compiler

~~~~
$ make defconfig
*** Default configuration is based on 'i386_defconfig'
\#
\# configuration written to .config
\#
$ grep CONFIG_RETPOLINE .config
CONFIG_RETPOLINE=y
$ make
arch/x86/Makefile:224: *** You are building kernel with non-retpoline
compiler, please update your compiler..  Stop.
~~~~

Second problem: when I disable the feature - it cannot take effect,
because the parse-time error happens before `syncconfig`

~~~~
$ scripts/config -d RETPOLINE
$ grep CONFIG_RETPOLINE .config
\# CONFIG_RETPOLINE is not set
$ make
arch/x86/Makefile:224: *** You are building kernel with non-retpoline
compiler, please update your compiler..  Stop.
~~~~

Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
 arch/x86/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f5d7f4134524..26a2198c59b3 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -220,9 +220,6 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-ifeq ($(RETPOLINE_CFLAGS),)
-  $(error You are building kernel with non-retpoline compiler, please update your compiler.)
-endif
   KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
 endif
 
-- 
2.13.6

