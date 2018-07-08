Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8FBC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59324208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js4IUmkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59324208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932984AbeGHKjc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 06:39:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37383 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932878AbeGHKjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 06:39:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id v22-v6so11639021edq.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a6w/AfqVYBRGbf2OPa4x3knI10d1DGZC1dLP6AZfe9I=;
        b=Js4IUmkHh0uIAvSxNEDAroaXrzQOuCSJcmlmioK/B09L360qBumSQ/MceCRZHw1+ax
         dr6uwLJ1og4rdRYbTBx/jeO1QGisAJLWaRazUvNwdjWNUbAv4Ayt+u65Nm/8l8SW88zT
         YiBQDkXP4L44wNdP7kqm7r/zElE/zBr8TnqvJW7djnSeAeEMUXB4azf4082RYwbnFTQY
         0GI8j/3P7R9Y+yEviJbmtHAjyaYNKdLy0i1zGN1ItSJEuJNTciQSJjrKBGAq8zTruQRk
         z0F05E6/sD+rj5O0ZCEIKT/GBG5P/Bme3qg2EANHJ3PB2iM1ZRtItIHcf8xwoTbxMQSa
         Sn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a6w/AfqVYBRGbf2OPa4x3knI10d1DGZC1dLP6AZfe9I=;
        b=lWk05Xn61sYRO/aO/wf6CsR6EG52U77yJZXYhFeOwIj8RzIeBhOAJVHp5axakRgSqH
         gPnQAygqumlXgiWLjfrXISD0lrvN8VaTWPkd9dD52Fn4vc12Pms/aGdMLXBaQxdmtsK5
         thM8ZDDmjDw5ZEShtssAhcdALmrX3oDhhbr6EVbc7vWDH4SPoppQ7T+cisQ4oaLlKqax
         Frl72HDWPXkpOfnhu4mIj84/1LHE8BNrEVqPIB/hOa75i9cbYNNY9M4dj84U8nfc2UOw
         xd2HAsOksXhhW2AsCqvJ1UL0qzbWSr3EeR8aESJYsQNK8jlf2BaKTvwiPX9+EAQ/cVqk
         keEw==
X-Gm-Message-State: APt69E2pup9fl0DxLkjXdJbPWHJTim9REfcd9YHt4IyRg9K1iDBv3mhu
        0KTixRIutvJpCYL56RniuyU=
X-Google-Smtp-Source: AAOMgpdqbInqbbBCQKXgRCJRExD1wyQbWgI45aoAJ1HjPyLAkTlLsQlePeaVzE7lS+oIbe0ByLK7Eg==
X-Received: by 2002:a50:8b66:: with SMTP id l93-v6mr17939710edl.44.1531046364820;
        Sun, 08 Jul 2018 03:39:24 -0700 (PDT)
Received: from arch.localdomain (x4db1e3f8.dyn.telefonica.de. [77.177.227.248])
        by smtp.gmail.com with ESMTPSA id p59-v6sm6295886edp.54.2018.07.08.03.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 03:39:24 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/6] staging: rtl8723bs: add missing blank lines
Date:   Sun,  8 Jul 2018 12:38:54 +0200
Message-Id: <20180708103855.12473-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708103855.12473-1-straube.linux@gmail.com>
References: <20180708103855.12473-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing blank lines after declarations as reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index ab1174f7c83a..a4f9e2b90b08 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -57,6 +57,7 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
 {
 	unsigned char dot11_rate_table[] = {2, 4, 11, 22, 12, 18, 24, 36, 48, 72, 96, 108, 0}; /*  last element must be zero!! */
 	int i = 0;
+
 	while (dot11_rate_table[i] != 0) {
 		if (dot11_rate_table[i] == val)
 			return BIT(i);
@@ -1139,6 +1140,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	unsigned char *pbuf;
 	int group_cipher = 0, pairwise_cipher = 0, is8021x = 0;
 	int ret = _FAIL;
+
 	pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
 
 	if (pbuf && (wpa_ielen > 0)) {
-- 
2.18.0

