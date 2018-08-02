Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE40DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887DB214D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIb+VsDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887DB214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeHBKdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:33:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46459 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbeHBKdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:33:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so883284pfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JcnqR4eHB+vf+nD6FO2RS0WFO7jADaVQWCHjLaoVaqE=;
        b=lIb+VsDQwj3Fy1/+8UQTsVehaZP/eelneqGb7f1RejFbA5l1CWUjO5piZCoRwjDIUJ
         Y4mPcBmXW9jjLRPS4BvdTuIr5Pg9y+v5uZKCQzLrlA1ZzIDAyNfYO7mfJv+RYJYeP65q
         emdiLLFXp4DMNKR2KMEbQhLFNKIIhLQ5Li8YbLQvBFEE/JJukcs9blLaZNXyEB48pkWT
         TQfCKiPSLozLltAyH+Sf1T4Nct0JNtj1fc7dk2bpmh+9cFOKqoVtkxkiHhMO4bC745A/
         e+09jCYTBGiYh7+6PY+d7NfF2TmgComcHemyZ35EP+fj0exVQo5M1lpMLuopjh8zeuZM
         iXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JcnqR4eHB+vf+nD6FO2RS0WFO7jADaVQWCHjLaoVaqE=;
        b=a353LJXebW+EMtNJHCYF6D4aM8d7TIQkjkIHWa1in1TqaR3ioXFrhtiQJ+uqM7zH1L
         k1Zc43WgIt9u0koKBwNNhjGjlfDeHf0gcp8f/4aJnJY/4O5I57vB38XyiIsssZhS/P6P
         UyGAZ8qqEz3EZ9gPefiQd0nLJa4/elxh6vTpzf6ukZ6q30pzwevsfhO7hvN4nes2osRx
         nfKnzZwB85kozlL2T6+nA87Ms2YD88HkFqzDJ8vQ/qvbs2/Tm59QAq9wD3P0b5c84b4B
         H/i4znaqkzEtR5zsAj6ZbDWRvad+l7cm+0Hj30NIAa/EbNLC3cS2IlssF1q4hK6l7HeF
         m7jQ==
X-Gm-Message-State: AOUpUlGOU29hluLCFysuRQY4OWVZ1U/wxp5cNIXNBgrZRnpIRhNMMCi5
        e4yiIjM1eAxaFqelkec6DKzDkvKu
X-Google-Smtp-Source: AAOMgpe6W17e4r0q+RVpMaYLna390nTCRdLkvPJFof+VQ+pttM6NgzgyYWVx1zZXcu7GSltbqo8z6Q==
X-Received: by 2002:a63:b43:: with SMTP id a3-v6mr1820051pgl.50.1533199384777;
        Thu, 02 Aug 2018 01:43:04 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id q21-v6sm2128397pfl.156.2018.08.02.01.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 01:43:04 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 4/8] staging: gasket: core: device register debug log cleanups
Date:   Thu,  2 Aug 2018 01:42:41 -0700
Message-Id: <20180802084245.239689-5-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180802084245.239689-1-toddpoynor@gmail.com>
References: <20180802084245.239689-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

At device/driver registration time, convert a not-very-informative
info message to a more informative dbeug message, drop some not overly
helpful debug messages.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 2160c2de78e77..36c077fffc41c 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1736,7 +1736,8 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	int desc_idx = -1;
 	struct gasket_internal_desc *internal;
 
-	pr_info("Initializing Gasket framework device\n");
+	pr_debug("gasket: Loading %s driver version %s\n", driver_desc->name,
+		 driver_desc->driver_version);
 	/* Check for duplicates and find a free slot. */
 	mutex_lock(&g_mutex);
 
@@ -1765,8 +1766,6 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 		return -EBUSY;
 	}
 
-	/* Internal structure setup. */
-	pr_debug("Performing initial internal structure setup.\n");
 	internal = &g_descs[desc_idx];
 	mutex_init(&internal->mutex);
 	memset(internal->devs, 0, sizeof(struct gasket_dev *) * GASKET_DEV_MAX);
@@ -1789,7 +1788,6 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	 * Not using pci_register_driver() (without underscores), as it
 	 * depends on KBUILD_MODNAME, and this is a shared file.
 	 */
-	pr_debug("Registering PCI driver.\n");
 	ret = __pci_register_driver(&internal->pci, driver_desc->module,
 				    driver_desc->name);
 	if (ret) {
@@ -1797,7 +1795,6 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 		goto fail1;
 	}
 
-	pr_debug("Registering char driver.\n");
 	ret = register_chrdev_region(MKDEV(driver_desc->major,
 					   driver_desc->minor), GASKET_DEV_MAX,
 				     driver_desc->name);
-- 
2.18.0.597.ga71716f1ad-goog

