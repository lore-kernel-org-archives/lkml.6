Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF15AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7793821531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Ew56mpX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7793821531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389654AbeIUNRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:17:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46789 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389575AbeIUNRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id a108-v6so11777087wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bgOE1ULQMMWfipJCdPWyqE18ogCrSsaTmNT0nDozskM=;
        b=Ew56mpX8JcOajDhnDoagv/zlPqozRf+XrJ7N0l26sBl5oTPCI/MRRAv8L+Yc9Gi0rJ
         AdhfJ7P+LOg/jSP6kr0c6Nr4PQ7xyXwxbxySUEDMc3/gbaqh1sm+yVhIbA8305jfZIFt
         JboGV8DC6SpjEDLrmPOPWFF8py5Ah6lEkSAb7qv7HXYZ4cLNQdsTnSJ+ia2FEnWK9Aui
         1/8Kt+R9bCBgk4ZPi9cJePjVfjLLE6yNw+hZ2Md+N8iQZsPg4zRV3VC1H9zD4PEJK+Gl
         jVujRpuC2btIZW501e/wg3E1GRHvquINxteekYP4eky718I+A6PiqWfExp1PUxDzYnng
         kFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bgOE1ULQMMWfipJCdPWyqE18ogCrSsaTmNT0nDozskM=;
        b=ixV71J7p2luT/7Z3XDLOMzTaf27pQ1gU84esfRSGmC4z5bH4zCRo7/Y26o3krtRERc
         ycQHzOvG83QbAtmHPMsQrlBsrC6wHDD+TTHN0SbgjfgBafTRVv8it0H7plMDu9cy1/u4
         0VljvnMsThpJwv0NjpHymdT4Gdky6OTtC+JBLCHMsTKe/z6tcfYnQn+1ejZjNLeT2KsI
         Ulv5FU1fsxUNSRqEhYqb3zQG102QBAAlp1mM5va5moDUs1oY3+yHBbeFddm0u04UEp9s
         IDgNVM6+TmG0ROjOOaC7dyWRezmeewv2LXlKBEIshnWoVxjoOIi7u9Y4UtKFbAGdGj/Z
         ehcQ==
X-Gm-Message-State: APzg51BcnYOseGDd5niwOHZc0ziY4siHc9G/Pn6lB2WN0dSYFi4ibKtq
        J9Xet7vU3vTjHvyidplhDsKviA==
X-Google-Smtp-Source: ANB0Vdbr5FjcvHNfz971aTXuZ+68jEtvCpG6PCBzVT8r8JmKfHIqtFLjatCFHAB3ncQJfzkEtwjXVA==
X-Received: by 2002:a5d:68c9:: with SMTP id p9-v6mr36816891wrw.108.1537514995004;
        Fri, 21 Sep 2018 00:29:55 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:54 -0700 (PDT)
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
Subject: [PATCH v5 21/22] nvmem: fix commenting style
Date:   Fri, 21 Sep 2018 09:29:20 +0200
Message-Id: <20180921072921.19387-22-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Remove a redundant '*/' as pointed out by checkpatch.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
2.18.0

