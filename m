Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E553BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8320208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMxhDouH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8320208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbeJFF7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:59:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44043 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeJFF7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:59:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id p25-v6so7463840pli.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 15:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=y2y5W6kWEEy9pR5bHSoPk0vDybU2gOhAwtIkESXALUQ=;
        b=WMxhDouH/neRL/G7/4Vzu/upSIzEmu0ssogpmX/KQA2ZS0oTW4FUQdoyLkftgb70Pt
         Ia0RptRzxDgOHTnfvd0aAaaE386Fklu3mBbYn28khY+Zv2fr8OyOorZIaDdTriKn5PTO
         U692/hir/Wmf5fXfvGpjTLj/Y3btKHyw1CNDsEtbESw0CMj0dgjVke7f79+JQN9uHfuX
         T/JPuADYkmyVw3B/gAULamzcWSNlFgJJVWfDzXkzrdU/vCSZtPXHyQhl4Eb1gmZsDdfu
         Z5D3PWo1e8Dlh+9BAoUHHFFwXqTZqXA0OcgIR4zgb3sTWlL4LFbk2KrhS8muUX0BbrE4
         modg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=y2y5W6kWEEy9pR5bHSoPk0vDybU2gOhAwtIkESXALUQ=;
        b=QPOrxjg+AVIkIyC73P+ecu7j0YtxKMKpGgmWAindGyV2ZvtgpKXydop7uUSgn8wyJC
         lRHerHhlZD9wG0T4CSvXRTGpHppsTLJWC6LkDKJEaazS42z6d5928ux9Ern8BuyrAqnL
         vz8okF2On0V/9pp4sky+dHOdhvx1NYFgcDBj85IhBmIYWFi0ErPrkjLOMwcQ36HI5C9s
         bfF0LNqNsBN3rUzCKq0Iirza+QSM2Z3sw7nfDpd1eNY5oIsStDA3nPLYj8GW8/xrfI3a
         GwBqH0RijXxyTfJYi8MCjhUd967ysdyxjPOnKcftXIMtM/zP2u9LjdCQsSGDjmaLqFVL
         zg2A==
X-Gm-Message-State: ABuFfojw3YsZ4JD3UZd3djxv75PotS2kXvGq56fipy95ZsLoQGXmUlgP
        ACTe4VDuNKsIwbAqs88d0c2PkRJDQpo=
X-Google-Smtp-Source: ACcGV62WIej01lGnvy40k9kalMchUKocHgn3m8VrsebV3I/vRYEQP/TOURErU/sivrbFP5Nb2Smo0w==
X-Received: by 2002:a17:902:40d:: with SMTP id 13-v6mr13581339ple.257.1538780340524;
        Fri, 05 Oct 2018 15:59:00 -0700 (PDT)
Received: from hax0rtop ([108.165.36.209])
        by smtp.gmail.com with ESMTPSA id j2-v6sm13228534pfj.91.2018.10.05.15.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 15:58:59 -0700 (PDT)
Date:   Fri, 5 Oct 2018 16:58:59 -0600
From:   Scott Tracy <scott.a.tracy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/rtlwifi: Fixing formatting warnings from
 checkpatch.pl.
Message-ID: <20181005225859.GA19554@hax0rtop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing formatting warnings in rtlwifi found by checkpatch.pl
Changes include breaking up functions calls into multi line calls.
No functional/logical changes. 

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

