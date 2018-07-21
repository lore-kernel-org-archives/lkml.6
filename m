Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E9BECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8685A20858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsAuKMWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8685A20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeGUNuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37236 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbeGUNuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so9015841pgq.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dDYm/GYvgblowb8y9wEtGkebDS1Mrgd/QdjFu9nk2O4=;
        b=IsAuKMWPuTh/GY6le7UtuiNH9Q6XyvrYkB2rx0WVKSAjjR6/iHub/VMmWNSjZrk4Gf
         7rfTA3zBRecaAI0NBCMdJ4FM7wQvsnaA+mqz1zuZuMZOi8j135M4t+kzYA1k9ClqziJ0
         2ciKEFZvF/9pXJ7MjErplUwRFP2ukfKsacriYhAtRrttdqOk1F1aRUCZkezgt9hBZShI
         Qez0HxCJcLKtVjqR39/v02a+WCbNS1ktOFz1OKJqVhSrpi13Hz4ouqoyqvDqyXcxz97t
         /Dyl1iv5RbEeVHve2wxoO+fE1N2mWwuJ6NkiMu9McqIp2srXMMN6bf01SXY8OSPiXnv0
         cPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dDYm/GYvgblowb8y9wEtGkebDS1Mrgd/QdjFu9nk2O4=;
        b=CyLt1fqQOe9vyZLt8p/QK5CjJQot00TG5P3uEYOKopXvOSsw1bg4uFdlyhw8c6pxEp
         uQOMP28hdN/k4L8TgQFCnm7HTRedOsJlI01/bi9bk6rFkM0Y+SLe56fNQfYtqZg3fnko
         GjyHBRNwFyNSpQDxNMl4NIruF0lpmC/4IFCJa1najlLvJy9pGpohRa+tn5/qEIaUBoLK
         /BA8VNuexeBD8BZ30ussPLnMqDcIAx/Gd5+nBUqPQE4l4l+5IM3uvFdPQ4WWZ329vc/x
         MmkbIJAvRP2NEffA2K+UQ0Rwp8ZJE5YQwzKgYGlvaoEi6QNlw+GlD1EwYINOxcLQ3IbN
         g70A==
X-Gm-Message-State: AOUpUlEbGHfMOlREo6IlcUXFAQ6G1pVHc5ejUL1ANntaBs3zsjrH1j/K
        O7hrxvF08dm+YPS9E3io09w=
X-Google-Smtp-Source: AAOMgpfPQsiSfVv2pjaCheNmxmeZP8HYwHh5GFarP/BeD6RKtHNJ1uAHwQVEK0HZo79jDxRoXMbKLw==
X-Received: by 2002:a63:2c8e:: with SMTP id s136-v6mr5401404pgs.390.1532177853965;
        Sat, 21 Jul 2018 05:57:33 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:33 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 01/20] staging: gasket: allow compile for ARM64 in Kconfig
Date:   Sat, 21 Jul 2018 05:56:40 -0700
Message-Id: <20180721125713.88501-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The gasket and apex drivers are also to be used on ARM64 architectures.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/Kconfig b/drivers/staging/gasket/Kconfig
index c836389c1402d..970e299046c37 100644
--- a/drivers/staging/gasket/Kconfig
+++ b/drivers/staging/gasket/Kconfig
@@ -2,7 +2,7 @@ menu "Gasket devices"
 
 config STAGING_GASKET_FRAMEWORK
 	tristate "Gasket framework"
-	depends on PCI && X86_64
+	depends on PCI && (X86_64 || ARM64)
 	help
 	  This framework supports Gasket-compatible devices, such as Apex.
 	  It is required for any of the following module(s).
-- 
2.18.0.233.g985f88cf7e-goog

