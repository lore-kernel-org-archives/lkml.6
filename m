Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4209C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E1120855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq+Go2oG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfBHTen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:34:43 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51423 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfBHTel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:34:41 -0500
Received: by mail-it1-f194.google.com with SMTP id y184so5331575itc.1;
        Fri, 08 Feb 2019 11:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ESOqZSGyoucI1+2p8zSZ9yGK4zHeL7l9qckYjJCW8o=;
        b=lq+Go2oGIEjUPWFyebfY/GOhPPxUcu3LVXirMD5v9iKafnahVq5Pz0S1/XU59goI/W
         S+KGlGVztloJnaVsobc57dM2thktdUJ55+XyXPAFO8FQxRiIR5iy2A317FAmvk95dJ3Y
         Utff5xF+wTn9byz31BlEI0KoBG6KFJJA0tlvMRqsmmUbEshEy0ToQUA4ZBS9QtgoWiLy
         2Md+i1aE2U6flYOO8cnLdUvpmhSpP5+t1WYV8NCojJddiN1u8WDk8o+BbzJvK5nLhNju
         XzTlGFnFIGxmylxRWpQRzeORVI2RJ2DCRSIWbYLNy6DFTFtOOtHQ0jj2ml4WkXzLQfrP
         zFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ESOqZSGyoucI1+2p8zSZ9yGK4zHeL7l9qckYjJCW8o=;
        b=sqwqi94cnu1RhOmkDLEQlAN/eXSGxuA+kN6lWabiYRiotqfImddv+/pyY6V32z49Zo
         CYJnUSTBD8fC/zqfpd+rVx8118XHLI21TMX3vXH/kgWwJtjhxeIuS5Am2t1Bug8KodrQ
         +r8lkBnciCE+IKfJTSRkv3ITS5lS/TDRWK9Lt3SohmVF/CZYFiwY6YxgMsO2utMSriVo
         gdrHoNEWthdJrDPX7IAQLBxtlVeDfd3Hcacjw4nT8DwhVUFRdGzEhaQ7V3uYjC/18pWy
         echqaCj0uVQsXWiJ+OEriVVUM52WWXLTyr93kzS2WLTT+CA/nyALeFgGPfaiNTB6dR5r
         sIZQ==
X-Gm-Message-State: AHQUAuZ6Ty8jxV5SzJ7yvWcmDQF4Fs/h6DWSSMhHsbctllRloWPVmNB3
        fP5ORp8vn1xCL35DWfKDojA+39JP
X-Google-Smtp-Source: AHgI3IbP4cEZCwtHdM7tNUSYXeaVu2HMJtz+jw+B/p39bnzvbER1iOWbb0+f0WNdc9g8+kVPc/oZFQ==
X-Received: by 2002:a24:738f:: with SMTP id y137mr92232itb.136.1549654480589;
        Fri, 08 Feb 2019 11:34:40 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id v202sm1636425ita.13.2019.02.08.11.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 11:34:39 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] Input: lm8323: remove recursive mutex lock/unlock
Date:   Fri,  8 Feb 2019 14:34:34 -0500
Message-Id: <20190208193434.5629-2-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190208193434.5629-1-TheSven73@gmail.com>
References: <20190208193434.5629-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recursive mutex lock/unlock is not permitted. Remove.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/input/keyboard/lm8323.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index ea4ed1750eb5..4363c60f7845 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -359,11 +359,9 @@ static int lm8323_configure(struct lm8323_chip *lm)
 
 static void pwm_done(struct lm8323_pwm *pwm)
 {
-	mutex_lock(&pwm->lock);
 	pwm->running = false;
 	if (pwm->desired_brightness != pwm->brightness)
 		led_set_brightness(&pwm->cdev, pwm->desired_brightness);
-	mutex_unlock(&pwm->lock);
 }
 
 /*
-- 
2.17.1

