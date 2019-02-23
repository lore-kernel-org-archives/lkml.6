Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6F7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1822084F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipj0u4Gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfBWGjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:39:45 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37700 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfBWGjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 01:39:44 -0500
Received: by mail-yw1-f66.google.com with SMTP id k14so1720461ywe.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 22:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3EMYznL3EWDnmNBfI54BAPtJwi8MBMqHzhrc8HovSg=;
        b=ipj0u4GsJKnMqHQym4766GkIiejMpzeO5QsLoB2RN1QgcMV/MceykDdMkd9BCFuox0
         2WT0o7eurmu29mpUbgKU+RNFMgEIElRo9k6ScSsVGGNDMTKmS5HLB4pv/jq1YxVt1A6z
         NyzOFEtGPmfYEKmxSgmKWMMYSUDUh6VEkI1laP5WD4d9f4RzyHjjJb9yXGAJsUcvQ2BB
         v2sTlbHyb5M453gLwYxOKs8FAM1xuWruKkO1bxOSzEEsX3+k9Ar3ndF6um3EPpmZF3uM
         TXeKm5lJB09tb3xGq/CLcV7gsHSjglfTeIeDait0s3Eu7F9RRExO3prgLeT4g/8Gdx84
         oQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3EMYznL3EWDnmNBfI54BAPtJwi8MBMqHzhrc8HovSg=;
        b=NmLSRtdie1eqRDn5iL14uDcnmE4GW7zY54ju4kl1UMGDzP1tpwvUiA6AHysDxQBO5L
         fXjJX/WqS4/Cks6AX/s9yi5XnmyaFxfN8ydNWEFctg8fPpQbzN2GAkSc/02qckyo70fC
         t2roT+YicIR1+oLC9OOaOV1I4HfSMrSGHCm2ozl8u5iIIkh5GRj+alptOpWyzJKs9cBW
         TaOewKhJvwuuzdApnxpQtr5jbDrIK4KQdJHol+rVh54DPhUxPdz7RhLXirq7QRep0HJi
         QfvRMfgxvUW++3a3FO07xibrRqGfoCickhBcj5KMF23euXoTSKsQkbrGBVWLKYjMsXeA
         P8/A==
X-Gm-Message-State: AHQUAuYK3rhNSqKD1xi5RmK1SCAdeGKXIwyIuAv0rKQItbbI9v2FZVZN
        QkH8TCdGqFHOjeZp6Mw27Ps=
X-Google-Smtp-Source: AHgI3IZfoan2IC+X3q1tnvuz8FOWgjXfB872gqPCHOYMm+44Okdklpur3R0n7V/Q32MzI+sg8MxQ6Q==
X-Received: by 2002:a81:7102:: with SMTP id m2mr6207562ywc.235.1550903983747;
        Fri, 22 Feb 2019 22:39:43 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id z186sm1233479ywf.17.2019.02.22.22.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 22:39:43 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, sergio.paracuellos@gmail.com,
        quytelda@tamalin.org
Cc:     Bo Yu <tsu.yubo@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, yuzibode@126.com
Subject: [PATCH] staging/ks7070: Removed unused varibale
Date:   Sat, 23 Feb 2019 01:39:39 -0500
Message-Id: <20190223063939.18261-1-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Yu <tsu.yubo@gmail.com>

Compiling the kernel with W=1 results in the following warning:

drivers/staging/ks7010/ks_hostif.c:465:6: warning: variable ‘mib_val_type’
set but not used [-Wunused-but-set-variable]
  u16 mib_val_type;

drivers/staging/ks7010/ks_hostif.c:464:6: warning: variable ‘mib_val_size’
set but not used [-Wunused-but-set-variable]
    u16 mib_val_size;

drivers/staging/ks7010/ks_hostif.c:786:6: warning: variable ‘result_code’
set but not used [-Wunused-but-set-variable]
      u16 result_code;

Remove these variables.

Rebase on next-20190222

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: Quytelda Kahja <quytelda@tamalin.org>

Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
---
 drivers/staging/ks7010/ks_hostif.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index d938b0997a53..913d8996437a 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -461,13 +461,9 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
 	struct net_device *dev = priv->net_dev;
 	u32 mib_status;
 	u32 mib_attribute;
-	u16 mib_val_size;
-	u16 mib_val_type;
 
 	mib_status = get_dword(priv);
 	mib_attribute = get_dword(priv);
-	mib_val_size = get_word(priv);
-	mib_val_type = get_word(priv);
 
 	if (mib_status) {
 		netdev_err(priv->net_dev, "attribute=%08X, status=%08X\n",
@@ -783,9 +779,7 @@ void hostif_ps_adhoc_set_confirm(struct ks_wlan_private *priv)
 static
 void hostif_infrastructure_set_confirm(struct ks_wlan_private *priv)
 {
-	u16 result_code;
 
-	result_code = get_word(priv);
 	priv->infra_status = 1;	/* infrastructure mode set */
 	hostif_sme_enqueue(priv, SME_MODE_SET_CONFIRM);
 }
-- 
2.11.0

