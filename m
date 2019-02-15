Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEA3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8577D21B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zysXGPt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfBOKnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:43:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52930 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbfBOKnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:43:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so9449446wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 02:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+6owkBUTp+2ZeTKY1pZgHAXcKgyGqK8I58+oLqdsrG4=;
        b=zysXGPt1xaS/nPsMacZ7ntWtzmXtX6YpzilWrwdKkgl++zmpowDvF17qpdCVdgXsAZ
         vTN38KbUKfJ35INanWNa6nTUgTNAvqnPtmW1ZSVIIGFYKUnlmPSJKWi260LjHTC50+jZ
         26k7r5nIvVtzLucLEDaTJRz+rvwSuJBUTDKpTbJyBRoHgAU/YT9+6I/tBFysnokbMdgA
         1E2K9aA83mNKzPoAVIoAZ219iS9jX0f3qgEqGyi/ZDJ30F7iBSkEyb3TBqKPeslkRYhD
         h4VbScVtwoHzaO42RLS42X5NmnXoRzqfFeGsdfQLzG2tT49HxMvd2Ans25ZVFI72Aon8
         Vu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+6owkBUTp+2ZeTKY1pZgHAXcKgyGqK8I58+oLqdsrG4=;
        b=o3ZURTigyPxnlHTfPclP7X1KlOwmdy54nL3KvzZyEvWU7gBTJgsviw19UT4I6Kzxgi
         NnFvR6AxhorqS2hsKTp49JUOKxod7jcJ7DsecVOxX4LA7Rs/5AyP5hRuTjTBQtW9bVUE
         Vakxgka6lcDNKDNuEqgHgZCCZ1ZnKBp32CM0aU57OoysdvuuDofcAUlSo7CCmFqJviOQ
         Yh2o7KdDvJdREDVfKhdXdHjV5X2hsz9OGnQkeXmgMHqaSxlX8du5m/UG78QX0DqhRwlz
         GDVlOMKsJaXqBXNDJz5ri7JLFXEVHPfGttNgvfBHxwQHK0p07Yi04jR4vacuUx7bU/29
         l2nw==
X-Gm-Message-State: AHQUAuaXVMjASXNm1k4Sk23+9cgYiXNwFGDnya2IvIOOsCF3d8/51eTR
        MzSvK79anWtPIdyAEMqZdnqm/Q==
X-Google-Smtp-Source: AHgI3IZBPy9YPYVQlxaByXhfA9ntSfEzIM+J/adbpUb4mrRzuI3jf9VFx5ieSbCbNizZFUzYz64yVw==
X-Received: by 2002:a1c:c40c:: with SMTP id u12mr5771714wmf.11.1550227381617;
        Fri, 15 Feb 2019 02:43:01 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id b18sm2988310wro.80.2019.02.15.02.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 02:43:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH] nvmem: core: don't check the return value of notifier chain call
Date:   Fri, 15 Feb 2019 11:42:59 +0100
Message-Id: <20190215104259.30732-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

blocking_notifier_call_chain() returns the value returned by the last
registered callback. A positive return value doesn't indicate an error
and an nvmem device should correctly register irrespective of any
notifier callback failures. Drop the retval check.

Fixes: bee1138bea15 ("nvmem: add a notifier chain")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f7301bb4ef3b..3ce65927e11c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -686,9 +686,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
-	rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
-	if (rval)
-		goto err_remove_cells;
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
 	return nvmem;
 
-- 
2.20.1

