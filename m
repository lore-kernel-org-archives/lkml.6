Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC25BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB33020657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="lA32F3Wi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbfAOShV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:37:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46799 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388821AbfAOShT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:37:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so1662841ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SqscPYVEpk1uqRXzsvpTxtP+0YHzATXKfHTcOFtNGKE=;
        b=lA32F3WiC7xnN08RP4L+8P/yAlnMHlvwdTW3034ovICxWBdZifBTNviC+Uzb9aPHAz
         A3L+gOI4d5ZSgAL+42WBoqWVD+9Hf/ysHceQdZKlkj6vmPgBEdu9Lvas/rybxhXkcnut
         opeLwXqGEZusczN0H5kIfBQHyzc8jJQXRTm9P8iiia5QGx5b6r3+NZ//SPYcjK+GGJq5
         POhjEjdl75GDmokkC0z8a7U111Cna/6y5F7M5AdxxsbZkRx4p3FXpw7IC86hGAMHZlCX
         ippLCC5jhY4xjpPKak/1KyRKekvPNxrJIazC8eHTkajiR7hAY2pWDlC6S78p4OsTHETx
         /apA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SqscPYVEpk1uqRXzsvpTxtP+0YHzATXKfHTcOFtNGKE=;
        b=UXN4tjE/w+7J98jcRsURBvW549vMi6ojvXoprvq9V6Y0n0w/WFs2lzRxOFCUabcAv+
         5J7Nj3zChZ1HyagYjKgv+L7PFbgTNXdWvqbkMZiMLapRl+PeYLDfGxTirkpqOPD83ml0
         jt1n2Vya4C80SZdPh2gGo0ZodaUA7N3tR5Wqo6s9tRxEtVDVzDZrEH/Ml9cvTy2Jf/KB
         vPrsE0ksGqMNYG/u0pVlwRWOk6cAwJP03prkp18ub/Mlt7LladTQZF4VYAOluA2ik6QC
         SkzlhXBeFFEnfrhSqYu+nn9RSBQLm07XwRjj/byuX3h67jEZ1RDy4ADYNP/18IQPI8pe
         VVng==
X-Gm-Message-State: AJcUukdg56cs3iEwJn1XxbwKNWel5v05Lbg+xNHRz5E81l5+Rz/JansL
        ZpStcLuJ0SHdIKtndEgtrv6sjlHFqfY=
X-Google-Smtp-Source: ALg8bN4Vopkc7jmwtSdPdc0ZdztF40Vv0HvPnQiOBNWv4uKpyxQY3vFAL63J3NczOwxhd/0qY4faZg==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12mr5451639plb.46.1547577438239;
        Tue, 15 Jan 2019 10:37:18 -0800 (PST)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id i193sm10156113pgc.22.2019.01.15.10.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 10:37:17 -0800 (PST)
From:   Tri Vo <trong@android.com>
X-Google-Original-From: Tri Vo <trong@google.com>
To:     oberpar@linux.ibm.com
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH v2 4/4] gcov: clang: pick GCC vs Clang format depending on compiler
Date:   Tue, 15 Jan 2019 10:36:43 -0800
Message-Id: <20190115183643.120619-5-trong@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190115183643.120619-1-trong@google.com>
References: <20190115183643.120619-1-trong@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tri Vo <trong@android.com>

Clang gcov format is only supported by Clang compiler, and Clang
compiler only supports Clang format.

We set gcov format to depend on which compiler (GCC or Clang) is used.

Automatic format detection behavior is preserved because:
If GCC is used, one of the GCC gcov formats is selected.
If Clang is used, Clang gcov format is selected.

Signed-off-by: Tri Vo <trong@android.com>
---
 kernel/gcov/Kconfig  | 8 ++------
 kernel/gcov/Makefile | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index eb428e570923..f71c1adcff31 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -53,6 +53,7 @@ config GCOV_PROFILE_ALL
 choice
 	prompt "Specify GCOV format"
 	depends on GCOV_KERNEL
+	depends on CC_IS_GCC
 	---help---
 	The gcov format is usually determined by the GCC version, and the
 	default is chosen according to your GCC version. However, there are
@@ -62,7 +63,7 @@ choice
 
 config GCOV_FORMAT_3_4
 	bool "GCC 3.4 format"
-	depends on CC_IS_GCC && GCC_VERSION < 40700
+	depends on GCC_VERSION < 40700
 	---help---
 	Select this option to use the format defined by GCC 3.4.
 
@@ -71,11 +72,6 @@ config GCOV_FORMAT_4_7
 	---help---
 	Select this option to use the format defined by GCC 4.7.
 
-config GCOV_FORMAT_CLANG
-	bool "Clang format"
-	---help---
-	Select this option to use the format defined by Clang.
-
 endchoice
 
 endmenu
diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
index 83da4765c18d..d66a74b0f100 100644
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -4,4 +4,4 @@ ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
 obj-y := base.o fs.o
 obj-$(CONFIG_GCOV_FORMAT_3_4) += gcc_base.o gcc_3_4.o
 obj-$(CONFIG_GCOV_FORMAT_4_7) += gcc_base.o gcc_4_7.o
-obj-$(CONFIG_GCOV_FORMAT_CLANG) += clang.o
+obj-$(CONFIG_CC_IS_CLANG) += clang.o
-- 
2.20.1.97.g81188d93c3-goog

