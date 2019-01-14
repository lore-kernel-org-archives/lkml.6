Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EE3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3328C20896
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="dKl6W2km"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfANVFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:05:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53040 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfANVF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:05:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so1123198wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 13:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GD+EBvrWZeLBiLbVYUmorj631pUkIjHc9+6iZNpQcXU=;
        b=dKl6W2kmX3JEWaXye7fKLgBiYCdvVxyGhuaVpfv341sIiYHAHNdkV+CP4AAgFz4yZL
         Xr/L1ONJeNWUS2wHbC3onHHM64N+yG6BLgjNaiBhPBJ2lpaufhHp53wb41aebETT51EE
         eHDFwp3r+6Ykht2fKufHU+UzpC2ApJLJWUKNgG8kosLuYmcBDj6iCR/rX5FDAMllF0GG
         gnOdU9MFlqnl3O7Rl+WHVwRiW5b0F3LHl5LXrEAfp5TgYk3BGFrFlE9ZdjsQwadVeck/
         wu/RcP4SJ2K2B+pNhH5tWaizL3Vy5RWY3Kw94oeO0h4CNB4VLr02iZjbEF90ivNpb80U
         9FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GD+EBvrWZeLBiLbVYUmorj631pUkIjHc9+6iZNpQcXU=;
        b=HyjWRICfVIECgMC+NsVznvFBeMUaebiWVVVCleSKbWbP1nX/AYM7z4ffhqJdunbtF6
         e4n8p2LDAkN4A8MQM1XFaUug+HplIqE6zc/fVJfu4CO/j21DSWI6pdK/B7JxVZWGBp3B
         eK1N0roOWu7kDSRYcNZhUeHLwtJ72wJEdZlfvTol+S0mG9lIvfH+qAkmsmg9nuQRy+9h
         ccJVadRYtGIhQytqPSn5heElBBG3yH+kyXG4XZzsf5/nYJDmZqpnDE8W8kSOZUBCfwRg
         2Sx7+hXDBMzdtO/GQFgPhFev0FYcAFiM3dXl0Rb2MbDnfHgjc4TC/xs+yqcOhjbyMhYU
         fwhg==
X-Gm-Message-State: AJcUukelm3b9qHuYOn/Yto10bgyNkJW07U/2198kUwAH3rmLVgOhFfbw
        /bvjaIMz20XrKhFNfvR4qAKLQw==
X-Google-Smtp-Source: ALg8bN4LwDvpdFX3lgkbQDGJAIsL+mbTgLeJLDHBtbwn4SRmnLC2BXnQBdC1GcapVn0QLhExjn+2Wg==
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr709714wmk.149.1547499927083;
        Mon, 14 Jan 2019 13:05:27 -0800 (PST)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id s1sm106981548wro.9.2019.01.14.13.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 13:05:26 -0800 (PST)
From:   Tri Vo <trong@android.com>
To:     oberpar@linux.ibm.com
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH 4/4] gcov: clang: pick GCC vs Clang format depending on compiler
Date:   Mon, 14 Jan 2019 13:04:26 -0800
Message-Id: <20190114210426.177543-5-trong@android.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190114210426.177543-1-trong@android.com>
References: <20190114210426.177543-1-trong@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang gcov format is only supported by Clang compiler, and Clang
compiler only supports Clang format.

We set gcov format to depend on which compiler (GCC or Clang) is used.

Automatic format detection behavior is preserved because:
If GCC is used, one of the GCC gcov formats is selected.
If Clang is used, Clang gcov format is selected.

Signed-off-by: Tri Vo <trong@android.com>
---
 kernel/gcov/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index eb428e570923..37ec551d4039 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -60,6 +60,8 @@ choice
 	In such a case, change this option to adjust the format used in the
 	kernel accordingly.
 
+	Select Clang gcov format if building with Clang compiler.
+
 config GCOV_FORMAT_3_4
 	bool "GCC 3.4 format"
 	depends on CC_IS_GCC && GCC_VERSION < 40700
@@ -68,11 +70,13 @@ config GCOV_FORMAT_3_4
 
 config GCOV_FORMAT_4_7
 	bool "GCC 4.7 format"
+	depends on CC_IS_GCC
 	---help---
 	Select this option to use the format defined by GCC 4.7.
 
 config GCOV_FORMAT_CLANG
 	bool "Clang format"
+	depends on CC_IS_CLANG
 	---help---
 	Select this option to use the format defined by Clang.
 
-- 
2.20.1.97.g81188d93c3-goog

