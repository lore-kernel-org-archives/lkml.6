Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CDBECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0359F2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahlxezMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0359F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeGPOvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:51:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37437 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeGPOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:51:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so2904295eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B1NeOrjJcGq/b2IjOTeSOJbGAv6ojqfK3iBRm+bbJAA=;
        b=ahlxezMYA+zz9CagrPj/RBXMP7WwgOr/mG96ZuJPrymTqVHeIIUg0K5yxvfWOWye5S
         8zymsV8pnoi7Pb7t8dOLwBIn6VQTCVmDORc2JUwabLlWDC7e9lX4UtkUnil+SbU/3wyv
         XOfLDQsqop5LjHE1XgSPY72uOg3Ycl1FGs4S0zi6uQxl7X79Lr4ZmuLZ4H47Ro/i0Obp
         5Och20nlLDzqmut7Ly4WSUj+6z54gMXoHmgkSCxGOQZl3ngW4IitzVvdW8Iu2lsr/kq4
         6F/nIlPJ3ncK9NjVaG6aHhk83Hm4tZLb4GPp21LAdqoS9e1zIFApDmXJGEP+gXgo17XY
         TMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B1NeOrjJcGq/b2IjOTeSOJbGAv6ojqfK3iBRm+bbJAA=;
        b=DiX5H/INrj10HEJW/XyGUZwanSyL7tgtCqkStVEIFz5gokF7OAfcCmnas4ZEGO8ocn
         686gA0YyRIhlTKoFcnbtdD6/mNGdFXaFZKg7CWFJyG3jYWojUadNuysIAgYiu79y/Af9
         CnK0Yn7zSOvv/5K+tuipXb8MKbojSzXwO8qtl2fi3YTtw5i+a95AwG++ZPZajIXqgH5u
         RKkSn/XAdasCt1ONupP6QmmAxrUrW2GMmouHetQIet5XpSwG/fkeVO4aSuV2sEbFMjL/
         eOlYjtBzrLpeZr9axH5jm2qP8qULiqn7Zfume4uLPgTkD+D96GDSPBywg9Y9t5SDYvpX
         +g2A==
X-Gm-Message-State: AOUpUlH3xisXpkCIW5rN27ipEIvypJvogqDwrPUoYF4npRjy5s+quZtj
        JB6KGsKkpWIzxXSDQWLAMcg=
X-Google-Smtp-Source: AAOMgpc6BhvgOu/f0JB/fK26DHgs8Lbz5kqSWJVze8tYrO8TfkrzYROUJw4vPqW2GGwsF80w6RXeZw==
X-Received: by 2002:a50:9069:: with SMTP id z38-v6mr17898463edz.79.1531750999106;
        Mon, 16 Jul 2018 07:23:19 -0700 (PDT)
Received: from arch.localdomain (x4db296c4.dyn.telefonica.de. [77.178.150.196])
        by smtp.gmail.com with ESMTPSA id o12-v6sm3264874edj.54.2018.07.16.07.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 07:23:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: remove MacAddr_isBcst macro
Date:   Mon, 16 Jul 2018 16:23:02 +0200
Message-Id: <20180716142303.1627-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_broadcast_ether_addr instead of the MacAddr_isBcst macro.
The macro is not used anywhere else, so remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 2 +-
 drivers/staging/rtl8188eu/include/wifi.h  | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 53c65d5463c0..2edc3a8242b1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -549,7 +549,7 @@ static void count_rx_stats(struct adapter *padapter,
 
 	padapter->mlmepriv.LinkDetectInfo.NumRxOkInPeriod++;
 
-	if ((!MacAddr_isBcst(pattrib->dst)) && (!IS_MCAST(pattrib->dst)))
+	if (!is_broadcast_ether_addr(pattrib->dst) && !IS_MCAST(pattrib->dst))
 		padapter->mlmepriv.LinkDetectInfo.NumRxUnicastOkInPeriod++;
 
 	if (sta)
diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index a41e8eda02fb..4a56e54e38f6 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -257,13 +257,6 @@ enum WIFI_REG_DOMAIN {
 
 #define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
 
-#define MacAddr_isBcst(addr) \
-	( \
-	((addr[0] == 0xff) && (addr[1] == 0xff) && \
-	(addr[2] == 0xff) && (addr[3] == 0xff) && \
-	(addr[4] == 0xff) && (addr[5] == 0xff))  ? true : false \
-)
-
 static inline int IS_MCAST(unsigned char *da)
 {
 	if ((*da) & 0x01)
-- 
2.18.0

