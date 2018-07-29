Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7476C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B9B20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1diE5BW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B9B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbeG2VIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:08:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44154 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbeG2VIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:08:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so3553729pff.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KVv678FdxaxfOX4DepdLicXdrn5z+R0eQ8KgAIkzi+8=;
        b=J1diE5BW/zN6grOqBIeVwVSJ9E455Oq4G6leLGNF0dXr9SntwLXBGf+x6IwVMKdFO1
         KRl7EYnOALMVV6ZF/RFfaR3rTJKgvX4BpWV2LSTuBMxN07vI8tn3tzwubpLNvqKJ49ie
         HyNe76SloMaOdnPSshoxkHPDNNGhzgN2umpincA2rwUAd81Feh647MWFfl+jqQV0nr72
         CtA6rYp/+H5YcciM2vjPk6YK1jGhV3iJp3/5S30rjB3YVIN2givZIZ6LKn+tYWlWh/JB
         UAGHAXOyR/3Gb0wt2xgCxPtdECf/Ni0UIFUXhly4GrXurjGvVJG8Z2jLyu1qp+Sgl4tZ
         TbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KVv678FdxaxfOX4DepdLicXdrn5z+R0eQ8KgAIkzi+8=;
        b=cbAIt12lD7nuEgjGeZ07LX48sR22oIDbXcdr2gdwHZZZB3Hag0K8UUkmxiYNGGyNbs
         XsJ0c5eV6YRd7hj6n0LZsIl0m2F2qMMMgMOyFDIh6HaXCXFnANWX1C4lGTcKdtgRJvSc
         6ljSpn5kVN4qbMLLz+pSYEJp50Myb2MLDczW2Ytu+/h2Uitg+gD41eV2stOq89aUrHMG
         Q2vKaBbcy32XTqL+rb+8uKgCytwI7Z9o64YjygIAI1luHom5UqEMC61IgMdwsQyWp8Nv
         geZh7ERD/TQlx2eDM7rpNaZ73kaXBbAtvoRTpgEcVmiAyvdPZWBvbjW9vy27rTsOEBcw
         jRAA==
X-Gm-Message-State: AOUpUlHT0arPHEU8JOx82GASKe+HZVkxjrRAtMQScnzrkvXp8XKQrgTu
        SbKtP2CcN06FhArpDUuBo8A=
X-Google-Smtp-Source: AAOMgpeNAUaO0W6Id4cPlbYLRXPtjGsuX62Ik4wEDUKU7nOGZAI1tNdUhJwTXZ9DPuWLB6hCtlgQpQ==
X-Received: by 2002:a63:4f63:: with SMTP id p35-v6mr13770902pgl.167.1532893027378;
        Sun, 29 Jul 2018 12:37:07 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id k26-v6sm27474062pfb.167.2018.07.29.12.37.06
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
Subject: [PATCH 10/13] staging: gasket: sysfs: simplify comments for static functions
Date:   Sun, 29 Jul 2018 12:36:43 -0700
Message-Id: <20180729193646.201721-11-toddpoynor@gmail.com>
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
 drivers/staging/gasket/gasket_sysfs.c | 28 ++++-----------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index fde04658419bc..ef4eca02afa63 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -47,22 +47,13 @@ struct gasket_sysfs_mapping {
  */
 static struct gasket_sysfs_mapping dev_mappings[GASKET_SYSFS_NUM_MAPPINGS];
 
-/*
- * Callback when a mapping's refcount goes to zero.
- * @ref: The reference count of the containing sysfs mapping.
- */
+/* Callback when a mapping's refcount goes to zero. */
 static void release_entry(struct kref *ref)
 {
 	/* All work is done after the return from kref_put. */
 }
 
-/*
- * Looks up mapping information for the given device.
- * @device: The device whose mapping to look for.
- *
- * Looks up the requested device and takes a reference and returns it if found,
- * and returns NULL otherwise.
- */
+/* Look up mapping information for the given device. */
 static struct gasket_sysfs_mapping *get_mapping(struct device *device)
 {
 	int i;
@@ -82,17 +73,7 @@ static struct gasket_sysfs_mapping *get_mapping(struct device *device)
 	return NULL;
 }
 
-/*
- * Returns a reference to a mapping.
- * @mapping: The mapping we're returning.
- *
- * Decrements the refcount for the given mapping (if valid). If the refcount is
- * zero, then it cleans up the mapping - in this function as opposed to the
- * kref_put callback, due to a potential deadlock.
- *
- * Although put_mapping_n exists, this function is left here (as an implicit
- * put_mapping_n(..., 1) for convenience.
- */
+/* Put a reference to a mapping. */
 static void put_mapping(struct gasket_sysfs_mapping *mapping)
 {
 	int i;
@@ -140,8 +121,7 @@ static void put_mapping(struct gasket_sysfs_mapping *mapping)
 }
 
 /*
- * Returns a reference N times.
- * @mapping: The mapping to return.
+ * Put a reference to a mapping N times.
  *
  * In higher-level resource acquire/release function pairs, the release function
  * will need to release a mapping 2x - once for the refcount taken in the
-- 
2.18.0.345.g5c9ce644c3-goog

