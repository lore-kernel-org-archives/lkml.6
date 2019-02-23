Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625BCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4E2206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klZfx+Y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfBWHtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 02:49:00 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39515 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfBWHtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 02:49:00 -0500
Received: by mail-yb1-f196.google.com with SMTP id s5so1799871ybp.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 23:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8RfGMmtOwH6+OmRZHpmvSXHOOXNzfPrFrH7OHXI6So=;
        b=klZfx+Y5KdMlgLPJh0M1dfm0UTqJpZJcW3kjmLuJj5zg3BR9CHdi+O41Rmtb1dUfme
         eECHUn0OxvsFichwEDzEkub7rIBrWtftXycJWZNvYyCjGnH5OC+Y48LfMweEumGegjNW
         azJfu11Yvbaej1m+9/AhQvPFYYZnD+TJinbl61SXjY+7rSaVCMeMEaxSyr4vuDkMRp2e
         zLkjSb0UY1WvspwR49xTfo8mWDIMracGibf0kP0mEpO/DJmqvkKTVzjD11pVFlJGKs7j
         vRBanbnoQhpx+AM5joasdwRC8ciT8ygB9sjBqChIrEYjinL5/xt2GqTR0vB3T5CAzLs8
         vjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8RfGMmtOwH6+OmRZHpmvSXHOOXNzfPrFrH7OHXI6So=;
        b=SvDeDRMQpbL4OoXgKxQ6yMdX0NGWLohg6ir44TwHaoMoqqrUVkomGTLepT6C3StvMQ
         gRvJ1jidcb1gt4pUWJNS5at3+PSGUpVpq3Qcn3Sh5t+bkmsA5oE5brqNAkXbkR3iMDnX
         0sa9mPiLjCOHM1lTy4BAwTKfZTBwr/xam01mkXidQcXoiIz3SoNNpk1I6JGfcGDDud3Q
         8pHSMYu32MGAxlAPNedpS0QUCiIO531SEV/9fTPvpPq6+pzmMdCcx0KsUGl8116I8Heb
         7EDRKbtjPJSPot2kiEHZxXClr8Bk983hf1GTaSWFo1C1Dl3TOzmUcJI7ERcgPrbSKwRv
         xFyQ==
X-Gm-Message-State: AHQUAuZ72SW5kjuwkzIZZeQ7rILLf/nbM/L4jzslrhqSh8YdW/zx/4Vu
        y9tSkUBO/7iIyQ6nrplbqpU=
X-Google-Smtp-Source: AHgI3IbZTrnRns3SYKb1gAUzRmIk6VZj4KefDct9Ru//pYaeV44kD0QGg+zrXJo8UaT+FN441eEneQ==
X-Received: by 2002:a25:e90b:: with SMTP id n11mr6581890ybd.16.1550908139324;
        Fri, 22 Feb 2019 23:48:59 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id x7sm1209835ywa.84.2019.02.22.23.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 23:48:58 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, sergio.paracuellos@gmail.com,
        quytelda@tamalin.org
Cc:     Bo Yu <tsu.yubo@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, yuzibode@126.com
Subject: [PATCH V3] staging: ks7010: removed unused variables
Date:   Sat, 23 Feb 2019 02:48:54 -0500
Message-Id: <20190223074854.18547-1-tsu.yubo@gmail.com>
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

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: Quytelda Kahja <quytelda@tamalin.org>

Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
---
Changelog:
V3: fix spell issue in subject line
V2: fix patch format
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

