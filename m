Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE1BECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E162077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzoP4bDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E162077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbeGQVjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39221 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731756AbeGQVjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:52 -0400
Received: by mail-pf0-f195.google.com with SMTP id j8-v6so1092179pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S4vI3ThfI6wnQvrRD92mDNSgcOf+uT/aJeHrGY+htzE=;
        b=fzoP4bDy5vgMocni6HBohQChCz6StqUf8WLr2G9BzdMjwHWwJKfXv46JRMKKSuuIYs
         EI1zAh9nv6Zo3WBsgb87LYDAhmVxfHpa3rqEvSzLOjznZtprDOo92gDMJpj1defa+h7T
         p0aBOcktd4p96GeT8w8gcAFvuP8MWFNHrabpweRuhI021DsdNRbDJQOT1wQmjeeCOyY3
         hkacKqgIhtKbtj4g7IGIbDh2EWEleUE/xlyRWku0I3IqdY+FKjICW6KPhz+acod5R63j
         +VFT73adkLTwTk7Fhe8IIFHeK3D2cb5Zmqz/FrA6PLpbb1uD/KatoxDHKp0SQmhMlNJW
         e5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S4vI3ThfI6wnQvrRD92mDNSgcOf+uT/aJeHrGY+htzE=;
        b=BMa+vbfqd5qG6EKJ3bvAqhEzpOSBmCFso0FEbtI8iO6ql0dAqo6uRBMm3F4Q3do6KT
         GHNQbTlVV7wQvs0CWB0oOSmpvTGQdoNIC7kNIxZyTo82HrQ7um9hkLaOveZYKBr4fV09
         +5F+ZkJ1vXTK8oRgF01em7F8FL5D4WbgR3bz+c7RRnXNF3Xv10PBTtS0bQSjRR4scEQS
         mvGyKb7IYbGdGOc1rVIXHIY9IgG3NLVGoA0Ctiej9PwGCQkd5c9Aafto8cQyyg4EQOBV
         BFO7WjCknpkqufmDNT2tcsocOOkGNu8V/5mEkcmDzB1dZjAfJnAqlvrIbpdi3nvGyCmX
         yqmA==
X-Gm-Message-State: AOUpUlFGf8oBa5dWBL2Ez0kt7OZc+IBxhiALM6hBZzWZKpembkp0v2Z+
        RMP3hxtrlc60A6R6NT48MmPV5qRb
X-Google-Smtp-Source: AAOMgpd+FLvzK7+JQGPZp1uhDbg+olsRavU9sxIHd+IdVvHEWJlRcZESkTOInyPmPSHMcSMDqQcO8w==
X-Received: by 2002:a63:a502:: with SMTP id n2-v6mr3124279pgf.263.1531861524587;
        Tue, 17 Jul 2018 14:05:24 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:23 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 28/32] staging: gasket: fix comment syntax in apex.h
Date:   Tue, 17 Jul 2018 13:57:08 -0700
Message-Id: <20180717205712.29495-29-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Use kernel-style multi-line comment syntax.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/apex.h b/drivers/staging/gasket/apex.h
index 4ef264106f503..d89cc2387b7d4 100644
--- a/drivers/staging/gasket/apex.h
+++ b/drivers/staging/gasket/apex.h
@@ -22,9 +22,10 @@
 
 #define APEX_EXTENDED_SHIFT 63 /* Extended address bit position. */
 
-/* Addresses are 2^3=8 bytes each. */
-/* page in second level page table */
-/* holds APEX_PAGE_SIZE/8 addresses  */
+/*
+ * Addresses are 2^3=8 bytes each. Page in second level page table holds
+ * APEX_PAGE_SIZE/8 addresses.
+ */
 #define APEX_ADDR_SHIFT 3
 #define APEX_LEVEL_SHIFT (APEX_PAGE_SHIFT - APEX_ADDR_SHIFT)
 #define APEX_LEVEL_SIZE BIT(APEX_LEVEL_SHIFT)
-- 
2.18.0.203.gfac676dfb9-goog

