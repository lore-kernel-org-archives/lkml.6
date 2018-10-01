Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B31EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEF92084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZOKxpbUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEF92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbeJAQiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:38:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39070 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbeJAQiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:38:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so13197012wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 03:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=9lkGVsNxlX+MgxZEditI3+TUfrnT+qVHsgFgcxCtk2w=;
        b=ZOKxpbUWqhLgCP4ASCtZf2YdLW4a+l14c4un/aoCYcSJuR9rsb0UNquKVmmrCGxFL6
         3oWXytaXh0svUcJRIip6X1jLt0ZKg0nOi+SCuRycOQIGElbTDThaYd9iW3YQF6w0JNH/
         CYiUpf7SkH3AFJgNYdKGa3BTqTApAu8rG/VojZKdy/8vIWsuiZsH9UJx0TnzyXjt6asm
         JbOHcYOuYDOTXU6C3n8tIACaYWNnJ37ors22VHql+VPrik4mFxQBQWVpHvPSaMB+vHuX
         sWEcCnomajArBB7M3yuh0fGJa2tW1LyG2juGzwMsu3s3jQeFIQOvYKElQ8r6whEs9/jO
         +Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9lkGVsNxlX+MgxZEditI3+TUfrnT+qVHsgFgcxCtk2w=;
        b=V0hf7sGB0RfTuYKxD2Z7zFnN8IuCtZjA7TMJJy+JeLDVjIBW9BAco53Jfdu+uDSpTX
         eAwFrSn3vAEg8ilUiJYUHIF2ttGsmXSvHbUPikrABoL0ox4HXvlPBCZoG9TQXqAKNVDT
         w2wY0Gvsb/1SS+K3iyYuaDi96TwU11YQ1e3IdBipboGvXfNoaP6g6BcucbnBbuuW4Cya
         9KygaDrbjATlNRitB/9tM6v/OBa8kD3nkimylVtRGWHomyWxo2E5fKlTh1jbqxIZgdnh
         sIfT03q7r90Y5OKyqIo+boKdPyDjVYjVh4m7dZkMEcru7SrKiMJwfCHyNbOTR4GVYRSF
         ME+Q==
X-Gm-Message-State: ABuFfoik2fMTw9dwN9PUExI2x+Kf9mYytEL3f5sJCe3P12fmJnSuOYHs
        xV3IRECT8iQyLoA4LCWltZljeg==
X-Google-Smtp-Source: ACcGV616rKr+oxnnBxwz2G3IN49pz01AkQWclQUNErXx9EaQ1PPip/RJilEgZwXH3kFmNtz13dBAeA==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr5239511wrx.215.1538388068551;
        Mon, 01 Oct 2018 03:01:08 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-14-252.w90-86.abo.wanadoo.fr. [90.86.135.252])
        by smtp.gmail.com with ESMTPSA id c13-v6sm1537658wrm.50.2018.10.01.03.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 03:01:07 -0700 (PDT)
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
        Chen-Yu Tsai <wens@csie.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] nvmem: fix nvmem_cell_get_from_lookup()
Date:   Mon,  1 Oct 2018 12:00:52 +0200
Message-Id: <20181001100052.3580-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
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
---
 drivers/nvmem/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ad1227df1984..8249621d11a6 100644
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
+				cell = (struct nvmem_cell *)nvmem;
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
2.18.0

