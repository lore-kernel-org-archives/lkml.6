Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33561C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAB921C3C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H47frBEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAB921C3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbeHIT1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:27:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47082 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeHIT1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:27:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so5731822wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=28iCIvWohZiuYcGEd2VXT60QobHWJk1wn6V3X+vnt/0=;
        b=H47frBEGLbsytVM9Em+w+M2NigW7ih4h0K+GYWUEVgSRyhP11344fhJZgDuSgIqgfF
         1B0rhx+J69NiTpQcNh5KYWiAh1gcwM9VAEJFGaKdAyWqTvgcGQPNWH7yqzSkHjyVgCte
         Vyt2vSrvijA5mPZCnfa/PJJrRsDDB4os4xBnoIQmj134D72Si3DrfH1uM8zfNxeaWc1C
         B+G/EyUMUkaiwGToQ0GZGdzFAqMOWOeHAs2OFKj9445qQqtQ7AaH+dyeNR1nwkohv7p+
         ANTDH+fWEIGEjTKJDBffMicI2I0ayLBlBx9roj9DMcyp6ZYiBToGYaAS8z+qXqJwJZ2V
         r9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=28iCIvWohZiuYcGEd2VXT60QobHWJk1wn6V3X+vnt/0=;
        b=tBfGQoXv4QUhs9gOA4RXB/UYxQzJlv97hohEVgt8zFwXoTUcQ0fcHNOEDdDjHcZo4p
         TlN4jIsK5/5g0I05QGQ35OA1DancOqi4V1q6V92slPAPBRSLE4QbUi5YLr0Wv6kt4h0N
         wfyDDUnb+wRHTYQU6HD4mzzTU7KUVUt3p8sfK187WlFmiAc+wNc8OHNuEDIFghOuvsLC
         04ML1qsxsMNWQ4Wp9th4nNCX1T9IDrB6lthwS5Bef6ShPmsMdBfyiQkL9Ngj0Cr8cFlr
         a2HJQ8bAWx+zBk0KR/RL25QqIdSOJBgQUZzlUqvHYF7JQx7kS5+/tbsD4tdRVNYWHtba
         q0kQ==
X-Gm-Message-State: AOUpUlEEQ9OjCzGxbCGOClwt3l2MgTTtx2gC0FpMvN9+9qQwKJhUAcfV
        BXlCb4kdUbPuwWPXaJK4bAA=
X-Google-Smtp-Source: AA+uWPyVv0GS6h+CleqodReO5No66AH1+kiTJozhAnilTgGCtooqvwrzjwS/llLb8qzji9ivUMASBA==
X-Received: by 2002:adf:9282:: with SMTP id 2-v6mr1825545wrn.69.1533834106964;
        Thu, 09 Aug 2018 10:01:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id b6-v6sm10389440wru.66.2018.08.09.10.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:01:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: rtl8188eu: use is_multicast_ether_addr in rtw_security.c
Date:   Thu,  9 Aug 2018 19:01:27 +0200
Message-Id: <20180809170131.29279-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom IS_MCAST in
core/rtw_security.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_security.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 2a48b09ea9ae..a2ec0e403718 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -608,7 +608,7 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 		if (stainfo != NULL) {
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
 
-			if (IS_MCAST(pattrib->ra))
+			if (is_multicast_ether_addr(pattrib->ra))
 				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
 			else
 				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
@@ -678,7 +678,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 	if (prxattrib->encrypt == _TKIP_) {
 		stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
 		if (stainfo) {
-			if (IS_MCAST(prxattrib->ra)) {
+			if (is_multicast_ether_addr(prxattrib->ra)) {
 				if (!psecuritypriv->binstallGrpkey) {
 					res = _FAIL;
 					DBG_88E("%s:rx bc/mc packets, but didn't install group key!!!!!!!!!!\n", __func__);
@@ -1250,7 +1250,7 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 		if (stainfo) {
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
 
-			if (IS_MCAST(pattrib->ra))
+			if (is_multicast_ether_addr(pattrib->ra))
 				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
 			else
 				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
@@ -1296,7 +1296,7 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 			struct security_priv *psecuritypriv = &padapter->securitypriv;
 			char iv[8], icv[8];
 
-			if (IS_MCAST(prxattrib->ra)) {
+			if (is_multicast_ether_addr(prxattrib->ra)) {
 				/* in concurrent we should use sw descrypt in group key, so we remove this message */
 				if (!psecuritypriv->binstallGrpkey) {
 					res = _FAIL;
-- 
2.18.0

