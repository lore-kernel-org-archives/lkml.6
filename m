Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F91C64EB0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676AE208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rG99nR2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676AE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbeJAC1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:27:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54025 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbeJAC1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so6653952wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qgLdO5rRE8eiu8nNDQ0zWZPL3dwJvCwwH/8hCrMxoW4=;
        b=rG99nR2GPK/Umqec+Uw2aPUWu1pwjIhA5QKevezqS+hUgtwqLUrfE0x47MQzoqDVNb
         MmfyX5/G55dNbih9EiNGZqn6jGS/ijbIIRZR1i0frmb1WmT6iNy4072o4yWhtokvlOVs
         TqtwNKwGciPtDVmDtqiYhWav6pmxgw0ZiP4NPfuP9SCxGAbqIxRPF52GbONz9kVfocyz
         m8Wsskaf6B+sqL9x0qSGbNivV758BQVWSsoDncnZFbJXxl9VH+cpFsDIX6dZBGg3QS3Z
         rVbxWnkgnhPG5q/PHzguek5Ssjyr99izZO/e3WBVKrUpB4+2w+UMpRJc+IN8DOtdT5u1
         opiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qgLdO5rRE8eiu8nNDQ0zWZPL3dwJvCwwH/8hCrMxoW4=;
        b=aeLaTXlwTeo+7SSE5MWXj6miiF9fdM3lk5+xHqNzx4zg4/i+wsYkZYbPIjHa9CDfli
         9UrDcUSyNmn/6iSNuoqcVDUggdJmyhFU8T6RqQxUtwJHaQzkYFc62JXUWAb9Gvgh1fFh
         ZS5LPPlmMArSTe27YIiy4/ECKvrZ+LSj7tnRs/cOwWRxzvVj5mfIHw82LeFzZwch9Lfn
         WEoEQxi88Lh00S5leRbedc9CPd5/P7Y3/ppUzL5ZKI7C+0Lnq2XmsOWA11AZOi1oaKMA
         66mux75S3w34vR73T4KyeGO+M2KO7RkMQenWyjORoXVGiRMpWvLE8aah3HuV6qceZ4AN
         L41g==
X-Gm-Message-State: ABuFfogPA/uDVaLAprk9nTR87ckQRTG5af3UsH7BCFAd6mBH17GIn0u7
        moJ9LlJriwA9hX2ZByo0qoo=
X-Google-Smtp-Source: ACcGV63b5SW6Ek2LxA4KHT8tjpV5S17BVV7hhtfaFBvDrie85i735eZqFdHnOwIsFlgunxQviqZlhw==
X-Received: by 2002:a1c:3b87:: with SMTP id i129-v6mr6773718wma.42.1538337209803;
        Sun, 30 Sep 2018 12:53:29 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/19] staging: rtl8188eu: rename odm_EVMdbToPercentage()
Date:   Sun, 30 Sep 2018 21:53:01 +0200
Message-Id: <20180930195310.1531-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename odm_EVMdbToPercentage() to avoid CamelCase.
odm_EVMdbToPercentage -> odm_evm_db_to_percentage

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index a3a85ad5c66e..6d7c379c4444 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -49,7 +49,7 @@ static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
 	return RetSig;
 }
 
-static u8 odm_EVMdbToPercentage(s8 value)
+static u8 odm_evm_db_to_percentage(s8 value)
 {
 	/*  -33dB~0dB to 0%~99% */
 	s8 ret_val;
@@ -231,7 +231,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			/*  Do not use shift operation like "rx_evmX >>= 1" because the compilor of free build environment */
 			/*  fill most significant bit to "zero" when doing shifting operation which may change a negative */
 			/*  value to positive one, then the dbm value (which is supposed to be negative)  is not correct anymore. */
-			EVM = odm_EVMdbToPercentage((pPhyStaRpt->stream_rxevm[i]));	/* dbm */
+			EVM = odm_evm_db_to_percentage((pPhyStaRpt->stream_rxevm[i]));	/* dbm */
 
 			if (pPktinfo->bPacketMatchBSSID) {
 				if (i == RF_PATH_A) /*  Fill value in RFD, Get the first spatial stream only */
-- 
2.19.0

