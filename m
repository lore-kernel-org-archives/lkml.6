Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDC7C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660C32177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJ03L7XD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfA1Wfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:35:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43979 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfA1Wfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:35:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so19904920wrs.10;
        Mon, 28 Jan 2019 14:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TrALtjK5VfQJXLM+noL+eRhCYVQ0l+5KwWNGeNwvD0=;
        b=qJ03L7XDrgyYkc/aj/jLu6NnmCt24qMLraxKCmOxeOXp8wWa8hd6L+NBITwoJ0donr
         1MVD9IBdF5WSJBexWFNsq2R/4cE19IgKqZAiG1L3kkz1rTu6H2heLO5JQPW0RvT+ibny
         5fzwnHqZ77BS14GF9HZr0BSw0fD+2hUfKD+geBukCPHEhwH9msyec0wzc4HWndlSMs8Q
         D94YYuWo5CJBBrFMjl3lQpel59ZaJ8Y8nlZzDzhRVNJVjW/ocFvX37wF7QnsxAdbHJ/C
         07ZntzQseC3r7TI6o50rL4vmI1nAgsx5j0Dj690FVSCl5dEjfBaZHTN1tLlDCN83oxQW
         9zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TrALtjK5VfQJXLM+noL+eRhCYVQ0l+5KwWNGeNwvD0=;
        b=r3VTzPfFtPLrn3hmTMt14mQI25LRQHkhZHo9f5mAuhwzzTgUp6zy1caZwLeY04EEWi
         6pMNjK4RoLqQeKBcSn7ybEt7gmNdzhHZXs2UI+63i8x7c2/6RKUXyXM/55rSjjgz9XQ+
         zQVcoukfk55sVqBGzWqX/RiYh4g19X+/J8sGLIFPYHt1x4nMURvgoJdUVyblfy5JuHh2
         +rEKiexvCaXeLInqcOtU4481EvXiZRTCQm/DTqosDkghIIJ1LzryNTM13MRLYvNVf9Vb
         aIiZYUWGHRGFhHkpbXguiyGOIGUwCgDfbeOQwv5/01q+TJkaO1b6hAIEgTW4HcCVZLqo
         KQMw==
X-Gm-Message-State: AJcUukcbbAAF3RDWktaWLHp8mpSQOip3+Kdp9yMFgqraqXnoRgxm7b40
        TWOienoJKBXGZRYt76wwldk=
X-Google-Smtp-Source: ALg8bN5dCnJy0Q8vUXfM/10/WRekOKJiKac+KCGvETwHMy/BivdcImQRkNBrEbpZ+f/1njCHF7/Okw==
X-Received: by 2002:adf:f605:: with SMTP id t5mr21831988wrp.229.1548714929708;
        Mon, 28 Jan 2019 14:35:29 -0800 (PST)
Received: from voyt-hp.fritz.box ([2001:16b8:a0d8:9300:66d8:3ba:de17:f9bf])
        by smtp.gmail.com with ESMTPSA id p5sm414641wmh.16.2019.01.28.14.35.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 28 Jan 2019 14:35:29 -0800 (PST)
From:   Dmitry Voytik <voytikd@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dmitry Voytik <voytikd@gmail.com>
Subject: [PATCH] pinctrl: mediatek: fix dependencies for PINCTRL_MT76XX
Date:   Mon, 28 Jan 2019 23:35:21 +0100
Message-Id: <20190128223521.2690-1-voytikd@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How to reproduce the problem:
$ make tinyconfig
$ make menuconfig
then enable:
 CONFIG_COMPILE_TEST=y
 CONFIG_PINCTRL=y
and any of these:
 CONFIG_PINCTRL_MT7622=y
 CONFIG_PINCTRL_MT7629=y
 CONFIG_PINCTRL_MT7623=y

This combination causes build failure.

Fix the problem by making PINCTRL_MT76XX to depend on CONFIG_OF=y.

Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
---
 drivers/pinctrl/mediatek/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 1817786ab6aa..a005cbccb4f7 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -45,12 +45,14 @@ config PINCTRL_MT2701
 config PINCTRL_MT7623
 	bool "Mediatek MT7623 pin control with generic binding"
 	depends on MACH_MT7623 || COMPILE_TEST
+	depends on OF
 	default MACH_MT7623
 	select PINCTRL_MTK_MOORE
 
 config PINCTRL_MT7629
 	bool "Mediatek MT7629 pin control"
 	depends on MACH_MT7629 || COMPILE_TEST
+	depends on OF
 	default MACH_MT7629
 	select PINCTRL_MTK_MOORE
 
@@ -92,6 +94,7 @@ config PINCTRL_MT6797
 
 config PINCTRL_MT7622
 	bool "MediaTek MT7622 pin control"
+	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	default ARM64 && ARCH_MEDIATEK
 	select PINCTRL_MTK_MOORE
-- 
2.20.1

