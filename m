Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDDAC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A0A20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A0A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967397AbeFSVsJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:48:09 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34882 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967311AbeFSVrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:47:22 -0400
Received: by mail-yw0-f194.google.com with SMTP id v131-v6so452910ywg.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W1Ng6EJXxwLUZYoApWutVMxtEjDppkRB8dUa9ssSHew=;
        b=mxqPRez6wif6W94hfc0KmR73TzMO0BYkrpwPKP9NII39V4CXtKgrVn+brUgMsC7M23
         9ZN+8JVPuIrAfRRfXo9wTBdWPta2SSdbHeiQDSUf2RK7+p7VlbNUnCWJALyNjUul0ijT
         YepO2rBH2vaPgNQSopWTa1ipxlStfZ7iyJqEuyMjWh0khre3jqdzHwdFmP1f/iR4FYXW
         YxJ8f3EBPprJeB3XqNEEcNgbdWOHve+oyLIV/oFvT6iYcVZE5sbMlaluSfGOCmG/IddY
         /CzEjycl225OmzasmqOEwa1cg9+XZ4SmmdsKcjDgbR6LV+BqwR/0u+TJHUPmsGCp69n5
         aWHw==
X-Gm-Message-State: APt69E1LTd5KNoqyUBJlxaNUVsZ/BddE7FlK9Da5Lz3Wr0Vdc+/6T5qS
        tGlAM3WWBD2Be7G97r7Jgg==
X-Google-Smtp-Source: ADUXVKIbzIEOSqM3qo0OkHJcwHsQLszyG0v2gtaxnWQRGraiX54Z7ZCVBdVyIkn44hTS6liLyhuTqw==
X-Received: by 2002:a81:6541:: with SMTP id z62-v6mr8755428ywb.160.1529444840548;
        Tue, 19 Jun 2018 14:47:20 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id x66-v6sm333612ywc.76.2018.06.19.14.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:47:19 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 5/5] MIPS: lantiq: remove unnecessary of_platform_default_populate call
Date:   Tue, 19 Jun 2018 15:47:10 -0600
Message-Id: <20180619214710.22066-6-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619214710.22066-1-robh@kernel.org>
References: <20180619214710.22066-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT core will call of_platform_default_populate, so it is not necessary
for arch specific code to call it unless there are custom match entries,
auxdata or parent device. Neither of those apply here, so remove the call.

Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/lantiq/prom.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 9ff7ccde9de0..d984bd5c2ec5 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -9,7 +9,6 @@
 #include <linux/export.h>
 #include <linux/clk.h>
 #include <linux/bootmem.h>
-#include <linux/of_platform.h>
 #include <linux/of_fdt.h>
 
 #include <asm/bootinfo.h>
@@ -114,10 +113,3 @@ void __init prom_init(void)
 		panic("failed to register_vsmp_smp_ops()");
 #endif
 }
-
-int __init plat_of_setup(void)
-{
-	return of_platform_default_populate(NULL, NULL, NULL);
-}
-
-arch_initcall(plat_of_setup);
-- 
2.17.1

