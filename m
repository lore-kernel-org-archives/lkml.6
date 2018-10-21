Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC28CECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E972083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lflqIXL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E972083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbeJVEBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:01:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41860 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeJVEBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:01:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id x31-v6so35934606edd.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xLa5dzj2qhRAorU6GFxV4vIqINuCii9odEyUB2VkvIk=;
        b=lflqIXL45U0UN1ttRqYAwvISoV8b9DaoHloYRa1LzXcyWlml1/zTkaUMTqSooObQhn
         1477XzwCJ2TrPP1Hll6xAhd2P6BZg6cjuqH4n6iqJVQRYypKZL4j48qwag+0FsLWhZMG
         FZpdNsozbb6XCS8hgRJifv1uqDEaq5dX/tgqr+S7f3yj9EpstlOgzkxNfTXLdBpO4xms
         KklQ4vNY4yO7ZM2vqlSmuIRIZOZQO7JyMDn1NMGOxpi4BLUnraL6c0u3hzuBCJc4E3Mu
         VrVDOuZWavm09eYCM1YdhtMOJQZlRcYby82RMcrLIUYYw22Zb2053gmB5AtMBuQDRfkZ
         riJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xLa5dzj2qhRAorU6GFxV4vIqINuCii9odEyUB2VkvIk=;
        b=QOFB4gzLJwe1bHid0FxlMtKl+aLUpYOPa4b/7v+3EsvGIM3fuPv7vgXKqeTFWl/aaZ
         vX/pPtBuhC/WS5UdT3Ty0Is/mhRTKkLPel//h7m9IqHHuzwBTdRt8AkCFs6N4/ifJaLa
         3Dl/1g9ePlbB2/nYgUWm7jQeGoeZpx4jYTXzpyrXpqQLMvoH5B9aNEAjg67TB12lvJM8
         YKIpoTE0OWP/8lvwkkSSPMAT6zX1CAqh5NIN3NwCeSYEyGURGgcq7JNpZFh3R1j/oXFz
         nzogJGotgpNp5VTUxym+cpglZG+zSi4Ms2PpSy34LmBQ0pjJiMCVzO3p5YgzGztJlVb3
         /UWg==
X-Gm-Message-State: AGRZ1gJdQaMAs/LduN5RjY67VsC8hM5MkEvGFA6LLFSFnAFq2PoSsnOs
        VhPxXWkukb8W0wUxQVXqx6c=
X-Google-Smtp-Source: AJdET5dHd/4r/YkDWZ2U+iKWmyqSxfc+MRkbPe5vWN/z1DJ82/a7+2zLpjm3p8vEq48F5epYHKhqGA==
X-Received: by 2002:aa7:dd08:: with SMTP id i8-v6mr2528464edv.164.1540151179094;
        Sun, 21 Oct 2018 12:46:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id w11-v6sm6159566ejv.4.2018.10.21.12.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 12:46:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/4] staging: rtl8188eu: rename variable Max_spatial_stream - style
Date:   Sun, 21 Oct 2018 21:45:26 +0200
Message-Id: <20181021194528.15542-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181021194528.15542-1-straube.linux@gmail.com>
References: <20181021194528.15542-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the variable Max_spatial_stream to avoid CamelCase.
Max_spatial_stream -> max_spatial_stream

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index 0c034b19d3dd..d7bdbb141b2b 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -67,7 +67,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			struct odm_per_pkt_info *pPktinfo)
 {
 	struct sw_ant_switch *pDM_SWAT_Table = &dm_odm->DM_SWAT_Table;
-	u8 i, Max_spatial_stream;
+	u8 i, max_spatial_stream;
 	s8 rx_pwr[4], rx_pwr_all = 0;
 	u8 EVM, PWDB_ALL = 0, PWDB_ALL_BT;
 	u8 RSSI, total_rssi = 0;
@@ -215,11 +215,11 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 
 		/*  (3)EVM of HT rate */
 		if (pPktinfo->Rate >= DESC92C_RATEMCS8 && pPktinfo->Rate <= DESC92C_RATEMCS15)
-			Max_spatial_stream = 2; /* both spatial stream make sense */
+			max_spatial_stream = 2; /* both spatial stream make sense */
 		else
-			Max_spatial_stream = 1; /* only spatial stream 1 makes sense */
+			max_spatial_stream = 1; /* only spatial stream 1 makes sense */
 
-		for (i = 0; i < Max_spatial_stream; i++) {
+		for (i = 0; i < max_spatial_stream; i++) {
 			/*  Do not use shift operation like "rx_evmX >>= 1" because the compilor of free build environment */
 			/*  fill most significant bit to "zero" when doing shifting operation which may change a negative */
 			/*  value to positive one, then the dbm value (which is supposed to be negative)  is not correct anymore. */
-- 
2.19.1

