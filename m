Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3463848-1520955352-2-17112049707521182984
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520955351; b=d7SqP2ZGm68+/FjV/+uz4bOmPn5/HJ9JMzSaLlYyailnGUy
    6j5oOKe7azfSC0QKPQzeL+TYw0wAsyRlytL8cDcDZ/jriIXJeycHqsHw1FeT1PQB
    3kmMNHH5T+L9xs9EENudbFDRWx5E8lvMj/9QSvuPyHWdYnqisr1izRkyVCxlAV7H
    MVbWv7O40ZbaLh/h9yRXOwjX4AvPQx7oz9WMT1o2F7ZRWEsaKtuPmheEV8KbiMUT
    LE+mYmd/jMZTIZJWebVQJWdwPIXVfJq0MylEcrW9Nnh7Yw1nDaQHunYt1Q1Jais1
    0yabYsZh1UKngSh7eKO6i869iORDDYkzkRaqp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955351; bh=wXRSgCnSwYujMpAR0s3SXQrOhD
    hoDd65U05Fe6/U6xU=; b=UAcsZczriz0MbnBL8IDo4x2StSgOeMyCqOLZZmfF8o
    CqBjgJhWxTbohNKe9PZ3nIeHYAwVE8p2M36br9ONljZZK/8LwTz0tcxrbSRjwlsk
    EphCy2vVYR2ZO944k3IxwMQWTHIZNK1PjO9tm0W0CQu6jlwxkl6xbwWWLG8r/0QT
    5wbK/D91kObdKm213fAqcz4Dgc+sz+TOzizEqyW6HH1D8Iymbe5fl+Kn47QVksxG
    cD1Bp9WLBO9LiakiOZOAjhTSo4KmotTqT2FseDHfZxuvr+eZ0wgZyT0YQORf0X9k
    ZSvmhV+8RdlNioOlUWjIy2iEXfrSB1Zykoy+rK9EBTWw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934079AbeCMPfs (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:35:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33278 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933991AbeCMPfr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:35:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Azhar Shaikh <azhar.shaikh@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.14 019/140] tpm_tis: Move ilb_base_addr to tpm_tis_data
Date: Tue, 13 Mar 2018 16:23:42 +0100
Message-Id: <20180313152459.380936035@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Azhar Shaikh <azhar.shaikh@intel.com>

commit c382babccba2c82fe57f9e647f290fb7bf4d130d upstream.

Move static variable ilb_base_addr to tpm_tis_data.

Cc: stable@vger.kernel.org
Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
Reviewed-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_tis.c      |   75 ++++++++++++++--------------------------
 drivers/char/tpm/tpm_tis_core.c |   16 ++++++++
 drivers/char/tpm/tpm_tis_core.h |   13 ++++++
 3 files changed, 56 insertions(+), 48 deletions(-)

--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -133,33 +133,24 @@ static int check_acpi_tpm2(struct device
 #endif
 
 #ifdef CONFIG_X86
-#define INTEL_LEGACY_BLK_BASE_ADDR      0xFED08000
-#define ILB_REMAP_SIZE			0x100
-#define LPC_CNTRL_REG_OFFSET            0x84
-#define LPC_CLKRUN_EN                   (1 << 2)
-
-static void __iomem *ilb_base_addr;
-
-static inline bool is_bsw(void)
-{
-	return ((boot_cpu_data.x86_model == INTEL_FAM6_ATOM_AIRMONT) ? 1 : 0);
-}
+#define LPC_CNTRL_OFFSET		0x84
+#define LPC_CLKRUN_EN			(1 << 2)
 
 /**
  * tpm_platform_begin_xfer() - clear LPC CLKRUN_EN i.e. clocks will be running
  */
-static void tpm_platform_begin_xfer(void)
+static void tpm_platform_begin_xfer(struct tpm_tis_data *data)
 {
 	u32 clkrun_val;
 
 	if (!is_bsw())
 		return;
 
-	clkrun_val = ioread32(ilb_base_addr + LPC_CNTRL_REG_OFFSET);
+	clkrun_val = ioread32(data->ilb_base_addr + LPC_CNTRL_OFFSET);
 
 	/* Disable LPC CLKRUN# */
 	clkrun_val &= ~LPC_CLKRUN_EN;
-	iowrite32(clkrun_val, ilb_base_addr + LPC_CNTRL_REG_OFFSET);
+	iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
 
 	/*
 	 * Write any random value on port 0x80 which is on LPC, to make
@@ -172,18 +163,18 @@ static void tpm_platform_begin_xfer(void
 /**
  * tpm_platform_end_xfer() - set LPC CLKRUN_EN i.e. clocks can be turned off
  */
-static void tpm_platform_end_xfer(void)
+static void tpm_platform_end_xfer(struct tpm_tis_data *data)
 {
 	u32 clkrun_val;
 
 	if (!is_bsw())
 		return;
 
-	clkrun_val = ioread32(ilb_base_addr + LPC_CNTRL_REG_OFFSET);
+	clkrun_val = ioread32(data->ilb_base_addr + LPC_CNTRL_OFFSET);
 
 	/* Enable LPC CLKRUN# */
 	clkrun_val |= LPC_CLKRUN_EN;
-	iowrite32(clkrun_val, ilb_base_addr + LPC_CNTRL_REG_OFFSET);
+	iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
 
 	/*
 	 * Write any random value on port 0x80 which is on LPC, to make
@@ -193,16 +184,11 @@ static void tpm_platform_end_xfer(void)
 
 }
 #else
-static inline bool is_bsw(void)
-{
-	return false;
-}
-
-static void tpm_platform_begin_xfer(void)
+static void tpm_platform_begin_xfer(struct tpm_tis_data *data)
 {
 }
 
-static void tpm_platform_end_xfer(void)
+static void tpm_platform_end_xfer(struct tpm_tis_data *data)
 {
 }
 #endif
@@ -212,12 +198,12 @@ static int tpm_tcg_read_bytes(struct tpm
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	while (len--)
 		*result++ = ioread8(phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
@@ -227,12 +213,12 @@ static int tpm_tcg_write_bytes(struct tp
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	while (len--)
 		iowrite8(*value++, phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
@@ -241,11 +227,11 @@ static int tpm_tcg_read16(struct tpm_tis
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	*result = ioread16(phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
@@ -254,11 +240,11 @@ static int tpm_tcg_read32(struct tpm_tis
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	*result = ioread32(phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
@@ -267,11 +253,11 @@ static int tpm_tcg_write32(struct tpm_ti
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	iowrite32(value, phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
@@ -350,9 +336,13 @@ MODULE_DEVICE_TABLE(pnp, tpm_pnp_tbl);
 static void tpm_tis_pnp_remove(struct pnp_dev *dev)
 {
 	struct tpm_chip *chip = pnp_get_drvdata(dev);
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
+	if (is_bsw())
+		iounmap(priv->ilb_base_addr);
+
 }
 
 static struct pnp_driver tis_pnp_driver = {
@@ -399,10 +389,14 @@ static int tpm_tis_plat_probe(struct pla
 static int tpm_tis_plat_remove(struct platform_device *pdev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
 
+	if (is_bsw())
+		iounmap(priv->ilb_base_addr);
+
 	return 0;
 }
 
@@ -460,11 +454,6 @@ static int __init init_tis(void)
 	if (rc)
 		goto err_force;
 
-#ifdef CONFIG_X86
-	if (is_bsw())
-		ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
-					ILB_REMAP_SIZE);
-#endif
 	rc = platform_driver_register(&tis_drv);
 	if (rc)
 		goto err_platform;
@@ -483,10 +472,6 @@ err_pnp:
 err_platform:
 	if (force_pdev)
 		platform_device_unregister(force_pdev);
-#ifdef CONFIG_X86
-	if (is_bsw())
-		iounmap(ilb_base_addr);
-#endif
 err_force:
 	return rc;
 }
@@ -496,10 +481,6 @@ static void __exit cleanup_tis(void)
 	pnp_unregister_driver(&tis_pnp_driver);
 	platform_driver_unregister(&tis_drv);
 
-#ifdef CONFIG_X86
-	if (is_bsw())
-		iounmap(ilb_base_addr);
-#endif
 	if (force_pdev)
 		platform_device_unregister(force_pdev);
 }
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -701,6 +701,13 @@ int tpm_tis_core_init(struct device *dev
 	priv->phy_ops = phy_ops;
 	dev_set_drvdata(&chip->dev, priv);
 
+	if (is_bsw()) {
+		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
+					ILB_REMAP_SIZE);
+		if (!priv->ilb_base_addr)
+			return -ENOMEM;
+	}
+
 	if (wait_startup(chip, 0) != 0) {
 		rc = -ENODEV;
 		goto out_err;
@@ -791,9 +798,16 @@ int tpm_tis_core_init(struct device *dev
 		}
 	}
 
-	return tpm_chip_register(chip);
+	rc = tpm_chip_register(chip);
+	if (rc && is_bsw())
+		iounmap(priv->ilb_base_addr);
+
+	return rc;
 out_err:
 	tpm_tis_remove(chip);
+	if (is_bsw())
+		iounmap(priv->ilb_base_addr);
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm_tis_core_init);
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -79,6 +79,9 @@ enum tis_defaults {
 #define	TPM_DID_VID(l)			(0x0F00 | ((l) << 12))
 #define	TPM_RID(l)			(0x0F04 | ((l) << 12))
 
+#define INTEL_LEGACY_BLK_BASE_ADDR	0xFED08000
+#define ILB_REMAP_SIZE			0x100
+
 enum tpm_tis_flags {
 	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
 };
@@ -89,6 +92,7 @@ struct tpm_tis_data {
 	int irq;
 	bool irq_tested;
 	unsigned int flags;
+	void __iomem *ilb_base_addr;
 	wait_queue_head_t int_queue;
 	wait_queue_head_t read_queue;
 	const struct tpm_tis_phy_ops *phy_ops;
@@ -144,6 +148,15 @@ static inline int tpm_tis_write32(struct
 	return data->phy_ops->write32(data, addr, value);
 }
 
+static inline bool is_bsw(void)
+{
+#ifdef CONFIG_X86
+	return ((boot_cpu_data.x86_model == INTEL_FAM6_ATOM_AIRMONT) ? 1 : 0);
+#else
+	return false;
+#endif
+}
+
 void tpm_tis_remove(struct tpm_chip *chip);
 int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		      const struct tpm_tis_phy_ops *phy_ops,
