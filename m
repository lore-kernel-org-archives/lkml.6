Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE9DC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB9020838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y7DPX8z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfBLOXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:23:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34786 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730077AbfBLOXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:23:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so2921996wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g3rdNZIUpTTqTQJmw0LRepuQplSBP1o3fYoThoCVA3M=;
        b=Y7DPX8z+KSEDDT7YCfLN+nnGHpJzPsrMBVUlwFLxOcwv3FlKjD6E4pV9aQbgaZ4QAe
         l7YtGT8biMJ4GgrNuTCxAssqCcUGnr5tNIdWV/XSBORJdB4aHLHJVTiPEt2VQY2g4WWv
         2sbWnb2hRTuLarcmYkeBtD3xZtF49lSVEE4+BaHv/V1CgnlGyETKoiw8VCrs/8TCAuPa
         2QgIijs/YkUmiK+lh2JJ4060gB8LVM+SzFxwetPadWYppNyKFIzHh7PIGuu3hFmZQpui
         VUFT9HaRHyyVgOZhBH7hCxf55AUWMDBN/jSvlOZ9MvaIEltapnlTyEbj+SiLLcozaZMP
         HNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g3rdNZIUpTTqTQJmw0LRepuQplSBP1o3fYoThoCVA3M=;
        b=lGCBQSEJWaEJGav7pfDSr6VbpxitqlwOLrRwhqfA8OoPxFW0n3XdjyoDkr6+loEILc
         MlBJKjCJuCoFmt6zC4IMOA1Oe2k4XPG4o7MUhrg3tUGiktxi+54TnWAlgQ4GDh5+HZyP
         JJvypBw5WZpPK5DkQE9T/M3zJOqPTWltBqkpS/xPgdPd4MXldBmzvWSzZyhXeqC6VzoL
         KvSg5lqxssyY/UYmD+dCHKtWn9fFWyMWMff72xvPM8Mv6pV3MXQ0LRFfPZXCZuIPBLGO
         qdVnIzGNjp+Q+joRrL2/RqigvQ+E48NqJlNbrsFENTQsYsAjldcSCycL1Sttjfk5V8H9
         grRg==
X-Gm-Message-State: AHQUAuZtRmB0Ynl1k9/ur5VTnnI3vNp39ndtfuWgNFFjihF87jA9bD6R
        7TB7j4FptMPb+hPKK3hJ0irqYg==
X-Google-Smtp-Source: AHgI3IavBHTgXxoo+RIaWqjfOzvXI7q16+p1nhFsnXsyGUVNyVuK8Tes91OHmpKZPsZ+jZxYJ9Zkgw==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr3142559wro.283.1549981427197;
        Tue, 12 Feb 2019 06:23:47 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y22sm39043216wrd.45.2019.02.12.06.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 06:23:46 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] soc: amlogic: gx-socinfo: Add mask for each SoC packages
Date:   Tue, 12 Feb 2019 15:23:42 +0100
Message-Id: <20190212142344.13634-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212142344.13634-1-narmstrong@baylibre.com>
References: <20190212142344.13634-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When updated IDs on f842c41adc04 ("amlogic: meson-gx-socinfo: Update soc ids")
we introduced packages ids using the full 8bit value, but in the function
socinfo_to_package_id() the id was filtered with the 0xf0 mask.

While the 0xf0 mask is valid for most board, it filters out the lower
4 bits which encodes some characteristics of the chip.

This patch moves the mask into the meson_gx_package_id table to be applied
on each package name independently and add the correct mask for some
specific entries.

An example is the S905, in the vendor code the S905 is package_id
different from 0x20, and S905M is exactly 0x20.

Another example are the The Wetek Hub & Play2 boards using a S905-H
variant, which is the S905 SoC with some licence bits enabled.
These licence bits are encoded in the lower 4bits, so to detect
the -H variant, we must detect the id == 0x3 with the 0xf mask.

Fixes: f842c41adc04 ("amlogic: meson-gx-socinfo: Update soc ids")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 32 ++++++++++++++------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 37ea0a1c24c8..1ae339f5eadb 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -43,20 +43,21 @@ static const struct meson_gx_package_id {
 	const char *name;
 	unsigned int major_id;
 	unsigned int pack_id;
+	unsigned int pack_mask;
 } soc_packages[] = {
-	{ "S905", 0x1f, 0 },
-	{ "S905H", 0x1f, 0x13 },
-	{ "S905M", 0x1f, 0x20 },
-	{ "S905D", 0x21, 0 },
-	{ "S905X", 0x21, 0x80 },
-	{ "S905W", 0x21, 0xa0 },
-	{ "S905L", 0x21, 0xc0 },
-	{ "S905M2", 0x21, 0xe0 },
-	{ "S912", 0x22, 0 },
-	{ "962X", 0x24, 0x10 },
-	{ "962E", 0x24, 0x20 },
-	{ "A113X", 0x25, 0x37 },
-	{ "A113D", 0x25, 0x22 },
+	{ "S905", 0x1f, 0, 0x20 }, /* pack_id != 0x20 */
+	{ "S905H", 0x1f, 0x3, 0xf }, /* pack_id & 0xf == 0x3 */
+	{ "S905M", 0x1f, 0x20, 0xf0 }, /* pack_id == 0x20 */
+	{ "S905D", 0x21, 0, 0xf0 },
+	{ "S905X", 0x21, 0x80, 0xf0 },
+	{ "S905W", 0x21, 0xa0, 0xf0 },
+	{ "S905L", 0x21, 0xc0, 0xf0 },
+	{ "S905M2", 0x21, 0xe0, 0xf0 },
+	{ "S912", 0x22, 0, 0x0 }, /* Only S912 is known for GXM */
+	{ "962X", 0x24, 0x10, 0xf0 },
+	{ "962E", 0x24, 0x20, 0xf0 },
+	{ "A113X", 0x25, 0x37, 0xff },
+	{ "A113D", 0x25, 0x22, 0xff },
 };
 
 static inline unsigned int socinfo_to_major(u32 socinfo)
@@ -81,13 +82,14 @@ static inline unsigned int socinfo_to_misc(u32 socinfo)
 
 static const char *socinfo_to_package_id(u32 socinfo)
 {
-	unsigned int pack = socinfo_to_pack(socinfo) & 0xf0;
+	unsigned int pack = socinfo_to_pack(socinfo);
 	unsigned int major = socinfo_to_major(socinfo);
 	int i;
 
 	for (i = 0 ; i < ARRAY_SIZE(soc_packages) ; ++i) {
 		if (soc_packages[i].major_id == major &&
-		    soc_packages[i].pack_id == pack)
+		    soc_packages[i].pack_id ==
+				(pack & soc_packages[i].pack_mask))
 			return soc_packages[i].name;
 	}
 
-- 
2.20.1

