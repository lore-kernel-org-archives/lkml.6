Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52D2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937E3208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5H6euAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937E3208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbeKQMP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:15:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32783 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbeKQMP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:15:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so8722788pgu.0;
        Fri, 16 Nov 2018 18:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mEQafE1ovXEtuUzq0Mo/a3RelWFovkIxuuwOuyJalEw=;
        b=Y5H6euACiw0+7MnIH/mAScux46LIKA1eMQ2cc9x6uXzGxd1hivywQ77YZ4vLhuwxt/
         osr6Bb2wGwSKR3teOrhoHIlSE/CTTupc4Qm35+iDgPF8SCuSQgIOvAPSLB2nh40SSGvJ
         FvopPaTJDnMtJACK/TD8DtyXKx8tYBcvm0utoOC6rpiAA/mru4AL6W/3AEnDpIYczWc4
         fzjc1+rWpcTXe1REQvjgzQXwZKDP75N40n3+yaEoOZ8DVMgRn8K2H3unDpbBp+0oAZzs
         +nW7Uy9vV7PrrXCVuIFh73G4Ti5chD2aIkBvh31c87NE/B6hW3uZbtUZe7ayvEI661Ii
         5Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mEQafE1ovXEtuUzq0Mo/a3RelWFovkIxuuwOuyJalEw=;
        b=UlOyi7ICPfzFaghlVwlouta51atDZVvIuDPc5+lbHPNeLgCpORJ89ohhs0Kg2oozgV
         xeGz3tHK40F+4hHYpYeuZeyAqaApPfX1QKv9WqMK7cENxtiLFeLqApIk8a3Wy7pA3IPk
         F/zv1M1LO1+I1xIGavJt17FdUhuw2SAznOZjf/4mCNcTid/XpK1nIVV9CFARMUSGNp7C
         WdBJIGjM7RrTUwjHBXwfnFqukX5Fx2S8gSQb4KErgNbQgrr8sM1ZtEmVg8SKAuo2hW3J
         TqHu/DuIoCtRZWaHULMXm6Ws3Nw+x7WIYuIi4az6NH+GlNoJaf+JqcnqyglxP+knG/5A
         9YeQ==
X-Gm-Message-State: AGRZ1gJ+oKzxJbSfRZ38Z6nbCQY1yZqRFloPGrxXjn+1N5OPpe0KP1+4
        wvxiP7ebV4hBlDw6eyqts9HJAP78
X-Google-Smtp-Source: AJdET5ePYmThfNL5z9KBdMVB9B+vcsXUprx8u5GjVsYV8YXe+1S/V2ZktRa0NKdvhZsiulMWW0sAeA==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr11939294pgf.87.1542420067210;
        Fri, 16 Nov 2018 18:01:07 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b14-v6sm47535498pgn.49.2018.11.16.18.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Nov 2018 18:01:06 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next 2/2] net: bcmgenet: abort suspend on error
Date:   Fri, 16 Nov 2018 18:00:22 -0800
Message-Id: <1542420022-30251-3-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542420022-30251-1-git-send-email-opendmb@gmail.com>
References: <1542420022-30251-1-git-send-email-opendmb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs during suspension of the driver the driver should
restore the hardware configuration and return an error to force the
system to resume.

Fixes: 0db55093b566 ("net: bcmgenet: return correct value 'ret' from bcmgenet_power_down")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 3 +++
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 01c8499fd87f..983245c0867c 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3717,6 +3717,9 @@ static int bcmgenet_suspend(struct device *d)
 	/* Turn off the clocks */
 	clk_disable_unprepare(priv->clk);
 
+	if (ret)
+		bcmgenet_resume(d);
+
 	return ret;
 }
 #endif /* CONFIG_PM_SLEEP */
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 2fbd027f0148..b3596e0ee47b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -186,9 +186,15 @@ void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	}
 
 	reg = bcmgenet_umac_readl(priv, UMAC_MPD_CTRL);
+	if (!(reg & MPD_EN))
+		return;	/* already powered up so skip the rest */
 	reg &= ~MPD_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_MPD_CTRL);
 
+	reg = bcmgenet_hfb_reg_readl(priv, HFB_CTRL);
+	reg &= ~(RBUF_HFB_EN | RBUF_ACPI_EN);
+	bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
+
 	/* Disable CRC Forward */
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	reg &= ~CMD_CRC_FWD;
-- 
2.7.4

