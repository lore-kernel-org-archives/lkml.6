Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BBDC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD56A2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFaVRODx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeLOQrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:47:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39321 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeLOQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:46:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so8609075wmd.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 08:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pQ7B5CjDkhg9MMIkErdYJgyFZkuIReQ6qXIdm8aTfAI=;
        b=DFaVRODxcDxZNRqrFxCUxszqBmHnITMlrW9+dKmrmpKG6XLNaRzcyOP5GU6hDU/MM6
         CqNinXEbioAyV/icJKUTz/hAGzXL1dmylViQkUk/QJEsKLcoEX9KSSiTVImLWukYZINd
         +/I2jj/HpHikivjTPMBapXsFtk9v33ieioqxraAQhhqsze5zD4NiKIULrJoJxSfYM8ub
         uDmcF4PgPXwLQ2IeEhgmqMbXaD2NtqTWDlgbna5UmzcABBoNoAg1R7FRi2OtWq+d3SP7
         2Qm6WaS4us4mZA7tZwwI3NdFJ5ur3E5g4Z8DEOUtZ2hTnZ2HUcM7Kx7guXbBqwTNmoGg
         J28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQ7B5CjDkhg9MMIkErdYJgyFZkuIReQ6qXIdm8aTfAI=;
        b=nyosGRJ+yhpmrR42B6rtee41a/as1bKlfvhOcGkpHAOKstOzKdGCcCDfKFy1107w4J
         fE8EIBjhe6362KyGGL0FmfAPcOl6iAWzKZdkaNcUW2bPQxUnwNqVWaaZdkfJEUrC/BZM
         kQkd3nS/tQx2bsgVFAPeUdZSvoBW9LI+nHNOPfd/NP1xgF5NqUpB8K1FnuzatDUs8dsq
         SQIYo5G69zQMduL7oQ6S5FLtza7Klhj2tPGr5pqn6htSOl2tRI0SCBgGhJtcfsumQug2
         7zP5nwSphwX9XackMrwSHaBbdccA/HGxjnLznQPOX4EVw6PGquZdOkJYAMPC6K+IBOVx
         3/HQ==
X-Gm-Message-State: AA+aEWYIxqSqvyodVeCD/axcbiLfjZKOXUKZepJFRHTKdII6UHjezZko
        /YACsC6D3qvRLsMMGLFInME=
X-Google-Smtp-Source: AFSGD/UaXoOsEtEvsPGzlO05eEmsslintcxdexbAGmr6XYOoC9jXzWfGxT6XBQv9XGlrnvDTJMXlnQ==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr6636318wmb.33.1544892391919;
        Sat, 15 Dec 2018 08:46:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i186sm8820935wmd.19.2018.12.15.08.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 08:46:31 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/9] staging: rtl8188eu: constify arrays in rtw_wlan_util.c
Date:   Sat, 15 Dec 2018 17:46:12 +0100
Message-Id: <20181215164616.2643-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181215164616.2643-1-straube.linux@gmail.com>
References: <20181215164616.2643-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values of these arrays are never changed, so make them const.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index f01a50e8ba51..cbdb0fae8df8 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -31,20 +31,20 @@ u8 REALTEK_96B_IE[] = {0x00, 0xe0, 0x4c, 0x02, 0x01, 0x20};
 #define WAIT_FOR_BCN_TO_MIN	(6000)
 #define WAIT_FOR_BCN_TO_MAX	(20000)
 
-static u8 rtw_basic_rate_cck[4] = {
+static const u8 rtw_basic_rate_cck[4] = {
 	IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_CCK_RATE_11MB | IEEE80211_BASIC_RATE_MASK
 };
 
-static u8 rtw_basic_rate_ofdm[3] = {
+static const u8 rtw_basic_rate_ofdm[3] = {
 	IEEE80211_OFDM_RATE_6MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_OFDM_RATE_12MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_OFDM_RATE_24MB | IEEE80211_BASIC_RATE_MASK
 };
 
-static u8 rtw_basic_rate_mix[7] = {
+static const u8 rtw_basic_rate_mix[7] = {
 	IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK,
-- 
2.20.0

