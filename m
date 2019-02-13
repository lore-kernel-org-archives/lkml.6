Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC074C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F45A222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025253;
	bh=3no22EYmO/OKYwLuELznf5xGue0RcVmh4wtJQU+P8Cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OFKX5X11FbGPdEMwkSyT8m6U9q+eYn+xjQzvLdn2tb11HUE7JI086yFHlREZKR20x
	 K7UgKLUV9h7c8kweT9cDOGnagx7hbRsErwVtClRQz6tKPTmAopXiNOGty1mXjVb5AN
	 JcpfVuBFEvuWDDF+cqNJBHXM4bVpEBb95FTSqZNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbfBMCeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:34:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387599AbfBMCeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:34:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EC74222CE;
        Wed, 13 Feb 2019 02:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025246;
        bh=3no22EYmO/OKYwLuELznf5xGue0RcVmh4wtJQU+P8Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4D/h32LtTGMnvVXA8Xcl+PHp3mvDMZeG3xNpd0BYUOrftZAazH3X6TSJQaUeWtXD
         /GRZTe6Zchw0U4AjS+BVB0haZG95JU9hJuI8RVXvc8j2/xwVERTOL3yXPwYUN6nhZN
         CHDIglrH+FBuZcYjC1UtL5q6x7MMya+epYopdvNY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Michael Cook <mcook@mackal.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 029/105] hwmon: (nct6775) Fix chip ID for NCT6798D
Date:   Tue, 12 Feb 2019 21:32:20 -0500
Message-Id: <20190213023336.19019-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 264142bc70ec039e26d8f3b46a717e8037f59ca0 ]

The chip ID is 0xd42[8-f], not 0xd45[8-f].

Fixes: 0599682b826f ("hwmon: (nct6775) Add support for NCT6798D")
Reported-by: Michael Cook <mcook@mackal.net>
Cc: Michael Cook <mcook@mackal.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index c3040079b1cb..8f91e366866f 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -44,8 +44,8 @@
  * nct6796d    14      7       7       2+6    0xd420 0xc1    0x5ca3
  * nct6797d    14      7       7       2+6    0xd450 0xc1    0x5ca3
  *                                           (0xd451)
- * nct6798d    14      7       7       2+6    0xd458 0xc1    0x5ca3
- *                                           (0xd459)
+ * nct6798d    14      7       7       2+6    0xd428 0xc1    0x5ca3
+ *                                           (0xd429)
  *
  * #temp lists the number of monitored temperature sources (first value) plus
  * the number of directly connectable temperature sensors (second value).
@@ -138,7 +138,7 @@ MODULE_PARM_DESC(fan_debounce, "Enable debouncing for fan RPM signal");
 #define SIO_NCT6795_ID		0xd350
 #define SIO_NCT6796_ID		0xd420
 #define SIO_NCT6797_ID		0xd450
-#define SIO_NCT6798_ID		0xd458
+#define SIO_NCT6798_ID		0xd428
 #define SIO_ID_MASK		0xFFF8
 
 enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3, sf4 };
-- 
2.19.1

