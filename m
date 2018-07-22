Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1A6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FD320858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svRGsi7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FD320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387846AbeGVXJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36388 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387780AbeGVXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so16060925wro.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G9jDKer0GFyWWGhctE2jil+6czI0s0y9GtXxrghfHzE=;
        b=svRGsi7he4H2rYxf6DI4936c+a/bUv26lYJ7LrbzVKoyfrJhZ/9/aiPcBCXeJhRZtd
         3pymLydvYZiKJF2J5j0jNSdYgz1L1z1goVvnrHi/M2gI2pLBnpmhwBqJqDDdT714EauX
         OhGSHfECF94f6v1Kwe7ztWA+qS789ZX62PcE+T33fZIbR0Q4cVJLJJBMMJK/XNupR8Wq
         4MrInxE4ARd7zeA1AWRmKOXYOdFhKBHcpRxogz8gr6VgI+D8RqOyw4G9umKsq1xI/8cs
         FqSuXL5Tr7RD0pski+4HX58tJguaofH8GToFY0BKAzDBG7vvrsKo53ZOBDSW/WPOIIPC
         J52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G9jDKer0GFyWWGhctE2jil+6czI0s0y9GtXxrghfHzE=;
        b=rSRtkQX9w2Z2Aa8WW6Xz2gkn1iNyUj7M1trYPrz/TRAhAvmBcRAFyGN94z+B02gJ+k
         XK9Cy7AqJiC7ir+M6ZdFEwU7JKj3k8kkVwW/L9cSu75mAevNfjeew70BPqXaaiR2ZIqw
         ZLVLXKIh1VNl5K9YU+1p9HqBqBTNwiBvg9cXIHKCT8JGPB5wCMsJvXUETagw5heQejpT
         FF2ozjXPWVyO+ZKLnJRCVSAwwZA8n/+91YDtqsKejJw7Kk0PYNQVOkZW38jIsYo+RzYx
         DGRjCdaeCM4jam1x9eP7cYudHCNOacwEeZJzgNcLVLv4+tDANNq5r3TOjAf9x8+ZzT6R
         9hJA==
X-Gm-Message-State: AOUpUlHXDFvYrWp9sQwuPv8fBRuTJ2ytRk5ot6PGKRNC9jlcbHsRasww
        mG7LJVgwxucxVRF33SwBgvdx4c1lfFc=
X-Google-Smtp-Source: AAOMgpd6EOJlZjX84ayDIN+tXYuEl75QFhoRBnQT+YjRh5NcnZuQ00BNqc6UxZrzfu2lejKCL1DOhA==
X-Received: by 2002:adf:fe8f:: with SMTP id l15-v6mr7018211wrr.165.1532297466824;
        Sun, 22 Jul 2018 15:11:06 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:11:06 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/20] staging:rtl8192u: Remove unused page-9 Bit Mask definitions - Style
Date:   Sun, 22 Jul 2018 23:10:27 +0100
Message-Id: <20180722221035.14453-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused page-9 Bit Mask definitions. These definitions fail
the checkpatch CamelCase naming tests. Since the definitions are unused
in code they have simply been removed, rather then renaming. The change
is purely a coding style change and should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index 211f34359e43..53beef72ceda 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -120,19 +120,6 @@
 #define bLSSIReadBackData			0xfff
 #define bXtalCap					0x0f000000
 
-/* page-9 */
-#define bOFDMTxSC				0x30000000
-#define bCCKTxOn					0x1
-#define bOFDMTxOn				0x2
-#define bDebugPage				0xfff  /* reset debug page and also HWord, LWord */
-#define bDebugItem				0xff   /* reset debug page and LWord */
-#define bAntL					0x10
-#define bAntNonHT					0x100
-#define bAntHT1					0x1000
-#define bAntHT2						0x10000
-#define bAntHT1S1					0x100000
-#define bAntNonHTS1				0x1000000
-
 /* page-a */
 #define bCCKBBMode				0x3
 #define bCCKTxPowerSaving			0x80
-- 
2.18.0

