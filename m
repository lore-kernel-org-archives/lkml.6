Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796E7C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4005B2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sn8eQyJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4005B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbeJAC1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:27:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34469 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbeJAC1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id z4-v6so10130343wrb.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1fefZB0EysnCrIe1EZVuIU6QjvJ+IAxqVXIVWfz3KVw=;
        b=sn8eQyJJQg5O731a9j5lRGPa7w7chsfSdMbwkPgQnVbx0dce1abnFydaJUYl4b4FsF
         6jyWGoFnoEd7F4UahYUGDHSGN3lN9CrQj9ZBBSbcNiKpsSGjfJ1ogd71OLPKwvSCut5K
         My8/nCRXQd+Lqhi/Q4MvfPGe/CArb5O1j/G/X/y5YFv2qA8fBKqVbQywQ8dAkrtv8lb4
         puBVBCQmxhGdR5yA8fRGRpHZD4MEdxkkQY9c2/gPW6mUmWJtqbWNMGwXnTMLyC0XjwvZ
         lhDXy4+wkZDJPXZYkhlU3cq1GNP8gUuB9GdX98BTFG3Ev3suEY0PxBK8wt6wY4o4DBK4
         BlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1fefZB0EysnCrIe1EZVuIU6QjvJ+IAxqVXIVWfz3KVw=;
        b=LDrmXBtBEK7xdHcwm2qx+Do1ow7Lp0f/8gd6Lo992SH8yUScc2AWiLqnk0JO5ynSm6
         toRsC2Toa1K/V/Co0Pe7wfNGihxaNcwo4lY1vf9qfwLb5I+NJ5LpmrZSbUBalBiy85+v
         Vn+ZIgSfUde++rq0i7sr5Pf7NJggIDB1l6K2wr/wlmfPDkTJCT4o8RIOT54iKU0Nn3Fo
         Yn1QlQfjRmI73Gj0j4pRoc7FXXR7J9nih5Y0kzVayS75bXNv/ftotOY/IRY0tbqPYEJ1
         zqkGfkuPKZ6g0f/abeTDFd3tx0etFoE8Lmn69YIdbJyW7Q6zexlyfHS7vaN5NI+PgINO
         HOPg==
X-Gm-Message-State: ABuFfoiM8MBzjpSMYfn+CBwnSRh7iewrfPmhn2fiomdg1G+TymzVdqVr
        ZHF062+wrOhg4fvbXo7nd/Q=
X-Google-Smtp-Source: ACcGV603UWeAI4X08JL4qjqt02cM6gRoaN4/nIUsgdpOhgOtBJvf9y1T2c/SpPjB+p34l8YNZUN6Wg==
X-Received: by 2002:a05:6000:1ce:: with SMTP id t14mr5259411wrx.146.1538337212531;
        Sun, 30 Sep 2018 12:53:32 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 13/19] staging: rtl8188eu: rename odm_SignalScaleMapping()
Date:   Sun, 30 Sep 2018 21:53:04 +0200
Message-Id: <20180930195310.1531-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename odm_SignalScaleMapping to avoid CamelCase.
odm_SignalScaleMapping -> odm_signal_scale_mapping

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index 498785d32a0b..82d6b2e18b29 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -26,7 +26,7 @@ static u8 odm_query_rxpwrpercentage(s8 antpower)
 
 /*  2012/01/12 MH MOve some signal strength smooth method to MP HAL layer. */
 /*  IF other SW team do not support the feature, remove this section.?? */
-static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 currsig)
+static s32 odm_signal_scale_mapping(struct odm_dm_struct *dm_odm, s32 currsig)
 {
 	s32 retsig = 0;
 
@@ -244,10 +244,10 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 	/* UI BSS List signal strength(in percentage), make it good looking, from 0~100. */
 	/* It is assigned to the BSS List in GetValueFromBeaconOrProbeRsp(). */
 	if (isCCKrate) {
-		pPhyInfo->SignalStrength = (u8)(odm_SignalScaleMapping(dm_odm, PWDB_ALL));/* PWDB_ALL; */
+		pPhyInfo->SignalStrength = (u8)(odm_signal_scale_mapping(dm_odm, PWDB_ALL));/* PWDB_ALL; */
 	} else {
 		if (rf_rx_num != 0)
-			pPhyInfo->SignalStrength = (u8)(odm_SignalScaleMapping(dm_odm, total_rssi /= rf_rx_num));
+			pPhyInfo->SignalStrength = (u8)(odm_signal_scale_mapping(dm_odm, total_rssi /= rf_rx_num));
 	}
 
 	/* For 92C/92D HW (Hybrid) Antenna Diversity */
-- 
2.19.0

