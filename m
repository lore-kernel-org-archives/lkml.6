Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58C7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5812A20881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oHFbqGmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5812A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933336AbeGJNpF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:45:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38542 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933248AbeGJNpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:45:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id m1-v6so1967507wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7IPyoDXpGF1eOuh4pfFTLqmQriOToKP2E67zheCTYds=;
        b=oHFbqGmWZawJyqLlIk4qfT/BO0I7V1+786X2ZuVyFUS5CSWFu1wzP/2gGLr63jRc25
         fUZNHGYvXjGU0znLhT0llsuomwNn8jzJQE7f5tnP5VHjznNyB9n9SQA+3VKojkj4Uues
         kJ0MwljeVl2d7N/VyPp4a2+/BhaJF2L1KBSGUwvh49SId29vE1RQ4UEX6rx//Mt+iVeV
         ufD6ExeZbHFjmwHdYfs3fFcKav3kDiVSmEPVhq18LzVvRYnV+LUf/JLQI7AQ+CjFoQ2n
         IBtbVK0PY0AY0o5xUmaolKnqrEcsSXnKciO6U4nvX4LdIaDB+Sc0A4tDbuOaakEZdnZ3
         ciMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7IPyoDXpGF1eOuh4pfFTLqmQriOToKP2E67zheCTYds=;
        b=WuRQwThG4hhQgeozVIOA/Pr0Ou6t81u9klHAaE7DsJFZAwBzCuP04rqAkFOaVwDptY
         rArx/3ncdZS818D0AYnuNq634jytvBeIGMlPymeVFsK5/4WN9pRDxmDtHwaSdjNCGfOD
         I9fMdUregE0i0L171d1Z95kEU6uhp19tHCSkRXpPupsv0oWYtm6iSYby5McrVeDWOsnl
         rqokWAHxZ3w+ELOxHd8lu0gcX2nTIFJS7fekFdUmHFwWB3NFWe2ZWSr4pFdl6QB6CkBM
         nbud0GJcKYIOywGm2lwpCxkOtYiwH2wdx+SVSrv2tPvZ1ENIojEhTH2WSuT67PkkI8CM
         C3Vg==
X-Gm-Message-State: APt69E1SnEJB4quT2Q9IJHhUi2/Cz0mbpMbYhkH8sqWem9M8xGQgQ34N
        7Ffi2ogKLkHbMJ2yNv/v/VRNKQ==
X-Google-Smtp-Source: AAOMgpflnXXKyTBmTu/7BPfuT7ijpEaUBrVK7Oa5SiXT+alXpjIqX8eIRX4E6td7rHrLrCD3pcW2gQ==
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr20050038wrb.155.1531230301863;
        Tue, 10 Jul 2018 06:45:01 -0700 (PDT)
Received: from bender.home ([2a01:cb1d:4ce:ea00:7411:64db:cd3a:8490])
        by smtp.gmail.com with ESMTPSA id p1-v6sm981822wrp.63.2018.07.10.06.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 06:45:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     mchehab@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: platform: meson-ao-cec: make busy TX warning silent
Date:   Tue, 10 Jul 2018 15:44:57 +0200
Message-Id: <1531230297-30921-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to dev_dbg for the busy TX message to avoid having a flood of:
[  228.064570] meson-ao-cec c8100100.cec: meson_ao_cec_transmit: busy TX: aborting
[  230.368489] meson-ao-cec c8100100.cec: meson_ao_cec_transmit: busy TX: aborting
[  234.208655] meson-ao-cec c8100100.cec: meson_ao_cec_transmit: busy TX: aborting
[  236.512558] meson-ao-cec c8100100.cec: meson_ao_cec_transmit: busy TX: aborting

This message is only a debug hint and not an error.

Fixes: 7ec2c0f72cb1 ("media: platform: Add Amlogic Meson AO CEC Controller driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/media/platform/meson/ao-cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/meson/ao-cec.c b/drivers/media/platform/meson/ao-cec.c
index 8040a62..cd4be38 100644
--- a/drivers/media/platform/meson/ao-cec.c
+++ b/drivers/media/platform/meson/ao-cec.c
@@ -524,7 +524,7 @@ static int meson_ao_cec_transmit(struct cec_adapter *adap, u8 attempts,
 		return ret;
 
 	if (reg == TX_BUSY) {
-		dev_err(&ao_cec->pdev->dev, "%s: busy TX: aborting\n",
+		dev_dbg(&ao_cec->pdev->dev, "%s: busy TX: aborting\n",
 			__func__);
 		meson_ao_cec_write(ao_cec, CEC_TX_MSG_CMD, TX_ABORT, &ret);
 	}
-- 
2.7.4

