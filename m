Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D7DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF2C2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6HF3eL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF2C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeICWq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:46:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34770 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeICWqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:46:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id g33-v6so1530065wrd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fCz7qgNiL82bDGI7f/Mz4I10Q6LE62flx0ZNAeaSw/Y=;
        b=O6HF3eL6MzUC1CdGiHx2LKyxUqJueFGPpURJJd4IETlFeHd1lTsPqpECchT79aRDKP
         mPvDoucofT8NgGXBBjxf1+tGurP9rFz5l5a23tskdst2B87izUvJ18BwacsXvkElgj3d
         nR3ob1DSDmne4tjS1KzvJBGa2NGWDuqh4qyWoo6Ueh/KYHXz9odwpORi88iQZabn7Sm6
         Tq9fkze40B3NUQUI3j4TR+HDHbEcid+2c6LinWvxeBvJirQBQ5GkQ6OT50n2dABlgWXq
         AXp6hnXOB4m8RiP4kxR6MaTWDi4cAYyLpIz6yks9rV/8jdK7qK61hU7MYETrU58SpaNK
         nKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fCz7qgNiL82bDGI7f/Mz4I10Q6LE62flx0ZNAeaSw/Y=;
        b=IK7SeATxYKwcHvFgfsZyOcjrMJe1U3Zfo3C7jXpqxqI3besO9parzCTa4aUxhM3rhA
         cQvSKmydd7R3CNpZK+TpqKo9rrDFzERtw/qsAzrsgxyRPXKtuPTM6TGdZT4V7sDoZGn1
         ldFNosWHLwcYObXUBrpjeRrChciB7onhatumpVxjR8srBt5XNUXXQnS+0Xyxpt1+73OG
         ZSzemOYxJqUesR7cnUqFX9eROTPeCS1CusvkyBKH0pWOpSiJsBfy7uSz/T/vOXmeHwcH
         ojf284aVl+OKWCOaAisUZ5TNWH97L8XOC/k66nMVDGXNnYIiCj6jsG9FgFfeT1cuW2ys
         j1OQ==
X-Gm-Message-State: APzg51AG0o7PV+lTeVhENGOJkKJdxtdpaWVWkiLoAZx/G8rfjzgYFCRt
        uQvUANfPyIFQN5UyDxX9oIxMDG8L
X-Google-Smtp-Source: ANB0Vdbg6me939D64tiKETi/iyfth6HGqIWArlMoZbl0rfLOPGLYtZxuE1KE8V8DoXGqMs+igTsUDg==
X-Received: by 2002:adf:9081:: with SMTP id i1-v6mr20938746wri.271.1535999100266;
        Mon, 03 Sep 2018 11:25:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id v46-v6sm24201349wrc.63.2018.09.03.11.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:24:59 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: rtl8188eu: remove unnecessary parentheses
Date:   Mon,  3 Sep 2018 20:24:45 +0200
Message-Id: <20180903182445.1969-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903182445.1969-1-straube.linux@gmail.com>
References: <20180903182445.1969-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses to follow kernel coding style
and clean checkpatch issues.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index a911c254b386..3e0801858737 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -108,7 +108,7 @@ u8 judge_network_type(struct adapter *padapter, unsigned char *rate, int ratelen
 {
 	u8 network_type = 0;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pmlmeinfo->HT_enable)
 		network_type = WIRELESS_11_24N;
@@ -1414,13 +1414,13 @@ void update_wireless_mode(struct adapter *padapter)
 	int ratelen, network_type = 0;
 	u32 SIFS_Timer;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
 	unsigned char *rate = cur_network->SupportedRates;
 
 	ratelen = rtw_get_rateset_len(cur_network->SupportedRates);
 
-	if ((pmlmeinfo->HT_info_enable) && (pmlmeinfo->HT_caps_enable))
+	if (pmlmeinfo->HT_info_enable && pmlmeinfo->HT_caps_enable)
 		pmlmeinfo->HT_enable = 1;
 
 	if (pmlmeinfo->HT_enable)
-- 
2.18.0

