Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B609EC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EADC22407
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwFPPFRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EADC22407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeHJNVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:21:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52338 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeHJNVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:21:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so1411416wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 03:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KLASDXOu2rJP2dcXHNfkzCCiShyEqockM050REIipaU=;
        b=PwFPPFRpEY0sQ94x63utpond8OPmIXlPPRQ+TzMvfKVQVmtXwrc06+83OjWAqSx1te
         3+hTwHgOTymVK0+6x59MUp1O0TzO7dJNHTs2i3EeReNrHx1PNvxzXz9AkDRRh+8KI0Zf
         TorIzFsCMTe7Bw0YGjoh7lk34Ty0I7pX5bImgzu/lXuMPeHMJ0yM9RYfp5M7HcynJG11
         ympX0b9tz7ZeMBTaQJUYdiBRN3v8coBWzKwZ0grRQOV1HZNQuLzRlvdiFabBSRRyfxbQ
         2mCjzQuu+7SsQbNQsM+Jyu8jtAYgUhbF0jOF0d0gudWJM1rO0PcrAFheDgyFNF6KekAT
         EvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KLASDXOu2rJP2dcXHNfkzCCiShyEqockM050REIipaU=;
        b=M+DwbykEXSDzYte48NCqIpv57fxDqwtUt34581HtyxyYZjNrf38jSnX61aeqxx/hfI
         OVJsBgwn+xxXxwKDmipsjCzIdULtFhqo61fi9UkG9rivXw+KDN0L4bnk+uNBooiyM5aM
         +B2pbjCBYmmZ6/Na/qpgr78/KCBMnNZxHhjBR7B7B+li7qk94lcxlzaKipsgh00gYfC+
         knnyR/roSZnwffVRbzK28Ju0Xh9P8d48eUHkWWVYoyTGVoysNv94cRys6wMSA+BBT1lI
         J/Lm6ssIPy+Ng/Apmb/Yv6Ydc6bHyz957ffxM8razF+0TyyDp68XxYSS/pYrrAb5tCc6
         KHrg==
X-Gm-Message-State: AOUpUlHus0CKfoAmMNmbOD5XTgdRCdQnH6j6pVwoRyA0I6O91MOcs/R+
        BAvswjSaAuuiurj/3qKNCqs=
X-Google-Smtp-Source: AA+uWPzdRUOHBwwU1ewP3kTl5odbt2D8J2yvCT2B2sTrO5FPKXwfnXnJV95KihSao6ysXjGzsj6DFQ==
X-Received: by 2002:a1c:e595:: with SMTP id c143-v6mr1199751wmh.85.1533898302505;
        Fri, 10 Aug 2018 03:51:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id p14-v6sm14273994wru.0.2018.08.10.03.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 03:51:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 1/5] staging: rtl8188eu: use is_multicast_ether_addr in rtw_security.c
Date:   Fri, 10 Aug 2018 12:51:29 +0200
Message-Id: <20180810105133.31224-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom IS_MCAST in
core/rtw_security.c. In all uses the address array is properly
aligned.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: checked that in all uses of is_multicast_ether_addr
    the address array/memory is properly aligned and
    updated the commit messages

v3: added "Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>"

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

