Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0281DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F43222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNVepkl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395187AbfBMWmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:42:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40084 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395158AbfBMWmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:42:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id q1so4370192wrp.7;
        Wed, 13 Feb 2019 14:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=hnmNnr9YQbwfaI93UrUGE24zBu/XKqtY3CcuY5KmkdU=;
        b=PNVepkl6wnUM5Gny5FQUy8cW58lk/9t/2MXulvttnDMJYmFIRT1s7OQDhJgy7JoYKr
         RENLyyEJtlADc4C3wWCABbcBNHnXBcoU97GOP46rTUOZi8pzqVZgUHorFtxsx6S0m9bo
         8cwStO91nzWS2kMGecQlHxxNYgZSEJk8564FrYQFFBKN79k5hsgwSqoR6L1SUgrG5STy
         6DnBXrTS5lCwPxLO7pNI8vjUAOAOL0lBgIhfFj90qFIvbvWhy2EvSEM+VEn4kc13PxnL
         G3vVyv/a1nxVe44l0Mz6WkwSBr5iEs3AxGCQ+65TWE7c0BkrHQtenb7WOy6oPPulyMcA
         vpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=hnmNnr9YQbwfaI93UrUGE24zBu/XKqtY3CcuY5KmkdU=;
        b=SkDxSLkLzoeYDFTQbJJvWWYr4Pdz/Z66WG8teyesRkzFM43GHlMtqismFC3NjjhD5U
         FjtNJpoAHNts+DJijM3/sONZHy/slAYPIkoq6SrV6XcmcC3AYTkq7PRnvO7gcoQFNt7w
         GSXzWl5meviQUENGOfEhz78siqx0CVSFI0vkVKh5QBNoona6NnGYZGeoaJxeg0SIFI92
         vvwMGG7vLHCOVD+g2hULpb3gk4INRvP4CN0pNf6EZTbGvJzk/nP7LwxBA1HFGXB6bdHw
         HAOSz9NQo4ZFsCRGPNxhRVgAY1+Om147lWTbzz5X5KJm7Kt5x0ciE4E1S5njcwvNseQS
         YvAw==
X-Gm-Message-State: AHQUAuamdZ+hcbu5LMAgA87aGl2e8tVUuFJ7pdtES4ZzIR3Mo7m59zTh
        bBluaQxysVDJ6u0bhaGXsuI=
X-Google-Smtp-Source: AHgI3IY2zZ/s+/of06qs5oz7e3UG5TRwg7xiFolsJ/mC0V02SnY5LJL9Knhh3oBwoWb72MhgeMlbNw==
X-Received: by 2002:a5d:5289:: with SMTP id c9mr284768wrv.11.1550097736697;
        Wed, 13 Feb 2019 14:42:16 -0800 (PST)
Received: from localhost.localdomain ([91.75.74.250])
        by smtp.gmail.com with ESMTPSA id f196sm780810wme.36.2019.02.13.14.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:42:16 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 06/12] __wr_after_init: arm64: enable
Date:   Thu, 14 Feb 2019 00:41:35 +0200
Message-Id: <c81c8be7d5bfcc234dce969b8be7efad3d18d1b8.1550097697.git.igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1550097697.git.igor.stoppa@huawei.com>
References: <cover.1550097697.git.igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set ARCH_HAS_PRMEM to Y for arm64

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

CC: Andy Lutomirski <luto@amacapital.net>
CC: Nadav Amit <nadav.amit@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Kees Cook <keescook@chromium.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC: Ahmed Soliman <ahmedsoliman@mena.vt.edu>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..7cbb2c133ed7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -66,6 +66,7 @@ config ARM64
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_PRMEM
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
 	select ARM_GIC
-- 
2.19.1

