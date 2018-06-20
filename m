Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22AEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBCD20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8nbsTQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBCD20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbeFTJuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:50:37 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41056 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeFTJuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:50:35 -0400
Received: by mail-pg0-f67.google.com with SMTP id l65-v6so1242758pgl.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6HA+Sc4127VnR0XoCzgvAGfwoxhAqa6oSGaBN0apa5A=;
        b=p8nbsTQd5fjhA+lMZ94m6kKoevAchxjKHOfX5au21rMvfieWH5Oeu1EJuaTvEcnr/L
         zLMnVoA+gYuRY0S+qb2YYGGhiBOeBXBMa3hlYZMUl6XQoMbZSvc9OYWnXbd+VVyPDMkL
         4tMHUM0CEXd7bd2uiVCg/qWnixhUigaQThNOHyI+yfr/DFrwYKc68Toxrfz5GNaaERUN
         9cYGa+wN23RY3vdrn70+z6hg8XjTsfrBnCToLPRmd4AO7cQeL0KkW4eIrDQPEr7iHxsR
         x36Gpq6zap111kWJjTBHx0h08fCSvBL5sCESTxYey3qH6vW9J669VxYYYhPMhsprnvZX
         dVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6HA+Sc4127VnR0XoCzgvAGfwoxhAqa6oSGaBN0apa5A=;
        b=FfeWQBb5oF2TfPogJCR180iakr3xnBPZokv3wL6e0mIEX8EZ/3pJRLEsd4bPgizvfw
         q/t6wdnc9ru6xQnTCgtnfKmLZtmxtuI4aiM2THP3e5uLL6sknt5jyzQZKog4B0ohMUW+
         FvArcr5lTdhEJN0Y5KWurcmlXfFTOEOXYGrqkjyPK5FEqRYaTPGK4AAR14NcaLZIhcMj
         Nf6NqFXNqm8TGCqnI0yoLotI7it2cndna5pdv3KcTVKWEGGJ1aj4eyNoZNWtZ07sgPSd
         kyUAo4sUgQFLxKMKro1AT4gbYpK4Wfo4NYze9gkyDx7z1xf1zbtPdr3C2uuJ/eIqAgZh
         gC+g==
X-Gm-Message-State: APt69E00L+04WLY9/Er9SlIviaawtlFcFQ/XTFSkaCQBxTlScKWNV89O
        jdT48G/1eJZgb1Sk2qWYmyc=
X-Google-Smtp-Source: ADUXVKJjgljrpmUJ9IXnp0VUbZ/JoaN4djAg+GJ1m8Tq5zaR3pA+62d45L4f+FmnbhpTCBmxd1nq0w==
X-Received: by 2002:aa7:8491:: with SMTP id u17-v6mr22025818pfn.48.1529488234991;
        Wed, 20 Jun 2018 02:50:34 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:1:4413:35c0:9e91:c7fc:672])
        by smtp.gmail.com with ESMTPSA id k15-v6sm2975069pfi.37.2018.06.20.02.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 02:50:34 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, quytelda@tamalin.org,
        Larry.Finger@lwfinger.net, harshasharmaiitr@gmail.com,
        arushisinghal19971997@gmail.com, amitoj1606@gmail.com,
        jeremy.lefaure@lse.epita.fr, teo.dacquet@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Fix two possible sleep-in-atomic-context bugs in translate_scan()
Date:   Wed, 20 Jun 2018 17:50:16 +0800
Message-Id: <20180620095016.8484-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.16.7 are:

[FUNC] kzalloc(GFP_KERNEL)
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 323: 
		kzalloc in translate_scan
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1554: 
		translate_scan in rtw_wx_get_scan
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1533: 
		spin_lock_bh in rtw_wx_get_scan

[FUNC] kzalloc(GFP_KERNEL)
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 455: 
		kzalloc in translate_scan
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1554: 
		translate_scan in rtw_wx_get_scan
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1533: 
		spin_lock_bh in rtw_wx_get_scan

To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.

These bugs are found by my static analysis tool (DSAC-2) and checked by
my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index b26533983864..7632b8974563 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -321,7 +321,7 @@ static char *translate_scan(struct adapter *padapter,
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.Ssid.Ssid));
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 
-		buf = kzalloc(MAX_WPA_IE_LEN*2, GFP_KERNEL);
+		buf = kzalloc(MAX_WPA_IE_LEN*2, GFP_ATOMIC);
 		if (!buf)
 			return start;
 		if (wpa_len > 0) {
@@ -453,7 +453,7 @@ static char *translate_scan(struct adapter *padapter,
 		u8 *buf;
 		u8 *p, *pos;
 
-		buf = kzalloc(MAX_WPA_IE_LEN, GFP_KERNEL);
+		buf = kzalloc(MAX_WPA_IE_LEN, GFP_ATOMIC);
 		if (!buf)
 			goto exit;
 		p = buf;
-- 
2.17.0

