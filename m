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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9080DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FC2206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHwg2bSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfBWH1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 02:27:20 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34836 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfBWH1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 02:27:20 -0500
Received: by mail-yb1-f194.google.com with SMTP id d9so1716812ybj.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 23:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LWQee6Hw+ubjDtsbZ5j7CoUHAe6PWxxWUM19c6x5AQM=;
        b=YHwg2bSgR5dWApjaRsy6psIv0USqpBHADAXv6Nckx7O8fG7CHoLFMo6Z3+dzwvh+TC
         tH9TMECo5/S3Rg3a0MA/y9H89z+pj5Jtj3IKvXpYCoT8krig71/aDeCouLWiSMGpbzVA
         1mS3s4Vnez+eaI4lK1s38ikl3dw04feBCpZLKGiPKUNtAIvgjyHiuZmYXH0wJL+Ag0/6
         ANJCP/DDOeICYyeCGEVLz1Spm8fz4XBU/lQxvlqh03Q6ZNZVm39bQmBAJTa6jQKj87zF
         9Egcu8MhP2LSFGLhmCAYCd7KwEx+qkTzfr2C/DzKo1c8UtLIcQBFqtTALcVD7MltghMv
         StEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LWQee6Hw+ubjDtsbZ5j7CoUHAe6PWxxWUM19c6x5AQM=;
        b=IlurKXgcy98uOODoBzLQImbcEyZsLxHUvOhgS8b2cLBvX5c070btB0O9yl2Va2PALV
         XdIbSg+LKzJdpcIhFONiWjmru8EK0/QC2uOQWgxGYBU8f5vEsMgUM9qG4jMXdiCYaW3h
         LxkPjwHNo/Lm2iczKt/zr3HVLENOGAi1Fn8xle8yythFSQ7auUcnZEFVjvF4PP8Pl39b
         a9IHOW88cuJc//Sn6PY3ufFzwN1Dsvgu2kijV9D7fQI1ryOaUO+/Ed4fo+F8mfz8ZJEw
         5I2tYW+HmGIPLWS0BQS8boTzQs7dRT022k8TLAH4MldM9kMZShfpHeOan133GTj6r65g
         Fe0g==
X-Gm-Message-State: AHQUAubb3JqKTa4ibKtDoI4Kg6U86CaS39LISyqKZLjVXRAPHXfFqJ9j
        ZS7ZVyLEOJNSEaUUPmfU3vCPnWw93Ic=
X-Google-Smtp-Source: AHgI3Ib4EXH1DgQuJ4uA9mluGQ2Vukr7HTBpVt3GChi5RI51AJlObIAHV93K9DzcmawAIBgDF9qAww==
X-Received: by 2002:a25:c804:: with SMTP id y4mr6637091ybf.429.1550906839175;
        Fri, 22 Feb 2019 23:27:19 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id q185sm1234634ywb.15.2019.02.22.23.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 23:27:18 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, sergio.paracuellos@gmail.com,
        quytelda@tamalin.org
Cc:     Bo Yu <tsu.yubo@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, yuzibode@126.com
Subject: [PATCH V2] staging: ks7070: removed unused varibales
Date:   Sat, 23 Feb 2019 02:27:12 -0500
Message-Id: <20190223072712.18422-1-tsu.yubo@gmail.com>
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

V2: fix patch format

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

