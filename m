Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778FCECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3009020856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF66VcNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3009020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbeGUNuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39137 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730163AbeGUNuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:39 -0400
Received: by mail-pl0-f68.google.com with SMTP id m1-v6so1338887plt.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dg3xIzBiiAUq2DNELD03K3Q86K4G/i1CzzoFATJh2wg=;
        b=WF66VcNOYNlYa7cF4YnVrjChUi+tUKtXkSG4f7c4rUgu+xXAEC5BVToHuFrHTE8onk
         WnL0XabkHc2eXxrHRbS8msef87i36Aw1IYFUBlsOB/bdu6uF6tN4EbbwZlnHitiwFcy6
         xhKu0Wp8i4Ok00tL5qyHo4WdL6zARlmju306U6vrw5zvyPkL0K1wcRAfq1IkFr/k79CI
         f1YBOrSE8Vj4n8TTAwkUJJtVQJELJL7v4hsLsjXP7UkO+qscc00mgVkEC1dxpe0iEMWR
         cFI2zJPeZ0s/VVmwnpsQnQ+oULoAWWxhkC+NX32CWD1BjaswxNzzIMOiXgeeDFx3+XGU
         lwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dg3xIzBiiAUq2DNELD03K3Q86K4G/i1CzzoFATJh2wg=;
        b=h3nko3vq4yMybaOJPdqfc6hmYJURz3o524trIXYWRh6wmliJM/C5INQDKisSPnmnDd
         s8kCipMtCZER8vWjsgdPWm5yK9JD9CZCuYgjyt0sGugN4aiV3w3nXl3QlAh4co0YE4Y6
         WjeTfFWX3NHQHGuu1JegSRAVi8JyP1f52xmJdJp5xBOjTnF67+jHPvAMwJFu8fHzcmb8
         5qwXKW8UTlxIflVc8wj/gGChzNEULA01uIYzvplIN+plhXDdu0KUWC5dwIxMqvJ1c9TL
         XGgIlcqGlVOBHuoHwmXIMyEwB5p0BujUoFiHBXYtP4Z3fxXDpORFUHOXdYgRVW6ywQYI
         wTHQ==
X-Gm-Message-State: AOUpUlGm3xDHWhf/2XhJSZA9cx4c/VcKtNFHEgOUoLRQPWTAaXkmyfKC
        3qq1xuRFrUEX0grxkzKZ6yU=
X-Google-Smtp-Source: AAOMgpcB9j9UjUQaJgZtWAEYyE9C1eJowOVwyrLySTgeMTfntRJ509Pt0YhV6clOiAI933+GjXWeRw==
X-Received: by 2002:a17:902:8541:: with SMTP id d1-v6mr5839285plo.81.1532177879811;
        Sat, 21 Jul 2018 05:57:59 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:59 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>,
        Simon Que <sque@chromium.org>
Subject: [PATCH 15/20] staging: gasket: fix multi-line comment syntax in gasket_core.h
Date:   Sat, 21 Jul 2018 05:57:08 -0700
Message-Id: <20180721125713.88501-30-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Use consistent kernel-style multi-line comment syntax.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 50ad0c8853183..7ea1df123ba5d 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -54,7 +54,8 @@ enum gasket_interrupt_type {
 	PLATFORM_WIRE = 2,
 };
 
-/* Used to describe a Gasket interrupt. Contains an interrupt index, a register,
+/*
+ * Used to describe a Gasket interrupt. Contains an interrupt index, a register,
  * and packing data for that interrupt. The register and packing data
  * fields are relevant only for PCI_MSIX interrupt type and can be
  * set to 0 for everything else.
-- 
2.18.0.233.g985f88cf7e-goog

