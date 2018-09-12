Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D5DC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBD820866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XaWZU6ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBD820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeILMzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36563 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeILMzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id e1-v6so928144wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dAHd6MEwqXVGzwWm3SfLFdQRcyv3zBIXXYtbxX6zPOs=;
        b=XaWZU6ad83b8KhhFlV4kIuhwjf9l8fQ9CD79b3i8E/N71O/s5PrxgbCP+WRUK/lh7a
         oHixyJ0EmcVKFcl5AuF7DJ+YttTAiEwyME+XEc27jeHuQTFOO/DPTddm/qQ5i/3iFhee
         vkHvLekaeXU+WzRfWS3G2ky8LKh5TY8Lv6jvt9kq7fvrsz+mDbvqRtbHU6JbvVbM7Llq
         N6glSjbiNb84KETKKb2zv04n2Dek6NPXzZD+IlBhydI3OifZYSQB5iU2D7cu5Qinw7aR
         w2BRWl5uH8uyDR22XOHGKcgi3PLexnRxGtt8jyzLWFn+/xaWTzhv12ADW/+m62PjLbuZ
         qsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dAHd6MEwqXVGzwWm3SfLFdQRcyv3zBIXXYtbxX6zPOs=;
        b=R60GVm3U6mbgS58Ql08ZipqzqkR2fRMfzCAf7AfPNviEL6DT8icGDyqB0mTjz6e10d
         SSowgbNsFLSOAygWbDgenAQKNBuRZ30RbwyZe9g1/6ptZDc5h+VPidhGOtqvbloxsPbU
         XJMwa/ctZJB1b9lJ23SSpKosU/SljKa0d9Scrxr+qdNls/O13V5I94FM2+OnHqXfhh76
         LBHhH8GWqzFn9fss7GE7uYXaH/YZbpCve1fknwuxufSDk8QYmxFyYyHxDJB0+pfZ72bi
         bYp/T7Ngqr2QjrBFAxcZjLajz9dmvEFBR8KsIsLXWourPltixbuTMboHm0ltMiNRBo07
         jUGg==
X-Gm-Message-State: APzg51DR2e7cf3ne0LfCeuWIIK88Q7QO6yCKZGnxsxUnM7WAESoQcv9u
        DHvD4kX6Y8UKia5+B5QXeq0R/o5iY/0=
X-Google-Smtp-Source: ANB0VdYPOfHEh0p5hqqrJFe3PqNbdLOAQRydlahUEvxdCASABxV459to2tOuooXLz5xv03xmEp6cRA==
X-Received: by 2002:adf:959a:: with SMTP id p26-v6mr493599wrp.202.1536738737336;
        Wed, 12 Sep 2018 00:52:17 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:52:16 -0700 (PDT)
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
Subject: [PATCH v3 20/21] nvmem: fix commenting style
Date:   Wed, 12 Sep 2018 09:51:28 +0200
Message-Id: <20180912075129.25185-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
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
index f4930f605d4f..bc14ffd87ca3 100644
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

