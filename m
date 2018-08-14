Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A53EC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15BA21730
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbn27NZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15BA21730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbeHNTsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:48:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34922 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732961AbeHNTsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:48:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id g1-v6so17832239wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8hbhFTrqWuu04Rk9VZuLA3oZQs21BZaow0qm//j+tqo=;
        b=fbn27NZD5OOzCW18DyVP6XM6KL2fUG3lVtNtFLrwa2W9wCoCRSL6ciV9S3LfIYlrmQ
         LTfN/bw+A/FbGzlU5RMpmoc6lgar77/7XR7oZdCmUuzmLoFl+jiLclhao4EEZ5BmIJ0n
         tNXbhajwYTh6EWmgiRPZa2ZkJQ957Etv4WAS0g1X+0w6uRdLW19dAXxZ4WHVkGQVd/8w
         3V5EvA6stm6i2l+foWXMKPz8Eju5NsoMUIgQseh1Be7PxBK5JQNuNqJGZrMZMvbFQP0p
         xTq4LuoWAomTV/jKaJPnyuyJ2iSuJLt0m+CylevIrr34MJzLkVFWnOIyHkWANtBgECxr
         6mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8hbhFTrqWuu04Rk9VZuLA3oZQs21BZaow0qm//j+tqo=;
        b=QYtQ395ts9QOELwgPzbsSKhLybJjyPBmvv4hLoOJif+YhkiZviCPeHUutVhpuUn6dt
         wyQO4WeYvOoGEtxYtklCBmzdo87Cra5dKwhhhP7EdE1sJAQm7toEMSYNaK0REl47/Bdn
         GSwEwz10bo/L1n813wuHWcUBSgE25+8P0BmfVLmSEho8xvBul4KXy71vTgo2i5CFQk8X
         r13rePaXnzwrxCu3fEqt/N/wK/gMOMw01DjkDM7SmXwWdWxoSGb7i1paAdQTGvokCgrZ
         l/h/I10B2mojjxrUJKI/1NfhMwaq3kK9OLQ0dAqgypDGodTMMvXo8tB84f8o8e83GECY
         hc/A==
X-Gm-Message-State: AOUpUlF4UWpwZLbGScXfc16ANi0hJXST4VCJhEaVYO8L0a4MCEmk8gJi
        xOacqdrhUr1Y+U7Z73kLPb5x/QS8
X-Google-Smtp-Source: AA+uWPw5XtkusnZlk8+4FgUj5hPXnmcQVD/8bY9oMVVPRpyXiibSaLibLH6evil2Li6wxALKXvPgGw==
X-Received: by 2002:a5d:5088:: with SMTP id a8-v6mr13466360wrt.37.1534266006700;
        Tue, 14 Aug 2018 10:00:06 -0700 (PDT)
Received: from localhost.localdomain.com (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id p5-v6sm15383945wre.32.2018.08.14.10.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 10:00:06 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH] x86, asm: Use CC_SET()/CC_OUT() in arch/x86/include/asm/signal.h
Date:   Tue, 14 Aug 2018 18:59:51 +0200
Message-Id: <20180814165951.13538-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove open-coded uses of set instructions to use CC_SET()/CC_OUT() in arch/x86/include/asm/signal.h.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/signal.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 5f9012ff52ed..33d3c88a7225 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -39,6 +39,7 @@ extern void do_signal(struct pt_regs *regs);
 
 #define __ARCH_HAS_SA_RESTORER
 
+#include <asm/asm.h>
 #include <uapi/asm/sigcontext.h>
 
 #ifdef __i386__
@@ -86,9 +87,9 @@ static inline int __const_sigismember(sigset_t *set, int _sig)
 
 static inline int __gen_sigismember(sigset_t *set, int _sig)
 {
-	unsigned char ret;
-	asm("btl %2,%1\n\tsetc %0"
-	    : "=qm"(ret) : "m"(*set), "Ir"(_sig-1) : "cc");
+	bool ret;
+	asm("btl %2,%1" CC_SET(c)
+	    : CC_OUT(c) (ret) : "m"(*set), "Ir"(_sig-1));
 	return ret;
 }
 
-- 
2.17.1

