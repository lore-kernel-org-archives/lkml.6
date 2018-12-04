Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DDDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E80A20661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bZlFbFs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E80A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbeLDQeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:34:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50880 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDQeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:34:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so7851451wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPLi5PSQm0wZ5w0jVFRD2zaX5ehve+yaUgJvEMdE2d8=;
        b=bZlFbFs+lIC+cfNlxMCjI9WMSWaT72J+TKgmmJlm6NUjYdIeUe00UM++FjLTw1ioYc
         sPkvvNKNATgwinQ3gf91BCzEpnjqhVDgyj6+XLD2BjRszO4HzigEi1KovmbLcs5bNGN+
         sFwlYVhny0ncAeNdCc11Wf3y/gTgVrhiHC+YNuZsDL9iz7IAgPcaAoo7c2zQX77t/pxG
         LUTL1aY8nP9i3cBIcXcrV7Y9Ao+N+Ds12QyVZJ50CexL8ZEfrWDVj6t1Wy7cCBOZEXdO
         nWxZN/kSd59W0/++GD7mXjUtkXsfdZfRMZBTQGWNBSJH73EASNmYwBSnZqmFAobQyzO1
         K7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPLi5PSQm0wZ5w0jVFRD2zaX5ehve+yaUgJvEMdE2d8=;
        b=TcyHRLrqmTKEKboiZ8TsGohrQHsNpzki4D6ME4jqNHxzQ9Zd1fird+N7INFeZeodjV
         l6RPt8250ncDwPf/fLxv9kaKfjGxG9SirOzPuntKUHwC+b5RVJ24p8g9AyHv+sxlRQnT
         Rus/r5AYnGaRzzzBw8B17g6FovjGYM9dDjgeCGsrye9MOCcuNdAOxv4aLlJM3iPr0Top
         bSlCWl20TUK5flh5Y18oXMmFz+Ppt90zxadeXQKm+/Pnc+sk2H9oi2vvdi1ilQYNGwnE
         KmM57CCKYdH+aOJO2P9cGISyjAAtMuhyVjMd34aG9osC3VfUY6YBky5yFfYPbxzeaKJA
         VI0g==
X-Gm-Message-State: AA+aEWarTSQIAeCw2eAdEQGQzQH9kERegHoqVABwQam9U3paisFfmzPt
        VslIaHwtjRNu7viO+E2q4V6OKg==
X-Google-Smtp-Source: AFSGD/WrXMVj09oObLij4EPkxv6JW6jGoJTVPT6nc/KqktUmd/hkrQR4iyvIRI+f8701vdzAPN6pJw==
X-Received: by 2002:a1c:3489:: with SMTP id b131mr12768188wma.44.1543941250775;
        Tue, 04 Dec 2018 08:34:10 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id t76sm22174826wme.33.2018.12.04.08.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 08:34:10 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: fix clk_mux_val_to_index() error value
Date:   Tue,  4 Dec 2018 17:34:03 +0100
Message-Id: <20181204163403.32321-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_mux_val_to_index() is meant to be used by .get_parent(), which
returns a u8, so when the value provided does not map to any valid index,
it is not a good idea to return a negative error value.

Instead, return num_parents which we know is an invalid index and let
CCF deal with it.

Fixes: 77deb66d262f ("clk: mux: add helper function for index/value translation")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk-mux.c        | 8 ++++----
 include/linux/clk-provider.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 1628b93655ed..b64e475802cc 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -26,8 +26,8 @@
  * parent - parent is adjustable through clk_set_parent
  */
 
-int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flags,
-			 unsigned int val)
+u8 clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flags,
+			unsigned int val)
 {
 	int num_parents = clk_hw_get_num_parents(hw);
 
@@ -37,7 +37,7 @@ int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flags,
 		for (i = 0; i < num_parents; i++)
 			if (table[i] == val)
 				return i;
-		return -EINVAL;
+		return num_parents;
 	}
 
 	if (val && (flags & CLK_MUX_INDEX_BIT))
@@ -47,7 +47,7 @@ int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flags,
 		val--;
 
 	if (val >= num_parents)
-		return -EINVAL;
+		return num_parents;
 
 	return val;
 }
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 60c51871b04b..fc20886ef069 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -550,8 +550,8 @@ struct clk_hw *clk_hw_register_mux_table(struct device *dev, const char *name,
 		void __iomem *reg, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
 
-int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flags,
-			 unsigned int val);
+u8 clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flags,
+			unsigned int val);
 unsigned int clk_mux_index_to_val(u32 *table, unsigned int flags, u8 index);
 
 void clk_unregister_mux(struct clk *clk);
-- 
2.19.1

