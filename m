Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54093C468C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B62B213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo2Ds1RD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B62B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeGLKp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:45:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40300 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeGLKp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:45:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id e19-v6so21493304edq.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=97Hwk7qyw/2m/Ri383OvmGWSE3E5FauAWWiEzY1T4YQ=;
        b=Qo2Ds1RD2YTIAP0vtsn47m6ga/S3rBVsWyQG+wuUcDEMWp5Bt3Zr/cOiLz4NUtAeSo
         6PR9yivWMrBtL3m2nivtEiPPVpH/i0/EikBn9VX25Sil8Fss+36ARJ/RL7sLV3ExQZOd
         D5AOZF6xcvOeXe2JsDdn5FKhMTvtHAHbXob8xlHo8LSzxbQooUpZVGYCmAIsyJ7Y5Ebt
         eb7n/YxAjQlRVoxFpctsBpFi3cP9TsLImkdmJV2MuqKQeg6iLAUlRJpw7nQsxbjVrF0F
         HncElN38KS207iWngWsUW0XPGYA/6KtGksXvlPA5TB63qmnWFsa8ScSvJ9b1ZWu2Ro3/
         5BWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=97Hwk7qyw/2m/Ri383OvmGWSE3E5FauAWWiEzY1T4YQ=;
        b=anbrzwoQY/iAG+ZhHE0DkqCqpAeNsKK+M9KpMQVnUSwdYoRXDV9lU7ZTTE5p8scnuq
         rVEvNcagioMQiUuCrBZJYRtjMTFJOqe5cQlLVqS2Oz+IMoY/vJW7sxmNPenGiiL8DUec
         1DhrtgfGTyoVX/Ga6Ok8fkOWaPaLmHgn4s8f1m7hJQwb0kYT4XXSRazItZWzWR4NqegC
         WO6vTjq/EL3NXIAxjYqJhJMWr5LViSKbRyC+uqJgCerVEnslYgMGekJUUKA/L2WWAc/B
         pQGMCIqOdcMmZ3Xmq6caleptG/ABcTVBP8r/WU4zcCVOJj6rzd24h4h7wiWx9FR1HR9F
         XlNQ==
X-Gm-Message-State: AOUpUlGwwwvJQ1oav0ZXsb2X3GnqPmtHilOkbOA0+A7U/SnRsE20+miT
        xBU4SvvTREwbaYGJY4ol0zk=
X-Google-Smtp-Source: AAOMgpfr4PPA0dVcgEFTc66XbeQ+bGsUEUJA8LkklUZaWpNobUIWVPSRZ+Me95AewM3KxvySEUN2Qg==
X-Received: by 2002:aa7:da16:: with SMTP id r22-v6mr2035786eds.54.1531391788007;
        Thu, 12 Jul 2018 03:36:28 -0700 (PDT)
Received: from arch.localdomain (x4d0a32b7.dyn.telefonica.de. [77.10.50.183])
        by smtp.gmail.com with ESMTPSA id r11-v6sm3661567edh.32.2018.07.12.03.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 03:36:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: rtl8723bs: refactor rtw_is_cckratesonly_included
Date:   Thu, 12 Jul 2018 12:36:08 +0200
Message-Id: <20180712103610.19532-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712103610.19532-1-straube.linux@gmail.com>
References: <20180712103610.19532-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor rtw_is_cckratesonly_included() to improve readability and
slightly reduce object file size.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 3adb58759d5f..e4a20a4a5e59 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -81,13 +81,12 @@ uint rtw_is_cckrates_included(u8 *rate)
 
 uint rtw_is_cckratesonly_included(u8 *rate)
 {
-	u32 i = 0;
+	while (*rate) {
+		u8 r = *rate & 0x7f;
 
-	while (rate[i] != 0) {
-		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-		     (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
+		if (r != 2 && r != 4 && r != 11 && r != 22)
 			return false;
-		i++;
+		rate++;
 	}
 
 	return true;
-- 
2.18.0

