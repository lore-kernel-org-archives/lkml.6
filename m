Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AF9C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4393020645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY4hptQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4393020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeLESbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:31:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36550 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbeLESbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:31:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id a18so14011447wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rh9g6iQGgmsRqteCQpodfWNae4zQKq+UcS1BPo1M4wI=;
        b=ZY4hptQ7JwtMzAC/uS8SEzLbWSm4tlNwTFtVXLvQu3jVWxTel4rAAb2yC3QoeqqOAE
         ROIoiCbBIG+iruKc58McskpVilvwKq2/uHDRETrjGGCgifF4qjs8THI82F/olJrVjdjl
         +YQDhV9ugesr4B10OgqbEF6ov6xmMP+hQ9+J2o6//MyDxLkKFF37/pJs+ZnQH71ORk6f
         w2MwcSi39499Y9dc9wSdDPvj9h26fVYiAM35Gfje4UHtpDsEXUf8zdj1HuRM6T0z7C4w
         5E6eVV1e7eOMD2OSGp2nFXADOeoEtDalHt6dG3Bw/6E+XWC8G4TII7oUfMy5CIiHP5Qc
         mLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rh9g6iQGgmsRqteCQpodfWNae4zQKq+UcS1BPo1M4wI=;
        b=FTb2RNv0SxXrXxaJkluLKoUsG2VYh2FqlAAGikf7DiknD1SAGKVhw8sNwyHIhQbf67
         VmjCinXwfQDRj9h/2ZrvmQlZ34NXeKN4MN1kynsJTMnRI/YQUWvu6uSKT6v2sVoG/njn
         BZU/nEn0Zyu2kkhMSsk+SO3B8q2nHg+Pq0DWl/2WD0JXe5l+3fq3vwgkN0T60qGYX646
         yWrkQmibvuOD1/6RPOZf1Tj2yglRItC/tzaZB/FFU4XryAyjCWW5DTFH3os8DCZuS19V
         ln9qCLtoCurJ+LHbzupPfFnYvvLTn4WapflXXQMR0GKnZujPk5nXODmXVxUuWaEPs9sL
         inyA==
X-Gm-Message-State: AA+aEWYgwGexj2O74HwLjR6GF3hhrLSE9yJ63afWxc5wimy5cahZkMue
        NWh4v9SSeGSnCqdkyFBChGQ=
X-Google-Smtp-Source: AFSGD/UGLxvGdmPaWb7Um29s+vxwxm22BwqQH2mB/yTHgDt/QYN9UGZRd1DKKxlCIteByYVH+FXXdQ==
X-Received: by 2002:a1c:90cb:: with SMTP id s194mr7406584wmd.57.1544034683446;
        Wed, 05 Dec 2018 10:31:23 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id a18sm27860998wrp.13.2018.12.05.10.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:31:22 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 10/12] staging: rtl8188eu: replace if else with ternary operator
Date:   Wed,  5 Dec 2018 19:30:58 +0100
Message-Id: <20181205183100.16828-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205183100.16828-1-straube.linux@gmail.com>
References: <20181205183100.16828-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace if else with a single call and ternary operator to
slightly reduce object file size. Also clears a checkpatch
warning: WARNING: Statements should start on a tabstop

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 7af3dd910c93..9a20faad96c9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -1440,10 +1440,9 @@ void update_wireless_mode(struct adapter *padapter)
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_RESP_SIFS,  (u8 *)&SIFS_Timer);
 
-	if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
-		update_mgnt_tx_rate(padapter, IEEE80211_CCK_RATE_1MB);
-	 else
-		update_mgnt_tx_rate(padapter, IEEE80211_OFDM_RATE_6MB);
+	update_mgnt_tx_rate(padapter,
+			    pmlmeext->cur_wireless_mode & WIRELESS_11B ?
+			    IEEE80211_CCK_RATE_1MB : IEEE80211_OFDM_RATE_6MB);
 }
 
 void update_bmc_sta_support_rate(struct adapter *padapter, u32 mac_id)
-- 
2.19.2

