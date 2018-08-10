Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAA8C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3120121A38
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFbeZ4/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3120121A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeHJJrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:47:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34206 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeHJJrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:47:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so7379946wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 00:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=22KGHnk3vmqTE4Md2oM9elvrh8gJszfM/wV46d81CI8=;
        b=dFbeZ4/xexbjV2Akz0hEKKdJkGsT76rcwTCyOy1WVyPdjtSQvtcMp5GtPEfF1MP82x
         7bpeY1rt7X22tI+2AZ42mIDCc9S0ujwxg0yoLM6ysrdJUJm8lIg0GDMkVotWpQ+OSxew
         puOtwcxtCyaqNqPPcodLet/Vxch7vOUFUS8sSMLkEkX8ZYCMxayKKd5hVP5p4khJbUo0
         n6ZvqzyOCi6GYjaKYtuoQivgzi0ttjagY79ohZV0KpZPSohiGuNTONY2skKARifJcCN2
         CUslPq4rqIM+nMQwEsNj5xabsBrf9ZVhldMgtddaM6HRzVhEgg3JvU19hZRZqs46l6Hw
         frJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=22KGHnk3vmqTE4Md2oM9elvrh8gJszfM/wV46d81CI8=;
        b=lG2otOfmyogqcHK5HJ1K+VS6FjNUutY/DdLmN8efMukKJ46j6sR+8kHo2zntle/MVn
         yXrIw0S2nZl2M7ZVr82fqY04HYzcDf8R4hCUixZm016oHSrvvBwTUQ5LJbJzrvIxkhw/
         Xk/OW7qz6u2xZqbVGj5HPpC2DunbrAiWU+hSZwQyiF/IUEWEZGf/v72t7nsg3yODSMYy
         55qH5tjJNjWvqP4FLJkm0dHkeA3tHoI9PbAfEmS/RTC8jx41OKLti6qrOCBqaS5OoyXh
         cRS6GXdRrGMU8hkwEwQSACm+tGa/G6C/jUWGgiSQp3P85ArwxKhT+99nzPTeK9TRzpoM
         2pVA==
X-Gm-Message-State: AOUpUlGnsyvk0uxdpa76qgtxKw3dWeF7reC7pQkFQnsmdp1tfNNBUP1d
        xDSDP00mpr/dj2F7Tbx3AermSSnX
X-Google-Smtp-Source: AA+uWPwt8ZEMXyTVlF2vl5ItPV0e7hnlHfjl9q4EpacJ9xl0mweKAC+K4zzUjORPd/ai2zX7FIDDhg==
X-Received: by 2002:adf:93e1:: with SMTP id 88-v6mr3139083wrp.81.1533885523586;
        Fri, 10 Aug 2018 00:18:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id k4-v6sm13253875wrl.12.2018.08.10.00.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 00:18:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/5] staging: rtl8188eu: use is_multicast_ether_addr in rtw_security.c
Date:   Fri, 10 Aug 2018 09:18:29 +0200
Message-Id: <20180810071833.1661-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom IS_MCAST in
core/rtw_security.c. In all uses the address array is properly
aligned.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: checked that in all uses of is_multicast_ether_addr
    the address array/memory is properly aligned and
    updated the commit messages

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

