Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2307271-1524543446-2-16089528156978304735
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524543446; b=qKar2ZnZ/i9w39rFQa3bau5Or5zYwhBZM62ZYj0z2P13YpnwB4
    srT6yHJSZAYXI1SVctZqMMOnWckauv5HLZG/ldmSTh/XuT9jVkpAFwwLhwEr17Lu
    ZPLl+8AkxinfMUpbbDOYfHJ5pzhchmpExRtEI5AEiTgUZBgKxe9wepBE4tVBgELO
    lUAYUaGJ9kF1o50Uah8UvVn+vkwXhUS8mgq69YrE6jCaLkd2IvPIgORIiPsAMyx4
    lp8QX9+VrQaMT6TE828Dpm5uf028f/efZHzYEXVqVKSsPUr+KWqhGx1RN39e9XCR
    sm5XisRfyBsajabR2ZZF4CGaHyhnKpbMxmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524543446; bh=+1yBawqAVUNhu1WGA1ZH0PY31wO3A5
    QIUwKGM+bFafM=; b=I2Whuj/TM9sqUBxm71srQj80exKnKbccPbaCjJm4p1jiRS
    6RZ842HcBQLUxconvOWUxONfeNpYy1AWinKgUShEAA4nnUE0PqePZjT09aqMwlVF
    akup4Xjkv5ZQ+uCHLwjNLdIG0qsr9nknhdhNLkKUicEwrf33QAt3Ewhp1wlm70pu
    mNLQUl3Z3TiCTwGx9w28nxIf05Owe5yGytWmFkTN24kvZKTTNDZtzr0Suwt1txjk
    LsWyyLgrzWTZ6Eionac4wtp6EEe28lmyI40pjYRwOBryAySZ5EOPME3Yavn62JNV
    yeXHhdgEdDPhiPUQWvXN4vpJPlC7OHpaScblrBpA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=marvell.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=marvell.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=marvell.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=marvell.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP/pgOWAIP8YGje91S6X5bWHCiHq4nCLntjmA2U6IcGmobXARgGrtmFTj29AZXO4f2IuWD0O7gg/3wTGD8X8v/ESAeRzgIXg8DwlG22ehxhu/dSMbWiH
    NnGKmf1PBY9aGyStXVNFyoIXWqZAnzfLpTkT6a5zf1Y6w0h0TcJfJgaSAL7dmBJXX58nqBe91J3980SS5o4QHCZjmtk50e8mSaNgKOz7KLcVLGApyYQAnIKa
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=M5GUcnROAAAA:8
    a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=VSKOGMM2P7uXZZH1RPIA:9
    a=ujk63XYTe-C9VGMk:21 a=cKcnCt98enyLeU7o:21 a=OBjm3rFKGHvpk9ecZwUJ:22
    a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755749AbeDXEQ6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 00:16:58 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40754 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755643AbeDXEQr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Apr 2018 00:16:47 -0400
From: <xswang@marvell.com>
To: <linux-ide@vger.kernel.org>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: <oferh@marvell.com>, <dingwei@marvell.com>, <xigu@marvell.com>,
        <nadavh@marvell.com>, Evan Wang <xswang@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/2] ata: ahci: mvebu: override ahci_stop_engine for mvebu AHCI
Date: Tue, 24 Apr 2018 12:06:45 +0800
Message-ID: <1524542805-11349-3-git-send-email-xswang@marvell.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524542805-11349-1-git-send-email-xswang@marvell.com>
References: <1524542805-11349-1-git-send-email-xswang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_09:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=537
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=336 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240040
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Evan Wang <xswang@marvell.com>

There is an issue(Errata Ref#226) that the SATA can not be
detected via SATA Port-MultiPlayer(PMP) with following
error log:
  ata1.15: PMP product ID mismatch
  ata1.15: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
  ata1.15: Port Multiplier vendor mismatch '0x1b4b'!='0x0'
  ata1.15: PMP revalidation failed (errno=-19)

After debugging, the reason is found that the value Port-x
FIS-based Switching Control(PxFBS@0x40) become wrong.
According to design, the bits[11:8, 0] of register PxFBS
are cleared when Port Command and Status (0x18) bit[0]
changes its value from 1 to 0, i.e. falling edge of Port
Command and Status bit[0] sends PULSE that resets PxFBS
bits[11:8; 0].
So it needs a mvebu SATA WA to save the port PxFBS register
before PxCMD ST write and restore it afterwards.

This patch implements the WA in a separate function of
ahci_mvebu_stop_engine to override ahci_stop_gngine.

Signed-off-by: Evan Wang <xswang@marvell.com>
Suggested-by: Ofer Heifetz <oferh@marvell.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index de7128d..0045dac 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -62,6 +62,60 @@ static void ahci_mvebu_regret_option(struct ahci_host_priv *hpriv)
 	writel(0x80, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);
 }
 
+/**
+ * ahci_mvebu_stop_engine
+ *
+ * @ap:	Target ata port
+ *
+ * Errata Ref#226 - SATA Disk HOT swap issue when connected through
+ * Port Multiplier in FIS-based Switching mode.
+ *
+ * To avoid the issue, according to design, the bits[11:8, 0] of
+ * register PxFBS are cleared when Port Command and Status (0x18) bit[0]
+ * changes its value from 1 to 0, i.e. falling edge of Port
+ * Command and Status bit[0] sends PULSE that resets PxFBS
+ * bits[11:8; 0].
+ *
+ * This function is used to override function of "ahci_stop_engine"
+ * from libahci.c by adding the mvebu work around(WA) to save PxFBS
+ * value before the PxCMD ST write of 0, then restore PxFBS value.
+ *
+ * Return: 0 on success; Error code otherwise.
+ */
+int ahci_mvebu_stop_engine(struct ata_port *ap)
+{
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 tmp, port_fbs;
+
+	tmp = readl(port_mmio + PORT_CMD);
+
+	/* check if the HBA is idle */
+	if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) == 0)
+		return 0;
+
+	/* save the port PxFBS register for later restore */
+	port_fbs = readl(port_mmio + PORT_FBS);
+
+	/* setting HBA to idle */
+	tmp &= ~PORT_CMD_START;
+	writel(tmp, port_mmio + PORT_CMD);
+
+	/*
+	 * bit #15 PxCMD signal doesn't clear PxFBS,
+	 * restore the PxFBS register right after clearing the PxCMD ST,
+	 * no need to wait for the PxCMD bit #15.
+	 */
+	writel(port_fbs, port_mmio + PORT_FBS);
+
+	/* wait for engine to stop. This could be as long as 500 msec */
+	tmp = ata_wait_register(ap, port_mmio + PORT_CMD,
+				PORT_CMD_LIST_ON, PORT_CMD_LIST_ON, 1, 500);
+	if (tmp & PORT_CMD_LIST_ON)
+		return -EIO;
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int ahci_mvebu_suspend(struct platform_device *pdev, pm_message_t state)
 {
@@ -112,6 +166,8 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	hpriv->stop_engine = ahci_mvebu_stop_engine;
+
 	if (of_device_is_compatible(pdev->dev.of_node,
 				    "marvell,armada-380-ahci")) {
 		dram = mv_mbus_dram_info();
-- 
1.9.1
