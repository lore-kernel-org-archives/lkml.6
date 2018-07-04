Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF86C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CED21BC9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dugd5MYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CED21BC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933642AbeGDLiA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:38:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51428 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932717AbeGDLh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:37:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so5491365wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yDcKfICg1szzLhxS6cLmZ2I7qVOF/hevt2sR0tIgwxk=;
        b=dugd5MYjzQ/wKKoT2SChgzcqrbUa4vqvHjw+NQSN3MjtNw3joL4BCQXCdxEEYncPNl
         zMLrbOEQnsDajstVd50q0m86UrTnXuNX9F2qHkDqGer/TamLlicdZCrd+HN0hwNSZ1sI
         NKUwIQGEbSFBFp+rHq/4dYEj9iSg8jt7MEVOZBsy/owDbSEr4laXcDmThA1/eoRP3W4F
         5kGhWSx/rSK57+UeKL9w618rKK3ezkX5W1rF63BNWk6rfogmK3MYYH2btf+ujobjZagA
         MykFXYFZMKA/iheGQjXX0zixaT7saHqOaqAn8GzteYvTwP7S7v7M+n/mLmbWfOZ8hmb/
         c55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yDcKfICg1szzLhxS6cLmZ2I7qVOF/hevt2sR0tIgwxk=;
        b=d4kGWEw/d3wIyFoW7zVW1ko29WZDY+CzqWVe21QrRX3y2z+RdGUsfGq9dLstb0vUcm
         IA4vGnbhrv1KfhAiJEYrHOB8lB5tnxVtJDjV7sKtKQuAJ8tb44QTTpqh4PsPv3aF7OkC
         YvsN4dS4Cb/VsP8g7J47FOTNkLK6oDpdKLWmEEFGNo9nINCOUvd1+XZfwfwgcSnvadq0
         O3PjyXWyqUVVnl68rdpzgpr7T3/xYr+Yfn8hHHU71mjtD/an4Kip9FtvSlh3nzdwF4F1
         YfDgqVePXrI29gAUpv9WJMiMwzChswzJ3tAKqFfd/TXf7+a5BepvNeGfVRSZYHiaelHn
         QT5Q==
X-Gm-Message-State: APt69E1MZZkt+GAjYywUg+mXHfvxIltw9XaPXpoaI1vBTgGNEfe0egE2
        +QR6jc2Cb6CjUk0e6Dfoqo4=
X-Google-Smtp-Source: AAOMgpcTiOciQDbv24ysrw9XYMI7zYtJh00V/rRxLy5WRlRh0re5+cdRy84zk87671rIO7CCfKStbQ==
X-Received: by 2002:a1c:dc1:: with SMTP id 184-v6mr1344338wmn.145.1530704278083;
        Wed, 04 Jul 2018 04:37:58 -0700 (PDT)
Received: from arch.localdomain (x590e846b.dyn.telefonica.de. [89.14.132.107])
        by smtp.gmail.com with ESMTPSA id n23-v6sm2800111wmh.6.2018.07.04.04.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 04:37:57 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8188eu: rename Hal8188EPhyCfg.h
Date:   Wed,  4 Jul 2018 13:37:39 +0200
Message-Id: <20180704113741.25358-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename header file to avoid CamelCase.

Hal8188EPhyCfg.h -> hal8188e_phy_cfg.h

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../rtl8188eu/include/{Hal8188EPhyCfg.h => hal8188e_phy_cfg.h}  | 0
 drivers/staging/rtl8188eu/include/hal_intf.h                    | 2 +-
 drivers/staging/rtl8188eu/include/rtl8188e_hal.h                | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/staging/rtl8188eu/include/{Hal8188EPhyCfg.h => hal8188e_phy_cfg.h} (100%)

diff --git a/drivers/staging/rtl8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h
similarity index 100%
rename from drivers/staging/rtl8188eu/include/Hal8188EPhyCfg.h
rename to drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h
diff --git a/drivers/staging/rtl8188eu/include/hal_intf.h b/drivers/staging/rtl8188eu/include/hal_intf.h
index 5a706818d079..e5be27af7bf5 100644
--- a/drivers/staging/rtl8188eu/include/hal_intf.h
+++ b/drivers/staging/rtl8188eu/include/hal_intf.h
@@ -9,7 +9,7 @@
 
 #include <osdep_service.h>
 #include <drv_types.h>
-#include <Hal8188EPhyCfg.h>
+#include <hal8188e_phy_cfg.h>
 
 enum RTL871X_HCI_TYPE {
 	RTW_PCIE	= BIT(0),
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
index 54d34976c721..e04e97e98ab7 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
@@ -11,7 +11,7 @@
 /* include HAL Related header after HAL Related compiling flags */
 #include "rtl8188e_spec.h"
 #include "Hal8188EPhyReg.h"
-#include "Hal8188EPhyCfg.h"
+#include "hal8188e_phy_cfg.h"
 #include "rtl8188e_dm.h"
 #include "rtl8188e_recv.h"
 #include "rtl8188e_xmit.h"
-- 
2.18.0

