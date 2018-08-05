Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF12C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DF42156B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB6FaXGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DF42156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeHEWOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:14:21 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42322 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbeHEWOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:14:20 -0400
Received: by mail-pl0-f68.google.com with SMTP id g6-v6so1154528plq.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wA/I74DwdG5/o2actje4g8J97nm7i9lFPMy6J5tsJ8E=;
        b=FB6FaXGfdbNqIsyQOsdJQ/WMvLJ8fOiRVXApOa+XuOLiE0vu/NMjx9UnKfobQYO+ip
         RxM3ih2Q3LzccoPJJBMfathTZUW+Z/plJEiZXm5GL6C50U/vcaIfCK32F/oS2rqBDlrl
         WNK796LLbYvAhns2qeWGauxXtOWUeMxqBe5YDr4h/FXFlDifukrZ3AT7TgmXbm5KHQfN
         N1M32+sn5wWVqsO165d9e2HPiDyW4P8cgVhYl0/yLWmU4+Ru70m9Mp9Rg5pUJkH61j/f
         RcdUvI99jVbPZV1pCws27eOsO6z+twUybj+fNAckjn9x3QdnRm6iM9cobXLpJcNzg3SR
         vLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wA/I74DwdG5/o2actje4g8J97nm7i9lFPMy6J5tsJ8E=;
        b=r3tSMzVSsXdbhKNKnHmsYkOdUhy/FcX5ywIlW+9Q+KCQn5mBfG9Hn2g3nEiJ+JNqze
         yi8lwBTaBxTGF/nx+jt6EWkR4GiZXapG3NuKElP1nZoIHodBXcUnuxv+cZjK0Bw2Xzwj
         sMFgSLJL+oqVJTQh4C2pjDXfKqXWW0XCLtWcI+YRmd2gCKw2u1vGRFxjNv1haU/Vp8lM
         NK7cS+d28caRxi20kLC3ol450b6RgXb27OeABXHW1LbGcQKbkEH2II2+G6/jEtgJgSFe
         jaXeS1PsKpd0gMkiBd8QC3XHWMr/iU/jrlqkK+uxEuPexygRdkvJc9lIao1N1mnd8cye
         Ju9A==
X-Gm-Message-State: AOUpUlHtJIZjUjdIx/gdNsCa+P3FkM1YupuSb7Em6VxlgOooDkewUaf9
        ppK/d4egfqdd/tvQFw1v9CQ=
X-Google-Smtp-Source: AAOMgpdgTLF4/R7p8CLQ9ebChPLqLJcJKdxWI9S5py/lOPnY3WvO+wb3DEv1NcZ8FPconh2KBSQVVw==
X-Received: by 2002:a17:902:8697:: with SMTP id g23-v6mr11440683plo.292.1533499715329;
        Sun, 05 Aug 2018 13:08:35 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:34 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 13/15] staging: gasket: core: protect against races during unregister
Date:   Sun,  5 Aug 2018 13:07:47 -0700
Message-Id: <20180805200749.116693-14-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180805200749.116693-1-toddpoynor@gmail.com>
References: <20180805200749.116693-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Keep mutex held across the unregistration operation, until the
driver_desc field of the global table is removed, to prevent a
concurrent accessor from looking up the driver_desc while
gasket_unregister_device() is in the processing of removing it.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index ace92f107ed58..a6462b6d702f1 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1765,9 +1765,9 @@ void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
 			break;
 		}
 	}
-	mutex_unlock(&g_mutex);
 
 	if (!internal_desc) {
+		mutex_unlock(&g_mutex);
 		pr_err("request to unregister unknown desc: %s, %d:%d\n",
 		       driver_desc->name, driver_desc->major,
 		       driver_desc->minor);
@@ -1780,7 +1780,6 @@ void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
 	class_destroy(internal_desc->class);
 
 	/* Finally, effectively "remove" the driver. */
-	mutex_lock(&g_mutex);
 	g_descs[desc_idx].driver_desc = NULL;
 	mutex_unlock(&g_mutex);
 
-- 
2.18.0.597.ga71716f1ad-goog

