Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B71AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07191206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi6YCFrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfAHNP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:15:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35422 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfAHNP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:15:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so1938185pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 05:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ekuhxggFWt9tfhBqsa6b8OQpmTzdH0pSdOcMdL9c37o=;
        b=Yi6YCFrKJqCiE71ZOS0yHMXtqdajGwq9WMUV+PhS+th/QTan3PeD2mYuP0I/CEdDdC
         hzC+MgSvgpcO4d2g4+9XY6KvloHilpa2g1whZ+92su2olV9dYJp5CO53lXsdlQP3DvU7
         M4vgiPb7dXCdxU54qcWszB4fEQ0C4lEtSNCiTVyOoLGQMJwxO3swyvPYR7/Tf0ONJKrP
         gzpPW8VN9GBXnAIsb1w8r21X8sdDMSLW5gavM7VGxNV28KZckuifbH0X8UfjDn2suKaS
         eTuiQVVh3HocaA0nJM8Ml0ZBX9fjMBOU68udxC2rOtVleQOOABGd/82sQlznEgbU42lu
         /IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ekuhxggFWt9tfhBqsa6b8OQpmTzdH0pSdOcMdL9c37o=;
        b=dJVaNriFLr/F0WA9q1OJXbcx0fNO6aErgzM1hxB+yvkSbH/1sjB1/fyaHGNvoBW7g9
         1TYOaAg1f57Aix+XI6Gekg62YIik71rSFAgj4fgWJu0SSZnSqZSBWUGWzN+/szDW6RmR
         eCP4sj6jA1VXGVCIJoQ0Nz2+G6sGeL6KXoDvyficQ5MDdt6BJicCINM3Cd+/t3rzs1jR
         /cnypR3l4nBgRn2QrNm2njb7UGsNaRPveFSi7aLB4fAJhdCq71tjeoKR/hnh7Aj0t/og
         eOFOPhT04f7izvMIA3cs2lK6x7HUaq/rYuaUkvGTakIE3Nyy7D29zxtsZid3E7GaKOWT
         aqGg==
X-Gm-Message-State: AJcUukexQdyGFaQcMDGxQDsMkJ+PRpPr+3KAAPn1WIKNJk2+JIVd4HY+
        u9SIMJz9NffOfI4AqAA2up94Ty10
X-Google-Smtp-Source: ALg8bN5dhQDMFQc+GsAZnxiUtZJ3Jt7/yaoQXy2IHxWavbvJWtfMArUkdgSdM3E7cNEmX5Zik8hq1Q==
X-Received: by 2002:a63:658:: with SMTP id 85mr1465556pgg.373.1546953326182;
        Tue, 08 Jan 2019 05:15:26 -0800 (PST)
Received: from localhost (g206.124-44-15.ppp.wakwak.ne.jp. [124.44.15.206])
        by smtp.gmail.com with ESMTPSA id l22sm119860345pfj.179.2019.01.08.05.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 05:15:25 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH] arch/openrisc: Fix issues with access_ok()
Date:   Tue,  8 Jan 2019 22:15:15 +0900
Message-Id: <20190108131516.27903-1-shorne@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 594cc251fdd0 ("make 'user_access_begin()' do 'access_ok()'")
exposed incorrect implementations of access_ok() macro in several
architectures.  This change fixes 2 issues found in OpenRISC.

OpenRISC was not properly using parenthesis for arguments and also using
arguments twice.  This patch fixes those 2 issues.

I test booted this patch with v5.0-rc1 on qemu and it's working fine.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index bc8191a34db7..a44682c8adc3 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -58,8 +58,12 @@
 /* Ensure that addr is below task's addr_limit */
 #define __addr_ok(addr) ((unsigned long) addr < get_fs())
 
-#define access_ok(addr, size) \
-	__range_ok((unsigned long)addr, (unsigned long)size)
+#define access_ok(addr, size)						\
+({ 									\
+	unsigned long __ao_addr = (unsigned long)(addr);		\
+	unsigned long __ao_size = (unsigned long)(size);		\
+	__range_ok(__ao_addr, __ao_size);				\
+})
 
 /*
  * These are the main single-value transfer routines.  They automatically
-- 
2.19.1

