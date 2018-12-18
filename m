Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66546C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367D7218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4YF55gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeLRSfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:35:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39719 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbeLRSfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so16964776wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mkGU+pakA/ERLfp0HzyjltVQvmKbGRm6yLWbJSoNomg=;
        b=K4YF55gvQ1bLPvToTdYWziwnnnDJBMZ11G6ltzaQJjLGqmvRdG89nmiwQlemUouJ0e
         z3MnHeYMTJw3EIHnEy/KRQpOROwlnFRDi34x+MFccbCdBc3tL3JKgsxw8bdk5JiYlU8G
         oVhy+/JcZe3kNvh+0felAObJo2l1aOgLEUbF0xtPpKVuSBVeA9Djq0U1lI/ZSTp+oFAM
         y/valFSphME9g7iwhrfHpS//61OfIoluUTyheWm+RprAVn5UFmuzUlhz98Tv0Wcmqj31
         dhoQ30zAeSGmmgwL18wyvj696whbA3sgTSgwcTg7KBGDU1nksMHxRdrKBysG6Y20FUYE
         YGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mkGU+pakA/ERLfp0HzyjltVQvmKbGRm6yLWbJSoNomg=;
        b=nIdSq6q6YE9jjHagGJKn05sky5YNB1CdRzqXTISdhxI7o1lTIyAJixiGNNJywKm3pE
         CZoKlM4yeMY1FpsbX7nhRrnewiRnjxeGA9fU0Q2L2FNcqXQfNZmAMlqz9iZy9J0Va87d
         6NIg0o6runSuMrGQ6VNkrRvKrJVTxROAeTH1OP1QS8EOGi52602geCZI8japoQwxaKb/
         LrO4mITBE6vsZAqUHoRhg5x225qfwlI9YCbYG0D17SHi5fq/nmSyoH1602EKuhTt3lrh
         qxztIBNTDrVGaTeLmU+L8UFGWPi/x0zAVrVLq3GsO1vmTFFLjAbTWAvNnT84V2dRlmzB
         eONA==
X-Gm-Message-State: AA+aEWbKi1X5xJMYRIvCaepKy/gYhOxY8F9lsBu2Y7NXimt5RF4QAdDe
        6hGk5TbDNErHwvzeGR34vPNKqEe2
X-Google-Smtp-Source: AFSGD/XjbDjjSn8rGESWV3p8dF9Q9k+b5YE4j29ZP9gaVwjpaBHkQAWW8VV6pNo/yiW9HJKV2FxQtA==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr15076569wrw.323.1545158109419;
        Tue, 18 Dec 2018 10:35:09 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:08 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 02/17] staging: rtl8188eu: replace tabs with spaces in rtw_mlme_ext.c
Date:   Tue, 18 Dec 2018 19:34:36 +0100
Message-Id: <20181218183451.18692-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces where appropriate.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 5c485777e482..8c566180d808 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -4025,7 +4025,7 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan,
 	return chanset_size;
 }
 
-int	init_mlme_ext_priv(struct adapter *padapter)
+int init_mlme_ext_priv(struct adapter *padapter)
 {
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -5205,7 +5205,7 @@ u8 setauth_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 	if (pparm->mode < 4)
 		pmlmeinfo->auth_algo = pparm->mode;
-	return	H2C_SUCCESS;
+	return H2C_SUCCESS;
 }
 
 u8 setkey_hdl(struct adapter *padapter, u8 *pbuf)
@@ -5310,7 +5310,7 @@ u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf)
 	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, pparm->addr);
 
 	if (!psta)
-		return	H2C_SUCCESS;
+		return H2C_SUCCESS;
 
 	if (((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && (pmlmeinfo->HT_enable)) ||
 	    ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)) {
@@ -5320,7 +5320,7 @@ u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf)
 	} else {
 		psta->htpriv.candidate_tid_bitmap &= ~BIT(pparm->tid);
 	}
-	return	H2C_SUCCESS;
+	return H2C_SUCCESS;
 }
 
 u8 set_tx_beacon_cmd(struct adapter *padapter)
@@ -5471,7 +5471,7 @@ u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf)
 
 	set_channel_bwmode(padapter, set_ch_parm->ch, set_ch_parm->ch_offset, set_ch_parm->bw);
 
-	return	H2C_SUCCESS;
+	return H2C_SUCCESS;
 }
 
 u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf)
@@ -5487,5 +5487,5 @@ u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf)
 	pmlmeext->max_chan_nums = init_channel_set(padapter, setChannelPlan_param->channel_plan, pmlmeext->channel_set);
 	init_channel_list(padapter, pmlmeext->channel_set, pmlmeext->max_chan_nums, &pmlmeext->channel_list);
 
-	return	H2C_SUCCESS;
+	return H2C_SUCCESS;
 }
-- 
2.20.1

