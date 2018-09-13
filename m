Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F409EC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF1E20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fieahl-im.20150623.gappssmtp.com header.i=@fieahl-im.20150623.gappssmtp.com header.b="yMBrzl3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF1E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieahl.im
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeIMPrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:47:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35401 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeIMPre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:47:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7-v6so2571017pgf.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fieahl-im.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EW5Ugiqn3b8WYpTlEqgx1ZMQW2Ps0mK+m8JtRTfIaU4=;
        b=yMBrzl3XAjzuYXTJvYqI9/NDVsBx7Khb8rwZ5IHo54vjv+vh58owBXiss6aa+cpmTk
         KhrBGc0UK+pSir7hi2pzb4x8OqVUHlGP+lovJyCDlk/Uo3fjrm9Mm9vNMdiR39LHKbeU
         zwxeCaINo8JK2z9yFchMGJYJoBS3Qfu4yOw+7csH1MPJKxi9Tqf58cXCWivfGlYN1ab+
         oekhbBkXDswW9yMUduBuXaFpHHW7PylJkPlQxw7GPwHqBuRJ1gIjllm6QcDmhA8hmvLb
         UMlkl+BSEyt7evw1pnfyas/GvMu6GzEcJrIEmJaU+q94yn8R7heBwr1jjiClQojirVsY
         TN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EW5Ugiqn3b8WYpTlEqgx1ZMQW2Ps0mK+m8JtRTfIaU4=;
        b=LLXOlpEYKlvtrF79ScdZIYksKVofFLCk8DlGl17UbCt6DwXLGY7546I5xJb4XB8Ks4
         8rup4k7HRX0vOKbNJfT/t7JWWp6FGrX2el4xTjlt4KQ27dGyubryPv+EuSDO91YGZLDA
         W7wXFzdpcSACiin3XqXon/axbDxkFBFcqLgu1aWL1Bt2lqZt4dcaxTV0BBgGzDNo7mL5
         xa/4gOeCZjiz/4aVMA+YwRStE1vh08j1m+ralU9cFoZ20+RCmbLeyenwooapy+teJXOb
         p5Lw54HP3sX4/sQY/3aULwKDGUL75N8zvatf8btVg0UHH9kXe27w+8aLOt1pEs54watW
         bSrg==
X-Gm-Message-State: APzg51BkE/Y1Eg2LLl7HbhYzwTyqruSQDdulAA2t7MbjZLIrB/u5BNgU
        RwHCoKCAVnXW3CsOXuS/vMoJgQ==
X-Google-Smtp-Source: ANB0VdaLhMP0rN5VvxRmyn8tCqqzwB+53YYaMGzjvLD6n0lc8kzvNAmNXSeLjRjysgaBgQhSB5p1Zw==
X-Received: by 2002:a63:4c54:: with SMTP id m20-v6mr4025490pgl.292.1536835122051;
        Thu, 13 Sep 2018 03:38:42 -0700 (PDT)
Received: from WorkZone.localdomain ([115.132.52.76])
        by smtp.gmail.com with ESMTPSA id r81-v6sm5492441pfa.18.2018.09.13.03.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 03:38:41 -0700 (PDT)
From:   Fieah Lim <kw@fieahl.im>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list)
Cc:     Fieah Lim <kw@fieahl.im>
Subject: [PATCH] ARM: Don't disable SRA optimization on recent GCC
Date:   Thu, 13 Sep 2018 18:38:32 +0800
Message-Id: <20180913103832.23463-1-kw@fieahl.im>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue addressed by
commit a077224fd35b ("ARM: 8429/1: disable GCC SRA optimization")
has been fixed in GCC version 5.4 and later:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65932#c33
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=7fa02f018da21445e1b93eb89cd29ecbbb98617f

Since ARM/Linaro is releasing latest GNU Toolchain for ARM
(up to version 8.2.1 till this date), we should only disable this
when compiling with GCC version <= 5.3

This patch add a GCC version check before passing -fno-ipa-sra
and remove two unnecessary # in the comment block.

Signed-off-by: Fieah Lim <kw@fieahl.im>
---
 arch/arm/Makefile | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index fc26c3d7b9b6..1fdd8eab21cd 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -54,13 +54,11 @@ AS		+= -EL
 LD		+= -EL
 endif
 
-#
-# The Scalar Replacement of Aggregates (SRA) optimization pass in GCC 4.9 and
-# later may result in code being generated that handles signed short and signed
-# char struct members incorrectly. So disable it.
+# The Scalar Replacement of Aggregates (SRA) optimization pass in GCC 5.3 and
+# earlier may result in code being generated that handles signed short and
+# signed char struct members incorrectly. So disable it.
 # (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65932)
-#
-KBUILD_CFLAGS	+= $(call cc-option,-fno-ipa-sra)
+KBUILD_CFLAGS	+= $(call cc-ifversion, -le, 0503, $(call cc-option,-fno-ipa-sra))
 
 # This selects which instruction set is used.
 # Note that GCC does not numerically define an architecture version
-- 
2.19.0

