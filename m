Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20C4C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D25D23CEE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDpeYLcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D25D23CEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933982AbeGDLiF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:38:05 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36303 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932717AbeGDLiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:38:02 -0400
Received: by mail-wr0-f195.google.com with SMTP id h9-v6so183437wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1/bWWajZO8Mghu/cFIvPJzr6mezW0exT14uILuhhYlQ=;
        b=LDpeYLcS2SJWFb0gDMOAlEnhyEKdTUIugO4IHJrv86EBlWCQX34nuJzBdr3fBZ0gft
         VBy9j7YKyXvGL0xdWOO9lK81unkgDY+MkbZcLXoLQ9FLB/xt9y68z0Sn+d78khAcOy8L
         TnwOdLLKKd2xK/8jmbw+gE2D/H/pVjLMvkB29RORAlVg+lSty4hGhNcfo2qRRUaawApr
         wwEQwDgWaYZVhsB257mnl4+f4kxs4RC/5UmRH7uF1C2no93X57+hK/Q/a8+h7gjYpOk3
         WnH/kUFtDLW0t5OuxR7VYBmGnTeeZRfSqlJtEAT/BC8qMaZb72JYNDWSNUEERC9v4gTM
         h75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1/bWWajZO8Mghu/cFIvPJzr6mezW0exT14uILuhhYlQ=;
        b=kV+AqoY/BVpLv3qtezQnL3Z93A5TIczxhzIZsB1PpI+zCigvKxyGZganMQWjTJmRfn
         lWftfiYGQbUSjGYCLqaribJ+3aT9nCN9geLhdrk9cocoZITt3bnWr4EQ2/7RBE44h+6n
         i15fKMM/vpdxMzAOP01Bts9kLKoiGHcLql/1avCu9a/u8hkJ3sbhWOm4SmjuSlgb2EAE
         YMPveNRsYn0b5hNS2L6jwQZtddgSbfDvqyRzWZCjEOUuYf58DVLcUGXRvyv/9FMqWd4T
         aouI4uhTpUdOJGgATONYAwmcgsf7/9NsTy40g8J3BGwbepLkOETEgQXpyK4t7AeJZE4v
         0sJA==
X-Gm-Message-State: APt69E0fLxHYoljdf1Dx4JclPAvzMjgzIn92Pq9aXv0DFqkUXyMVx2x1
        0ozLEGAhH8k15AdbRxK3WA1EMKEwLH4=
X-Google-Smtp-Source: AAOMgpd2G11Es7bt1ceR57hBjMCaiur1tJmPDnVCjW+r/w8Ub5H3Yjmy8roeRIc2BePxcXfuSkNgcQ==
X-Received: by 2002:adf:ebc3:: with SMTP id v3-v6mr1340432wrn.33.1530704281239;
        Wed, 04 Jul 2018 04:38:01 -0700 (PDT)
Received: from arch.localdomain (x590e846b.dyn.telefonica.de. [89.14.132.107])
        by smtp.gmail.com with ESMTPSA id n23-v6sm2800111wmh.6.2018.07.04.04.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 04:38:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8188eu: rename Hal8188ERateAdaptive
Date:   Wed,  4 Jul 2018 13:37:41 +0200
Message-Id: <20180704113741.25358-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180704113741.25358-1-straube.linux@gmail.com>
References: <20180704113741.25358-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename header and source file to avoid CamelCase.

Hal8188ERateAdaptive.h -> hal8188e_rate_adaptive.h
Hal8188ERateAdaptive.c -> hal8188e_rate_adaptive.c

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/Makefile                              | 2 +-
 .../hal/{Hal8188ERateAdaptive.c => hal8188e_rate_adaptive.c}    | 0
 .../{Hal8188ERateAdaptive.h => hal8188e_rate_adaptive.h}        | 0
 drivers/staging/rtl8188eu/include/odm_precomp.h                 | 2 +-
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/staging/rtl8188eu/hal/{Hal8188ERateAdaptive.c => hal8188e_rate_adaptive.c} (100%)
 rename drivers/staging/rtl8188eu/include/{Hal8188ERateAdaptive.h => hal8188e_rate_adaptive.h} (100%)

diff --git a/drivers/staging/rtl8188eu/Makefile b/drivers/staging/rtl8188eu/Makefile
index 033fb2e6950d..aa6ea65d05fe 100644
--- a/drivers/staging/rtl8188eu/Makefile
+++ b/drivers/staging/rtl8188eu/Makefile
@@ -24,7 +24,7 @@ r8188eu-y :=				\
 		hal/rf_cfg.o \
 		hal/pwrseqcmd.o \
 		hal/pwrseq.o \
-		hal/Hal8188ERateAdaptive.o\
+		hal/hal8188e_rate_adaptive.o \
 		hal/hal_intf.o		\
 		hal/hal_com.o		\
 		hal/odm.o		\
diff --git a/drivers/staging/rtl8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
similarity index 100%
rename from drivers/staging/rtl8188eu/hal/Hal8188ERateAdaptive.c
rename to drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
diff --git a/drivers/staging/rtl8188eu/include/Hal8188ERateAdaptive.h b/drivers/staging/rtl8188eu/include/hal8188e_rate_adaptive.h
similarity index 100%
rename from drivers/staging/rtl8188eu/include/Hal8188ERateAdaptive.h
rename to drivers/staging/rtl8188eu/include/hal8188e_rate_adaptive.h
diff --git a/drivers/staging/rtl8188eu/include/odm_precomp.h b/drivers/staging/rtl8188eu/include/odm_precomp.h
index c01714be141f..f00967fd9599 100644
--- a/drivers/staging/rtl8188eu/include/odm_precomp.h
+++ b/drivers/staging/rtl8188eu/include/odm_precomp.h
@@ -26,7 +26,7 @@
 #include "odm_debug.h"
 #include "odm_RegDefine11N.h"
 
-#include "Hal8188ERateAdaptive.h"/* for  RA,Power training */
+#include "hal8188e_rate_adaptive.h" /* for RA,Power training */
 #include "rtl8188e_hal.h"
 
 #include "odm_reg.h"
-- 
2.18.0

