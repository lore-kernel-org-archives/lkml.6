Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FF4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB4B20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSgirm/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB4B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeIDQVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:21:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32884 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbeIDQVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:21:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id b92-v6so1540859plb.0;
        Tue, 04 Sep 2018 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dlfSQFDwzKOSjnjxyCTv1Vk+WCVtxFvV9WTaMiQMTaM=;
        b=WSgirm/s8BWwEXCznoI2hynvaeceOGMeJ0Q/MVojbKNDjpLtC60qao2EcW8Oc0raxA
         3dqOvGtQxykEEkp+Z9vxDlkWRrV8EzIMos3fwMHnY/PeNYwT7HuobYmMkoVGx202zXvL
         bn6N12g23nzx0rxVOYPyPRDMX7RNt/qNPAI9YP6KP2GF9muY+ciCqS/q3Oe6opB73qpT
         XnXEkKGIGwFxB/SeEc8e4iUzhBzoZTruPKgMofYSHBsCOk+Nw6KmpJKiMT2XNL3gRPmG
         fNn0SQ+WSQJxL5hKzjCNwv6A23pdnteQiMlGuDgg7/cw5V+9WIgy7IbIYlLs7yPDmixC
         BD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dlfSQFDwzKOSjnjxyCTv1Vk+WCVtxFvV9WTaMiQMTaM=;
        b=se/tRjS0GDrxsIKU0yg+afhomOAcHAH2nGHBZxoPElp+jfu7b2EQfSUflp4Z/6DNjS
         Dl9ohzUVUxI+xVqs5uQZVZoPzW4GGDtSbAjv9DJR85IUFm6YoO76gdlEkj/LRjAsVK+o
         8fwtUupbPB8j24j0iOwZBTMXL+DUOeOQhV+jR+WWSK0z/cUBm4WR8Af6yEWdZ86lJeBR
         5vgGbYGwkpVnGGQj4xQmRqH/+9rpj4VW7rklqVfo2Eh24SOwMMXV7ZVN2XjPM6sRxjJV
         pZVIHe0icemfUpop+BzqO7Yz5rtbe7ybwkQjURgKJQpBJzTf5DVeBq87JlsB05hpKnQA
         bvlg==
X-Gm-Message-State: APzg51B4136lpcCnKr1hBnTM8nOHlnmcGZU6q7Ysqjm67Wh3RYCr5KeC
        WPtWO/AgYDDHOpCgZzCb3HZ2pQyW
X-Google-Smtp-Source: ANB0VdZbhBOMIhxm0F65dyYzAnaXbKct3jlmuSM7bXH9tz0FjeECY0A4eYgDDLh0fUGnzExG0+0HmA==
X-Received: by 2002:a17:902:b60b:: with SMTP id b11-v6mr31952542pls.301.1536062171037;
        Tue, 04 Sep 2018 04:56:11 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id u184-v6sm29740190pgd.46.2018.09.04.04.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 04:56:10 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH v2 15/15] MAINTAINERS: Add entry for Marvell OcteonTX2 Admin Function driver
Date:   Tue,  4 Sep 2018 17:24:50 +0530
Message-Id: <1536062090-30446-16-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Goutham <sgoutham@marvell.com>

Added maintainers entry for Marvell OcteonTX2 SOC's RVU
admin function driver.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e178f2b..38f874c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8748,6 +8748,16 @@ S:	Supported
 F:	drivers/mmc/host/sdhci-xenon*
 F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
 
+MARVELL OCTEONTX2 RVU ADMIN FUNCTION DRIVER
+M:	Sunil Goutham <sgoutham@marvell.com>
+M:	Linu Cherian <lcherian@marvell.com>
+M:	Geetha sowjanya <gakula@marvell.com>
+M:	Jerin Jacob <jerinj@marvell.com>
+L:	linux-kernel@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/soc/marvell/octeontx2
+
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev@vger.kernel.org
 S:	Orphan
-- 
2.7.4

