Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3F8C468C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441AE21479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS/3+lLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441AE21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeGLKp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:45:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42834 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeGLKp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:45:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id g12-v6so21493396edi.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=anKfC4aCnw8IkdbS9m18e4upLpD9da7Lj0mtfsM3I/0=;
        b=JS/3+lLkPUBMnEdOzJ3++2UAUZQdvAypk4grDNteGIumxkr1MhQcGmuwOTZrpn5v4z
         Dmpff8uwdh365lzFrAY5OitA2t5AIpCNry8TGfzvQCxlapVL3zGXXpqfWDSDHRYG07xg
         hz1hkRBGzTB1ji+a0bfAbDReA6T12yv/RFhA7VrmMf5+vmza/zh8lLjV8481lGiDmjiK
         Y8Q0vyntOvPYK2G+T/m9hoErm8ninJHx+ySIL4MVUKIzQshr0lyZ9uUxwhJrvlESu8iP
         te/tnBncs4K4uEemnVYtoclpeCVtFOwFHx6xmlvjeVYGeXU5+caVI7F9wdo2lrayA5SH
         okdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=anKfC4aCnw8IkdbS9m18e4upLpD9da7Lj0mtfsM3I/0=;
        b=kIFeBv9KPIF9w+W7Ov/mXAONVPkybn18pOX3WziWO1JHAEkdxmpCQt2298y6GoIOfU
         EJqx1bepnkLJxqjIBhBpt9umxZf+Adcp403Zb1jaaTxJutXhcQxh+U1amYvBZe+7Th/0
         2mPpu/N67nMFYHRjRnXvbZXrIKFpquLLoZKe8vVewfo8nRguFLbfTH7ewLiBbGbP5//1
         Akfn6a8rHKJ7O+A1hXQuA0PbNphaSfmcW3GfcoIF5ZH1mqJgy5sdUy3ZOhq2bCoHhTJ8
         kKv3gDlbz2eR05sOxW7AxS/sYbeEQyGKP5lyuxlIM8C/0OcQ7oBVux0BnhaECD8/atk4
         qaRg==
X-Gm-Message-State: AOUpUlErlDm3y7trYHPBU2P9sWzbZMIijjCT4cd5VBLrCPUGQlKbpzsA
        oxI/s/si0Gh2Wm2M5BMf3iC2uIF9AjE=
X-Google-Smtp-Source: AAOMgpehgzKLtdfDNJ9/qJBLQY9IRLTVURimKIiI+7P/Jfl5JuCPx68nno3pwwui7KsHwGHR2ItEQg==
X-Received: by 2002:a50:8d46:: with SMTP id t6-v6mr1928217edt.238.1531391789358;
        Thu, 12 Jul 2018 03:36:29 -0700 (PDT)
Received: from arch.localdomain (x4d0a32b7.dyn.telefonica.de. [77.10.50.183])
        by smtp.gmail.com with ESMTPSA id r11-v6sm3661567edh.32.2018.07.12.03.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 03:36:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: rtl8723bs: change return type to bool
Date:   Thu, 12 Jul 2018 12:36:09 +0200
Message-Id: <20180712103610.19532-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712103610.19532-1-straube.linux@gmail.com>
References: <20180712103610.19532-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both rtw_is_cckrates_included() and rtw_is_cckratesonly_included()
return true or false. Change the return type from uint to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 ++--
 drivers/staging/rtl8723bs/include/ieee80211.h  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index e4a20a4a5e59..62718045f3cc 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -66,7 +66,7 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
 	return 0;
 }
 
-uint rtw_is_cckrates_included(u8 *rate)
+bool rtw_is_cckrates_included(u8 *rate)
 {
 	while (*rate) {
 		u8 r = *rate & 0x7f;
@@ -79,7 +79,7 @@ uint rtw_is_cckrates_included(u8 *rate)
 	return false;
 }
 
-uint rtw_is_cckratesonly_included(u8 *rate)
+bool rtw_is_cckratesonly_included(u8 *rate)
 {
 	while (*rate) {
 		u8 r = *rate & 0x7f;
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 974e922f54fa..bcc8dfa8e672 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -1169,9 +1169,9 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv);
 
 int rtw_get_bit_value_from_ieee_value(u8 val);
 
-uint	rtw_is_cckrates_included(u8 *rate);
+bool rtw_is_cckrates_included(u8 *rate);
 
-uint	rtw_is_cckratesonly_included(u8 *rate);
+bool rtw_is_cckratesonly_included(u8 *rate);
 
 int rtw_check_network_type(unsigned char *rate, int ratelen, int channel);
 
-- 
2.18.0

