Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976EEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648B421726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="R8sGZjXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfAVXjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:39:14 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:33225 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfAVXjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:39:11 -0500
Received: by mail-it1-f196.google.com with SMTP id m8so10855044itk.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iNLqZdvEm5CxeKT6RdyYcEltmMyKybFyRQUZBsiBNFA=;
        b=R8sGZjXmfr0NKQLuiqdaFQyNglBl7T9PIc9fo4phgxtQj4LBR3SbSgchzkbSHR9hwG
         Mh3yGz/0T/cJ9q/LBab1VxKb48oPDsMBW7CVCho4/qBsbSKMoJWlJSURQx9sAO6n6wDN
         fZ4v9J+/zdsqe5UwdxPWnvprOA6ilaiVevTWWCwBhdbKHfBGODvNj+xW76yq/nd3Sqan
         QGu33VHwKYYlj9atubT10ceRmn5gww4KfdcNgFgP1heLXWoH1o+Os15aEkipiTtYI9A7
         kX2EzMLLCjQmIkEBKanq5JfAL1r7JbqCwMK45MCMFHy0IPw5PtSP+5i8/y/KVMVHDhIA
         xEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iNLqZdvEm5CxeKT6RdyYcEltmMyKybFyRQUZBsiBNFA=;
        b=mbzKJcdwHuXCZdYbzVHH/j8osztIoNVPabZyarCnHsK/PhgGeTIvaOiqMD0c/k9TOL
         OFox/QXktZXECoaVQU3UPPn4uhUW8zlLsYB3ShSoMNyAA3xRPXtsQUKtz2ny9N3CMvUh
         bGzffmk1BQCPHitih2XJQpiNp9EDiK4fAHW0+cpLS4iZ1T0xvuazmOXw7ZDvIctErGxN
         xqLpKN+bWAjWLiq9uq2wvFCMJpixgR7LNYi1d9UPUXZaSbJJbbOQaz7DZ2FBEvVzikXq
         m5GJeS0iilmZM88wqZVf1uKGrV9BC2+6E87RYobdg2uA5jp+cnvl/ePAeyZHMuQA4LDr
         DUXA==
X-Gm-Message-State: AHQUAubmwsDVQBj9w0z86qSfgJBiGRx2xcbLyp98Q7q+oUE6QFHlJttP
        1j5HvDxrywrB2osqKyqYMBtPMQ==
X-Google-Smtp-Source: AHgI3IbAi83tNb4xc7JVndkEmo1tPl98/gEs0c2kVZE8TlA6cwE3qDP54BIeqfQ1VKSH8sY3ngO35Q==
X-Received: by 2002:a24:c456:: with SMTP id v83mr374543itf.44.1548200350277;
        Tue, 22 Jan 2019 15:39:10 -0800 (PST)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id g186sm8058823ite.39.2019.01.22.15.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 15:39:09 -0800 (PST)
From:   Tri Vo <trong@android.com>
To:     oberpar@linux.ibm.com
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        yamada.masahiro@socionext.com, Tri Vo <trong@android.com>
Subject: [PATCH v3 3/3] gcov: docs: add a note on GCC vs Clang differences
Date:   Tue, 22 Jan 2019 15:37:49 -0800
Message-Id: <20190122233749.42220-4-trong@android.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190122233749.42220-1-trong@android.com>
References: <20190122233749.42220-1-trong@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document some things of note to gcov users:
1. GCC gcov and Clang llvm-cov tools are not compatible.
2. The use of GCC vs Clang is transparent at build-time.

Signed-off-by: Tri Vo <trong@android.com>
---
 Documentation/dev-tools/gcov.rst | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/gcov.rst b/Documentation/dev-tools/gcov.rst
index 69a7d90c320a..46aae52a41d0 100644
--- a/Documentation/dev-tools/gcov.rst
+++ b/Documentation/dev-tools/gcov.rst
@@ -34,10 +34,6 @@ Configure the kernel with::
         CONFIG_DEBUG_FS=y
         CONFIG_GCOV_KERNEL=y
 
-select the gcc's gcov format, default is autodetect based on gcc version::
-
-        CONFIG_GCOV_FORMAT_AUTODETECT=y
-
 and to get coverage data for the entire kernel::
 
         CONFIG_GCOV_PROFILE_ALL=y
@@ -169,6 +165,20 @@ b) gcov is run on the BUILD machine
       [user@build] gcov -o /tmp/coverage/tmp/out/init main.c
 
 
+Note on compilers
+-----------------
+
+GCC and LLVM gcov tools are not necessarily compatible. Use gcov_ to work with
+GCC-generated .gcno and .gcda files, and use llvm-cov_ for Clang.
+
+.. _gcov: http://gcc.gnu.org/onlinedocs/gcc/Gcov.html
+.. _llvm-cov: https://llvm.org/docs/CommandGuide/llvm-cov.html
+
+Build differences between GCC and Clang gcov are handled by Kconfig. It
+automatically selects the appropriate gcov format depending on the detected
+toolchain.
+
+
 Troubleshooting
 ---------------
 
-- 
2.20.1.321.g9e740568ce-goog

