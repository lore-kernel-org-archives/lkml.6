Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D100DFC6183
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B56221479
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="12rmIQnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B56221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeINTzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:55:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54817 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbeINTzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id c14-v6so2183846wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bgOE1ULQMMWfipJCdPWyqE18ogCrSsaTmNT0nDozskM=;
        b=12rmIQnLSxRah0jIWPCrqBXtImBz27dSY2L4zYm5ugr4x5upENwWdL3Gelv24P5g31
         l36nGiI5drvS+i/I/dduUf6TodQGCHEkulXpgAM8xZIamMa/ONYbD3pD3kzBqPU2Koen
         N5HhIDUYZ4A7/IUSbUlhS83mYNQrwPmMmVjmaIByUUkLVfChMxXrWqzakwsY/HEjbCTS
         MtJMO7iLTcJVqMirmk0014rQkuIZy45jqsePfXVQSrNeS3zKikAn5GB2GgcNmoQWcTBN
         Tr41hMP6cv3Gv8szV8e5ThnoqS56de9gzuEtuKoMpeKudvpHLrs5baJYi+kFp3y8XFt6
         6yGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bgOE1ULQMMWfipJCdPWyqE18ogCrSsaTmNT0nDozskM=;
        b=DO5Oed07azGdH5kBuQ4HGnNzV3wV1J/LUK2Muj8oWdW7Hy+F8UhhVU1/fHZpKQNxgr
         7Bmjx6itFsL/gzgCpGiIHmvhgb54zKDmcGewF5lXrKuNxSGlqpZIIHPuYkQxIJnq4eBY
         jkJFU8LZc86zrGT1ISW07pTSG9I/lvjEDo9xhKJzEwBDKbYO7vUnDVUGRNbxWL78PQpC
         ChkwuJJ5UxQzMx2YUf+S+HaqP0c9OdlyqwNnd6UXB2N0Ir4bMSKlh/EBBg9x34YC7kiT
         qJvAQ5KV9TIXbOQe6WRt3fVfj6gcCRcpJ1dUV71AcojaznMFjUlBsVLHfoNCjiOEUXig
         +mtQ==
X-Gm-Message-State: APzg51CC61dJQsvgQDiQpchqv7WSjHluAbvNNElFVaPke6B16QLFPF+7
        +NxhIKDj0HsV0maYVD4ds0LXsQ==
X-Google-Smtp-Source: ANB0Vdbyoboif8kkoL6w59OXgc7YVNKwxX/pjoAcaVxxVv0ojGqrw1afeisPi8dn/KHkkG7fKUzQOQ==
X-Received: by 2002:a1c:c5cc:: with SMTP id v195-v6mr2662105wmf.29.1536936051682;
        Fri, 14 Sep 2018 07:40:51 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:51 -0700 (PDT)
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
Subject: [PATCH v4 21/22] nvmem: fix commenting style
Date:   Fri, 14 Sep 2018 16:40:10 +0200
Message-Id: <20180914144011.27614-22-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
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

