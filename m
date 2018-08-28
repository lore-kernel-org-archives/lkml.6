Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A81C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664AD20891
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRXYVNm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664AD20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeH1Ote (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:49:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33093 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeH1Otd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:49:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id t14-v6so594266pgf.0;
        Tue, 28 Aug 2018 03:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HUicNyteihh7HJkj21xqDZIVHQIldxZ6evsDsB/1yeY=;
        b=kRXYVNm7puehOXGHn4rCQ/d4MBzKc+u5YSeWCK0Lx0ZoyUbGB0zK30dHa9ftEBY6c3
         i7rYGCWsYDgIPXEZgqcxOZJqV06W4EWW8OoQVZS2OQZTig4MQjQbEkkOCslphJBaLdO1
         um9tgVxt+tXJhELIy0phYv49yiMwURu6ctixTT3D6wz0OKiX+zvugow7i1xB1bXchist
         VbKffwg+s9IOHbv3WaTbNckv9dvc8Zl0PxUdY5qienF2f7j2dWV61FnV8QIgPQs3AHUT
         DI8paS2pApiU+kFkjcO3vd1YQ0ZYwFyz3SAKsbEQy0hOLtnmKob+OzVcSQ6jYUZ6hm2z
         EpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HUicNyteihh7HJkj21xqDZIVHQIldxZ6evsDsB/1yeY=;
        b=W4Dm0WDXSVTjPykbhY0k7Oy05+Dqry6EOH8xwxR7pgALDnYq0LF/mN7saQ72PzRZjR
         Sf+UWq6CwNUpsD5sAB3sruMnP0GAIWiuo7uWWSYzi0LlMV9S0jmwKylQZfsJTl47Ci0g
         4KPY/XpScxwPEXfnrPd6/HNZwf3LpsyAs4nfoGxcotdWb7djGJHSl3uZ79nYEPqB8O7P
         ay8+unDLLKITxbgHP8tBeBkJeohOvSP9d4Y/cgYorZgy/ncy9Qhvz7lYDXA2C1tHAHEX
         BN7Hwd5lcRv3py+56jzUtzCBnm5GFKDYCNLMe3O8BEv04NwsopFnrFy0KII7Brd/jENk
         XtJA==
X-Gm-Message-State: APzg51CioIp5VeKDmeOp8aJwVCAxpJmXPlwzvMwprrTUhjz8J/xiHyTp
        uUHmIlMPCPDrvJskWN+Nqc4Vy8qN
X-Google-Smtp-Source: ANB0VdZZdJEbe5VSieb4Kyq/5NEsdJEz8ln7Nh5SYKdiB1gRpn7ogE9VfacpXNPV9ODZusJMCzYWtw==
X-Received: by 2002:a63:4a09:: with SMTP id x9-v6mr1002184pga.34.1535453907152;
        Tue, 28 Aug 2018 03:58:27 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id n22-v6sm2946798pfj.68.2018.08.28.03.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 03:58:26 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH 15/15] MAINTAINERS: Add entry for Marvell OcteonTX2 Admin Function driver
Date:   Tue, 28 Aug 2018 16:27:18 +0530
Message-Id: <1535453838-12154-16-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
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
index 8bef28b..99ef6c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8821,6 +8821,16 @@ S:	Supported
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

