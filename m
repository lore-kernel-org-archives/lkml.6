Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C45BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2C9247D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcmoqPi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2C9247D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934349AbeFVT1F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:27:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36753 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933382AbeFVT1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:27:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id v131-v6so3786989wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvvvSbx0/lqHcUeMeexa3pxT0FD18SDoSNhBteFCioY=;
        b=ZcmoqPi/rI4ofXERWdmKiDA/gzM5r/ZYRs7t6Uxcufo4HRmB5mX3Q0N5uBEsl78Arb
         /KjMUKSkzVN1Wb1I4+c6GVx7cUC6Ovrxr0i029vZu7oTCORlL1yslDq92usxSKVv3C01
         ab++T2A+kvoR7PbdipM3OJ6bIAC2S3ErPylThvllnOPv6OjvPcW3vKUIaL6ifzxWyqN4
         554vUkcLUR2L7kO2kq0io++7KGX45AtA41HLjBTm1xhxZz1O2pYU+TxcFbfJKLUfotcb
         QLdz3HrovlkEeelm/AaX/K4WEygbJcLhp9CXojk1wsgcZhI4+RvsCr8b1A/0yt0Q2vn0
         Guvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=yvvvSbx0/lqHcUeMeexa3pxT0FD18SDoSNhBteFCioY=;
        b=YjuwHF1pPaBreg4WTqI54ufpimsvsV2KYqLKhfyunaKZjzHL9Wuz50Iw5aLZnVJSLH
         5/fZQj06OWCLoE+2AK5Yu/rs0xrjxdv7GuyltMp8Ix0z1Uc5bkKSIsscM8zbrUl3T7eY
         J2PCm9lPUGO/cNj966k/mQ6Eto98Tqxd7sKJG7/a0tfJD/RibJoG7k9+m9o/IiO2G2TB
         XmSGPTndwJx0Euq6nOZ2XjUBUdtxvjlB5j5MxPr5yGizH2x02a1Y1yg1FcGdXcpYPSrC
         Aaoibi+fLdXjqEGXrid4ohJEKzbC9UJZQ2YM1LyuPr0KPz1i5ny1e8HE659pB4dK/TiZ
         XlTw==
X-Gm-Message-State: APt69E0vrSJu5c4m0Th787Zus0B5jxAzKV/70VS3CdsBUrI+QdeusGmi
        DCeONJk4RJfS/6iG0vqazAE=
X-Google-Smtp-Source: ADUXVKL4pjRuQcKqnjRtFnVytuPvAoxyx8Hn6YuNOxDLkUP8L1JArh3Hocsx6mRCNJyxkFvfLwyBXw==
X-Received: by 2002:a1c:b5c7:: with SMTP id e190-v6mr760792wmf.118.1529695623348;
        Fri, 22 Jun 2018 12:27:03 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id s17-v6sm1628939wmc.34.2018.06.22.12.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 12:27:01 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 718F810C0452; Fri, 22 Jun 2018 21:27:00 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: include setup.h header file to fix warnings
Date:   Fri, 22 Jun 2018 21:26:53 +0200
Message-Id: <20180622192655.23464-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to include setup.h to provide the following prototypes:

- irqstack_early_init
- setup_power_save
- initialize_cache_info

Fix the following warnings (treated as error in W=1):

  arch/powerpc/kernel/setup_32.c:198:13: error: no previous prototype for ‘irqstack_early_init’ [-Werror=missing-prototypes]
  arch/powerpc/kernel/setup_32.c:238:13: error: no previous prototype for ‘setup_power_save’ [-Werror=missing-prototypes]
  arch/powerpc/kernel/setup_32.c:253:13: error: no previous prototype for ‘initialize_cache_info’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/setup_32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 74457485574b..9827b6b3aaaa 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -41,6 +41,8 @@
 #include <asm/cpu_has_feature.h>
 #include <asm/asm-prototypes.h>
 
+#include "setup.h"
+
 #define DBG(fmt...)
 
 extern void bootx_init(unsigned long r4, unsigned long phys);
-- 
2.11.0

