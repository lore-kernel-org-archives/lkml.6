Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3579367-1520832382-2-8572320638107233196
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES encada, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520832382; b=C6B6WF7UrCd1gy6wHFyjefNkLKWrX0K93B//cy6WtkXGu5m
    ZJLZ6T8f1nCNcNEtDrFJa8M0ycb+WtGVI1xrRr54GL1PVzxIq+7gWgGDkPkjFfxB
    mo/eW2CaJ2eURhnZ3pVIpY6kjCbROmfhdjD5oRGyRPmdC/hpPIZrnBtdCbEShHHs
    kvLqpYua51LMtzOLZud/vDl31D/1oTn1W/dZjESwUbcahQqWUh5MaVF8zzLNKB83
    sz8KCJ3A1/QJVphdXZykm6zUfaE1LTmKC3PWSuOS7i2/R4PSlXgGmiHih2mkEAkL
    J8LjhdvbFHHBDZUaljFEHCXzJHGBHKYrKyeiAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1520832382; bh=bxWt2QQOBPyb2P8kP9bWP3HO3/ZYwulBd0/6/5hh2WQ=; b=S
    bOBwuFidvDzdxVSfl0bUVUb8sU3a3WJ+GqheIIN08uin4S3aNUry1ZcMQNbNoz9S
    l8cNR1O6nimIFTx+pE2hKabT4XAmLCUqTu9U/Phth0B2oU5zwlSs2wlBPjrikKna
    NCufMkwY28YBkEY80d8E1cAXyWNmMoFB7LY05O2TKLssJ8hKz2BInf1zRQVTh8UF
    Bt7HHbajaNp17kNECFbBydVGR6FkVpOymy0YK05p5zGAHP5nHpVkw+944S5phoHt
    ML8/SMDQiun+DcyviDvv1E6O4F1h60GIjy6NoWlwO+hFZF+5GbSQPegKWWieGUaH
    OWxhU9+JSg0JxGRxW94zQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeCLFZw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 01:25:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31679 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750967AbeCLFZt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 12 Mar 2018 01:25:49 -0400
X-UUID: c7114154eed44fe0be6e63a599fbda53-20180312
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/3] phy: phy-mtk-tphy: keep default value of mcu_bus_ck_gate_en
Date: Mon, 12 Mar 2018 13:25:38 +0800
Message-ID: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520832210.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23714.005
X-TM-AS-Result: No-1.908400-8.000000-10
X-TMASE-MatchedRID: vws8hDIFFaMx6KucKu0cuu7KTDtx8CggHIOuQjCOKFtd15Kx2hUn1PlY
        oV6p/cSxdaFz8kVCOhx5OPD8XJFfpB8TzIzimOwP0C1sQRfQzEHEQdG7H66TyAHBfPF4BytGxgX
        JkdlDcqFt46joM/BziE/ZqQ3W0/wWJoZ1iX3RkdWUc/Dt3amsQitKSMGtticXxKznzw+nKt4U4P
        KSo1WaKM/qwp+F9lXT8OyccFNBL2TKhETi2//sjuP9Cb59K8ACZrS+A8PszW/U9h9N881NSQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.908400-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23714.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The default value of mcu_bus_ck_gate_en is 1, if clear it, will
prevent system to enter deep idle mode, so keep its default value
and without affecting PCIe function.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 1e96d07..6073c25 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -688,8 +688,7 @@ static void pcie_phy_instance_power_on(struct mtk_tphy *tphy,
 	u32 tmp;
 
 	tmp = readl(bank->chip + U3P_U3_CHIP_GPIO_CTLD);
-	tmp &= ~(P3C_FORCE_IP_SW_RST | P3C_MCU_BUS_CK_GATE_EN |
-		P3C_REG_IP_SW_RST);
+	tmp &= ~(P3C_FORCE_IP_SW_RST | P3C_REG_IP_SW_RST);
 	writel(tmp, bank->chip + U3P_U3_CHIP_GPIO_CTLD);
 
 	tmp = readl(bank->chip + U3P_U3_CHIP_GPIO_CTLE);
-- 
1.9.1

