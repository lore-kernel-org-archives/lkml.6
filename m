Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239DAECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D72204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jILOEgua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D72204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJRIw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:52:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39037 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRIw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:52:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id y144-v6so3954718wmd.4;
        Wed, 17 Oct 2018 17:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ad3/14ZGqgDualdXOF+nC2YcKs/kWOMzknw5d4T11is=;
        b=jILOEguaLXSalObU9Q3KWtiAShXOLtm3TBSreJt3o609cvLGiDV93yH24+c9NVGGTM
         ++tBvtQQdkN0Bh+4mtpZo8nKdJ0lYQcKTxRpO0KgaVFvBB2wQOVGzwrC0XzIrpyM6chM
         EKRlrhQyw5xUoeir30d2oiJ7s9+/Du3WKSupis4lz4JPIhLEhFi7rQ0vozL7krAYvrPH
         wpTE4oPasaDk/5cC/HttxFMDYk5uQFS2A0oilCoSyoEx+OeP9lyLOyfPrLTgucPzBrcu
         SL2bCMmwoZnQoEpSuR2ZRIMIWBXpEFP8njwlDTejHkYl6RK6v7h0fmkhI5x/GHEbTHYS
         x/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ad3/14ZGqgDualdXOF+nC2YcKs/kWOMzknw5d4T11is=;
        b=kDOKjHLPjKL/jCPUUUpWs2By/EI3cJ2Ko9xHGcHKLXSlshK4lyhvjsIH4p7jTzSluS
         6ucKiJb/8/XaSC9boFnACa0/dHOrChVbu9Cqn9TipNBik4+IwKtYnzX2vo6ldj1qanv+
         YcfyESfBUQ6f1WZAHidqKHLsKpydOTZBJ9Z6nhsMrJmH1jDPwHlDBtGdxwXJIIjS61em
         84JF0E/UKjKWFru8GXZMwHo8JwxRCTDURjf4oQaYZKAV7SIT1zszVU+vSYPcAMTjpm4j
         pLIUnhFZ1r1e20kiRWu3pUaqLDTL8XDkdQgQo+67d8ZOslYj2ZYvLXevM1qeq/zcBhDd
         eA4A==
X-Gm-Message-State: ABuFfoiEuaC77Ue3vW+evNJItgf4NKKAS6A/UjLzq6jUxklh+JGV2crf
        gMjwputBWoM6ZYk9Y/IJwhc=
X-Google-Smtp-Source: ACcGV63zsMO13wta45glYSpIqEV0fPEr+ibZd87zcusbiXOG8bj5puZrFtsBm23khWYKY/wNsOMP6A==
X-Received: by 2002:a1c:3702:: with SMTP id e2-v6mr4654587wma.89.1539824047325;
        Wed, 17 Oct 2018 17:54:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t198-v6sm2280291wmd.9.2018.10.17.17.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 17:54:06 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Paul Walmsley <paul@pwsan.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup
Date:   Wed, 17 Oct 2018 17:54:00 -0700
Message-Id: <20181018005400.7521-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the kernel with Clang, the following section mismatch
warning appears:

WARNING: vmlinux.o(.text+0x38b3c): Section mismatch in reference from
the function omap44xx_prm_late_init() to the function
.init.text:omap44xx_prm_enable_io_wakeup()
The function omap44xx_prm_late_init() references
the function __init omap44xx_prm_enable_io_wakeup().
This is often because omap44xx_prm_late_init lacks a __init
annotation or the annotation of omap44xx_prm_enable_io_wakeup is wrong.

Remove the __init annotation from omap44xx_prm_enable_io_wakeup so there
is no more mismatch.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm/mach-omap2/prm44xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 7b95729e8359..38a1be6c3694 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -351,7 +351,7 @@ static void omap44xx_prm_reconfigure_io_chain(void)
  * to occur, WAKEUPENABLE bits must be set in the pad mux registers, and
  * omap44xx_prm_reconfigure_io_chain() must be called.  No return value.
  */
-static void __init omap44xx_prm_enable_io_wakeup(void)
+static void omap44xx_prm_enable_io_wakeup(void)
 {
 	s32 inst = omap4_prmst_get_prm_dev_inst();
 
-- 
2.19.1

