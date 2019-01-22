Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BCDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7082183F
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548188819;
	bh=22aFYyTqaaRjmBbmAiqFyaMbuIoSlYsqZVc2vBO8Xz8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=taISQBZBhk1mK9EBzbGQEB3rlBqEw9rz6m+J4PwZOqyC1+qz5lPSlOS/Eat9qcv9q
	 Vi0BQc2ByGy/Ub2AioeiUnhZwJFiWiiBqtyVljtchieRTtkhk6AbrpxANg85U9EbF0
	 AmZmGm0f3orxwUAkqRNyNtxk0o2bU6Yx7cHcDbbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfAVU05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:26:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52796 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfAVU05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=XSjcoK5K62+F10Fb335kL4xkO0ieLjcoyq0CJOImNYE=; b=uif1Cfi3syul
        mr9x1KLeU1PCvOrQqDP1x+UgypB40MrlryCUn6KeKCFCxqFe3ZKH7penT69dJYuNxD1bcRPu/kaAm
        2SERM0LAo8CGZPNC1vGHL2hHSDuB4IOhLb233ovqewO2IGQHmwfw8NuxA0PNlPqlH+Ki/Dbl262Qs
        tZo4k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gm2dK-0007Cx-4o; Tue, 22 Jan 2019 20:26:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C4AC31127955; Tue, 22 Jan 2019 20:26:53 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: qcom-smd: Batch up requests for disabled regulators" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190122202653.C4AC31127955@debutante.sirena.org.uk>
Date:   Tue, 22 Jan 2019 20:26:53 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: qcom-smd: Batch up requests for disabled regulators

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From fd805d99352c89b5cc1ca62ca5644840c9f02f07 Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Tue, 22 Jan 2019 11:01:47 -0800
Subject: [PATCH] regulator: qcom-smd: Batch up requests for disabled
 regulators

In some scenarios the early stages of the boot chain has configured
regulators to be in a required state, but the later stages has skipped
to inform the RPM about it's requirements.

But as the SMD RPM regulators are being initialized voltage change
requests will be issued to align the voltage with the valid ranges. The
RPM aggregates all parameters for the specific regulator, the voltage
will be adjusted and the "enabled" state will be "off" - and the
regulator is turned off.

This patch addresses this problem by caching the requested enable state,
voltage and load and send the parameters in a batch, depending on the
enable state - effectively delaying the voltage request for disabled
regulators.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/qcom_smd-regulator.c | 104 ++++++++++++++++---------
 1 file changed, 69 insertions(+), 35 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index f5bca77d67c1..68bc23df4213 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -31,6 +31,11 @@ struct qcom_rpm_reg {
 
 	int is_enabled;
 	int uV;
+	u32 load;
+
+	unsigned int enabled_updated:1;
+	unsigned int uv_updated:1;
+	unsigned int load_updated:1;
 };
 
 struct rpm_regulator_req {
@@ -43,30 +48,59 @@ struct rpm_regulator_req {
 #define RPM_KEY_UV	0x00007675 /* "uv" */
 #define RPM_KEY_MA	0x0000616d /* "ma" */
 
-static int rpm_reg_write_active(struct qcom_rpm_reg *vreg,
-				struct rpm_regulator_req *req,
-				size_t size)
+static int rpm_reg_write_active(struct qcom_rpm_reg *vreg)
 {
-	return qcom_rpm_smd_write(vreg->rpm,
-				  QCOM_SMD_RPM_ACTIVE_STATE,
-				  vreg->type,
-				  vreg->id,
-				  req, size);
+	struct rpm_regulator_req req[3];
+	int reqlen = 0;
+	int ret;
+
+	if (vreg->enabled_updated) {
+		req[reqlen].key = cpu_to_le32(RPM_KEY_SWEN);
+		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
+		req[reqlen].value = cpu_to_le32(vreg->is_enabled);
+		reqlen++;
+	}
+
+	if (vreg->uv_updated && vreg->is_enabled) {
+		req[reqlen].key = cpu_to_le32(RPM_KEY_UV);
+		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
+		req[reqlen].value = cpu_to_le32(vreg->uV);
+		reqlen++;
+	}
+
+	if (vreg->load_updated && vreg->is_enabled) {
+		req[reqlen].key = cpu_to_le32(RPM_KEY_MA);
+		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
+		req[reqlen].value = cpu_to_le32(vreg->load / 1000);
+		reqlen++;
+	}
+
+	if (!reqlen)
+		return 0;
+
+	ret = qcom_rpm_smd_write(vreg->rpm, QCOM_SMD_RPM_ACTIVE_STATE,
+				 vreg->type, vreg->id,
+				 req, sizeof(req[0]) * reqlen);
+	if (!ret) {
+		vreg->enabled_updated = 0;
+		vreg->uv_updated = 0;
+		vreg->load_updated = 0;
+	}
+
+	return ret;
 }
 
 static int rpm_reg_enable(struct regulator_dev *rdev)
 {
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
-	struct rpm_regulator_req req;
 	int ret;
 
-	req.key = cpu_to_le32(RPM_KEY_SWEN);
-	req.nbytes = cpu_to_le32(sizeof(u32));
-	req.value = cpu_to_le32(1);
+	vreg->is_enabled = 1;
+	vreg->enabled_updated = 1;
 
-	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
-	if (!ret)
-		vreg->is_enabled = 1;
+	ret = rpm_reg_write_active(vreg);
+	if (ret)
+		vreg->is_enabled = 0;
 
 	return ret;
 }
@@ -81,16 +115,14 @@ static int rpm_reg_is_enabled(struct regulator_dev *rdev)
 static int rpm_reg_disable(struct regulator_dev *rdev)
 {
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
-	struct rpm_regulator_req req;
 	int ret;
 
-	req.key = cpu_to_le32(RPM_KEY_SWEN);
-	req.nbytes = cpu_to_le32(sizeof(u32));
-	req.value = 0;
+	vreg->is_enabled = 0;
+	vreg->enabled_updated = 1;
 
-	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
-	if (!ret)
-		vreg->is_enabled = 0;
+	ret = rpm_reg_write_active(vreg);
+	if (ret)
+		vreg->is_enabled = 1;
 
 	return ret;
 }
@@ -108,16 +140,15 @@ static int rpm_reg_set_voltage(struct regulator_dev *rdev,
 			       unsigned *selector)
 {
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
-	struct rpm_regulator_req req;
-	int ret = 0;
+	int ret;
+	int old_uV = vreg->uV;
 
-	req.key = cpu_to_le32(RPM_KEY_UV);
-	req.nbytes = cpu_to_le32(sizeof(u32));
-	req.value = cpu_to_le32(min_uV);
+	vreg->uV = min_uV;
+	vreg->uv_updated = 1;
 
-	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
-	if (!ret)
-		vreg->uV = min_uV;
+	ret = rpm_reg_write_active(vreg);
+	if (ret)
+		vreg->uV = old_uV;
 
 	return ret;
 }
@@ -125,13 +156,16 @@ static int rpm_reg_set_voltage(struct regulator_dev *rdev,
 static int rpm_reg_set_load(struct regulator_dev *rdev, int load_uA)
 {
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
-	struct rpm_regulator_req req;
+	u32 old_load = vreg->load;
+	int ret;
 
-	req.key = cpu_to_le32(RPM_KEY_MA);
-	req.nbytes = cpu_to_le32(sizeof(u32));
-	req.value = cpu_to_le32(load_uA / 1000);
+	vreg->load = load_uA;
+	vreg->load_updated = 1;
+	ret = rpm_reg_write_active(vreg);
+	if (ret)
+		vreg->load = old_load;
 
-	return rpm_reg_write_active(vreg, &req, sizeof(req));
+	return ret;
 }
 
 static const struct regulator_ops rpm_smps_ldo_ops = {
-- 
2.20.1

