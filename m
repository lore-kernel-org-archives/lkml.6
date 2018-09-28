Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A39C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA49C216FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA49C216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeI1IeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:34:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbeI1IeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:34:19 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0FBEA49950632;
        Fri, 28 Sep 2018 10:12:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Fri, 28 Sep 2018 10:12:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] staging: rtlwifi: Remove set but not used variable 'ppsc'
Date:   Fri, 28 Sep 2018 02:21:53 +0000
Message-ID: <1538101313-161546-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c: In function 'halbtc_leave_lps':
drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c:284:21: warning:
 variable 'ppsc' set but not used [-Wunused-but-set-variable]

drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c: In function 'halbtc_enter_lps':
drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c:307:21: warning:
 variable 'ppsc' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c b/drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c
index 85a7490..24e19ff 100644
--- a/drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c
+++ b/drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c
@@ -281,11 +281,9 @@ bool halbtc_send_bt_mp_operation(struct btc_coexist *btcoexist, u8 op_code,
 static void halbtc_leave_lps(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv;
-	struct rtl_ps_ctl *ppsc;
 	bool ap_enable = false;
 
 	rtlpriv = btcoexist->adapter;
-	ppsc = rtl_psc(rtlpriv);
 
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_AP_MODE_ENABLE,
 			   &ap_enable);
@@ -304,11 +302,9 @@ static void halbtc_leave_lps(struct btc_coexist *btcoexist)
 static void halbtc_enter_lps(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv;
-	struct rtl_ps_ctl *ppsc;
 	bool ap_enable = false;
 
 	rtlpriv = btcoexist->adapter;
-	ppsc = rtl_psc(rtlpriv);
 
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_AP_MODE_ENABLE,
 			   &ap_enable);

