Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131E0ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB602083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsthzuHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB602083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeJVEBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:01:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43426 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeJVEBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:01:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so35922618eds.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Y2A4P/+gPra1ZBEux7V17SxtFphfvc2ua/2kOv4VFc=;
        b=jsthzuHM7TOFV+j3A++f83qG2lmRwQ6fPbmCOUdp9lIK4S7pFqaHhfeaFcIcOMlW2Q
         eW20vJOkkqh+s89Xx40l0iPMkrFPPKpQDcMjC8YtcJQVHAfGVl+/Of5dv7SEo7l2ykDB
         ZeW9WggijFiKTxeREbf+UCvoTI6iIjEHcyu30RSuacJlGKyMgHRurD7mNAMMH/uN66i+
         B0rSWOZwPKRkO5zfcZ1c/BAU2+9qqWUI/U+jvRDT+cg3aIZOOnOMuANiEMa4h3KxBsXk
         AKqnJ5vqcEimIa6diRrLglWxbYqEsUvBPQoYYqr/zVAhnQh2yCFEwpeePohYfUCPO1Jz
         ZDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Y2A4P/+gPra1ZBEux7V17SxtFphfvc2ua/2kOv4VFc=;
        b=sLjjUe3uSwWHXkPsOw7xXuhVhxInoGvfio63bPWdHH0AUU7+WjycjKOAFv2UMaFw64
         jqznURp0zIlyy5gEfA2+hqO9Wz4lWL4ADOr9kC8WzKKZED7pg+k4s1+GIuAFs2d3glin
         8PXg2hctcbShNPr1Npg8/OuOM9j0qKCNXHjABtGOamev4wD+UhOeNcV6Ce7pJyxIGn07
         G0RaFn+8P+tBw1JICkH8q40fpQqFsCNrha3Yh1fQDo3iwxz/LyGrmOEghQ6YI2dF8gaq
         2vPIWY/67toi23w9F9ciYXbEYJAiKtPkRrGFvr7y7h5a5BIjhDX+C4+WfEl3uV3oe6P9
         BUVw==
X-Gm-Message-State: ABuFfoik5dEDpdVLLMsO7QOZEDI2MH6R8FUOwYflLlUqmgJ+F1IVFTCq
        NWwIr5BFS3sjp46mfnnE8z0=
X-Google-Smtp-Source: ACcGV62vLPwmUWmgeh99esKrQh1XH1dPkFkgeS9pd6grIYdzQ6Suf9k3z3CeULVqQyu/FsQmhT63wA==
X-Received: by 2002:a50:f14b:: with SMTP id z11-v6mr12059238edl.0.1540151181316;
        Sun, 21 Oct 2018 12:46:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id w11-v6sm6159566ejv.4.2018.10.21.12.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 12:46:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 4/4] staging: rtl8188eu: change type of is_cck_rate - style
Date:   Sun, 21 Oct 2018 21:45:28 +0200
Message-Id: <20181021194528.15542-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181021194528.15542-1-straube.linux@gmail.com>
References: <20181021194528.15542-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable is_cck_rate is used for boolean values, so change the
type from u8 to bool. The initializations to zero and use of ternary
operator in the assignments are unnecessary, remove them as well.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index 5d72d7f6d05f..7ae476ffcd8c 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -71,15 +71,15 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 	s8 rx_pwr[4], rx_pwr_all = 0;
 	u8 EVM, PWDB_ALL = 0, PWDB_ALL_BT;
 	u8 RSSI, total_rssi = 0;
-	u8 is_cck_rate = 0;
+	bool is_cck_rate;
 	u8 rf_rx_num = 0;
 	u8 cck_highpwr = 0;
 	u8 LNA_idx, VGA_idx;
 
 	struct phy_status_rpt *pPhyStaRpt = (struct phy_status_rpt *)pPhyStatus;
 
-	is_cck_rate = ((pPktinfo->Rate >= DESC92C_RATE1M) &&
-		       (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
+	is_cck_rate = pPktinfo->Rate >= DESC92C_RATE1M &&
+		      pPktinfo->Rate <= DESC92C_RATE11M;
 
 	pPhyInfo->RxMIMOSignalQuality[RF_PATH_A] = -1;
 	pPhyInfo->RxMIMOSignalQuality[RF_PATH_B] = -1;
@@ -256,7 +256,7 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 {
 	s32 UndecoratedSmoothedPWDB, UndecoratedSmoothedCCK;
 	s32 UndecoratedSmoothedOFDM, RSSI_Ave;
-	u8 is_cck_rate = 0;
+	bool is_cck_rate;
 	u8 RSSI_max, RSSI_min, i;
 	u32 OFDM_pkt = 0;
 	u32 Weighting = 0;
@@ -272,8 +272,8 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 	if ((!pPktinfo->bPacketMatchBSSID))
 		return;
 
-	is_cck_rate = ((pPktinfo->Rate >= DESC92C_RATE1M) &&
-		       (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
+	is_cck_rate = pPktinfo->Rate >= DESC92C_RATE1M &&
+		      pPktinfo->Rate <= DESC92C_RATE11M;
 
 	/* Smart Antenna Debug Message------------------  */
 
-- 
2.19.1

