Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80151C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBF221479
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfxsOGLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBF221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeKUJts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:49:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37015 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeKUJts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 04:49:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so2527008plr.4;
        Tue, 20 Nov 2018 15:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7RS3UCahL7eL5cCrFYDkdJ6sasQ4tBi9a6j/NQiDfFk=;
        b=bfxsOGLtsusFytPEqpe97mIwvSDh3nkmzxhbHRr6Dg6IJjvf2tac+Gywzx1PumoU6v
         JVM0fNbll/YyejWNhoeyCLiEZ1QUugAMvtKgTacsIUylHWIswjOpUZonlEi39FN+llHK
         xgDpJq7+KiZ0H9vRpInwknIivVCIzSg/GowxEqV2R0tuN31t/vVijkQwigeH8ND/uM+x
         6ssVwNFdM7sW4xhvO69ldiIuXcubrlycBgT3m6W7vZSNBwBTyd9bAusjMn45UvNYWTee
         hvIhapLGVJvDagdAsMR6wGssRLNnMRZ8sFK7J+TWMQCYtIFhEfu/cY7Wv1pMRG+5Uwsn
         DvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7RS3UCahL7eL5cCrFYDkdJ6sasQ4tBi9a6j/NQiDfFk=;
        b=RH/c+4y3KsKe4adR8MF9P8POu1tbrAUsJyNSD0fdsStvOLNvyLU0Z8cerg4vMWC6Xa
         yNAbuAEEIDjAcDF8BpMT3Rn3CyT9SyWk/WNINuKnQf3rOAK9P7H5rUferYua3eCaIuoN
         AkNRCf5vT/lGfxInLj4hZOr1X+gPZpWFoghPZ27A8xlgthjF6sK4RFFjSl207F1UEo5M
         ntiaZeZKgg7veB9bpDdEMdAjGMmVaKPN68Rj169dSYT4gLlK2FMaeSTXgSUqyJhDbly3
         3LA9f/Lv48A1u15UCmrC2cMcRLqBtsUcsvYxGvOAZ7EP4+UAcE9+MB+mMFEkx4BPk9N3
         42Aw==
X-Gm-Message-State: AA+aEWZCA07RWF3sribTAnnoj0oCHK3GGIX6YXlnYjyckMrqbpXbX0mu
        PRPPwcc2IHm1645vIqO+zF8=
X-Google-Smtp-Source: AFSGD/V29hZeUImnJRgiKE64yCkurHOptJn1j4Vey0yn5vnUiO6vHlwuhoLIBrZW2nodnnFSDl6duw==
X-Received: by 2002:a17:902:7882:: with SMTP id q2mr4370183pll.305.1542755888069;
        Tue, 20 Nov 2018 15:18:08 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id u127-v6sm52049933pfb.47.2018.11.20.15.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 15:18:07 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next] net: bcmgenet: remove HFB_CTRL access
Date:   Tue, 20 Nov 2018 15:17:01 -0800
Message-Id: <1542755821-21554-1-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c5a54bbcecec ("net: bcmgenet: abort suspend on error")
mistakenly introduced register accesses that should not occur
in bcmgenet_wol_power_up_cfg().

Fixes: c5a54bbcecec ("net: bcmgenet: abort suspend on error")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index b3596e0ee47b..57582efa362d 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -191,10 +191,6 @@ void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	reg &= ~MPD_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_MPD_CTRL);
 
-	reg = bcmgenet_hfb_reg_readl(priv, HFB_CTRL);
-	reg &= ~(RBUF_HFB_EN | RBUF_ACPI_EN);
-	bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
-
 	/* Disable CRC Forward */
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	reg &= ~CMD_CRC_FWD;
-- 
2.7.4

