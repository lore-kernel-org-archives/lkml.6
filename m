Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,TVD_PH_SUBJ_META1,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACA3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7618F222DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDmkFJJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403972AbfBOWkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:40:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38921 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393866AbfBOWj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:39:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id z84so4099288wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 14:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QQX9lLr5Bx8cu+UN8IcOnqq7nuwuG6u18wYqC9vM+Gs=;
        b=FDmkFJJ3/YereI0eWOOqncLVfrsamjMhOPNGlLNplacJMoXeEiGn3WxEdn0zPOb09f
         kG7QdAuyD8N7vUQ8hI09th/7dnVR2ilkooXXCqvpnRycDPAFtNfTpbsxkK62EjlH88Ko
         CV3SEac7VyldUPLKsUtaOkmfZVMcY4Ff2iwjh3OvVPzi/mJUMeLZGtwIRkK8KC1hT98+
         oleLr7qQxdjpC8JxdaWr/uFMpwht4sNpqhfgDq28DtVIsKAwLZ8p/NF/gBjiUmlRDTQ8
         g+M8u1JnzBTMbJnMMzJ7bZxBIJv4CCAHExRtmT3+7lF/aEDivu9oaSG8+BjlhhG6wc8+
         eBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QQX9lLr5Bx8cu+UN8IcOnqq7nuwuG6u18wYqC9vM+Gs=;
        b=QmPG67HZeNM5+OyBhK2loJKjtH1Z6+B6XIkvF7tRe3ZBDssDK+PHpmPxGJ/4YmLCVe
         aoXjMFjZDpPjJzm+ntZbYFdo/0YMldGImXTNZBRhGlDN3v2VutqhSul2uAJ7k79TSrgt
         X4+9XKwNimOUC1lu6MY19HWJ8TG7Z7QOAhlCijsqzCOzvaLXGWJRm8gWmvtwYDe8wZ5J
         z8tra6hCwWP8TaFCxtUu2S0QDyyKq4aAjdHAFdNHm8zRMewvwYdxuy0S3pydf4lQkTAR
         Ag7zHvyWDFNVDN+nVPaL3CtO2RYhh/mdFXgCD+C7zPmJOGWtXb3zbxxsHLEj/EzO2ESf
         898g==
X-Gm-Message-State: AHQUAub5gwcsJhdTjYmd6GetoOHrmYygst3aS5iL70v8pd4ZXY3Y7+2m
        pjfMQjwRq+p2OkG1GFWFgcWBeHuD
X-Google-Smtp-Source: AHgI3IZG4II89AroEGIroJk4kPkrYQD0pDsJq4aiVw3BR2ylSYXMG/NFlqF0GLvHAsT6sH5dBziXZw==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr8427366wmh.87.1550270397488;
        Fri, 15 Feb 2019 14:39:57 -0800 (PST)
Received: from goyamonster.habana-labs.com ([31.154.181.186])
        by smtp.gmail.com with ESMTPSA id b197sm14652609wmd.23.2019.02.15.14.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:39:57 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, olof@lixom.net
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v6 15/15] Update MAINTAINERS and CREDITS with habanalabs info
Date:   Sat, 16 Feb 2019 00:39:25 +0200
Message-Id: <20190215223925.16351-16-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190215223925.16351-1-oded.gabbay@gmail.com>
References: <20190215223925.16351-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The habanalabs driver was written from scratch from the very first days
of Habana and is maintained by Oded Gabbay.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 CREDITS     | 2 +-
 MAINTAINERS | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index e818eb6a3e71..03f3d67126fc 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1222,7 +1222,7 @@ S: Brazil
 
 N: Oded Gabbay
 E: oded.gabbay@gmail.com
-D: AMD KFD maintainer
+D: HabanaLabs and AMD KFD maintainer
 S: 12 Shraga Raphaeli
 S: Petah-Tikva, 4906418
 S: Israel
diff --git a/MAINTAINERS b/MAINTAINERS
index 9919840d54cd..ac6fde220d2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6647,6 +6647,15 @@ F:	drivers/clocksource/h8300_*.c
 F:	drivers/clk/h8300/
 F:	drivers/irqchip/irq-renesas-h8*.c
 
+HABANALABS PCI DRIVER
+M:	Oded Gabbay <oded.gabbay@gmail.com>
+T:	git https://github.com/HabanaAI/linux.git
+S:	Supported
+F:	drivers/misc/habanalabs/
+F:	include/uapi/misc/habanalabs.h
+F:	Documentation/ABI/testing/sysfs-driver-habanalabs
+F:	Documentation/ABI/testing/debugfs-driver-habanalabs
+
 HACKRF MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-- 
2.18.0

