Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0096BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903A6213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEgJZpzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903A6213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbeJFD6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:58:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34383 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbeJFD6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:58:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id f18-v6so7349122plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zqyaW3pC9vozTN9Sdx0zTz5tFMHv97WNfyK4KJLBC3c=;
        b=iEgJZpzK4zmdtrvcyJNhUOm8T/MuHLs/FwWu1VdnPz+Q+3uBUxTXwMsH9oz4gCTNFU
         +JVs63zDIF7phY6QxXe53ANR6XOevUF35AgvhVhmxYRfN/J997mhxaYtMKWXx+Z3EZBz
         5PlvkLqes5oxqr4vADl/XpFSnTd9VWx+CBhDrvoNZZwV9b1GeqMP1KQrEyo4Rf3ZqI2+
         qVPxnDEKFers9qUoAMpSJMIjCmxRfBV8F4LfXEppxwYl3o/zlEKpxbaXqDs+8aeKijgH
         Z31x1ZH4us1400DiuU14LzuYYAwJ/qasSPBSkCv/+N4SAQdilb5NXMHcOP+cKyMcxfRW
         z/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zqyaW3pC9vozTN9Sdx0zTz5tFMHv97WNfyK4KJLBC3c=;
        b=mzuW+QbmoVaqLCUoBjokZmJcZ7pmYOei2fxAmxSUGBIcvenNan9B2g4D2Im5AIdxIV
         CXoPzZZnHdyjJQQl/MFsFEVz7rhIp5Azox4tc1YL0+sNFWdX7jC6rbES/as1kjqE29Cz
         w4fSqn8LbVm7b4sghDbvjMmoEPEKeGjJiAEKfM2KVkH2AWS0cxnB9q9s68DtYLknaUvp
         zVpc6bZtXwyAhvshKUuKrBsIfiy2npPlaicBF8XGAIxYSEVlYgsrXo0wyitYuVBSVxcA
         ulhf+9Puos6rNVzxFyW+b4zYAcLp8abY1FG9xQrJCk76wUhaPZV5Uxl69O2UFw69irLH
         0fZQ==
X-Gm-Message-State: ABuFfogxCFkI1g6heOeZCg+LXFk72iNQd1LUmOp0Og++FJEvTUSHTWjO
        P34w5lrjGBWfPXHDl1Azm/nQrZ1HQUI=
X-Google-Smtp-Source: ACcGV620YRazDknDK/M4CQz+0PQHxbtltFAYkSBx5ZAa2OAcGkpwvWz9OrmI1ddcLVPioIhKTmmXUw==
X-Received: by 2002:a17:902:9f97:: with SMTP id g23-v6mr13020933plq.68.1538773097051;
        Fri, 05 Oct 2018 13:58:17 -0700 (PDT)
Received: from hax0rtop ([108.165.36.209])
        by smtp.gmail.com with ESMTPSA id r23-v6sm11880000pfh.79.2018.10.05.13.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:58:16 -0700 (PDT)
Date:   Fri, 5 Oct 2018 14:58:15 -0600
From:   Scott Tracy <scott.a.tracy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/rtlwifi: Fixing formatting warnings.
Message-ID: <20181005205815.GA2624@hax0rtop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Scott Tracy <scott.a.tracy@gmail.com>
---
 drivers/staging/rtlwifi/core.c  | 5 +++--
 drivers/staging/rtlwifi/efuse.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtlwifi/core.c b/drivers/staging/rtlwifi/core.c
index ca37f7511c4d..a36cb44a5388 100644
--- a/drivers/staging/rtlwifi/core.c
+++ b/drivers/staging/rtlwifi/core.c
@@ -1109,7 +1109,7 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 			if (rtlpriv->dm.supp_phymode_switch) {
 				if (sta->ht_cap.ht_supported)
 					rtl_send_smps_action(hw, sta,
-							     IEEE80211_SMPS_STATIC);
+							IEEE80211_SMPS_STATIC);
 			}
 
 			if (rtlhal->current_bandtype == BAND_ON_5G) {
@@ -1882,7 +1882,8 @@ bool rtl_hal_pwrseqcmdparsing(struct rtl_priv *rtlpriv, u8 cut_version,
 				return true;
 			default:
 				WARN_ONCE(true,
-					  "rtlwifi: %s(): Unknown CMD!!\n", __func__);
+					 "rtlwifi: %s(): Unknown CMD!!\n",
+					  __func__);
 				break;
 			}
 		}
diff --git a/drivers/staging/rtlwifi/efuse.c b/drivers/staging/rtlwifi/efuse.c
index 1dc71455f270..5b8afdb3e0fe 100644
--- a/drivers/staging/rtlwifi/efuse.c
+++ b/drivers/staging/rtlwifi/efuse.c
@@ -245,7 +245,8 @@ void read_efuse(struct ieee80211_hw *hw, u16 _offset, u16 _size_byte, u8 *pbuf)
 	if (!efuse_word)
 		goto out;
 	for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
-		efuse_word[i] = kcalloc(efuse_max_section, sizeof(u16), GFP_ATOMIC);
+		efuse_word[i] = kcalloc(efuse_max_section,
+					sizeof(u16), GFP_ATOMIC);
 		if (!efuse_word[i])
 			goto done;
 	}
@@ -375,7 +376,7 @@ bool efuse_shadow_update_chk(struct ieee80211_hw *hw)
 		for (i = 0; i < 8; i = i + 2) {
 			if ((rtlefuse->efuse_map[EFUSE_INIT_MAP][base + i] !=
 			     rtlefuse->efuse_map[EFUSE_MODIFY_MAP][base + i]) ||
-			    (rtlefuse->efuse_map[EFUSE_INIT_MAP][base + i + 1] !=
+			   (rtlefuse->efuse_map[EFUSE_INIT_MAP][base + i + 1] !=
 			     rtlefuse->efuse_map[EFUSE_MODIFY_MAP][base + i +
 								   1])) {
 				words_need++;
-- 
2.17.1

