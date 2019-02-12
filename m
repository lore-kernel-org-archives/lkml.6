Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839C0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D1B206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bWuUTyTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfBLOXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:23:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38760 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbfBLOXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:23:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so2890559wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yod8/2mWK4Qd4G4cKjNo2LDaZQqOzQK+ax711W0cspI=;
        b=bWuUTyTk+K7IOE1U0JkgR78suNjCu4uZMTdc4aHjtqrSjR1Ohnv8ODAP/grJKpMKJL
         5VEFSJxRm7lL0A+b4GP7fVNY/kMnlz4tUYa3IMojDRemFMgV45VHHkFcq8yDQos25jDj
         Z/bpINroM+UX2Gz19ehPSV2sEMb/AqVu+b+G9cLn6g43mzSOYBJcpcWzqBgpzmlK5u7z
         QK9d8y2UjqJ9BcpxdthXDCGZtV1LKpM7BHuVLy+De0J7uoC8OOByKi/uKDFIDMWiHKlh
         MvFls1QBrZx91hu7Cc9AufpyzpIW4mnkpQKGs9oCUFkWL9qX0bl/fLkxd9OGXtce4UG8
         GRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yod8/2mWK4Qd4G4cKjNo2LDaZQqOzQK+ax711W0cspI=;
        b=plBcTXxX3gHye+rQAho/tc3bep/o2G05rzAFaFLx+pWdMC9zbLdgFwoyCzPKzHthkC
         tlq2WZASrKzR1KH3t8z6K/LfB7YFjnZ/gy5EwSILe1wXkidMQLnmB4sArmVKcWB5vG55
         tBNm+ORti7TvmN9PXok62cG2MkvKXgWJsZ9oXBkLuBqjD+aojDL+APsDTbxxwCx5/kOI
         AjX1HwYX9tkHpL6Ezq73NKmpSCeg1W/54BP2smY0J09YRHkKO6tAAK5XZqmzBOY3b9H6
         j88YTdrkC7MWpt7e4IeWa3f/msI/UGiPtIYpGfIhgaIjfLS4UpNGfKLTROnM2NXAcsGt
         JvoQ==
X-Gm-Message-State: AHQUAubF/m40Vk8q18U6b9OPuOkw1yrvyQNNb3VqH2srrUzE+O0p4ARe
        2vWb6GzgKDOo2A0emi0S0OTRig6nNxov2A==
X-Google-Smtp-Source: AHgI3IYLGpRQ1uFj2rXREsPDErxHuMzviiqaPR2IY3RnkyVn5W5JuVEQmaiQ+qlymVpSwLdvFK5RAg==
X-Received: by 2002:adf:9061:: with SMTP id h88mr3094553wrh.65.1549981428568;
        Tue, 12 Feb 2019 06:23:48 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y22sm39043216wrd.45.2019.02.12.06.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 06:23:47 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] soc: amlogic: gx-socinfo: Add new SoC IDs and Packages IDs
Date:   Tue, 12 Feb 2019 15:23:43 +0100
Message-Id: <20190212142344.13634-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212142344.13634-1-narmstrong@baylibre.com>
References: <20190212142344.13634-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the G12A and G12B SoC ids and the S90X2 package ID.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 1ae339f5eadb..c1a9c34d861b 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -37,6 +37,8 @@ static const struct meson_gx_soc_id {
 	{ "AXG", 0x25 },
 	{ "GXLX", 0x26 },
 	{ "TXHD", 0x27 },
+	{ "G12A", 0x28 },
+	{ "G12B", 0x29 },
 };
 
 static const struct meson_gx_package_id {
@@ -53,11 +55,14 @@ static const struct meson_gx_package_id {
 	{ "S905W", 0x21, 0xa0, 0xf0 },
 	{ "S905L", 0x21, 0xc0, 0xf0 },
 	{ "S905M2", 0x21, 0xe0, 0xf0 },
+	{ "S805X", 0x21, 0x30, 0xf0 },
+	{ "S805Y", 0x21, 0xb0, 0xf0 },
 	{ "S912", 0x22, 0, 0x0 }, /* Only S912 is known for GXM */
 	{ "962X", 0x24, 0x10, 0xf0 },
 	{ "962E", 0x24, 0x20, 0xf0 },
 	{ "A113X", 0x25, 0x37, 0xff },
 	{ "A113D", 0x25, 0x22, 0xff },
+	{ "S905X2", 0x28, 0x40, 0xf0 },
 };
 
 static inline unsigned int socinfo_to_major(u32 socinfo)
-- 
2.20.1

