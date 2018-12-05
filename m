Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0418EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF87D20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPryZoJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF87D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbeLEScP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:32:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35043 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeLESbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:31:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so13914644wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bk8nNVekZI9AjQvGfZEA9xfq+U1PngaXCZ0EqdfByfY=;
        b=QPryZoJhSXl9BKaFJHedBEqFt4er1AGWqMcsBKmjzknqUDymFts11hIlQpHGvikuNM
         hYIUSiIni62Io5zcDcFsde73BebxKtGbboWT1CityAHTO2uzLLYN21IifME3B9xy3cwZ
         3lfUYguQU/NhUkUM2t93ZsvxPIzbYWFBfEObgScHO4I9V2G3Kk8FdRLPrkBEx3gKdlzO
         ctglZSS9x2t/enVFHCAS5oO/gaZisEAm4kFcl0SuRKHegpKw7A8GANOmfu9VA8aQS2pG
         LcVJX0F+qyat7sOhqH1bB0LZoG9TJ/hTAMyDrWOZgyw08z2W8T8G324Mr3//DBKkVhjl
         n4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bk8nNVekZI9AjQvGfZEA9xfq+U1PngaXCZ0EqdfByfY=;
        b=LR0KVzrmke6/xunjvGokSB70AGJHaxI1VimbmXhmZ9WRlnzmrzNf+QvglTbcKJBUTz
         6M0OYHU8yDVoE2PhjNB3wc86+bWivtmhKClfFdQllTjePeRW6/sveVgVNohBXZkooDiR
         Yxi1+fzHbqI+25J0epskw30lSlDJqKPKbp8YvseBbVjspedsUVEcAmClo1AxZMwdLN8i
         DpVTWqHeZ3qBmEj2BJQvZag/tMEFBPsRE+d8KCbI/zG0K30hyeS5P10PjlscUqc4R3af
         G7ytDRNx9T0iMZy73fG9X/ErPnDu1K+7MQvjO/oAthIWeWMuQtwNN75ChlM05ym3Qt00
         dMxg==
X-Gm-Message-State: AA+aEWac6VGLd3OBb2fpDTbSwJcoVp3V1/S5Aikq9gZ+k+HODsfhNHLQ
        wNEPFhBptwvbzDAefb+TYwI=
X-Google-Smtp-Source: AFSGD/U0cEjm9cs5MCZMZv8t/H/6SVl++53cqwnEunKEphsZV7OQ2f+Fd3lXrf3jPzjgQ5Sjp2lnVg==
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr15835830wmb.127.1544034679308;
        Wed, 05 Dec 2018 10:31:19 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id a18sm27860998wrp.13.2018.12.05.10.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:31:18 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 06/12] staging: rtl8188eu: cleanup block comment in rtw_wlan_util.c
Date:   Wed,  5 Dec 2018 19:30:54 +0100
Message-Id: <20181205183100.16828-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205183100.16828-1-straube.linux@gmail.com>
References: <20181205183100.16828-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup a block comment to clear a checkpatch warning.
WARNING: Block comments use * on subsequent lines

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index e61fc7ce65e8..956a331beda2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -760,11 +760,11 @@ void HTOnAssocRsp(struct adapter *padapter)
 		return;
 	}
 
-	/* handle A-MPDU parameter field */
-	/*
-		AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
-		AMPDU_para [4:2]:Min MPDU Start Spacing
-	*/
+	/* handle A-MPDU parameter field
+	 *
+	 * AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
+	 * AMPDU_para [4:2]:Min MPDU Start Spacing
+	 */
 	max_AMPDU_len = pmlmeinfo->HT_caps.ampdu_params_info & 0x03;
 
 	min_MPDU_spacing = (pmlmeinfo->HT_caps.ampdu_params_info & 0x1c) >> 2;
-- 
2.19.2

