Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64A8C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C392098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Wu11J0GA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C392098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbeJCOS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:18:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39763 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeJCOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:18:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so4511480wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zA3130o6tIFdcW3y+5AjvuDR9dBDEcVc1A4OLI8A1wM=;
        b=Wu11J0GAasU0r+YSFpOJT2Jrj2qG1vKGIxOegCGglxqYi3bwkdeoPXriLBlBOOHjzD
         Sm7cX/gMZ5ic6EDtVNLlkixFzSNIZY6kN1AwysbhmRhG6tUF6UbiVJbxVFJVDUow+SBb
         TS1vPG83KupZ97CrZI+JBJ9fE8FvSSMuo02MttdgOS0WsmJ75toymbixm+iGlyRpd7lz
         z82aGKvemhr2QLrQt9/lMuhGJ862U+HjNff85a1N4s/Z0LIc2gYm16/kHNqBxlq0PWI8
         i5+9ZRCFeqC4fRMZgBoL845i+LOzjwotIrTcIJ/7VPDonXPrXulugNSflpXEKXu6Ory2
         bgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zA3130o6tIFdcW3y+5AjvuDR9dBDEcVc1A4OLI8A1wM=;
        b=W7oLcyFJiQQOfwBw8sIcJeek1XJQ0HFI0OTE4rujhjhwRGh4XQ+RMls3Tdr1Kkyvi6
         rxnhZxhXrtgQmzGnv3pT3oZZS4rmWUM6baBHVf6HEhKreEVjwngk7M4yyHEH1o/F1Rc1
         WAdKWb06owYVi09c6Eys6HpJ9FF20ltZvwJ5Kf69wlE3oIvLEHPOf1yC0VYy7HZ4tvTa
         cafIplnu3egE7/xbJNtMXDygJ8Aj/fX9/bd8A1wlqj5ZA4mZpCh+Z90jhl5ZdfoVIXAy
         L+0kIhi33QyPBRBLuu0nsiApWzgQo5XhagtorhDfUnxELk4tGx5DI2EqBNUN0DvuR6En
         Fjbg==
X-Gm-Message-State: ABuFfojh1KbnNfHLg6i5kj/XZlXL9Ys4dUxJXDHSjYOBwg4c1q51hs1q
        KIfmCX71FKKv3SCwc3DSMbeqOw==
X-Google-Smtp-Source: ACcGV60cWImS8XrBJRH51ixLMKlyzIeCfCsDH4PcbqTwQlcdGDIaR6ZfFg2PNSzKzd6DNwVGeklxbg==
X-Received: by 2002:a1c:9816:: with SMTP id a22-v6mr482231wme.13.1538551874010;
        Wed, 03 Oct 2018 00:31:14 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:217b:7d7b:52aa:bc53])
        by smtp.gmail.com with ESMTPSA id h78-v6sm1645401wmd.4.2018.10.03.00.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 00:31:13 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Greg KH <greg@kroah.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3] nvmem: fix nvmem_cell_get_from_lookup()
Date:   Wed,  3 Oct 2018 09:31:11 +0200
Message-Id: <20181003073111.27212-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We check if the pointer returned by __nvmem_device_get() is not NULL
while we should actually check if it is not IS_ERR(nvmem). Fix it.

While we're at it: fix the next error path where we should assign an
error value to cell before returning.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
v1 -> v2:
- use ERR_CAST() instead of a direct pointer cast

v2 -> v3:
- added the Reported-by tag

 drivers/nvmem/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ad1227df1984..f49474e1ad49 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -952,9 +952,9 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 		    (strcmp(lookup->con_id, con_id) == 0)) {
 			/* This is the right entry. */
 			nvmem = __nvmem_device_get(NULL, lookup->nvmem_name);
-			if (!nvmem) {
+			if (IS_ERR(nvmem)) {
 				/* Provider may not be registered yet. */
-				cell = ERR_PTR(-EPROBE_DEFER);
+				cell = ERR_CAST(nvmem);
 				goto out;
 			}
 
@@ -962,6 +962,7 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 						       lookup->cell_name);
 			if (!cell) {
 				__nvmem_device_put(nvmem);
+				cell = ERR_PTR(-ENOENT);
 				goto out;
 			}
 		}
-- 
2.19.0

