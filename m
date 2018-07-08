Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7637C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B67208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGDbLG2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B67208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932766AbeGHKjX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 06:39:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37379 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932380AbeGHKjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 06:39:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id v22-v6so11638958edq.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fuvWEFq6sjxvdeX+xWV6XzO61pE2v6MEtsHemALeAdg=;
        b=bGDbLG2khY2PmM/ge/ZZ/EOlQ0l0m3+b0X0dnaRt7GXfD5gOM9ogsWv+31uLgrrh+e
         Cc+crbw6cm377+Hvv7ShXQIOVsWyKDk/RlZGYTz1Ijzt6B2iKeuoE/krzjy5OIjnH2Fi
         9XRjpFHrkJ+nU53lK6gOCkMrbm5dI4/v1ssQ6XaZb6nUehzTYogajK60W55ja4C4JA5f
         ZLSmQp5rPsvGyQZhg/Mlt9LnJp7f3RNjM5DoQCnRccOvwPhFuVeAyu5rcorYlZs2jpZB
         +t0UhPBpzdzIwbFTubOHRNSh0Mv87VO6IlyeYN53UHWGTT1bwWb4/SRvuK8Y101qxUrf
         4ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fuvWEFq6sjxvdeX+xWV6XzO61pE2v6MEtsHemALeAdg=;
        b=mBLrZU6tUNiXwtr+eXNCdZl71ZOL9xtsSU4imULywZAdP/0tHeSqkfVbtANLWrg1HZ
         lSjqZp67Tk9MWHt3nmhxgwubtcRFfXe9asHwroBXiBweqpSBEGDW/IiIOYMf9oIaN7Wx
         1z6v9NFAcFh0TBmUuwRQTjCheeCT4htKyvctqKRduJ46LKZ4k/8VrRjgBv44cU6mrhQg
         ZvKPVFazFZ1OsuaGZKFuLe1+veL8VIRyjj3L38s/JPg++q71qlNEIAAAsVrx7oq1pzGh
         Z+sBKQfwr2HDzbXmtzYwloF8K44Db2auyubnDqAkcTPE1+Ew7LODRIR7OEVg0l642vgt
         qnMg==
X-Gm-Message-State: APt69E3gEa40AQLKrV2SIgCQ8OmfV5gShtjov/SBff0g6sysnW6xTl8q
        upMLwntM4RxB9c6dk0aVNtA=
X-Google-Smtp-Source: AAOMgpcDvuTYzgjq8RBpDpE3gDT4ACz9Utf6rKeQx/EJRxoD7TWa3xU81kBfyn4SeIIM3j7a8N33cA==
X-Received: by 2002:a50:a6c7:: with SMTP id f7-v6mr4200601edc.225.1531046360608;
        Sun, 08 Jul 2018 03:39:20 -0700 (PDT)
Received: from arch.localdomain (x4db1e3f8.dyn.telefonica.de. [77.177.227.248])
        by smtp.gmail.com with ESMTPSA id p59-v6sm6295886edp.54.2018.07.08.03.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 03:39:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/6] staging: rtl8723bs: replace tab with space
Date:   Sun,  8 Jul 2018 12:38:51 +0200
Message-Id: <20180708103855.12473-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708103855.12473-1-straube.linux@gmail.com>
References: <20180708103855.12473-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces in some function definitions.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 9b60e0214bd8..429ec929fa1a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -67,7 +67,7 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
 	return 0;
 }
 
-uint	rtw_is_cckrates_included(u8 *rate)
+uint rtw_is_cckrates_included(u8 *rate)
 {
 		u32 i = 0;
 
@@ -81,7 +81,7 @@ uint	rtw_is_cckrates_included(u8 *rate)
 		return false;
 }
 
-uint	rtw_is_cckratesonly_included(u8 *rate)
+uint rtw_is_cckratesonly_included(u8 *rate)
 {
 	u32 i = 0;
 
@@ -296,7 +296,7 @@ void rtw_set_supported_rate(u8 *SupportedRates, uint mode)
 	}
 }
 
-uint	rtw_get_rateset_len(u8 *rateset)
+uint rtw_get_rateset_len(u8 *rateset)
 {
 	uint i;
 
-- 
2.18.0

