Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F06C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5026C20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="M+NNZM9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfBEIca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:32:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50985 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfBEIca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:32:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id z5so2587609wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 00:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8g1XLIE6fTtgeGNFN37ZGEI5BE8leclv0hOaGRovJHI=;
        b=M+NNZM9M3zECd5jE5pkYjg/gpAybKERmTb7UWnFIacrAdKhHvR766NaBaZceX7roE+
         3ggK4CIBN7qQhehWhY97pN8539ZMS5jVTsVMFd6FULML7mb3VOEqouk/N/JF7k6ctmS6
         GBi8A9vJXwnt0QHMiikolydK/VZFogd1Eb59+Iwrj6kFiwIJ/84OBcgrb/cQqZ/SmXm9
         w3TQrm7SdsXsmX2Iw3WsaZ1Zk+JitmmK4Wki3nWKf3tIv8o+B66mbBDfgj63OUl1E625
         xwnC2Qrv4NbY/WqQMk//hz9ZWsMXNC6Uex1XUdoXLBgc9kli+NTwRp3pfxAAgOHiKCro
         EZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8g1XLIE6fTtgeGNFN37ZGEI5BE8leclv0hOaGRovJHI=;
        b=Q0GpPju0F26jMGvYPGV3YyHBxL7K4KszCM1C4fkRwQ0U9dMSNUSxddZKqUuX1Ypsmv
         iJ24BR47neJ48+ZQTo3R4u30YpFZio4+yOaH/q9jNpskxEHDfWm9miP8u7q0U9pCakLg
         2dI2OPUuyYsBHTlj9RQBoXBKTHhf7aGMtTocn58MDLIvZLHFYI4zCe9FKi9wAi08BQD5
         d1HUVpES4857QEw1Q9bsPmtZRUZt8INyfH+ZL3179Cg1nmcBH/a0qPOCINHE07cFtBD8
         TjrFp2ffXnT8siQtTL12iujCzNU+2PDFjjFe/BPhgj9zQhzSlZtISoG1HaYzV1dMkc3n
         apow==
X-Gm-Message-State: AHQUAuZSlcOtF86tVGjhUcztXDWziKntJbCc5L6j3LJxesjtLt20hiIk
        XERN39qgqdVsu/SiNK+SPWrUGg==
X-Google-Smtp-Source: AHgI3IYTunnrPLBBNwEDWXRF7Qhj6QbadQB+yWWbToGIp6lhWW3ZIHHQ4BsXK4H2KMYb6XnrtRItoQ==
X-Received: by 2002:a1c:b455:: with SMTP id d82mr2764956wmf.78.1549355548401;
        Tue, 05 Feb 2019 00:32:28 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id g3sm3118596wmh.20.2019.02.05.00.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Feb 2019 00:32:27 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     vgupta@synopsys.com, abrodkin@synopsys.com
Cc:     linux-kernel@vger.kernel.org, khilman@baylibre.com,
        linux-snps-arc@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/2] arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM
Date:   Tue,  5 Feb 2019 08:32:14 +0000
Message-Id: <1549355535-22052-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549355535-22052-1-git-send-email-clabbe@baylibre.com>
References: <1549355535-22052-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have now a HSDK device in our kernelci lab, but kernel builded via
the hsdk_defconfig lacks ramfs supports, so it cannot boot kernelci jobs
yet.

So this patch enable CONFIG_BLK_DEV_RAM in hsdk_defconfig.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arc/configs/hsdk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 6fd3d29546af..0e5fd29ed238 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -8,6 +8,7 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_BLK_DEV_RAM=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
-- 
2.19.2

