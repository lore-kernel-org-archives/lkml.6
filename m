Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22317C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE58C21547
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpUzTu1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE58C21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeI0CTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:19:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45627 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeI0CS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:18:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id m16so166139wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fR5oe1Futa8moGIg7JwPWYoBXsXJj+GMNbRcYjC0+qo=;
        b=qpUzTu1ZT8NQeF6dXT2h2LzE4BDt7JxSM248jOw5C+DnH8HBcopwzJXXsaxrZ1KMUL
         7RlUrLlDhP1oM9uQC3x6DBVn9Xsk1k63tNz+hVQ9YVRuUpDKWrz3cpc1gBDUQ7SBEOm5
         yeCGFE2Fd6beEGkIimNRpi8uLLw669DvHudJMS7+hlYDEkmXXnfrvUDrJFiROcgXixkU
         hhMC0qv45ND5WT7VyBmoxy6NCeRPVX3MBm5LBaTymV2kvO7QN9ynwRsXWd72BHoEG2Lq
         u80W0Khz7wa/zwuuIjDp2RsBBjVOiP/Ot6RnhKlncRHfJ1Di3nTskPqppNXFp3ji93fP
         1MhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fR5oe1Futa8moGIg7JwPWYoBXsXJj+GMNbRcYjC0+qo=;
        b=T8lK9i8EgK2nmjXLVRIqjxtPtaTDaAG+Wahzb7j/+4TAvy6QgFwv+SrzJyUuOHhUDq
         TDN2AsO+x5pIBLfWDCLFzCdwVZ8C1KWFY+Pon0Ql/JU1cg66fv7DjBk3o2sIMIZiGsDD
         e+X45WcefLcnS9TJjsffav0SlXmmRKfACUrDI/YmQ51S0E8DaU8lKpOk6QKVs0kMSfvm
         L8Hj8xXZsiMtLFFe7oW+aSGB2FeCmqUl2XH+gzdFr3BYMBH7yegackC5Q+9TnHvsg8N+
         yQiYocr5lYxq+Rz58gWwEFS2lmvuAi58jwW+8htU0XhfCX07XAK4enYul+p/ruRdi7TD
         U5yw==
X-Gm-Message-State: ABuFfoiOqgdjsfYJ/afg4QksYQ5cp21aJ5aBJJSH3qxA+DSkFPOjgNSb
        7li7rrHncfChV9edLDf02N4=
X-Google-Smtp-Source: ACcGV60zFo0plC89V8VtgHwQse//S7Z/BTVIjvI/O1kvoIpARPY56+SaeoVUB3/gkO92zQVn7sMH+A==
X-Received: by 2002:adf:9227:: with SMTP id 36-v6mr6386093wrj.275.1537992261762;
        Wed, 26 Sep 2018 13:04:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id n4-v6sm7447403wrr.21.2018.09.26.13.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 13:04:21 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: rtl8188eu: use break to exit while loop
Date:   Wed, 26 Sep 2018 22:04:08 +0200
Message-Id: <20180926200408.2372-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926200408.2372-1-straube.linux@gmail.com>
References: <20180926200408.2372-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable bContinual is only used to break out of the while loop.
Remove the variable and use break instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index ca0217881eb4..4988d97ca0d1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -360,15 +360,13 @@ u8 Efuse_WordEnableDataWrite(struct adapter *pAdapter, u16 efuse_addr, u8 word_e
 
 static u16 Efuse_GetCurrentSize(struct adapter *pAdapter)
 {
-	int	bContinual = true;
 	u16	efuse_addr = 0;
 	u8 hoffset = 0, hworden = 0;
 	u8 efuse_data, word_cnts = 0;
 
 	rtw_hal_get_hwreg(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&efuse_addr);
 
-	while (bContinual &&
-	       efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data) &&
+	while (efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data) &&
 	       AVAILABLE_EFUSE_ADDR(efuse_addr)) {
 		if (efuse_data != 0xFF) {
 			if ((efuse_data&0x1F) == 0x0F) {		/* extended header */
@@ -390,7 +388,7 @@ static u16 Efuse_GetCurrentSize(struct adapter *pAdapter)
 			/* read next header */
 			efuse_addr = efuse_addr + (word_cnts*2)+1;
 		} else {
-			bContinual = false;
+			break;
 		}
 	}
 
-- 
2.19.0

