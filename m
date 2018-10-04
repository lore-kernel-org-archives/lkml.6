Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385ABC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 01:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6B020856
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 01:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rj/uVx7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6B020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJDIXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 04:23:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35236 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeJDIXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 04:23:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id w5-v6so8090861wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 18:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=la17VNTm7gH2smnjwiXoVT4jBF8ETsayS53yegxuu2c=;
        b=rj/uVx7tJMj/fMkXCZ9hwEL49lp/lC9hR84f9+pnZtbxwzXypJe9vRXV5IBEO5Qics
         qYeIW5OEYEreuD/IncQpV8sQ2fXcbRoQIiCgiM/xyvrErFKXgyjCKsrJX1C+thsYJmQE
         3RyM/hMLqsz88GD4rlEgrw/BNFCHw2Zv/Ob8LRT613BTxFqzDWsYry2biwgUHuckv6V5
         V2hNrfdIWPeg+mRrC6IqMlF2eo+AyJ0ug7J95JzzVjd9th2LFuM79IYhufNKAPhR898D
         /gY6w106Ek3csUtrqYq7pqS/iTMmNmR/hXSQUUyItSkgh20T2rP9jp16Y1KjfrjivoiE
         WXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=la17VNTm7gH2smnjwiXoVT4jBF8ETsayS53yegxuu2c=;
        b=BnwUdtjSEeBnGlXpu9QXohSV0xGPy1VRQNpgg25/WuHp7Z8q8RiM/r1VYERyUyNmX8
         fmNZI12P/HIAWAkk7yycEL2EAcfJGjodCjMESBq1KFpKkfZS7Hj2WCIbM/FpVC70WMBK
         mOtZFjT2NLPuyZF1WM8MiEQNV1RklIEW/PrN42Oz84vAlwGyPl8Ms+AjitxFAjAmbvuJ
         OILhp+ww4soY/lek47hH2In77rDFQeF/K5YQrmBTDMc0axox/gzOAEG+t3BymycrDJz5
         lBKhDHzUxUf4NS0Z6bNPVBqPiJsG5/NpQBj5DPKZcD5IjvZAq4ma80pOd2eDE81fpEIT
         hilw==
X-Gm-Message-State: ABuFfojagclVSx8ClQ306+rWMm83mAshYPGotcDrb5kMGwLIIWx/rm/d
        zsz1HhFhwqZsSUHnQkWhsqk=
X-Google-Smtp-Source: ACcGV62cL3LAD2i9TtRgjffTq9Nw1zbpumTRnLKnGpa8tjcOMeTXUU/SnR6q7EJ/oV5cFQOWTuhVwg==
X-Received: by 2002:adf:e28d:: with SMTP id v13-v6mr2918259wri.139.1538616778445;
        Wed, 03 Oct 2018 18:32:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e142-v6sm7926185wmf.20.2018.10.03.18.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 18:32:57 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Remove unnecessary parentheses and dead commented code
Date:   Wed,  3 Oct 2018 18:32:51 -0700
Message-Id: <20181004013251.24253-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:3351:20: warning:
equality comparison with extraneous parentheses [-Wparentheses-equality]

The commented code is pointless since _HW_STATE_AP_ is handled right
below this block.

Link: https://github.com/ClangBuiltLinux/linux/issues/168
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 592917fc00aa..c7e55618b9a8 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -3348,7 +3348,7 @@ static void hw_var_set_opmode(struct adapter *padapter, u8 variable, u8 *val)
 			/*  disable atim wnd */
 			rtw_write8(padapter, REG_BCN_CTRL, DIS_TSF_UDT|EN_BCN_FUNCTION|DIS_ATIM);
 			/* rtw_write8(padapter, REG_BCN_CTRL, 0x18); */
-		} else if ((mode == _HW_STATE_ADHOC_) /*|| (mode == _HW_STATE_AP_)*/) {
+		} else if (mode == _HW_STATE_ADHOC_) {
 			ResumeTxBeacon(padapter);
 			rtw_write8(padapter, REG_BCN_CTRL, DIS_TSF_UDT|EN_BCN_FUNCTION|DIS_BCNQ_SUB);
 		} else if (mode == _HW_STATE_AP_) {
-- 
2.19.0

