Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5A1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69F620645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4SqMEyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69F620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeLESbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:31:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40585 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeLESbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:31:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so20730822wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UrwbSsilASWQXKhY8mtydhKi4I7CC/pS4q3yTCPjBas=;
        b=V4SqMEyE+s428mktMQohIEQxv4nueCOwRQp3eW1slGISeKxyNnaGmXgzCYxpXVXUFN
         6vOilwAFvOO1PWl1/3X30mckknPL8YRtOGp/w8aO3T6PD1frBAmgh1sRjA820XtGRyW/
         LnAGE3sqfscfG1VpTZWiJY4gNqaqbGr4I9xNjtI8+GEPLKXY9IrECCtqWSY5Q/Hz8A3t
         I99KtWpgHzfmmGcRX3tiBhzWfuCYKuBcd7o/SD598hdn6eLH1aQro1o4vNiSE7Q+pmi0
         kqr5tIx4mytVv0jTkvTTZ4EN9vk+XBM9A445BinuLJyn/5+nwFpaC67CMAW+tjQBgy/E
         Ppvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UrwbSsilASWQXKhY8mtydhKi4I7CC/pS4q3yTCPjBas=;
        b=FKEJHRogjuTskssWj/OzBVzLYjRVMkFKTj5Zd27ftseCKV8BxuyYEbms1i+JTdmCTQ
         i/nlNLL7JXb7Hc4j4XFelsdjLmRZjej0zaW7E7ts88nCFXQoGOzOBGKATgpD9EZPV5WW
         B7RJUX7Yd++VCKMmUi/BKwBMGLOjm7BsgTsUJf5Y+tM5YBV1rBxZcL+MpK/Ppym69HSz
         gZrjDne3k0huvPzmN0NkZf0F4D1FMqwIG0y7YMyKDmECi5nC4g7oUy2T/YaAjfeoIEfx
         8o204QI9nBcHbered7QJz9jDdJ+YPC2Uiusd1IhvISxC6sJyRBTvAmP09L20rnP+tc3J
         M1vw==
X-Gm-Message-State: AA+aEWYyCSa7aPa7a58Jv/jB06ghqFgiCmQBKvosi4Nm7rjDYU8GwXgg
        os9KKSvvePlWVtCz/2sP6CY=
X-Google-Smtp-Source: AFSGD/XhOzUvna0Aw7/aD0b1eAP1UtW1ubjaYAH4ApHzmLd7YpKxfFFsO+Wj2BIVE7gcg1KQOyvCng==
X-Received: by 2002:a05:6000:104b:: with SMTP id c11mr23236610wrx.303.1544034675419;
        Wed, 05 Dec 2018 10:31:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id a18sm27860998wrp.13.2018.12.05.10.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:31:14 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 02/12] staging: rtl8188eu: refactor cckratesonly_included()
Date:   Wed,  5 Dec 2018 19:30:50 +0100
Message-Id: <20181205183100.16828-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205183100.16828-1-straube.linux@gmail.com>
References: <20181205183100.16828-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor cckratesonly_included() to improve readability and slightly
reduce object file size. Also change the return type to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c   | 10 +++++-----
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 90160d5fc292..fac1c1c20b2f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -69,16 +69,16 @@ bool cckrates_included(unsigned char *rate, int ratelen)
 	return false;
 }
 
-int cckratesonly_included(unsigned char *rate, int ratelen)
+bool cckratesonly_included(unsigned char *rate, int ratelen)
 {
-	int	i;
+	int i;
 
 	for (i = 0; i < ratelen; i++) {
-		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-			   (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
+		u8 r = rate[i] & 0x7f;
+
+		if (r != 2 && r != 4 && r != 11 && r != 22)
 			return false;
 	}
-
 	return true;
 }
 
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index c86dec12dec2..0ade33df16d2 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -581,7 +581,7 @@ void addba_timer_hdl(struct timer_list *t);
 		  msecs_to_jiffies(ms))
 
 bool cckrates_included(unsigned char *rate, int ratelen);
-int cckratesonly_included(unsigned char *rate, int ratelen);
+bool cckratesonly_included(unsigned char *rate, int ratelen);
 
 void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr);
 
-- 
2.19.2

