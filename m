Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B0BC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 11:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD5425811
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 11:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXHY+IKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD5425811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936910AbeF3Lgq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 07:36:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34408 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936427AbeF3Lgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 07:36:45 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so11134753wro.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 04:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rr7PnF5CoQkYrjGWMbuFYbyOosCx0422yIjPCRlKUaQ=;
        b=KXHY+IKSn0soXbOgoAX+Z5HTwp9mrI0FuDieta1lgw165bfZnn9U6fqpGOqcqGVQeY
         9Fq75S1a10JGGLCoVf+19BxhmN7dHkHQmYZuxBdl5uUTZq6o8akRJL8aGwIb9gGgJUSo
         BzSXbl1R7KgCZeyYF76nmWZPkR+jJB063qwTQDeK4Y9FzsVBJo0FU8dl7hyZveCVltq+
         riu1PbYBu8tTJ3nLxuUswoED+KIjdoXfpkaBe1OuYh8XMNtDwS4cZPHOsoY+2p76+GAV
         deMZhXKgiqZ4YeRazcDN5xxO/9QI1CKyewULmG9aDXEczvR4HKYtdbrgobZLnt28hgtk
         dbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rr7PnF5CoQkYrjGWMbuFYbyOosCx0422yIjPCRlKUaQ=;
        b=bsWRV5g1h0uCEq8tXHYqkFEKn/utKrhbptot+xfIt5D/bocKWqUZ/Brs0e92ORzlyw
         WGrCxkaFgGl5OFkzSPuDXuCwaAhygDc0cYOLTvCwIEWDsLa6gg5/6U+aacjSOmIgr4aw
         qhwO6E46i1A2f1Vgp0HIML+7ihmssAAG+m3Vq7uuGNI/cufg3LCOUVycmHjfeJ+Z6NrJ
         oljLxUH4vAe88filvkhgnyJI0XqlhdKgBqv48+ubvK7N8amCrmccFbnW0kYhvPsO0ipg
         3JkqqF6Yn3dO2+AfY8/+8joL0Sk0/qrxD1OEAT5GYx+ztpCA9fS0EImzc/EfmE9E8O9k
         EEHg==
X-Gm-Message-State: APt69E0/KjYj+Zt4NtWu5IG6AbvRaCKD++6u5gF7EySXnPbOGyWZTx5C
        CpDaxiYfnw6iP/3A81CZg/g=
X-Google-Smtp-Source: AAOMgpfmPPUyknnju+NN68CK+38aJBhoRkoQmfBMJEJHy6sGC+f7zBSRm2L8waCkPddxLREjhi4Y9A==
X-Received: by 2002:a5d:4e49:: with SMTP id r9-v6mr14029273wrt.27.1530358604686;
        Sat, 30 Jun 2018 04:36:44 -0700 (PDT)
Received: from arch.localdomain (x4db215a8.dyn.telefonica.de. [77.178.21.168])
        by smtp.gmail.com with ESMTPSA id s184-v6sm3733848wmf.5.2018.06.30.04.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 04:36:44 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        schwab@linux-m68k.org, Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/2] staging: rtl8723bs: fix comparsion to true/false and brace issues
Date:   Sat, 30 Jun 2018 13:36:27 +0200
Message-Id: <20180630113628.18231-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if(x) and if(!x) instead of comparsion to true/false.
Reported by checkpatch.

Remove unrequired braces from single if else statement.
Add missing space after else: else{ -> else {

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_btcoex.c | 8 ++++----
 drivers/staging/rtl8723bs/core/rtw_efuse.c  | 5 ++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_btcoex.c b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
index adac915a2153..e56502e301ec 100644
--- a/drivers/staging/rtl8723bs/core/rtw_btcoex.c
+++ b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
@@ -77,14 +77,14 @@ void rtw_btcoex_SuspendNotify(struct adapter *padapter, u8 state)
 
 void rtw_btcoex_HaltNotify(struct adapter *padapter)
 {
-	if (false == padapter->bup) {
+	if (!padapter->bup) {
 		DBG_871X(FUNC_ADPT_FMT ": bup =%d Skip!\n",
 			FUNC_ADPT_ARG(padapter), padapter->bup);
 
 		return;
 	}
 
-	if (true == padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved) {
 		DBG_871X(FUNC_ADPT_FMT ": bSurpriseRemoved =%d Skip!\n",
 			FUNC_ADPT_ARG(padapter), padapter->bSurpriseRemoved);
 
@@ -198,11 +198,11 @@ void rtw_btcoex_RejectApAggregatedPacket(struct adapter *padapter, u8 enable)
 	pmlmeinfo = &padapter->mlmeextpriv.mlmext_info;
 	psta = rtw_get_stainfo(&padapter->stapriv, get_bssid(&padapter->mlmepriv));
 
-	if (true == enable) {
+	if (enable) {
 		pmlmeinfo->accept_addba_req = false;
 		if (psta)
 			send_delba(padapter, 0, psta->hwaddr);
-	} else{
+	} else {
 		pmlmeinfo->accept_addba_req = true;
 	}
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index c306ad7e395c..b3247c9642ea 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -580,11 +580,10 @@ void EFUSE_ShadowMapUpdate(
 
 	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, bPseudoTest);
 
-	if (pEEPROM->bautoload_fail_flag == true) {
+	if (pEEPROM->bautoload_fail_flag)
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
-	} else{
+	else
 		Efuse_ReadAllMap(padapter, efuseType, pEEPROM->efuse_eeprom_data, bPseudoTest);
-	}
 
 	/* PlatformMoveMemory((void *)&pHalData->EfuseMap[EFUSE_MODIFY_MAP][0], */
 	/* void *)&pHalData->EfuseMap[EFUSE_INIT_MAP][0], mapLen); */
-- 
2.18.0

