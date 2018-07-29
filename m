Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CB1C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8B420857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0icW17N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8B420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbeG2VIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:08:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38203 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbeG2VIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:08:38 -0400
Received: by mail-pl0-f66.google.com with SMTP id b1-v6so4510741pls.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+4mz9c1aLGju9QYl/6+Cc+jkdZYEQNBOKjBqQyqOxnE=;
        b=U0icW17Nvg0fC+7EmujTm6gk/6J4yTMQwB5RRc+SP+Ke4VxdmVDqpDbK6VOMcp17qH
         L8jY/T12hi04AF7cX+25nCxLGnSlKNXvT16zR3kk9ydTFnRBsjgmXVDyIanZ0MGqvWVU
         UU9yFnELhEq2pRR4a13xxSjHQ0N9V/5SNVjxIheDEq8XhDEEyW6qc2kqna7j/T72+4EH
         JUacduFUtz07FjHRSl35XvNDKlmNs7UpBfmwNBsXCw+e0FJyYEG1ofmjwwAMK2Pi6t3q
         EtaPtWl2LZjgYYhQND3WZixwMILpS0B4NobYxi0LRenef6aLcsnLmNoIfE1bLUc9z1Zd
         QlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4mz9c1aLGju9QYl/6+Cc+jkdZYEQNBOKjBqQyqOxnE=;
        b=cQvGt8/4Qxdk3ooLDtLKSh8rCDAnAlxoeJ0tNxyP8o8Z9X25wjmDG9uTnesKfBtQCH
         HnVho02Jin8CzouwU2xR3trBD6IrKJPhGrZZGS7IevF/Uyc7/3FGeacNU5rBZ9Qf40FK
         QPBt7C87q1lxGTI3eRLZIv1zbQHYDsYnAeqf7GmMN7hM9qSMh1s5gV6pByIub6w+cpuj
         dEftWOjjIWHR8tijlLqg8+Pyn8Dd5brjqie0M6Qi4rcu6+bLDvTrNyUee4Tv5A2ODCTf
         pV1thSOeopa/us+cM/MnNDvqK4eo/lxNzFDdodufYelAcknNl6BZwWiYbnBsdhHPInts
         tmUQ==
X-Gm-Message-State: AOUpUlEHr0eRy/IB6ZwwMAsrsaCeAOmH/rsBrT9mGojHkH8RL4N/0DOD
        ZuQT8bPYDIIVnfNvPO/jSw8=
X-Google-Smtp-Source: AAOMgpdJDsT/LLf3saohL49FQlDd97NVnTwfYCS2OgMN9TJsanApNZ91kQUvHPf9NmvmMPLTc0Zylg==
X-Received: by 2002:a17:902:9693:: with SMTP id n19-v6mr13889705plp.212.1532893026554;
        Sun, 29 Jul 2018 12:37:06 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id k26-v6sm27474062pfb.167.2018.07.29.12.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 12:37:06 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 09/13] staging: gasket: interrupt: simplify comments for static functions
Date:   Sun, 29 Jul 2018 12:36:42 -0700
Message-Id: <20180729193646.201721-10-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180729193646.201721-1-toddpoynor@gmail.com>
References: <20180729193646.201721-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Static functions don't need kernel doc formatting, can be simplified.
Reformat comments that can be single-line.  Remove extraneous text.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_interrupt.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
index 3be8e24c126d0..27fde991edc6b 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -87,13 +87,6 @@ static struct gasket_sysfs_attribute interrupt_sysfs_attrs[] = {
 	GASKET_END_OF_ATTR_ARRAY,
 };
 
-/*
- * Set up device registers for interrupt handling.
- * @gasket_dev: The Gasket information structure for this device.
- *
- * Sets up the device registers with the correct indices for the relevant
- * interrupts.
- */
 static void gasket_interrupt_setup(struct gasket_dev *gasket_dev);
 
 /* MSIX init and cleanup. */
@@ -334,13 +327,7 @@ int gasket_interrupt_reset_counts(struct gasket_dev *gasket_dev)
 	return 0;
 }
 
-/*
- * Set up device registers for interrupt handling.
- * @gasket_dev: The Gasket information structure for this device.
- *
- * Sets up the device registers with the correct indices for the relevant
- * interrupts.
- */
+/* Set up device registers for interrupt handling. */
 static void gasket_interrupt_setup(struct gasket_dev *gasket_dev)
 {
 	int i;
@@ -553,9 +540,6 @@ static ssize_t interrupt_sysfs_show(
 	return ret;
 }
 
-/*
- * MSIX interrupt handler, used with PCI driver.
- */
 static irqreturn_t gasket_msix_interrupt_handler(int irq, void *dev_id)
 {
 	struct eventfd_ctx *ctx;
-- 
2.18.0.345.g5c9ce644c3-goog

