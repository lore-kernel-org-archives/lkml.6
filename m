Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A4EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DB821738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up2+JbGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfBTBXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:23:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35635 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfBTBXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:23:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id y15so4758281wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 17:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZykuMiX0ah2ZI0MnN/LWzb3+FQhAjRyij/UeYadgCq0=;
        b=Up2+JbGHCzCX2K1xkt493kqIoNwlwHTZ5xM2cAA3jSmJprXCUK4jqSuahYq6Scrj7q
         J22WruWthD2bj3h38C3lsHcwGL1SkTX7jItdtwF1wq21thhVH1vQ9oYvtXND/EJE1qxL
         EMYafe5SCi2LqQHDbp5NbbHmRegaYcAMadf4qUHLA26iHRXmKh6hW7ASJcjd07K5B55b
         wM6IGVSwc9PQ5Je1nfVkeK0L+JwpWcRbeh5qapJzaE9Qp48+1PARuo5kmYYakeYNCqj+
         knlfz1EA0phx4TRvv4+W71iqN/GAA7H/888BrsCiM0LIYhtIV+vF1TjYFHPbmhNa1W5y
         kegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZykuMiX0ah2ZI0MnN/LWzb3+FQhAjRyij/UeYadgCq0=;
        b=uGB11x1v2B88ZzGhO/ckzZRpgfIXZMctWyB9lv2gCBPYDctwaGG8fl4rn40zhQKfFN
         7uTBVwMkoxrGIu0CrlL/Gz8kma3guxdKH1kVRUI8gYPWBpdl67Kcg2jtmquJ8mgPMncC
         fz0VuhOFNSQVCPte1UBHICEuAy0bdKPIYm0SiDkyjPuBL4WigsQ3iJbvmsOHVSWpqLap
         UpQV2wswAOK+JvwmKyJFC0ywpXy9VXSdMzmuBw5pYQGrFzXTb2tbt0qHggbvudgHSobE
         12mtYj+i14fU1fJcKIe+f12GIuRYxD4VP2VX9i+nKreHJ1ufjzVMDb27P9PExohgxu7C
         76Mg==
X-Gm-Message-State: AHQUAuavaphs6jvDvtXL1+WWx7jxxmcd9Gw2ykDgQWfCbQ5qLl4I2fA4
        VvWSxKkfoVU+gkr2Dl9oyts=
X-Google-Smtp-Source: AHgI3IbEbBu7gN8ytJCrS9KwqP2IEXDx1KqlFAhWZ3L/Aym47WkDB2Y89aHiMCojYjLafWMwzFzcNg==
X-Received: by 2002:a1c:a58c:: with SMTP id o134mr4477918wme.79.1550625802317;
        Tue, 19 Feb 2019 17:23:22 -0800 (PST)
Received: from localhost.localdomain (77.49.81.239.dsl.dyn.forthnet.gr. [77.49.81.239])
        by smtp.gmail.com with ESMTPSA id c1sm14732787wrw.7.2019.02.19.17.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 17:23:21 -0800 (PST)
From:   George Sofianos <gsf.greece@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     George Sofianos <gsf.greece@gmail.com>, trivial@kernel.org
Subject: [PATCH] Docs: Correct /proc/stat path
Date:   Wed, 20 Feb 2019 03:22:45 +0200
Message-Id: <20190220012245.16858-1-gsf.greece@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for dynamic ticks in high resolution timers uses an
old path for the stat process.

Signed-off-by: George Sofianos <gsf.greece@gmail.com>
---
 Documentation/timers/highres.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/timers/highres.txt b/Documentation/timers/highres.txt
index 9d88f6778..8f9741592 100644
--- a/Documentation/timers/highres.txt
+++ b/Documentation/timers/highres.txt
@@ -231,7 +231,7 @@ in the idle period to make sure that jiffies are up to date and the interrupt
 handler has not to deal with an eventually stale jiffy value.
 
 The dynamic tick feature provides statistical values which are exported to
-userspace via /proc/stats and can be made available for enhanced power
+userspace via /proc/stat and can be made available for enhanced power
 management control.
 
 The implementation leaves room for further development like full tickless
-- 
2.20.1
