Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680A0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165C82172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pv+4/cAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165C82172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cpan.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeHCGbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 02:31:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43886 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbeHCGbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 02:31:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so2535257pfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 21:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YXsKfW1sTmBVP3ASBJGLVLnkiKpDrrkO9PQ+vtiWtMo=;
        b=pv+4/cAGKcxDOP1MK7ejvsFab3DCaqdMurjRHlaLpVdqYVEOI206fLDFKXyCipFvph
         RUUQpOIP8/BsyMvV6DVi2VB7UmYCnkYnUZ9EPDbsy+nniv3CX6Ex0O+GTrzK00Ksh8m+
         YZ51avCMpmFrrR6uMGkaolOTsBjb6s7Y+HQmpLsHOEcOYniG+X0zYTfaJCYStEFfVeBa
         rwT2of72U2ZlzF/u9bQ33jakSfFSl54oKdtpdgJCo9nC9Ryv5/fblvDQ6mWDUJs9MuOL
         ylxkwoCDwvs4+Vpa+6lCn92Bq8fJETDqFS9CWTF4a4EG4ev3pjPfJE/bAgnesLfLEXPO
         kARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=YXsKfW1sTmBVP3ASBJGLVLnkiKpDrrkO9PQ+vtiWtMo=;
        b=B+dG4anNKyVq5Dsbt/VUI3KtCJeZUyhUsEwbdkNngrIPL2qTCGLnIl6RxXn4nbomaJ
         nDGFoEig1lq49oIwmfyRhPorE4+OqjqUiVYFVNDyNhXCEf+6QqkEalMQObTtXyfyQxCE
         gri2buFMsrhM12gfTIM8K5qCg09uVwxYL9PNm8MAFxktFCZ0yFpkJOJUUGAevEQT5/MR
         OikjEfFMLDeeZijqpfXKcCdZt/rmZ1Gh1HQw6KTgJjeJCwvbPLcBbz9PuKl1ZZoHCw77
         1bi1DNCRJxKf6Lpg6pZ5yL6lQx+611ZxS/nHCkgZLpUprRKGIR9B5QSDuoYHaXzVdy9d
         glug==
X-Gm-Message-State: AOUpUlF6tJENHw31zrtcIHDOb8DcSFaL1bhbqrXmeA9Zxp3D3yJfh+7z
        b6v8ejNztVopyNq1jIPswEoY3Jll
X-Google-Smtp-Source: AAOMgpfpMXYXynd9FfPxnyC7mRJGTl5OfJwJnsIWZJElAgn0HbG5+N5lQB1EygV2dYFrgORBX0CgAw==
X-Received: by 2002:a62:9f1d:: with SMTP id g29-v6mr2517643pfe.207.1533271039198;
        Thu, 02 Aug 2018 21:37:19 -0700 (PDT)
Received: from cd80.lan (124-170-1-73.dyn.iinet.net.au. [124.170.1.73])
        by smtp.gmail.com with ESMTPSA id e126-v6sm7141387pfg.31.2018.08.02.21.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 21:37:18 -0700 (PDT)
Date:   Fri, 3 Aug 2018 14:37:13 +1000
From:   Luke Triantafyllidis <ltriant@cpan.org>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net
Subject: [PATCH v2] staging: rtlwifi: refactor rtl_get_tcb_desc
Message-ID: <20180803043713.GA52848@cd80.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactored rtl_get_tcb_desc slightly to stay within the 80 character
line limit.

Signed-off-by: Luke Triantafyllidis <ltriant@cpan.org>
---

Changes in v2:
 - Fixed the formatting of the comments
 - Unwrapped some of the lines that were originally wrapped over multiple
   lines to stay within the 80 character limit

Note:
 - I didn't CC the first version of this patch to a public mailing list, so if
   you're not Greg KH, you probably want to look at this in its entirety

 drivers/staging/rtlwifi/base.c |  102 +++++++++++++++++++---------------------
 1 files changed, 48 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/rtlwifi/base.c b/drivers/staging/rtlwifi/base.c
index e46e47d..b1b2f78 100644
--- a/drivers/staging/rtlwifi/base.c
+++ b/drivers/staging/rtlwifi/base.c
@@ -1237,67 +1237,61 @@ void rtl_get_tcb_desc(struct ieee80211_hw *hw,
 	if (rtl_is_tx_report_skb(hw, skb))
 		tcb_desc->use_spe_rpt = 1;
 
-	if (ieee80211_is_data(fc)) {
-		/*
-		 *we set data rate INX 0
-		 *in rtl_rc.c   if skb is special data or
-		 *mgt which need low data rate.
-		 */
-
-		/*
-		 *So tcb_desc->hw_rate is just used for
-		 *special data and mgt frames
-		 */
-		if (info->control.rates[0].idx == 0 ||
-		    ieee80211_is_nullfunc(fc)) {
-			tcb_desc->use_driver_rate = true;
-			tcb_desc->ratr_index =
-					SET_RATE_ID(RATR_INX_WIRELESS_MC);
+	if (!ieee80211_is_data(fc)) {
+		tcb_desc->use_driver_rate = true;
+		tcb_desc->ratr_index = SET_RATE_ID(RATR_INX_WIRELESS_MC);
+		tcb_desc->disable_ratefallback = 1;
+		tcb_desc->mac_id = 0;
+		tcb_desc->packet_bw = false;
 
-			tcb_desc->disable_ratefallback = 1;
-		} else {
-			/* because hw will never use hw_rate
-			 * when tcb_desc->use_driver_rate = false
-			 * so we never set highest N rate here,
-			 * and N rate will all be controlled by FW
-			 * when tcb_desc->use_driver_rate = false
-			 */
-			if (sta && sta->vht_cap.vht_supported) {
-				tcb_desc->hw_rate =
-				_rtl_get_vht_highest_n_rate(hw, sta);
-			} else {
-				if (sta && sta->ht_cap.ht_supported) {
-					tcb_desc->hw_rate =
-					    _rtl_get_highest_n_rate(hw, sta);
-				} else {
-					if (rtlmac->mode == WIRELESS_MODE_B) {
-						tcb_desc->hw_rate =
-						    rtlpriv->cfg->maps[RTL_RC_CCK_RATE11M];
-					} else {
-						tcb_desc->hw_rate =
-						    rtlpriv->cfg->maps[RTL_RC_OFDM_RATE54M];
-					}
-				}
-			}
-		}
+		return;
+	}
 
-		if (is_multicast_ether_addr(hdr->addr1))
-			tcb_desc->multicast = 1;
-		else if (is_broadcast_ether_addr(hdr->addr1))
-			tcb_desc->broadcast = 1;
+	/*
+	 * We set data rate INX 0
+	 * in rtl_rc.c if skb is special data or
+	 * mgt which need low data rate.
+	 */
 
-		_rtl_txrate_selectmode(hw, sta, tcb_desc);
-		_rtl_query_bandwidth_mode(hw, sta, tcb_desc);
-		_rtl_qurey_shortpreamble_mode(hw, tcb_desc, info);
-		_rtl_query_shortgi(hw, sta, tcb_desc, info);
-		_rtl_query_protection_mode(hw, tcb_desc, info);
-	} else {
+	/*
+	 * So tcb_desc->hw_rate is just used for
+	 * special data and mgt frames
+	 */
+	if (info->control.rates[0].idx == 0 || ieee80211_is_nullfunc(fc)) {
 		tcb_desc->use_driver_rate = true;
 		tcb_desc->ratr_index = SET_RATE_ID(RATR_INX_WIRELESS_MC);
+
 		tcb_desc->disable_ratefallback = 1;
-		tcb_desc->mac_id = 0;
-		tcb_desc->packet_bw = false;
+	} else if (sta && sta->vht_cap.vht_supported) {
+		/*
+		 * Because hw will never use hw_rate
+		 * when tcb_desc->use_driver_rate = false
+		 * so we never set highest N rate here,
+		 * and N rate will all be controlled by FW
+		 * when tcb_desc->use_driver_rate = false
+		 */
+		tcb_desc->hw_rate = _rtl_get_vht_highest_n_rate(hw, sta);
+	} else if (sta && sta->ht_cap.ht_supported) {
+		tcb_desc->hw_rate = _rtl_get_highest_n_rate(hw, sta);
+	} else {
+		enum rtl_var_map var = RTL_RC_OFDM_RATE54M;
+
+		if (rtlmac->mode == WIRELESS_MODE_B)
+			var = RTL_RC_CCK_RATE11M;
+
+		tcb_desc->hw_rate = rtlpriv->cfg->maps[var];
 	}
+
+	if (is_multicast_ether_addr(hdr->addr1))
+		tcb_desc->multicast = 1;
+	else if (is_broadcast_ether_addr(hdr->addr1))
+		tcb_desc->broadcast = 1;
+
+	_rtl_txrate_selectmode(hw, sta, tcb_desc);
+	_rtl_query_bandwidth_mode(hw, sta, tcb_desc);
+	_rtl_qurey_shortpreamble_mode(hw, tcb_desc, info);
+	_rtl_query_shortgi(hw, sta, tcb_desc, info);
+	_rtl_query_protection_mode(hw, tcb_desc, info);
 #undef SET_RATE_ID
 }
 
-- 
1.7.1

