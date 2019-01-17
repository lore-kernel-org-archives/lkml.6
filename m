Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E827C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2979620859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqWaUmrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfAQTXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:23:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33929 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfAQTXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:23:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so12375504wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 11:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89qquB7Rf8HBQpXRVe9oPZqu9yn+naQ0dRCk4GCwnW4=;
        b=hqWaUmrmohhbYJnVDIPP0qyNupnat1yDtfvy7tnjfuPM1roL6BHidE7Rh7fYc0tNiq
         ajVZF3bbQwNd7zie4SoLtHviAUPBi4P9Z76e+oGKPHCFVmt2xvEbnrQrC4N7tM7hq8z4
         pd4XeZpGS8SNL+ArCip+Nbe2LCDeaT7L9WoBHG7W94YZVaz77IolENuJ3x3pgthRQhKI
         2EbUlQGrhfNy0UmaFNHE0hk8GCtHKtw0ZnOvA6tcRC/m70djMWa7pKudszV0wJ92vUY6
         9TR1HixO+Ngi+YRGk6x0vNfCfMZJPAfomM8+AgtPy4vjHYRDP6Z/6bp1EONK2TVI4OFU
         7CMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89qquB7Rf8HBQpXRVe9oPZqu9yn+naQ0dRCk4GCwnW4=;
        b=kb8lA3Zen9cs52luShQ9hV7xpN7oa6hm7pFsVDOkFWz/zpexWNl815+9DJw37JvsPW
         X2FDwpWmrkgKCGmXKfAocA/E2HckIqJJhm/Uf9l7nQ1K/GIkyhlBwNnuPdLCB8fQIsOS
         TYWToE8sNn51eCSMiJ0zcUlU1Wy0s0Dj8WsZNvcroMx6x6GEzxza9X4hw2HtLAhBm2E/
         HmGdUuGvArBwIcieLlLDHSzR4NJbCe5wmImLNify2OuJIeXldPPmqugNrol5jCLm0VuI
         BeZ0kKAuHNxd5v1ElgvgwynVN9t3KwkIpAhVSCvq3xbLCyWMaa89/9syLI3W8I2075VS
         /x2g==
X-Gm-Message-State: AJcUukdpV8y1jAJWL1+SmT5DXc/exFzjl8BiX1nvvkAILnjSmGSne3g3
        5Xp2V0gY7D/oiaSh4FCDpISecy18dw4=
X-Google-Smtp-Source: ALg8bN60ynyoqOHz5E9t5cuiWyrZiwgaK4hlPL6X/TbKM3yAVHtLZeIWu5ElooN+lSUk7MTFgcdqRw==
X-Received: by 2002:adf:fa83:: with SMTP id h3mr14128507wrr.173.1547752997235;
        Thu, 17 Jan 2019 11:23:17 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id l14sm167069378wrp.55.2019.01.17.11.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 11:23:16 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: add spaces around operators in mlme_linux.c
Date:   Thu, 17 Jan 2019 20:23:00 +0100
Message-Id: <20190117192301.17579-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '+' and '-' to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
index d5ceb3beabbc..8180769610c3 100644
--- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
@@ -99,13 +99,13 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 		memset(buff, 0, IW_CUSTOM_MAX);
 		p = buff;
 		p += sprintf(p, "ASSOCINFO(ReqIEs =");
-		len = sec_ie[1]+2;
+		len = sec_ie[1] + 2;
 		len =  min_t(uint, len, IW_CUSTOM_MAX);
 		for (i = 0; i < len; i++)
 			p += sprintf(p, "%02x", sec_ie[i]);
 		p += sprintf(p, ")");
 		memset(&wrqu, 0, sizeof(wrqu));
-		wrqu.data.length = p-buff;
+		wrqu.data.length = p - buff;
 		wrqu.data.length = min_t(__u16, wrqu.data.length, IW_CUSTOM_MAX);
 		wireless_send_event(adapter->pnetdev, IWEVCUSTOM, &wrqu, buff);
 		kfree(buff);
-- 
2.20.1

