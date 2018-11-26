Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D29C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EAD2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1zgxT6p/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EAD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeKZTJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:09:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45565 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeKZTJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:09:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id v6so17816983wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NGqFs2PFaLlGrGO7grCWGkhmYr5kPA8K8eAuGVHnppo=;
        b=1zgxT6p/aIGtBiI5xjby6ate96hQl2CzVHFfo43WG+/mb56LdssSLdh/zSJ0r4yfNa
         sbr2I3k4JTe3Q1NC1XDIjkLGwcpRY5yINBmNEB7Qs/ng6epWtbY6mtldXvbhsHl+GBqo
         LZKPV3bxrAfFkVD3tbw/Yeg78a82utVx8M+KiuaPyT+9F8C00+afrknx+rFdCHHbhE0+
         lBuErZp1Zf9HadLJFkS3Idu/7sTH7l3lmhvDkmKruuWsVXgQwmu1fGLe6jiVLIzyzqiq
         bVl7yisq5oHKsTASrMUBDL0dj/TosZ7KMyOemWdgEqrk/QfWnFFdMLtxnBUO5qqK+kse
         Wnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NGqFs2PFaLlGrGO7grCWGkhmYr5kPA8K8eAuGVHnppo=;
        b=QmLPIW0W3ZTVbCAn4iwZstqu00VrRcTP+hqvT363sj16D1/8wAbPtWinDvHxk3o/iQ
         ye1M4xTmnuejlpWSE1RznQF7ZdLWbEHoPCZf1sS5325o6cwm2Q6cB12a4bYE7iUyXgJm
         lsx3F17BrE/KmC/Xr8CZHKAo1WNDBiJt5shytsvnlNC0F8QHz1Nui3AXzakBsApkRD+i
         8QxGd1nRu2hGAsZ86hDynu7qke9t4rFJJYnIPIeT/T1/473OGNACIXK/bMwn0vATbutY
         lXEaEW591/x77ITOSpvHZBBJGhhxp57gZQGrZZqrZhRb2gK6QScXLyPrVkSBQt/Av2yQ
         i7Mg==
X-Gm-Message-State: AA+aEWb4Y8xpjsHVe65t4T/+ORcQE6g21FVth++0xvKW5qVAANiYDMVq
        /RPE/eoyOM/qynbf5LofFd82UA==
X-Google-Smtp-Source: AFSGD/XfAEPbICqhVjpn8q0v8Qm3oWs7hFwy2e/GNMyEaE6MflXaekV1+YhR8hat/MqZIv4zWKMYrw==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr21943294wrw.310.1543220160895;
        Mon, 26 Nov 2018 00:16:00 -0800 (PST)
Received: from debian-brgl.home (lfbn-mar-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id b10-v6sm39988564wrt.49.2018.11.26.00.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:16:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] MAINTAINERS: remove a duplicate entry for gpio-mockup
Date:   Mon, 26 Nov 2018 09:15:58 +0100
Message-Id: <20181126081558.32175-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I'll be getting all GPIO e-mail now, so remove my name from reviewers
of gpio-mockup.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 380e43f585d3..021c73808212 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6299,7 +6299,6 @@ F:	drivers/media/rc/gpio-ir-tx.c
 
 GPIO MOCKUP DRIVER
 M:	Bamvor Jian Zhang <bamv2005@gmail.com>
-R:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-mockup.c
-- 
2.19.1

