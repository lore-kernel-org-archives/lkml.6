Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59997ECDFC1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1451E2088F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="U5e4qxYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1451E2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeILMzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41441 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeILMzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so913442wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=To/SQLBCgeq0lnY/26X7cnEpcdLcDIuj/UXMlG3uaxI=;
        b=U5e4qxYZDq0sIHyWyZrFlnqVXVUPZTGpquDb26zZzLQdaJfq6Iw0UB2wJPzxl/BTy6
         Fm2TOQabJk7wq7hk/whzNBenH4c8wybwsil1+pcqhCTVxVJVcp8VXblX5+iBl19NAobi
         MQmiK9eThd1W3wIOePjJ81//0CDPIuOU2Qix+mljM87cUfTSrYOUNEw6hkdUEz0UuijI
         lYiDG858c3/og51eoo+4l5WrI4GcdPMFTL900W01TLcO/uUwTG1MFrOsHk/fgeD+wEv5
         /1etGhftAfq9sGHn0572rgOeyL4yFcyvQkMdZ+3geRc6XHEnqniwO1Q/wk0zbnrLgcAu
         f4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=To/SQLBCgeq0lnY/26X7cnEpcdLcDIuj/UXMlG3uaxI=;
        b=SQI0G2bYLE8hlVWQuVX/4suOjIPful1T31SCfO17oIRUldDBmJonr+Gj276w/ixWc6
         Fm76fRdV9QriyXZZ4yLSeDHpUoJKgvo+ogcAJiqr688ubPmm3j+rC2lDRNnZ054zTJcJ
         iuAarXn7Ewwdzmx+U9vqpk88tzPX+z5LYXAGJDkCspms9lJCQ18v7bXoB60s2hG1EnKz
         nJOWfiIFX4bYN4Gziur1VRNaZhd4o/OGff4hn4sHkH59Q1g4FHIbhCKbRHWt/YQaBx+q
         EWv9QAiXMjTbu5divl6ECzuGh5uPrGGeguRo5E+0O4b2bW/dsIho5ocZwx8Ii22LFy2y
         63Uw==
X-Gm-Message-State: APzg51DfYFRWt0w7e2hbKW7kDuLRAxhmLLxWLJeNGlLpfSypmfacbWL2
        3x4DO6HLsPLbCB+Ug1mmZ8+QYg==
X-Google-Smtp-Source: ANB0VdarJ0J0MvgBUorYHhtJphzZzqcXqTMzumPQBhHlJDxLQ35awmtqkI4Bzje4oHRh7PPtDzc5DA==
X-Received: by 2002:a5d:55ca:: with SMTP id i10-v6mr530270wrw.38.1536738703451;
        Wed, 12 Sep 2018 00:51:43 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:51:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 02/21] nvmem: remove the name field from struct nvmem_device
Date:   Wed, 12 Sep 2018 09:51:10 +0200
Message-Id: <20180912075129.25185-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This field is never set and is only used in a single error message.
Remove the field and use nvmem_dev_name() instead.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d96348ae0f37..8987da0f7456 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 
 struct nvmem_device {
-	const char		*name;
 	struct module		*owner;
 	struct device		dev;
 	int			stride;
@@ -652,7 +651,7 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np,
 	if (!try_module_get(nvmem->owner)) {
 		dev_err(&nvmem->dev,
 			"could not increase module refcount for cell %s\n",
-			nvmem->name);
+			nvmem_dev_name(nvmem));
 
 		mutex_lock(&nvmem_mutex);
 		nvmem->users--;
-- 
2.18.0

