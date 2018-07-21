Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2A9ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFDD20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2sRS3vW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFDD20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbeGUBej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 21:34:39 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43990 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeGUBej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 21:34:39 -0400
Received: by mail-qk0-f195.google.com with SMTP id z74-v6so7204469qkb.10;
        Fri, 20 Jul 2018 17:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=mpJ1mwYdG3spUJpFRcQNOD+Cy19KhT8VB8ZpKqxBsCs=;
        b=Y2sRS3vWaFR39tlPpAiW7VpWg423XiSe2/PJo9d//GwiF1Stq3kQMlnXmY24fgi5X2
         WqjipCBAT/BSkSum76rGigWgsqkMl9i9nnZJnT9liR1pPWXywy8mSErb0ePK3x1q5ibu
         ZSkv0ttB1iLAdsUasCEq13XsmNFZcNE6bMruLix+k8O4Xea+DXF3iUGJi3gPJCbEv8Z8
         9RQzC3+Oi3yWF6FUAwPS8mvML3ipT6Eg7+MLflR+j1iaYPiueActJ/7JDwFR6s7I+mQS
         ZHNszqh05i80MSECg53IlOrGP5l0wFiRSOVgec8DlpZpO7wqhw1NUNFJTgt0K1emmbC/
         RtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=mpJ1mwYdG3spUJpFRcQNOD+Cy19KhT8VB8ZpKqxBsCs=;
        b=aB25eLdX2kktCA7NVBvpPX/qxQsFiU/jtezHx0cRTF9mEReZcX8yKDFmKK9FyVrZ6n
         6YA/9P1HNDzsAYEdF/s4lm/MSfpo9KWRJnG7rAb09ttLTexj/waZ92Twb5T6XOQVDIex
         7j8U8EBUAw0Ota2czeZ9jsZowe4PRRsT4mN6zbSSLotOYEWe/ZZmQxFn7K3a3iYmEzvp
         hY7QePmfsil1SHmPvbypya84TxAf6XEAxIbEkFLJkW1hmNz32vJybUWSUmuUQGz3/6Xy
         t7fJa83c5IVzo9qq1teGSJb9b7NswnaVq147rtKlIG97SrvBI5v0qWBatUosheWoCvlj
         wEMQ==
X-Gm-Message-State: AOUpUlG8OFIMgs3zQ5kPnkkJ+Z7/wxzFFEJN/2RbSRfMEXft/z/vJkKh
        C1ydHHOFG2V+XoCZ8ZaEyPgyCte0WSS02g==
X-Google-Smtp-Source: AAOMgpcnb/ylx2GiAJpxwGX7X/TCqlJOTfn4wuOGI8Mmzu5pLbZsZHiO/biNJQKoyd1LjugLtN62NQ==
X-Received: by 2002:ae9:ed82:: with SMTP id c124-v6mr3905487qkg.303.1532133837854;
        Fri, 20 Jul 2018 17:43:57 -0700 (PDT)
Received: from ?IPv6:2601:153:601:7d2a::100b? ([2601:153:601:7d2a::100b])
        by smtp.gmail.com with ESMTPSA id i24-v6sm2407180qti.28.2018.07.20.17.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 17:43:57 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 2/2] Add support for CPCAP regulators on Tegra devices.
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Message-ID: <1abd663a-7f3f-d7cd-2329-e59b301aef6f@gmail.com>
Date:   Fri, 20 Jul 2018 20:43:56 -0400
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
+       CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
+                 CPCAP_BIT_SW1_SEL, unknown_val_tbl,
+                 0, 0, 0, 0, 0, 0),
+       CPCAP_REG(SW2, CPCAP_REG_S2C1, CPCAP_REG_ASSIGN2,
+                 CPCAP_BIT_SW2_SEL, sw2_sw4_val_tbl,
+                 0xf00, 0x7f, 0, 0x800, 0, 120),
+       CPCAP_REG(SW3, CPCAP_REG_S3C, CPCAP_REG_ASSIGN2,
+                 CPCAP_BIT_SW3_SEL, unknown_val_tbl,
+                 0, 0, 0, 0, 0, 0),
+       CPCAP_REG(SW4, CPCAP_REG_S4C1, CPCAP_REG_ASSIGN2,
+                 CPCAP_BIT_SW4_SEL, sw2_sw4_val_tbl,
+                 0xf00, 0x7f, 0, 0x900, 0, 100),
+       CPCAP_REG(SW5, CPCAP_REG_S5C, CPCAP_REG_ASSIGN2,
+                 CPCAP_BIT_SW5_SEL, sw5_val_tbl,
+                 0x2a, 0, 0, 0x22, 0, 0),
+       CPCAP_REG(SW6, CPCAP_REG_S6C, CPCAP_REG_ASSIGN2,
+                 CPCAP_BIT_SW6_SEL, unknown_val_tbl,
+                 0, 0, 0, 0, 0, 0),
+       CPCAP_REG(VCAM, CPCAP_REG_VCAMC, CPCAP_REG_ASSIGN2,
+                 CPCAP_BIT_VCAM_SEL, vcam_val_tbl,
+                 0x87, 0x30, 4, 0x7, 0, 420),
+       CPCAP_REG(VCSI, CPCAP_REG_VCSIC, CPCAP_REG_ASSIGN3,
+                 CPCAP_BIT_VCSI_SEL, vcsi_val_tbl,
+                 0x47, 0x10, 4, 0x7, 0, 350),
+       CPCAP_REG(VDAC, CPCAP_REG_VDACC, CPCAP_REG_ASSIGN3,
+                 CPCAP_BIT_VDAC_SEL, vdac_val_tbl,
+                 0x87, 0x30, 4, 0x3, 0, 420),
+       CPCAP_REG(VDIG, CPCAP_REG_VDIGC, CPCAP_REG_ASSIGN2,
+                 CPCAP_BIT_VDIG_SEL, vdig_val_tbl,
+                 0x87, 0x30, 4, 0x5, 0, 420),
+       CPCAP_REG(VFUSE, CPCAP_REG_VFUSEC, CPCAP_REG_ASSIGN3,
+                 CPCAP_BIT_VFUSE_SEL, vfuse_val_tbl,
+                 0x80, 0xf, 0, 0x80, 0, 420),
+       CPCAP_REG(VHVIO, CPCAP_REG_VHVIOC, CPCAP_REG_ASSIGN3,
+                 CPCAP_BIT_VHVIO_SEL, vhvio_val_tbl,
+                 0x17, 0, 0, 0x2, 0, 0),
+       CPCAP_REG(VSDIO, CPCAP_REG_VSDIOC, CPCAP_REG_ASSIGN2,
+                 CPCAP_BIT_VSDIO_SEL, vsdio_val_tbl,
+                 0x87, 0x38, 3, 0x2, 0, 420),
+       CPCAP_REG(VPLL, CPCAP_REG_VPLLC, CPCAP_REG_ASSIGN3,
+                 CPCAP_BIT_VPLL_SEL, vpll_val_tbl,
+                 0x43, 0x18, 3, 0x1, 0, 420),
+       CPCAP_REG(VRF1, CPCAP_REG_VRF1C, CPCAP_REG_ASSIGN3,
+                 CPCAP_BIT_VRF1_SEL, vrf1_val_tbl,
+                 0xac, 0x2, 1, 0xc, 0, 10),
+       CPCAP_REG(VRF2, CPCAP_REG_VRF2C, CPCAP_REG_ASSIGN3,
+                 CPCAP_BIT_VRF2_SEL, vrf2_val_tbl,
+                 0x23, 0x8, 3, 0x3, 0, 10),
+       CPCAP_REG(VRFREF, CPCAP_REG_VRFREFC, CPCAP_REG_ASSIGN3,
+                 CPCAP_BIT_VRFREF_SEL, vrfref_val_tbl,
+                 0x23, 0x8, 3, 0x3, 0, 420),
+       CPCAP_REG(VWLAN1, CPCAP_REG_VWLAN1C, CPCAP_REG_ASSIGN3,
+                 CPCAP_BIT_VWLAN1_SEL, vwlan1_val_tbl,
+                 0x47, 0x10, 4, 0x5, 0, 420),
+       CPCAP_REG(VWLAN2, CPCAP_REG_VWLAN2C, CPCAP_REG_ASSIGN3,
+                 CPCAP_BIT_VWLAN2_SEL, vwlan2_val_tbl,
+                 0x20c, 0xc0, 6, 0x8, 0, 420),
+       CPCAP_REG(VSIM, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
+                 0xffff, vsim_val_tbl,
+                 0x23, 0x8, 3, 0x3, 0, 420),
+       CPCAP_REG(VSIMCARD, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
+                 0xffff, vsimcard_val_tbl,
+                 0x1e80, 0x8, 3, 0x1e00, 0, 420),
+       CPCAP_REG(VVIB, CPCAP_REG_VVIBC, CPCAP_REG_ASSIGN3,
+                 CPCAP_BIT_VVIB_SEL, vvib_val_tbl,
+                 0x1, 0xc, 2, 0, 0x1, 500),
+       CPCAP_REG(VUSB, CPCAP_REG_VUSBC, CPCAP_REG_ASSIGN3,
+                 CPCAP_BIT_VUSB_SEL, vusb_val_tbl,
+                 0x11c, 0x40, 6, 0xc, 0, 0),
+       CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
+                 CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
+                 0x16, 0x1, 0, 0x4, 0, 0),
+       { /* sentinel */ },
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
+       {
+               .compatible = "motorola,tegra-cpcap-regulator",
+               .data = tegra_regulators,
+       },
         {},
  };
  MODULE_DEVICE_TABLE(of, cpcap_regulator_id_table);
-- 
2.17.1
