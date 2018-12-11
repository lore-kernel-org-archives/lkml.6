Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F46C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBB02087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="rBzT8lAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBB02087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeLKTSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:18:05 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40141 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbeLKTRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so14035698lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4m8ctf6y9EGC+mUnRjPepFgwQACfKyscQiqNabOlRE=;
        b=rBzT8lAPsnGK0TXlsr01Y8QxrdVrvC3TgoTOYniq/EwFlpFaZtm3uWR4U2ZZ4gUZf1
         YY/imMLZO6PiRBzq/aHIIbjZt654tnhXv9hGn3pvs3YuQlVA0pQigkVr5ARuNm+l7qAY
         oo+ALvHm3PNLe6/XCTXfwx1YmwtCeo6mg8IIupshdDzfa2yNeYXb+6H+CRGyDrOVznci
         QH2Xa4GtrTXOWl5pJh3ryGmX2IewYHRuB076yu6E50YyIUc73/1HwY7yx1sfcQ1cPfle
         LW20dSVtuclPz0nHzjVkDKAz+9T5eGaVxjB3c+2ZwfCIV8CsvKfAkeKfofNIFbO/j8C0
         Y2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4m8ctf6y9EGC+mUnRjPepFgwQACfKyscQiqNabOlRE=;
        b=HHG27vDfcUZpRB+rg4G30nWGL885Hsl3+INZdqOpr3tF+RdHUuWX1o2F0oEmGb8+a+
         Q2iMU+dSVXYtpfPotKutLcHyWB1Wm3I0WzdV3tVvZtYEAJslUk3HGY7EahN6oQ51Hf5u
         vEOJiCD1F/t5pIZAZXuBD5B/y2i2rf2s3Zt+bGhSbL4HAul4TVGJgQ+YhVQn9v97D5Ox
         IHgMy+6QzrXrbYHiOyaI0OCGPJ5bK9EcmYPZCeFSftGAj3Irm0UEMzMTGWKHVOylxvkS
         OBPq/uRXa0X1M18/0Ggm+qfochR1dg1L99A/932rF1t6lHPHZAhSW5V9/GeeCbMSOHAn
         u0Mg==
X-Gm-Message-State: AA+aEWaI0TeeJTyEjWK7Gz+oWUA4og4WwPidK8ow0AcnI93xERcr+aQX
        RkeoDk0OkxX92kpOEyzpUAuTQMHNXrs=
X-Google-Smtp-Source: AFSGD/UmjcE1RUlHxivzDdSb/DcOL0LDzhraLFh9tHdiE9UGhUbBeVYpHkg50O4saIK8mGFf5z5lXA==
X-Received: by 2002:a2e:87c3:: with SMTP id v3-v6mr11380558ljj.13.1544555838714;
        Tue, 11 Dec 2018 11:17:18 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:17 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 15/21] lightnvm: pblk: avoid ref warning on cache creation
Date:   Tue, 11 Dec 2018 20:16:21 +0100
Message-Id: <20181211191627.15542-16-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier@javigon.com>

The current kref implementation around pblk global caches triggers a
false positive on refcount_inc_checked() (when called) as the kref is
initialized to 0. Instead of usint kref_inc() on a 0 reference, which is
in principle correct, use kref_init() to avoid the check. This is also
more explicit about what actually happens on cache creation.

In the process, do a small refactoring to use kref helpers.

Fixes: 1864de94ec9d6 "lightnvm: pblk: stop recreating global caches"
Signed-off-by: Javier González <javier@cnexlabs.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 0e37104de596..72ad3e70318c 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -347,23 +347,19 @@ static int pblk_create_global_caches(void)
 
 static int pblk_get_global_caches(void)
 {
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&pblk_caches.mutex);
 
-	if (kref_read(&pblk_caches.kref) > 0) {
-		kref_get(&pblk_caches.kref);
-		mutex_unlock(&pblk_caches.mutex);
-		return 0;
-	}
+	if (kref_get_unless_zero(&pblk_caches.kref))
+		goto out;
 
 	ret = pblk_create_global_caches();
-
 	if (!ret)
-		kref_get(&pblk_caches.kref);
+		kref_init(&pblk_caches.kref);
 
+out:
 	mutex_unlock(&pblk_caches.mutex);
-
 	return ret;
 }
 
-- 
2.17.1

