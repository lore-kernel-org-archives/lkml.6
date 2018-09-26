Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585AEC004D1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046BA2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq9KG++5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046BA2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeI0CS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:18:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45624 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeI0CS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:18:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id m16so166070wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 13:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mIclTe4LdvtYrYe+iP7JN7dauUMFSOzDdclJfiydLio=;
        b=Kq9KG++5dn3aKtfRVcLhDKYtcPoUcTmWaZJ3cMbnj/9MOhMBjGJ3f/jBDVk+UlGC3b
         CHy3X3sKA6TYMvlCo4IaZ1KBLXPTVPF5I8D3hokp6KebYaCJR4WEP5GgVNo+cgoeO7As
         K11ayGU9iEnzHWROxWtv+zr0ys2dJwHudyUeXq0ovAtvQ2cxHCulUHmvVtmf6KTRT8F/
         3tgQ/hkdPoa5SNwHAB4kC9e2TMOUTbBYVpDau8oIZ46k2KDuxfv2W0npQFVCSMSqS/QK
         V3m/tlLeOKoln2UeKtxk5SL3Gb4tJTlkgsZKDZCzEBCQWYprtNwh4KL/6ALLPnUBMuiI
         fEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mIclTe4LdvtYrYe+iP7JN7dauUMFSOzDdclJfiydLio=;
        b=uXBfBvqYOBjxASezTtVRtORHHSAV9KvsCn0CiawjOxqflQdIzqb892dGUIP5NNyHzp
         Z2/31FS95Nhl7Df3cpc6mn61g6v3ehxfVH5BRGejsythCKkBv9drv2KTXhIWLAl4+u7o
         vKwvm57Ns5tJyWQF2G3BMWam4HfgVED2oDOs6n+URPAcRwCRaoXw4UkrgN5V87nN7dK8
         ZyHYmAnWE/MAn04AwWW45dZCBufFVTr+x2KbV2dliMld3mNJFH6LPJB/oW9pK8Ax1foh
         U3xkdF46d6FFXp0rbFfplV8pVp8QfkhTiktSuJZkg5rn+8JmofDHc1LdMxv++nK5e71q
         NguQ==
X-Gm-Message-State: ABuFfogbRkxDaRpZDeSRxTm187praICqb2dRLQimzkbRzdvRdQdCO3hL
        gN/l9vrsax57T7d9Q9pKze7yH7la
X-Google-Smtp-Source: ACcGV61tOGYq4WWTvza4efOe1Ha4zmazuDT16Rtw0SPuhkCpj0EXabILiXglfbvm1bpvW/JX6HD79w==
X-Received: by 2002:adf:fc84:: with SMTP id g4-v6mr5883088wrr.166.1537992260227;
        Wed, 26 Sep 2018 13:04:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id n4-v6sm7447403wrr.21.2018.09.26.13.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 13:04:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: rtl8188eu: rename variable - style
Date:   Wed, 26 Sep 2018 22:04:07 +0200
Message-Id: <20180926200408.2372-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926200408.2372-1-straube.linux@gmail.com>
References: <20180926200408.2372-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the return value variable in some functions in rtw_efuse.c
to avoid CamelCase. bRet -> ret

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 38 +++++++++++-----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index ce8add5773de..ca0217881eb4 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -512,7 +512,7 @@ static bool hal_EfuseFixHeaderProcess(struct adapter *pAdapter, u8 efuseType, st
 
 static bool hal_EfusePgPacketWrite2ByteHeader(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt)
 {
-	bool bRet = false;
+	bool ret = false;
 	u16 efuse_addr = *pAddr;
 	u16 efuse_max_available_len =
 		EFUSE_REAL_CONTENT_LEN_88E - EFUSE_OOB_PROTECT_BYTES_88E;
@@ -564,7 +564,7 @@ static bool hal_EfusePgPacketWrite2ByteHeader(struct adapter *pAdapter, u8 efuse
 				if (!hal_EfuseFixHeaderProcess(pAdapter, efuseType, &fixPkt, &efuse_addr))
 					return false;
 			} else {
-				bRet = true;
+				ret = true;
 				break;
 			}
 		} else if ((tmp_header & 0x1F) == 0x0F) {		/* wrong extended header */
@@ -574,12 +574,12 @@ static bool hal_EfusePgPacketWrite2ByteHeader(struct adapter *pAdapter, u8 efuse
 	}
 
 	*pAddr = efuse_addr;
-	return bRet;
+	return ret;
 }
 
 static bool hal_EfusePgPacketWrite1ByteHeader(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt)
 {
-	bool bRet = false;
+	bool ret = false;
 	u8 pg_header = 0, tmp_header = 0;
 	u16	efuse_addr = *pAddr;
 	u8 repeatcnt = 0;
@@ -597,7 +597,7 @@ static bool hal_EfusePgPacketWrite1ByteHeader(struct adapter *pAdapter, u8 efuse
 	}
 
 	if (pg_header == tmp_header) {
-		bRet = true;
+		ret = true;
 	} else {
 		struct pgpkt	fixPkt;
 
@@ -609,7 +609,7 @@ static bool hal_EfusePgPacketWrite1ByteHeader(struct adapter *pAdapter, u8 efuse
 	}
 
 	*pAddr = efuse_addr;
-	return bRet;
+	return ret;
 }
 
 static bool hal_EfusePgPacketWriteData(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt)
@@ -639,14 +639,14 @@ hal_EfusePgPacketWriteHeader(
 				u16				*pAddr,
 				struct pgpkt *pTargetPkt)
 {
-	bool bRet = false;
+	bool ret = false;
 
 	if (pTargetPkt->offset >= EFUSE_MAX_SECTION_BASE)
-		bRet = hal_EfusePgPacketWrite2ByteHeader(pAdapter, efuseType, pAddr, pTargetPkt);
+		ret = hal_EfusePgPacketWrite2ByteHeader(pAdapter, efuseType, pAddr, pTargetPkt);
 	else
-		bRet = hal_EfusePgPacketWrite1ByteHeader(pAdapter, efuseType, pAddr, pTargetPkt);
+		ret = hal_EfusePgPacketWrite1ByteHeader(pAdapter, efuseType, pAddr, pTargetPkt);
 
-	return bRet;
+	return ret;
 }
 
 static bool wordEnMatched(struct pgpkt *pTargetPkt, struct pgpkt *pCurPkt,
@@ -678,19 +678,19 @@ static bool wordEnMatched(struct pgpkt *pTargetPkt, struct pgpkt *pCurPkt,
 
 static bool hal_EfuseCheckIfDatafollowed(struct adapter *pAdapter, u8 word_cnts, u16 startAddr)
 {
-	bool bRet = false;
+	bool ret = false;
 	u8 i, efuse_data;
 
 	for (i = 0; i < (word_cnts*2); i++) {
 		if (efuse_OneByteRead(pAdapter, (startAddr+i), &efuse_data) && (efuse_data != 0xFF))
-			bRet = true;
+			ret = true;
 	}
-	return bRet;
+	return ret;
 }
 
 static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt)
 {
-	bool bRet = false;
+	bool ret = false;
 	u8 i, efuse_data = 0, cur_header = 0;
 	u8 matched_wden = 0, badworden = 0;
 	u16 startAddr = 0;
@@ -703,7 +703,7 @@ static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u
 
 	while (1) {
 		if (startAddr >= efuse_max_available_len) {
-			bRet = false;
+			ret = false;
 			break;
 		}
 
@@ -713,7 +713,7 @@ static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u
 				startAddr++;
 				efuse_OneByteRead(pAdapter, startAddr, &efuse_data);
 				if (ALL_WORDS_DISABLED(efuse_data)) {
-					bRet = false;
+					ret = false;
 					break;
 				} else {
 					curPkt.offset = ((cur_header & 0xE0) >> 5) | ((efuse_data & 0xF0) >> 1);
@@ -740,7 +740,7 @@ static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u
 					PgWriteSuccess = Efuse_PgPacketWrite(pAdapter, pTargetPkt->offset, badworden, pTargetPkt->data);
 
 					if (!PgWriteSuccess) {
-						bRet = false;	/*  write fail, return */
+						ret = false;	/*  write fail, return */
 						break;
 					}
 				}
@@ -756,11 +756,11 @@ static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u
 		} else {
 			/*  not used header, 0xff */
 			*pAddr = startAddr;
-			bRet = true;
+			ret = true;
 			break;
 		}
 	}
-	return bRet;
+	return ret;
 }
 
 static bool
-- 
2.19.0

