Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653320-2-15159996656852673986
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653319; b=i25ZNRGXrLa8x+GxmGqGYyk6c7eTwv4lSV8xhCWn4cmYixjMlG
    YIIoYTMmiwtWtQcxZEhXsat17OKE3l08ms3jXGqmZNu/hAWBnUCIuGE6smwwCVE4
    cSCRvJARALjGTvsYo5bnuEn2OyhQ1CdMfAwQSQ7lcFQZ/F7rlrY77cBqfXlCmCpj
    z6eol/mWAaepGxwPODcTIYhP50Ixs7O3NO+1wxPb0GbXrocAElmj4QLLvsSVPDDq
    ToAlTl5KzYo6amsIG2f5bRDndTkIZHgq44f51N5Yw7yBuLsldHykjcpoBn4lw5gX
    /r2SW5ZegYOszK72ZwueX26qD4msbJ9qxBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524653319; bh=
    ePTbV6NnciKaop4a1ok/J9h7hnB8D7/vUhUpuTwHLPI=; b=rRhKy9/+q8Ky1GJV
    ymYxqRhtUybHXer5qRn7rN4GA9NEX2szQWAmpe/269eBAF5/KQAaEJX5xhol1e+4
    q2BO9A6Soma0zWdEJHX1jr+LnUc2AviV5DyB1jdtrzoA/DFKO5jb+x48WRqncnUR
    ABef0W04bLoigINVR6m/4UwrAXvE5TbfROnI1Tf63MlmRF4jR45wt/V/v3Dwfeuy
    JZRW+8+94krQBS82BvRkbZs2I0Okve6z3AEkkwsmxyB/d5suCWxgS63FV2CcG8DG
    mVne7BS0OTex45+snmPDzJVNHSiRK2bqY/k8c5l/irU91qvM0HBf7DdoLdY041Vt
    IeBGEQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAfXEL6cmNu0EV51wqCZhF8SXm1Ak7MJvo/t0br8l3QTH+ciioq7KTVrJBtzPxh29JKoZph6dL+pg9FMSrh30sk4s5VBYwl44nSQDAjJGeiaqUEACfBg
    t5kvi0QU+qak+GZn2led4y4GWIJfTmvPWI9NW4QCeXuJ4NKVzTI5OmW8HduZGVk0f6qEg1kyc/W+wjVwTHWxDmHbHw7jGSEijnJZdy6pamDAsdjGY3rktJ8S
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=90GG8wBJcqmzEgQOjvcA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeDYKsh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:48:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:18136 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754416AbeDYKoq (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 25 Apr 2018 06:44:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="223203167"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] tpm: cmd_ready command can be issued only after granting locality
Date: Wed, 25 Apr 2018 13:44:21 +0300
Message-Id: <20180425104425.5803-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
References: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tomas Winkler <tomas.winkler@intel.com>

commit 888d867df4417deffc33927e6fc2c6925736fe92 upstream

The correct sequence is to first request locality and only after
that perform cmd_ready handshake, otherwise the hardware will drop
the subsequent message as from the device point of view the cmd_ready
handshake wasn't performed. Symmetrically locality has to be relinquished
only after going idle handshake has completed, this requires that
go_idle has to poll for the completion and as well locality
relinquish has to poll for completion so it is not overridden
in back to back commands flow.

Two wrapper functions are added (request_locality relinquish_locality)
to simplify the error handling.

The issue is only visible on devices that support multiple localities.

Fixes: 877c57d0d0ca ("tpm_crb: request and relinquish locality 0")
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c |  54 ++++++++++++----
 drivers/char/tpm/tpm_crb.c       | 108 +++++++++++++++++++++----------
 drivers/char/tpm/tpm_tis_core.c  |   4 +-
 include/linux/tpm.h              |   2 +-
 4 files changed, 120 insertions(+), 48 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 248c04090dea..0091eccdaf8d 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -369,6 +369,36 @@ static int tpm_validate_command(struct tpm_chip *chip,
 	return -EINVAL;
 }
 
+static int tpm_request_locality(struct tpm_chip *chip)
+{
+	int rc;
+
+	if (!chip->ops->request_locality)
+		return 0;
+
+	rc = chip->ops->request_locality(chip, 0);
+	if (rc < 0)
+		return rc;
+
+	chip->locality = rc;
+
+	return 0;
+}
+
+static void tpm_relinquish_locality(struct tpm_chip *chip)
+{
+	int rc;
+
+	if (!chip->ops->relinquish_locality)
+		return;
+
+	rc = chip->ops->relinquish_locality(chip, chip->locality);
+	if (rc)
+		dev_err(&chip->dev, "%s: : error %d\n", __func__, rc);
+
+	chip->locality = -1;
+}
+
 /**
  * tmp_transmit - Internal kernel interface to transmit TPM commands.
  *
@@ -422,8 +452,6 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	if (!(flags & TPM_TRANSMIT_UNLOCKED))
 		mutex_lock(&chip->tpm_mutex);
 
-	if (chip->dev.parent)
-		pm_runtime_get_sync(chip->dev.parent);
 
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, true);
@@ -431,14 +459,15 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	/* Store the decision as chip->locality will be changed. */
 	need_locality = chip->locality == -1;
 
-	if (!(flags & TPM_TRANSMIT_RAW) &&
-	    need_locality && chip->ops->request_locality)  {
-		rc = chip->ops->request_locality(chip, 0);
+	if (!(flags & TPM_TRANSMIT_RAW) && need_locality) {
+		rc = tpm_request_locality(chip);
 		if (rc < 0)
 			goto out_no_locality;
-		chip->locality = rc;
 	}
 
+	if (chip->dev.parent)
+		pm_runtime_get_sync(chip->dev.parent);
+
 	rc = tpm2_prepare_space(chip, space, ordinal, buf);
 	if (rc)
 		goto out;
@@ -499,17 +528,16 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
 
 out:
-	if (need_locality && chip->ops->relinquish_locality) {
-		chip->ops->relinquish_locality(chip, chip->locality);
-		chip->locality = -1;
-	}
+	if (chip->dev.parent)
+		pm_runtime_put_sync(chip->dev.parent);
+
+	if (need_locality)
+		tpm_relinquish_locality(chip);
+
 out_no_locality:
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, false);
 
-	if (chip->dev.parent)
-		pm_runtime_put_sync(chip->dev.parent);
-
 	if (!(flags & TPM_TRANSMIT_UNLOCKED))
 		mutex_unlock(&chip->tpm_mutex);
 	return rc ? rc : len;
diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 7b3c2a8aa9de..497edd9848cd 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -112,6 +112,25 @@ struct tpm2_crb_smc {
 	u32 smc_func_id;
 };
 
+static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
+				unsigned long timeout)
+{
+	ktime_t start;
+	ktime_t stop;
+
+	start = ktime_get();
+	stop = ktime_add(start, ms_to_ktime(timeout));
+
+	do {
+		if ((ioread32(reg) & mask) == value)
+			return true;
+
+		usleep_range(50, 100);
+	} while (ktime_before(ktime_get(), stop));
+
+	return ((ioread32(reg) & mask) == value);
+}
+
 /**
  * crb_go_idle - request tpm crb device to go the idle state
  *
@@ -128,7 +147,7 @@ struct tpm2_crb_smc {
  *
  * Return: 0 always
  */
-static int __maybe_unused crb_go_idle(struct device *dev, struct crb_priv *priv)
+static int crb_go_idle(struct device *dev, struct crb_priv *priv)
 {
 	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
 	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
@@ -136,30 +155,17 @@ static int __maybe_unused crb_go_idle(struct device *dev, struct crb_priv *priv)
 		return 0;
 
 	iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t->ctrl_req);
-	/* we don't really care when this settles */
 
+	if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_req,
+				 CRB_CTRL_REQ_GO_IDLE/* mask */,
+				 0, /* value */
+				 TPM2_TIMEOUT_C)) {
+		dev_warn(dev, "goIdle timed out\n");
+		return -ETIME;
+	}
 	return 0;
 }
 
-static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
-				unsigned long timeout)
-{
-	ktime_t start;
-	ktime_t stop;
-
-	start = ktime_get();
-	stop = ktime_add(start, ms_to_ktime(timeout));
-
-	do {
-		if ((ioread32(reg) & mask) == value)
-			return true;
-
-		usleep_range(50, 100);
-	} while (ktime_before(ktime_get(), stop));
-
-	return false;
-}
-
 /**
  * crb_cmd_ready - request tpm crb device to enter ready state
  *
@@ -175,8 +181,7 @@ static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
  *
  * Return: 0 on success -ETIME on timeout;
  */
-static int __maybe_unused crb_cmd_ready(struct device *dev,
-					struct crb_priv *priv)
+static int crb_cmd_ready(struct device *dev, struct crb_priv *priv)
 {
 	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
 	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
@@ -195,11 +200,11 @@ static int __maybe_unused crb_cmd_ready(struct device *dev,
 	return 0;
 }
 
-static int crb_request_locality(struct tpm_chip *chip, int loc)
+static int __crb_request_locality(struct device *dev,
+				  struct crb_priv *priv, int loc)
 {
-	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
 	u32 value = CRB_LOC_STATE_LOC_ASSIGNED |
-		CRB_LOC_STATE_TPM_REG_VALID_STS;
+		    CRB_LOC_STATE_TPM_REG_VALID_STS;
 
 	if (!priv->regs_h)
 		return 0;
@@ -207,21 +212,45 @@ static int crb_request_locality(struct tpm_chip *chip, int loc)
 	iowrite32(CRB_LOC_CTRL_REQUEST_ACCESS, &priv->regs_h->loc_ctrl);
 	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, value, value,
 				 TPM2_TIMEOUT_C)) {
-		dev_warn(&chip->dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
+		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
 		return -ETIME;
 	}
 
 	return 0;
 }
 
-static void crb_relinquish_locality(struct tpm_chip *chip, int loc)
+static int crb_request_locality(struct tpm_chip *chip, int loc)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
 
+	return __crb_request_locality(&chip->dev, priv, loc);
+}
+
+static int __crb_relinquish_locality(struct device *dev,
+				     struct crb_priv *priv, int loc)
+{
+	u32 mask = CRB_LOC_STATE_LOC_ASSIGNED |
+		   CRB_LOC_STATE_TPM_REG_VALID_STS;
+	u32 value = CRB_LOC_STATE_TPM_REG_VALID_STS;
+
 	if (!priv->regs_h)
-		return;
+		return 0;
 
 	iowrite32(CRB_LOC_CTRL_RELINQUISH, &priv->regs_h->loc_ctrl);
+	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask, value,
+				 TPM2_TIMEOUT_C)) {
+		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
+		return -ETIME;
+	}
+
+	return 0;
+}
+
+static int crb_relinquish_locality(struct tpm_chip *chip, int loc)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+
+	return __crb_relinquish_locality(&chip->dev, priv, loc);
 }
 
 static u8 crb_status(struct tpm_chip *chip)
@@ -475,6 +504,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 			dev_warn(dev, FW_BUG "Bad ACPI memory layout");
 	}
 
+	ret = __crb_request_locality(dev, priv, 0);
+	if (ret)
+		return ret;
+
 	priv->regs_t = crb_map_res(dev, priv, &io_res, buf->control_address,
 				   sizeof(struct crb_regs_tail));
 	if (IS_ERR(priv->regs_t))
@@ -531,6 +564,8 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	crb_go_idle(dev, priv);
 
+	__crb_relinquish_locality(dev, priv, 0);
+
 	return ret;
 }
 
@@ -588,10 +623,14 @@ static int crb_acpi_add(struct acpi_device *device)
 	chip->acpi_dev_handle = device->handle;
 	chip->flags = TPM_CHIP_FLAG_TPM2;
 
-	rc  = crb_cmd_ready(dev, priv);
+	rc = __crb_request_locality(dev, priv, 0);
 	if (rc)
 		return rc;
 
+	rc  = crb_cmd_ready(dev, priv);
+	if (rc)
+		goto out;
+
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -601,12 +640,15 @@ static int crb_acpi_add(struct acpi_device *device)
 		crb_go_idle(dev, priv);
 		pm_runtime_put_noidle(dev);
 		pm_runtime_disable(dev);
-		return rc;
+		goto out;
 	}
 
-	pm_runtime_put(dev);
+	pm_runtime_put_sync(dev);
 
-	return 0;
+out:
+	__crb_relinquish_locality(dev, priv, 0);
+
+	return rc;
 }
 
 static int crb_acpi_remove(struct acpi_device *device)
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index da074e3db19b..5a1f47b43947 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -143,11 +143,13 @@ static bool check_locality(struct tpm_chip *chip, int l)
 	return false;
 }
 
-static void release_locality(struct tpm_chip *chip, int l)
+static int release_locality(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
+
+	return 0;
 }
 
 static int request_locality(struct tpm_chip *chip, int l)
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index bcdd3790e94d..06639fb6ab85 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -44,7 +44,7 @@ struct tpm_class_ops {
 	bool (*update_timeouts)(struct tpm_chip *chip,
 				unsigned long *timeout_cap);
 	int (*request_locality)(struct tpm_chip *chip, int loc);
-	void (*relinquish_locality)(struct tpm_chip *chip, int loc);
+	int (*relinquish_locality)(struct tpm_chip *chip, int loc);
 	void (*clk_enable)(struct tpm_chip *chip, bool value);
 };
 
-- 
2.17.0
