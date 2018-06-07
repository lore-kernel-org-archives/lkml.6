Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Uik8OFKLGVvsWgAAmS7hNA
	; Thu, 07 Jun 2018 19:45:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 851306074D; Thu,  7 Jun 2018 19:45:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gX1zQAGp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BC04B601D2;
	Thu,  7 Jun 2018 19:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC04B601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbeFGTp0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:45:26 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34064 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932642AbeFGTpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:45:10 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so11034561wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=sszc6qeEZoNbWImzwUGcyXXnJKHgmugDqwWhgTjCJLU=;
        b=gX1zQAGpO+h8IPJBJErOIMjXDAFsVuStjn0NcaRt1Fn9uQfT5Q11Civ2d265bi63VL
         j3rjdmsel+bWBqvtA12m88JNY86dm3HCUTEL3l5LNNxkuRk2MaLTr0QUJf6g6RxwoH4U
         BaNJJq5MHCbvCS5mhhF27aUzX+sIPe2/+PQS4ix/ATozYqR0aSWzjm35JLLu5IegyzZS
         iCfGbNJ/Xgjf9blfFq8AR6O+X3hWSgGr0tmLy64KIqgY6AMyOgrExej8zwP7XDEACgI2
         fXCjyoaEpRK6rPcwlC5ya80QO34nWBxQNxTykg6MMQBD7cRn1YOgboDy8odwkpiQXFEn
         q2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sszc6qeEZoNbWImzwUGcyXXnJKHgmugDqwWhgTjCJLU=;
        b=ZQcDV8ndgN53NcVr9issV/z1lcT2eFgN3qub0Xd58UBwkWLir2MQ99+G6XLy3QYcj7
         24AA5admxFs/EvG265wbbkvbvxt2IH7rJM1d0qjdgcW1sUsbgahaN5lG/MAZZgK3vPXH
         F4Yk80kZQ5hLXv3NYFnqDGKFtf3hXYdHm/Db536d8g2PnsnVJ4a4xhFHhUPifLqHKnz8
         IBaxdX7zE1PJA7oaW1uv0Es0Qui/5lCitNnQD1Bty60CHLiHXXntQ4n66EzQRgAtkAM8
         WaVw1nbIsIlg5JCnMKNnWw3cWoZdScKL1LNoOtQW+qT/Xm4L6GibvDagiQHUCA0UEs/W
         8osQ==
X-Gm-Message-State: APt69E2sDXDC72kqPO3UUkHUZFyS9uOVViBy/r06coKIpiMLxwFFKSp3
        K1iHiKrKoAxR401aHabO3DWKcg==
X-Google-Smtp-Source: ADUXVKJXYEpykZOhwwStB297rx3KhH3fWVKIfCqP464PwMfigPyGKG4ShwKx8ER+VhvznomDBOyr/A==
X-Received: by 2002:adf:eccd:: with SMTP id s13-v6mr2956078wro.160.1528400709609;
        Thu, 07 Jun 2018 12:45:09 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id n56-v6sm67841749wrn.72.2018.06.07.12.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 12:45:08 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: geert+renesas@glider.be, jroedel@suse.de, horms@verge.net.au,
        magnus.damm@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] iommu/shmobile: Remove unused include/linux/platform_data/sh_ipmmu.h header
Date: Thu,  7 Jun 2018 19:44:56 +0000
Message-Id: <1528400696-32609-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/platform_data/sh_ipmmu.h is unused since commit ae50dc4874c5 ("iommu/shmobile: Remove unused Renesas IPMMU/IPMMUI")
Let's remove it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/platform_data/sh_ipmmu.h | 18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100644 include/linux/platform_data/sh_ipmmu.h

diff --git a/include/linux/platform_data/sh_ipmmu.h b/include/linux/platform_data/sh_ipmmu.h
deleted file mode 100644
index 39f7405cdac5..000000000000
--- a/include/linux/platform_data/sh_ipmmu.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* sh_ipmmu.h
- *
- * Copyright (C) 2012  Hideki EIRAKU
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- */
-
-#ifndef __SH_IPMMU_H__
-#define __SH_IPMMU_H__
-
-struct shmobile_ipmmu_platform_data {
-	const char * const *dev_names;
-	unsigned int num_dev_names;
-};
-
-#endif /* __SH_IPMMU_H__ */
-- 
2.16.4
