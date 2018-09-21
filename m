Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B9FECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DF42086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDIreCev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DF42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390391AbeIUT35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:57 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37159 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389657AbeIUT34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:56 -0400
Received: by mail-it1-f196.google.com with SMTP id h20-v6so1932783itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NQJQYueES4psX0iGxyT2wAKnP/SWUtQBqBYjkByNhug=;
        b=WDIreCevCdOq9+pFiUQ3+dOq76o2JZUpWEGf71pQ6GGu94MyY7yrke0XCm9scLM4eA
         XjuTkq7ehnAYm+NUbvEuK4FwxTdgt/SsBNk0M34L/TFz8cntfhSisVKyr7j32zF6YOMX
         hRlMry2BxFXHolNbPiRDo9DnQ/d4ZMlSMsapM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NQJQYueES4psX0iGxyT2wAKnP/SWUtQBqBYjkByNhug=;
        b=Bva/Zu4z9kiy24mUiAFm2cvEFuen4cd0REVms5YIDc1UeQtmxqAD++VLy7LWmRxmJ9
         2/b5dCxJra2xonOIENAbnx/KhAMedZxktNScnZO9n6ZfzD/uPYMNswB+PpsInRNKvelO
         NTr/F2DkIVcjjDgKRPiIZ/7Hmq2mqQNEiqC4amZ4rHy8Q7pWQDRIq09E/G5LeR9p2HUd
         JMsvSnkoiyy16F/5OQYAaX5PrTDAV3+b3lzzKi8Pns0jjbVquXNGZFk8hSOkLcuZgaAv
         cpc3tdiKb7fa9F9hdegeRnvxZqAkcBXouHdRATjeA5HPRIoAv/V1yIqytrbXAX5C0loF
         OhKg==
X-Gm-Message-State: APzg51Cc7+qUAOCznfFViUybeHJHXjpJ03oiSuRoevdVV/I8xJVBzcp0
        gnUkqJjS21yuB3cD/ELqjO+wUQ==
X-Google-Smtp-Source: ANB0VdZ3X6Ju4nISf+W3MJZaNT6VCjGPFHL6xxcDlyqtGVtQ3IBlW5b5cexdyNvm6KD0mBU/6RIEsw==
X-Received: by 2002:a24:90c6:: with SMTP id x189-v6mr5939272itd.108.1537537260951;
        Fri, 21 Sep 2018 06:41:00 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:41:00 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 23/26] nvmem: fix commenting style
Date:   Fri, 21 Sep 2018 06:40:23 -0700
Message-Id: <20180921134026.4596-24-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Remove a redundant '*/' as pointed out by checkpatch.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ff21402fbd7d..e44a1860a2b3 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1374,7 +1374,7 @@ EXPORT_SYMBOL_GPL(nvmem_device_cell_read);
  * @buf: buffer to be written to cell.
  *
  * Return: length of bytes written or negative error code on failure.
- * */
+ */
 int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf)
 {
@@ -1430,7 +1430,7 @@ EXPORT_SYMBOL_GPL(nvmem_device_read);
  * @buf: buffer to be written.
  *
  * Return: length of bytes written or negative error code on failure.
- * */
+ */
 int nvmem_device_write(struct nvmem_device *nvmem,
 		       unsigned int offset,
 		       size_t bytes, void *buf)
-- 
2.19.0

