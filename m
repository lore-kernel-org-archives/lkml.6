Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCDFECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B2020856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCQhRSw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B2020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbeGUNuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45141 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbeGUNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:23 -0400
Received: by mail-pl0-f65.google.com with SMTP id 94-v6so6330601ple.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rAtoadXSt5hxka2LKV3Eq+/r8t+CIFxOEm2gppHYq8M=;
        b=sCQhRSw9gNts+5Nzr9GlVbGIvaLonqwn9yTAcoKKDBtXVVN6uaGKlf4CVMEF1oSFjB
         63APP3HTMQkRgASqQGO3u4f3M6RyWLo6w+s09vboUJSOj68zT9V8KdQn7ZMcrJY76BDC
         TY5tGulMpCll5Lk+380lK4EFR+JJGKBjcffGD+7bSfWy2igN305+/HEj1j9fF8yYNXmW
         OUEMyJa0fqwGa4TlwadxGtVYTzylaHKn2xnYpYzva+L3Jd047q/4FDtLyvNdVz/8XR1U
         Ua4O1xuZ+tgxFWZeD133PQRwJDhScnQCO/5VgDpIEiUuFWg279RPUWdLRx71RJoIdeQ6
         4YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rAtoadXSt5hxka2LKV3Eq+/r8t+CIFxOEm2gppHYq8M=;
        b=PYMm7v9DrU0zPDdHNJXcF9acF91jyxYn2ql0T+cQIXhwnJOtNsQegM6d43fFCQdUzc
         OYiK3jcdLYMRf9yMG6bn0505mMxXjzBdePZBc+U/5jgie3ycdH9bEflel1mvLFnBanRD
         eduyQMuzpx/zdN2Z3fouEmcxjkSY3JY3WNqmN0xfYXOcFtxMEBsOwuCcCLRBFwzMwM2F
         0QWnghYgnDftjh2nZjyItxgZSjdeseAXOHNoAMaCaI9RWoEbKpcIXFDpO+UYvRAzy9vg
         VtS9PPfWH8uqkQsK4/Jtdussu+KgD5A/0dsY7xMfNRWiKjAzY9YS4OCd0PM2mi7I91+/
         CV3w==
X-Gm-Message-State: AOUpUlHHXNvgLZNnwrmYeLPAZJmGwQadiuLVfbfD7IbcsY2zcv7YdylV
        u0D08cP6P6MitROG3CZSAjo=
X-Google-Smtp-Source: AAOMgpdipjiBc71nJv9hKWU6rHMi6WTMcRik8NJkvsDMO/cqMGOIkC/Y9G0R9j2RQ4G7xy8542NyAA==
X-Received: by 2002:a17:902:292b:: with SMTP id g40-v6mr5805253plb.273.1532177863226;
        Sat, 21 Jul 2018 05:57:43 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:42 -0700 (PDT)
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
Subject: [PATCH 06/20] staging: gasket: don't treat no device reset callback as an error
Date:   Sat, 21 Jul 2018 05:56:50 -0700
Message-Id: <20180721125713.88501-12-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

It is not an error for a device to not have a reset callback registered.

Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 53236e1ba4e48..eb5ad161ccda2 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1836,11 +1836,8 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 	const struct gasket_driver_desc *driver_desc;
 
 	driver_desc = gasket_dev->internal_desc->driver_desc;
-	if (!driver_desc->device_reset_cb) {
-		gasket_log_error(
-			gasket_dev, "No device reset callback was registered.");
-		return -EINVAL;
-	}
+	if (!driver_desc->device_reset_cb)
+		return 0;
 
 	/* Perform a device reset of the requested type. */
 	ret = driver_desc->device_reset_cb(gasket_dev, reset_type);
-- 
2.18.0.233.g985f88cf7e-goog

