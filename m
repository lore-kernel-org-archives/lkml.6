Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C995BECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D2820850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YApQzTFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D2820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeGTEgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47044 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbeGTEgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id p23-v6so5604151pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hiW2Dbr3eUgq/g4Rbn6WYhxli/PT+BDktrtcY4Ukais=;
        b=YApQzTFHDjs6cm/G0DEKbQQicq4z7RjvxVCrvRyVYW3PKDWYTHq5Cg+h2Xo/AgHmVb
         KS7bhChazNrX3B64greBUwGxyHKbmv5kSsHlgfTTwH2OeEr5JpqHNpYZVoRTS0zRFvZp
         rjfcvOxVp7zsdrh8UxbipNfnSRKlsR6hmRGh8OPxBqEmcI5GR/qk4qYiwhzTE0dWZmrp
         jegWzPCgB0nphK9TAOKH4A3H2Jt1K8GveyeB5/V7W2WtAuQbJiGy4hewKAwPcY1qCd9p
         Db7HwNB2EzCcL/IV4JlpPFIncXqDgeMIdir0oXnw+PexsoUXIcINUSpFLjY0w6CzC1sd
         +tfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hiW2Dbr3eUgq/g4Rbn6WYhxli/PT+BDktrtcY4Ukais=;
        b=hwlR3uJ8w+mFrhK+jtpervcb1ryrgDd7jEr8MaU5Yy05lp10LFMlde9qA9HPoDlnek
         LVa/FfVh1J/joMAaYea5MjHlM+kvpK1KR8pcK9mWA39RL8VKjdKTS/jnSkQAHN/DKohl
         Z0z6yIyVqPgtCpywCRBMfmNzD5w8kkeac+9T6cvDQa+6fg7SFd+5wCo65x4liTdRAdYz
         7KwLr4KhGqhYvkP5eLcd0JtlqV3X928s/C3EGLNAbe4SX/MFz9xM0c1IHgoWIM1OTMPe
         fcSjGPUDmrFAJeEi9hGe3CVkCKMorxrBdqcS0EOHT6/YHetnAxVwuUJnag6OCfg76ig2
         19aw==
X-Gm-Message-State: AOUpUlFo4ADCpYx2ifvnD6gh5lJNzwJjm2Wodh7ZYwB09DeuvM1kaOrR
        x20chdV9zu9Ud9q4o6Kdjwg=
X-Google-Smtp-Source: AAOMgpcLsPf+ehtp3p/ylY8aSGhMIoCOVw2vUXbi+7565KZJeMniCh/erJHH6fUBYgg/HB696pbsSA==
X-Received: by 2002:a62:4c0f:: with SMTP id z15-v6mr476694pfa.110.1532058599937;
        Thu, 19 Jul 2018 20:49:59 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:49:59 -0700 (PDT)
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
Subject: [PATCH 11/20] staging: gasket: fix comment syntax in apex.h
Date:   Thu, 19 Jul 2018 20:49:11 -0700
Message-Id: <20180720034920.77320-12-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
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
2.18.0.233.g985f88cf7e-goog

