Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1358616-1525295271-2-8361599481060666676
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UPPERCASE_50_75 0.008, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525295270; b=Ao8SAY1v1LRFwbao9ubW2HMjUMyeY1hmW2YnV5ths+Kwvyff6o
    ZHkcBqTdLxmsnIX0SZ5XUQMvEoLlL6bQWGzc+/FZsNdbmYT1JgBWecTSyjRFfy8v
    dlRPkS8gi3rwC4TbtHUc0QwJ0g/XXU9VWU5KtD0eH5HVRiOPvxgz9zmOmCF5lnoB
    lizg//i7NGcm2l0IQ3orWHYN20ZRSyu5yKhuw7xuM+NlcYcMFWdphTVipUrewfE2
    mKAvNzHr2gn/S++0F9mQ1vF4AGrZofRfQdLzF2fmNjpWohPylDND7h9s02Fd6spS
    n1w7u3br14DLMKXeYa2Rueh6NFq4Qo2W3J7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525295270; bh=
    +ebeGQwE3aXkru86gQvouG7SSoCk9cwvLDVlfd6mmoU=; b=i6J5kKLB1QjtEwLd
    Gk9rl7yBYnRVQbi+IrG8cY+YkdJbkpg+fk/Fe1tP5TOL/PV0UpX26kPNxwtaz3so
    zMC/i2ZKs5knqCXvTIi/1c2NcHL3kbq+yWW4P0O1rLdb5pHqwlt6MUfVbWHCenoM
    AId3Ronsvs8nfGCL2YPAndMa0L4eQTXHSE3+GvVvEb8CzeVYnHK0dZg5af1RAutR
    H1wbhGIEnGpQ8Mw+LTkS+Xk7pLkI7MGD/Um7xX3Vb2IASQWyaVctD1L/6Dyq2cri
    PgUABANvK8SQQCi1doqQ0f/CYVQh6FXsW5y7OuW/NWPwf2Ual29kB6v1LndNUcTF
    RKiCzw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=YBQK5VT2
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=ZtU7OHeQ
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codeaurora.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=YBQK5VT2
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=ZtU7OHeQ
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codeaurora.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDnNfpl+HjHvHEABoTACVTIMSp6uzeMeNhTQlj1NxfRAib6PFDP05CFe6bgdrEZf9AeUguU7TBJpIB+lXP/riq/h2h5siXaS++gA+lAX7ANH6jpSUyCl
    V2hpjq7zW+XhYpLWXbFG7vadfxfN8JvWnrWteQwjSu4WfY9yhTLnzwS7sCnBrHGopf8FhiPZwcjcdO0KrNhzuAyoGHBQX10YcuxWIX1xkQJMp0n3z/T4yd0u
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=cm27Pg_UAAAA:8
    a=LpQP-O61AAAA:8 a=VwQbUJbxAAAA:8 a=ql7W4PSTR6ETy7z4LssA:9
    a=6xP-8WZLYHo0Iqvv:21 a=7yil2BNY3HY5G_kJ:21 a=x8gzFH9gYPwA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeEBVHB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:07:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59906 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbeEBVGy (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 17:06:54 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1C9E60588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@ti.com>, robh@kernel.org,
        sboyd@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, evgreen@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v5 5/7] phy: qcom-qmp: Add QMP V3 USB3 UNI PHY support for sdm845
Date: Thu,  3 May 2018 02:36:12 +0530
Message-Id: <1525295174-15995-6-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

QMP V3 UNI PHY is a single lane USB3 PHY without support
for DisplayPort (DP).
Main difference from DP combo QMPv3 PHY is that UNI PHY
doesn't have dual RX/TX lanes and no separate DP_COM
block for configuration related to type-c or DP.
Also remove "qcom,qmp-v3-usb3-phy" compatible string which
was earlier added for sdm845 only as there wouldn't be
any user of same.
While at it, fix has_pwrdn_delay attribute for USB-DP
PHY configuration and.

Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 147 +++++++++++++++++++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h |   5 ++
 2 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index fddb1c9..4c47010 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -490,6 +490,118 @@ enum qphy_reg_layout {
 	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
 };
 
+static const struct qmp_phy_init_tbl qmp_v3_usb3_uniphy_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_IVCO, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_EN_SEL, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_RESETSM_CNTRL2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SVS_MODE_CLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_HSCLK_SEL, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START2_MODE0, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START3_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE0, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE0, 0xc9),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORECLK_DIV_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE0, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP_EN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP_CFG, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_BUF_ENABLE, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_ADJ_PER1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_ADJ_PER2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_STEP_SIZE1, 0x85),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_STEP_SIZE2, 0x07),
+};
+
+static const struct qmp_phy_init_tbl qmp_v3_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_HIGHZ_DRVR_EN, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0xc6),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x06),
+};
+
+static const struct qmp_phy_init_tbl qmp_v3_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_VGA_CAL_CNTRL2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x50),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x75),
+};
+
+static const struct qmp_phy_init_tbl qmp_v3_usb3_uniphy_pcs_tbl[] = {
+	/* FLL settings */
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
+
+	/* Lock Det settings */
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_STATE_CONFIG2, 0x1b),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0xba),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V0, 0x9f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V1, 0x9f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V2, 0xb5),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V3, 0x4c),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V4, 0x64),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_LS, 0x6a),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V1, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V1, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V2, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V2, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V3, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V3, 0x1d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V4, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V4, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_LS, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_LS, 0x0d),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RATE_SLEW_CNTRL, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_REFGEN_REQ_CONFIG1, 0x21),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_REFGEN_REQ_CONFIG2, 0x60),
+};
+
+
 /* struct qmp_phy_cfg - per-PHY initialization config */
 struct qmp_phy_cfg {
 	/* phy-type - PCIE/UFS/USB */
@@ -766,6 +878,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
 	.pwrdn_ctrl		= SW_PWRDN,
 	.mask_pcs_ready		= PHYSTATUS,
 
+	.has_pwrdn_delay	= true,
 	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 
@@ -774,6 +887,35 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
 	.rx_b_lane_offset	= 0x400,
 };
 
+static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
+	.type			= PHY_TYPE_USB3,
+	.nlanes			= 1,
+
+	.serdes_tbl		= qmp_v3_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= qmp_v3_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_uniphy_tx_tbl),
+	.rx_tbl			= qmp_v3_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= qmp_v3_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_uniphy_pcs_tbl),
+	.clk_list		= qmp_v3_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= msm8996_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(msm8996_phy_vreg_l),
+	.regs			= qmp_v3_usb3phy_regs_layout,
+
+	.start_ctrl		= SERDES_START | PCS_START,
+	.pwrdn_ctrl		= SW_PWRDN,
+	.mask_pcs_ready		= PHYSTATUS,
+
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
+	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
+};
+
 static void qcom_qmp_phy_configure(void __iomem *base,
 				   const unsigned int *regs,
 				   const struct qmp_phy_init_tbl tbl[],
@@ -1375,8 +1517,11 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
 		.compatible = "qcom,ipq8074-qmp-pcie-phy",
 		.data = &ipq8074_pciephy_cfg,
 	}, {
-		.compatible = "qcom,qmp-v3-usb3-phy",
+		.compatible = "qcom,sdm845-qmp-usb3-phy",
 		.data = &qmp_v3_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,sdm845-qmp-usb3-uni-phy",
+		.data = &qmp_v3_usb3_uniphy_cfg,
 	},
 	{ },
 };
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index d1c6905..5d78d43 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -214,6 +214,8 @@
 #define QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN		0x030
 #define QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE	0x034
 #define QSERDES_V3_RX_RX_TERM_BW			0x07c
+#define QSERDES_V3_RX_VGA_CAL_CNTRL1			0x0bc
+#define QSERDES_V3_RX_VGA_CAL_CNTRL2			0x0c0
 #define QSERDES_V3_RX_RX_EQ_GAIN2_LSB			0x0c8
 #define QSERDES_V3_RX_RX_EQ_GAIN2_MSB			0x0cc
 #define QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2		0x0d4
@@ -227,6 +229,7 @@
 #define QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL		0x10c
 #define QSERDES_V3_RX_RX_BAND				0x110
 #define QSERDES_V3_RX_RX_INTERFACE_MODE			0x11c
+#define QSERDES_V3_RX_RX_MODE_00			0x164
 
 /* Only for QMP V3 PHY - PCS registers */
 #define QPHY_V3_PCS_POWER_DOWN_CONTROL			0x004
@@ -273,6 +276,8 @@
 #define QPHY_V3_PCS_FLL_CNT_VAL_H_TOL			0x0d0
 #define QPHY_V3_PCS_FLL_MAN_CODE			0x0d4
 #define QPHY_V3_PCS_RX_SIGDET_LVL			0x1d8
+#define QPHY_V3_PCS_REFGEN_REQ_CONFIG1			0x20c
+#define QPHY_V3_PCS_REFGEN_REQ_CONFIG2			0x210
 
 /* Only for QMP V3 PHY - PCS_MISC registers */
 #define QPHY_V3_PCS_MISC_CLAMP_ENABLE			0x0c
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

