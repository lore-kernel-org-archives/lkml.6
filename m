Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC3FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44A92147D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY0NsDaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44A92147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbeHBKdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:33:12 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38664 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeHBKdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:33:11 -0400
Received: by mail-pl0-f67.google.com with SMTP id u11-v6so706598plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyQMtAoMyFTbUnnmKx/H1qCfjbw8TXHdQewZWzT6tww=;
        b=iY0NsDaafuU7WI292yIdajxExqEezq6HqwrJ+l5ggyL782RNG6Xx3rmHMW38TrvrcU
         vgdOsplk4phxH9q/cdkVdIFA1AHsynb5SBzLcXBZG+J2SdlcPFbj709ZnEBwZ0Z5GVJ4
         yZhT4kbAznwzx7A7exSq5KUOp93xN+r5NvnAR4bFUV2AVd5EruXQ1rzH9HJygyy3FTTM
         qtFD+w9jD5y8GMK//xfpDxe9gDl3HoNQrxEmWUZxeYiYzJUabJpGWYt4gxZu82BB4F7L
         cqSH3WLrRk5HX1GKmURV5z5NqwaVxAxDk1CNPEa3Oa31x5G4wpLq92sRLRoARFgV4mfS
         1/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyQMtAoMyFTbUnnmKx/H1qCfjbw8TXHdQewZWzT6tww=;
        b=rOvviI1/jHQkJpk1WVJvfEPn4lFXt8ygfTH3T91werKg/6D1FYr69OF9ECxy53AMlI
         lptLcA6WBe9keTzF1YQ6daErLRrSxdFDSivqWmJk6p+hFZbYjbMkJ/AXoKe1H5V6HVnq
         5Dh9IjqiDedhRe7oqCFJFVzfL5SdnBCbF0hm3Lc30yLYbQgm6v6MwxeeUqkqsof7yT3p
         S/C85E82yz601Wc8pdEISXx75vGU/SRXGOokVujrrHgsEZSLVC2f531fGJpg11dl6C6p
         6hh8fQMzDFUZap2D20HXPHkgP0egP6WnMiW32BoK5W8IvxnnaTzkmwn1ej918l05XADF
         UbVQ==
X-Gm-Message-State: AOUpUlGdVyOvnL9RuAbPylL+cB5032cIZ/j33yvPe6i6NhagTri+KPZv
        IBN+T4x0OdIptpoS5qgsTKc=
X-Google-Smtp-Source: AAOMgpchIqtX0iqmaxIOIQCaNV5sUnrqOwCtGgzKSBY9NImeq4GxluNyWPM1k89wePYPSrmT+N5ejQ==
X-Received: by 2002:a17:902:7488:: with SMTP id h8-v6mr1556440pll.41.1533199382832;
        Thu, 02 Aug 2018 01:43:02 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id q21-v6sm2128397pfl.156.2018.08.02.01.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 01:43:02 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 2/8] staging: gasket: core: print driver version code at registration time
Date:   Thu,  2 Aug 2018 01:42:39 -0700
Message-Id: <20180802084245.239689-3-toddpoynor@gmail.com>
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

Print the driver version code in the kernel log at gasket driver
registration time for informational purposes.  Add "gasket:" prefix to
make clear it is the gasket framework logging this information.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index f76f4a0ecbac6..e550c9060dcd2 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1759,8 +1759,9 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	}
 	mutex_unlock(&g_mutex);
 
-	pr_info("Loaded %s driver, framework version %s\n",
-		driver_desc->name, GASKET_FRAMEWORK_VERSION);
+	pr_info("gasket: Loaded %s driver version %s, framework version %s\n",
+		driver_desc->name, driver_desc->driver_version,
+		GASKET_FRAMEWORK_VERSION);
 
 	if (desc_idx == -1) {
 		pr_err("Too many Gasket drivers loaded: %d\n",
-- 
2.18.0.597.ga71716f1ad-goog

