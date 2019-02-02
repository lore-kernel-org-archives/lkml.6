Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFE9C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B5F21479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="vRdP6HIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfBBGYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:24:36 -0500
Received: from tomli.me ([153.92.126.73]:45102 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbfBBGYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:24:35 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Feb 2019 01:24:22 EST
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 2477a273;
        Sat, 2 Feb 2019 06:17:53 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:7b76:77ab)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 02 Feb 2019 06:17:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=8VKQSE7QUu2B2RUs/34CkwDT/6pGZ5n0b6W1DBUTy74=; b=vRdP6HIbOCtPI/IkULgEE9MZ/tj6P9Dyj+cI9kaxY5Me5LVI8wex2PONOKTT7KbviQJ1sPXpGHxip10aV69WyRPC+tSn+tLEKKC58d0Fw5Bp7Bw4M3WEmNzATuH4JmHFi0bGmSdTQREy2en2KemfT0KX8qIV46AbQTuTK5rEM1grpJT6afGpAgSKtbSszqdmLSN24qTDIu2suh7A+FB8jHsmzL4Uy1slCAEjL1FyaBxwoKiyRlziGZrs3eMdgFhAFbNqXok2rW4n0f4P8XgpPapBKX8ZRHMvvycGMnjbQYHtjZKoycj4WyjbdG8im9P4WqBJ6l8/ld/RUTmXfmk4Zw==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 7/8] fbdev: sm712fb: Kconfig: add information about docs.
Date:   Sat,  2 Feb 2019 14:16:47 +0800
Message-Id: <20190202061648.30374-8-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202061648.30374-1-tomli@tomli.me>
References: <20190202061648.30374-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits update the Kconfig description of sm712fb,
and inform the user about the existence of documentation.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/video/fbdev/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ae7712c9687a..4f3c0075352a 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2302,6 +2302,10 @@ config FB_SM712
 	  called sm712fb. If you want to compile it as a module, say M
 	  here and read <file:Documentation/kbuild/modules.txt>.
 
+	  Warning: this driver has many known problems and limitations,
+	  please make sure you've checked the documentation, at
+	  <file:Documentation/fb/sm712fb.txt>.
+
 source "drivers/video/fbdev/omap/Kconfig"
 source "drivers/video/fbdev/omap2/Kconfig"
 source "drivers/video/fbdev/mmp/Kconfig"
-- 
2.20.1

