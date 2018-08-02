Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7735BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D787205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvRslcAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D787205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbeHBKdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:33:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33777 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731192AbeHBKdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:33:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so916024pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bborxfqh4KpTgAssl7H8PA3gLF64R+cvmW+pCFmK8yc=;
        b=dvRslcAqYTllG5yMUVYZhp7R8z/+12v43zvlIe23ZuJnDH+mwR6c4nBCaXXfXOUfQF
         yC73IejTOaOi5Vd4f8lkANhfVMn7cD0tYA59ld1oixix/0QP1boIfM5nWuOrVm+vBSNd
         30Nq1u1N7gJzncxOE9kn4Xmc8tQLdhhLxrwR9gSwrEdeIkBXZZvabKd645CAnZ/8aeMG
         lXzPxUt439ZzVLK2+/xAyPZqMu3/O6U59pjPk/Z4ljD4uy62WECmqnz8f+T2kt3o/iSa
         q+f/kH1zIgbvEfmPBZYB7A43E+wTAFt3wo0FiDA6mOJO7xJCigilM9tY6SVnN/1Sek6i
         Cg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bborxfqh4KpTgAssl7H8PA3gLF64R+cvmW+pCFmK8yc=;
        b=OPM6yXK739n7kVNhzJ0N4G/PZ0bnVoUU2iirTm/4RSUNpV5U0Zp4FamwiX7BWV3PhB
         h59erLXfFSt+bBWH/DuLCIMCYoJjadAsb03A+7rMJL+RnLmgVE+lhrna87N7P+qnSFlg
         8ZTp3fpMXzNOsIu5dDI4t18VXhKKYe6/tCPjjtdub6IZ4scCeiGnoarVGo+enygFPAUG
         haR4pfmyQr21ukd/lWlTv5+jFxW36MGTexVGy3Y2tz+kZCXRGv/SBI5I9Uto4zFN/PKl
         wvTZq71SNTnh4pt6lUXq93OCWIcyV0m6iJQXbD46kf5VJHzWwWARW7yAYl4SagNk/cxL
         w0Hw==
X-Gm-Message-State: AOUpUlFqqNVHW6rOtbZMzl7jL/dbFfEizHHrrmd8BElYYbIFWDKfVJEP
        yxMQbgKM7afekivBVYF3yhs=
X-Google-Smtp-Source: AAOMgpeLP+phFVURN8svCtAxFFHqL5ZSpdvmryuaW6VTimUagCcrujB98MwhSKNNbd1sL/03LU25ug==
X-Received: by 2002:a63:943:: with SMTP id 64-v6mr1800221pgj.368.1533199383752;
        Thu, 02 Aug 2018 01:43:03 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id q21-v6sm2128397pfl.156.2018.08.02.01.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 01:43:03 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 3/8] staging: gasket: core: move driver loaded log after error cases
Date:   Thu,  2 Aug 2018 01:42:40 -0700
Message-Id: <20180802084245.239689-4-toddpoynor@gmail.com>
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

Gasket could claim to have loaded a driver and then print an error
indicating it actually did not.  Move the driver registration message
after the last error check.  Replace the existing "loaded successfully"
message with this instead.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index e550c9060dcd2..2160c2de78e77 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1759,10 +1759,6 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	}
 	mutex_unlock(&g_mutex);
 
-	pr_info("gasket: Loaded %s driver version %s, framework version %s\n",
-		driver_desc->name, driver_desc->driver_version,
-		GASKET_FRAMEWORK_VERSION);
-
 	if (desc_idx == -1) {
 		pr_err("Too many Gasket drivers loaded: %d\n",
 		       GASKET_FRAMEWORK_DESC_MAX);
@@ -1810,7 +1806,10 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 		goto fail2;
 	}
 
-	pr_info("Driver registered successfully.\n");
+	pr_info("gasket: Loaded %s driver version %s, framework version %s\n",
+		driver_desc->name, driver_desc->driver_version,
+		GASKET_FRAMEWORK_VERSION);
+
 	return 0;
 
 fail2:
-- 
2.18.0.597.ga71716f1ad-goog

