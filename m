Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC51AECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD7E20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvneHFRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD7E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbeGWTA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:00:58 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42993 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388523AbeGWTA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:00:58 -0400
Received: by mail-qk0-f193.google.com with SMTP id 26-v6so972658qks.9;
        Mon, 23 Jul 2018 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=mpJ1mwYdG3spUJpFRcQNOD+Cy19KhT8VB8ZpKqxBsCs=;
        b=GvneHFRoF5SyatbmFegw+9PAsS5T2xfLu5FVz2TnPTVhrHhT39Cja4F2Kp8rMCMxWj
         IGoXDQBpjM9V1EYNQBmRta/d+qq4Vj35xKcgHWuqCmLfblDUFIUSnbjLPTGVqwbOpTVc
         +1v0yn+SoluwE8t339/K79NnSMvluNuVOED1RFpjOPWE2ZAjz1/qLSGoQ3iekmRFbz0t
         KYzu19kq/gfQtBCw/9+fz/nn1oU1LX8XCJdEQesRtakrx+KIdJ2gMuxJQKrb1MFjLsHP
         vhmC33Enfk/hIE/8cAtY8aDj/k7mGQg5BasJc0gUYlUVipXBq2tMw7aKnlPewO+C0JG0
         JyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=mpJ1mwYdG3spUJpFRcQNOD+Cy19KhT8VB8ZpKqxBsCs=;
        b=uY0u/CxfGqE5v+BEu81FIAWT2jwxxekDU2c4giywCAyCQBDcufqVuWLPTUyRbiKTsg
         Kda9RP1S53QMjkejQJ0UZz/6K1ADb/zBuFGA2McWlQTQCzKQrP4j2pkj5NCiCDBubyYh
         6+/hdPNh0FUtb6+KVxYr5CC4pT9ylNxwupdz8wZFeWl7EwHXZVgrt2mo4dPxob5Wl+vU
         4Io2FarJIgiGq2eIIg0j2adMO0+7bNDGfTot332OluVQrL398610wlArBJxLb9uxWnUo
         QKoYxXqTYaVguzpL1MqewGSa5SrnZUTOlDO112SKEVHofHDqfcRZ1I0yU8S8T+R8FY4T
         uZnA==
X-Gm-Message-State: AOUpUlFoGaLfAY2qZW4aZeCqKTSNvcLeGjeuB4Ya07WC60212jMm+N+y
        iI+dGKInc5T6fq5hsEQx2g/HNheVxdk=
X-Google-Smtp-Source: AAOMgpe+Wxe0mkrXfXMuJKUkX/QGQ2RE93y1dM2UExC3sbU9VN5lPjL0j1cjC4CzDzqK5H5nETd05g==
X-Received: by 2002:a37:4d1:: with SMTP id 200-v6mr11977493qke.35.1532368715081;
        Mon, 23 Jul 2018 10:58:35 -0700 (PDT)
Received: from [192.168.44.96] (65.sub-174-226-2.myvzw.com. [174.226.2.65])
        by smtp.gmail.com with ESMTPSA id c93-v6sm11923161qkh.90.2018.07.23.10.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 10:58:34 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 2/2] Add support for CPCAP regulators on Tegra devices.
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Message-ID: <6545601f-c0f1-501b-dcc8-ad252d5b9b8a@gmail.com>
Date:   Mon, 23 Jul 2018 13:58:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for the CPCAP power management regulator functions on
Tegra devices.
Added sw2_sw4 value tables, which provide power to the Tegra core and
aux devices.
Added the Tegra init tables and device tree compatibility match.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
  .../bindings/regulator/cpcap-regulator.txt    |  1 +
  drivers/regulator/cpcap-regulator.c           | 80 +++++++++++++++++++
  2 files changed, 81 insertions(+)

diff --git 
a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt 
b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
index 675f4437ce92..3e2d33ab1731 100644
--- a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
@@ -4,6 +4,7 @@ Motorola CPCAP PMIC voltage regulators
  Requires node properties:
  - "compatible" value one of:
      "motorola,cpcap-regulator"
+    "motorola,tegra-cpcap-regulator"
      "motorola,mapphone-cpcap-regulator"

  Required regulator properties:
diff --git a/drivers/regulator/cpcap-regulator.c 
b/drivers/regulator/cpcap-regulator.c
index c0b1e04bd90f..cb3774be445d 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -412,6 +412,82 @@ static struct cpcap_regulator omap4_regulators[] = {
  	{ /* sentinel */ },
  };

+static struct cpcap_regulator tegra_regulators[] = {
+	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
+		  0, 0, 0, 0, 0, 0),
+	CPCAP_REG(SW2, CPCAP_REG_S2C1, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW2_SEL, sw2_sw4_val_tbl,
+		  0xf00, 0x7f, 0, 0x800, 0, 120),
+	CPCAP_REG(SW3, CPCAP_REG_S3C, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW3_SEL, unknown_val_tbl,
+		  0, 0, 0, 0, 0, 0),
+	CPCAP_REG(SW4, CPCAP_REG_S4C1, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW4_SEL, sw2_sw4_val_tbl,
+		  0xf00, 0x7f, 0, 0x900, 0, 100),
+	CPCAP_REG(SW5, CPCAP_REG_S5C, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW5_SEL, sw5_val_tbl,
+		  0x2a, 0, 0, 0x22, 0, 0),
+	CPCAP_REG(SW6, CPCAP_REG_S6C, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW6_SEL, unknown_val_tbl,
+		  0, 0, 0, 0, 0, 0),
+	CPCAP_REG(VCAM, CPCAP_REG_VCAMC, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_VCAM_SEL, vcam_val_tbl,
+		  0x87, 0x30, 4, 0x7, 0, 420),
+	CPCAP_REG(VCSI, CPCAP_REG_VCSIC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VCSI_SEL, vcsi_val_tbl,
+		  0x47, 0x10, 4, 0x7, 0, 350),
+	CPCAP_REG(VDAC, CPCAP_REG_VDACC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VDAC_SEL, vdac_val_tbl,
+		  0x87, 0x30, 4, 0x3, 0, 420),
+	CPCAP_REG(VDIG, CPCAP_REG_VDIGC, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_VDIG_SEL, vdig_val_tbl,
+		  0x87, 0x30, 4, 0x5, 0, 420),
+	CPCAP_REG(VFUSE, CPCAP_REG_VFUSEC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VFUSE_SEL, vfuse_val_tbl,
+		  0x80, 0xf, 0, 0x80, 0, 420),
+	CPCAP_REG(VHVIO, CPCAP_REG_VHVIOC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VHVIO_SEL, vhvio_val_tbl,
+		  0x17, 0, 0, 0x2, 0, 0),
+	CPCAP_REG(VSDIO, CPCAP_REG_VSDIOC, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_VSDIO_SEL, vsdio_val_tbl,
+		  0x87, 0x38, 3, 0x2, 0, 420),
+	CPCAP_REG(VPLL, CPCAP_REG_VPLLC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VPLL_SEL, vpll_val_tbl,
+		  0x43, 0x18, 3, 0x1, 0, 420),
+	CPCAP_REG(VRF1, CPCAP_REG_VRF1C, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VRF1_SEL, vrf1_val_tbl,
+		  0xac, 0x2, 1, 0xc, 0, 10),
+	CPCAP_REG(VRF2, CPCAP_REG_VRF2C, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VRF2_SEL, vrf2_val_tbl,
+		  0x23, 0x8, 3, 0x3, 0, 10),
+	CPCAP_REG(VRFREF, CPCAP_REG_VRFREFC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VRFREF_SEL, vrfref_val_tbl,
+		  0x23, 0x8, 3, 0x3, 0, 420),
+	CPCAP_REG(VWLAN1, CPCAP_REG_VWLAN1C, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VWLAN1_SEL, vwlan1_val_tbl,
+		  0x47, 0x10, 4, 0x5, 0, 420),
+	CPCAP_REG(VWLAN2, CPCAP_REG_VWLAN2C, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VWLAN2_SEL, vwlan2_val_tbl,
+		  0x20c, 0xc0, 6, 0x8, 0, 420),
+	CPCAP_REG(VSIM, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
+		  0xffff, vsim_val_tbl,
+		  0x23, 0x8, 3, 0x3, 0, 420),
+	CPCAP_REG(VSIMCARD, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
+		  0xffff, vsimcard_val_tbl,
+		  0x1e80, 0x8, 3, 0x1e00, 0, 420),
+	CPCAP_REG(VVIB, CPCAP_REG_VVIBC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VVIB_SEL, vvib_val_tbl,
+		  0x1, 0xc, 2, 0, 0x1, 500),
+	CPCAP_REG(VUSB, CPCAP_REG_VUSBC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VUSB_SEL, vusb_val_tbl,
+		  0x11c, 0x40, 6, 0xc, 0, 0),
+	CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
+		  CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
+		  0x16, 0x1, 0, 0x4, 0, 0),
+	{ /* sentinel */ },
+};
+
  static const struct of_device_id cpcap_regulator_id_table[] = {
  	{
  		.compatible = "motorola,cpcap-regulator",
@@ -420,6 +496,10 @@ static const struct of_device_id 
cpcap_regulator_id_table[] = {
  		.compatible = "motorola,mapphone-cpcap-regulator",
  		.data = omap4_regulators,
  	},
+	{
+		.compatible = "motorola,tegra-cpcap-regulator",
+		.data = tegra_regulators,
+	},
  	{},
  };
  MODULE_DEVICE_TABLE(of, cpcap_regulator_id_table);
-- 
2.17.1
