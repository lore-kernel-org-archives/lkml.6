Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4146373-1524630709-5-9454465441902713145
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524630709; b=LEa2Zjt4uUOr3bQIUhgfp57uWP/eoIKvhP7GUaMuEmC9zQUfka
    w/55jCnuqHn6dPsk6OT8xLRl16h0wXmuHUZlLRDOlGUomd7MCY9TiZHZ9uktOS25
    uhci+7R/FDeWLk60JULs5HFInDgAgbW46mC7GGM9B9e/3u6um9hwpHpCPKJAvOEQ
    bmbAVRyjp6RnJg59cdjjiMU7E8y+r79clvEN4HuA2G6koXfKfyzQouLMWxBQeI2v
    mHzf6aaClGyenKic7YWq4JtYnW8njZpDmxaVGnP5GCjhPgQx6Ai67dw209A8jLDY
    Wrr5XSPXIX/Sx0zFrFgVFi777+/fzzW0AJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524630709; bh=WaTFC7Nm4feCEFOMPNzUcgCLZd2eoE
    tLUqFMDXzifjE=; b=Kv8+rKdKFvu70L2FfSlW5Df2+s6Yc7FJUo5/8FlPqAMRNn
    GACq4H96MdUTrgnu/JgTqXfrKIJRLSUX3LKtX2DjYdT/ktRwErZqyYzk2ItsUcyh
    JZcVWPu2sxy3PgmC0694Avb4e8X6d76+LkeoWT+4TH4PutnchfIJy8LXgerhcOGP
    xuygu361T8HElon5L5QQzKEauCEmzW+dNbAM2Org7CiL/aRveXwBMbH0HZR+Vmwr
    eimAC5k3i2aOL7yfkD6GcnebB2u7FUEj7rDGzKCQOxfl3gq/AEnwRgMtdVrhCptw
    zF1ih3eU6JigwdNI5PkStxeSEa47xbvYdXLC+x8Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=marvell.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=marvell.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfIkxnNRzlonaD1ds3XoBo/I2KKCE6jAZXoaIGWlNFz32+3DYLJQQfmobBGz7dYHm/x4ACl82iN4ZtTljfBpdWw/4x+wUilIjfKOhQaWxI+8YlwNlMwX6
    5thBTwB1Rfrcv6c22oaseZD5xlI3K88u35pVxRDhbeT63DJIyzomEXHRYpSgC6JJQxx5LAbl6jbJSwoNlzoMVIsMdjhlTxzWOvSDuG1tpzh3q6lAS1rGOzKV
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=M5GUcnROAAAA:8
    a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=w5eeTf67AG8EOKVvsb4A:9
    a=B1Pa7BAV8wiwwP7V:21 a=ajsAvqKQzgt1s9i-:21 a=OBjm3rFKGHvpk9ecZwUJ:22
    a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeDYEbn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 00:31:43 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35794 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751251AbeDYEbc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 00:31:32 -0400
From: <xswang@marvell.com>
To: <linux-ide@vger.kernel.org>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <oferh@marvell.com>, <dingwei@marvell.com>, <xigu@marvell.com>,
        <nadavh@marvell.com>, Evan Wang <xswang@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/2] libahci: Allow drivers to override stop_engine
Date: Wed, 25 Apr 2018 12:27:13 +0800
Message-ID: <1524630434-5914-2-git-send-email-xswang@marvell.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524630434-5914-1-git-send-email-xswang@marvell.com>
References: <1524630434-5914-1-git-send-email-xswang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_01:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804250038
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Evan Wang <xswang@marvell.com>

Marvell armada37xx, armada7k and armada8k share the same
AHCI sata controller IP, and currently there is an issue
(Errata Ref#226)that the SATA can not be detected via SATA
Port-MultiPlayer(PMP). After debugging, the reason is
found that the value of Port-x FIS-based Switching Control
(PxFBS@0x40) became wrong.
According to design, the bits[11:8, 0] of register PxFBS
are cleared when Port Command and Status (0x18) bit[0]
changes its value from 1 to 0, i.e. falling edge of Port
Command and Status bit[0] sends PULSE that resets PxFBS
bits[11:8; 0].
So it needs save the port PxFBS register before PxCMD
ST write and restore the port PxFBS register afterwards
in ahci_stop_engine().

This commit allows drivers to override ahci_stop_engine
behavior for use by the Marvell AHCI driver(and potentially
other drivers in the future).

Signed-off-by: Evan Wang <xswang@marvell.com>
Suggested-by: Ofer Heifetz <oferh@marvell.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: stable@vger.kernel.org
---
 drivers/ata/ahci.c          |  6 +++---
 drivers/ata/ahci.h          |  7 +++++++
 drivers/ata/ahci_qoriq.c    |  2 +-
 drivers/ata/ahci_xgene.c    |  4 ++--
 drivers/ata/libahci.c       | 20 ++++++++++++--------
 drivers/ata/sata_highbank.c |  2 +-
 6 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1ff1779..6389c88 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -698,7 +698,7 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
 				 deadline, &online, NULL);
@@ -724,7 +724,7 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 	bool online;
 	int rc;
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
@@ -788,7 +788,7 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	for (i = 0; i < 2; i++) {
 		u16 val;
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 4356ef1..7d88ede 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -366,6 +366,13 @@ struct ahci_host_priv {
 	 * be overridden anytime before the host is activated.
 	 */
 	void			(*start_engine)(struct ata_port *ap);
+	/*
+	 * Optional ahci_stop_engine override, if not set this gets set to the
+	 * default ahci_stop_engine during ahci_save_initial_config, this can
+	 * be overridden anytime before the host is activated.
+	 */
+	int			(*stop_engine)(struct ata_port *ap);
+
 	irqreturn_t 		(*irq_handler)(int irq, void *dev_instance);
 
 	/* only required for per-port MSI(-X) support */
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 2685f28..cfdef4d 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -96,7 +96,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	/*
 	 * There is a errata on ls1021a Rev1.0 and Rev2.0 which is:
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index c2b5941..ad58da7 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -165,7 +165,7 @@ static int xgene_ahci_restart_engine(struct ata_port *ap)
 				    PORT_CMD_ISSUE, 0x0, 1, 100))
 		  return -EBUSY;
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 	ahci_start_fis_rx(ap);
 
 	/*
@@ -421,7 +421,7 @@ static int xgene_ahci_hardreset(struct ata_link *link, unsigned int *class,
 	portrxfis_saved = readl(port_mmio + PORT_FIS_ADDR);
 	portrxfishi_saved = readl(port_mmio + PORT_FIS_ADDR_HI);
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	rc = xgene_ahci_do_hardreset(link, deadline, &online);
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 7adcf3c..e5d9097 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -560,6 +560,9 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 	if (!hpriv->start_engine)
 		hpriv->start_engine = ahci_start_engine;
 
+	if (!hpriv->stop_engine)
+		hpriv->stop_engine = ahci_stop_engine;
+
 	if (!hpriv->irq_handler)
 		hpriv->irq_handler = ahci_single_level_irq_intr;
 }
@@ -897,9 +900,10 @@ static void ahci_start_port(struct ata_port *ap)
 static int ahci_deinit_port(struct ata_port *ap, const char **emsg)
 {
 	int rc;
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 
 	/* disable DMA */
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc) {
 		*emsg = "failed to stop engine";
 		return rc;
@@ -1310,7 +1314,7 @@ int ahci_kick_engine(struct ata_port *ap)
 	int busy, rc;
 
 	/* stop engine */
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc)
 		goto out_restart;
 
@@ -1549,7 +1553,7 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
@@ -2075,14 +2079,14 @@ void ahci_error_handler(struct ata_port *ap)
 
 	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
-		ahci_stop_engine(ap);
+		hpriv->stop_engine(ap);
 		hpriv->start_engine(ap);
 	}
 
 	sata_pmp_error_handler(ap);
 
 	if (!ata_dev_enabled(ap->link.device))
-		ahci_stop_engine(ap);
+		hpriv->stop_engine(ap);
 }
 EXPORT_SYMBOL_GPL(ahci_error_handler);
 
@@ -2129,7 +2133,7 @@ static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
 		return;
 
 	/* set DITO, MDAT, DETO and enable DevSlp, need to stop engine first */
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc)
 		return;
 
@@ -2189,7 +2193,7 @@ static void ahci_enable_fbs(struct ata_port *ap)
 		return;
 	}
 
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc)
 		return;
 
@@ -2222,7 +2226,7 @@ static void ahci_disable_fbs(struct ata_port *ap)
 		return;
 	}
 
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc)
 		return;
 
diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index aafb8cc..e67815b 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -410,7 +410,7 @@ static int ahci_highbank_hardreset(struct ata_link *link, unsigned int *class,
 	int rc;
 	int retry = 100;
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
-- 
1.9.1
