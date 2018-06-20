Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9B6C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC5F20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9o5NNJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC5F20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754069AbeFTML7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:11:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40661 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbeFTMLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:11:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id n5-v6so6419685wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 05:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gSrXz+Ac1qZIXAw7/EQDjiJu46mhWeyLOdN6UJgkS6Y=;
        b=M9o5NNJIpe1sTNGBplM894/DfAtaB5CFYqQlDUm8iesIIhnX++XCjmk7rWxIsVlyt5
         JND4CZpPb54gwGCrXPoynHZPUESRW2LuV5OhkvtmhNUTJhCzObt2b/ofoXr/5mAYVQx+
         nXeY/BxIvxMOjbdw3jy1IwGxQ1dSj3qHGhmw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gSrXz+Ac1qZIXAw7/EQDjiJu46mhWeyLOdN6UJgkS6Y=;
        b=jCDundn8OsxChpu0SFUJYBuKQ3bllzCVxKagt+UtIC7poL9iwKBd3W/tZDsobdwwq1
         Q1q9tQiKLQSPmZS+A6HJw0biY9TN1RVgTftdWMdEudu/deUaljWhS3icD2hZUDm8YT6h
         szyEcNFgDk1EQmTuJBA7Xz4+Sjd8JRFKD+vtF2hVyRo0RtqW4/UJLg1G0ZEHwep8ITPl
         F2Fe4d/r/zyXe99bRB6FKvPk7b4xPotgrJdTJ9Z84qkk06K+DQVjuOW8pR/vqX6IA495
         29wol7bHWO0LMbVkocvlzfMjwe0akRnydwATV6IldyfNpy393je5nrGxlzdfDMuLx8dd
         HnKg==
X-Gm-Message-State: APt69E15HmUPJ1oIPaZhdPns52Q3Ctry4TWCLRJNWRABFvLqPQiqjw9v
        OZEbMINSP99nZGt1XzKOrygk8A==
X-Google-Smtp-Source: ADUXVKIsSG0u7GxPtZgcCifXRzz/ZqGKvOBqmqzbRZSl4RABdWEgI726bm7XlS863pTEsk+uFdrWsg==
X-Received: by 2002:a1c:8301:: with SMTP id f1-v6mr1683292wmd.17.1529496712911;
        Wed, 20 Jun 2018 05:11:52 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id e14-v6sm1656483wmh.17.2018.06.20.05.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 05:11:52 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v5 5/8] dt-bindings: interconnect: Document qcom,msm8916 NoC bindings
Date:   Wed, 20 Jun 2018 15:11:38 +0300
Message-Id: <20180620121141.15403-6-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620121141.15403-1-georgi.djakov@linaro.org>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the device-tree bindings Network-On-Chip interconnect driver
for Qualcomm msm8916 platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/qcom-msm8916.txt    |  39 ++
 include/dt-bindings/interconnect/qcom.h       | 350 ++++++++++++++++++
 2 files changed, 389 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
 create mode 100644 include/dt-bindings/interconnect/qcom.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt b/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
new file mode 100644
index 000000000000..f309eaed3d19
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
@@ -0,0 +1,39 @@
+Qualcomm MSM8916 Network-On-Chip interconnect driver binding
+----------------------------------------------------
+
+Required properties :
+- compatible : shall contain only one of the following:
+			"qcom,msm8916-bimc"
+			"qcom,msm8916-pnoc"
+			"qcom,msm8916-snoc"
+- #interconnect-cells : should contain 1
+- reg : shall contain base register location and length
+
+Optional properties :
+clocks : list of phandles and specifiers to all interconnect bus clocks
+clock-names : clock names should include both "bus_clk" and "bus_a_clk"
+
+Examples:
+
+		snoc: snoc@580000 {
+			compatible = "qcom,msm8916-snoc";
+			#interconnect-cells = <1>;
+			reg = <0x580000 0x14000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+		bimc: bimc@400000 {
+			compatible = "qcom,msm8916-bimc";
+			#interconnect-cells = <1>;
+			reg = <0x400000 0x62000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>, <&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+		pnoc: pnoc@500000 {
+			compatible = "qcom,msm8916-pnoc";
+			#interconnect-cells = <1>;
+			reg = <0x500000 0x11000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>, <&rpmcc RPM_SMD_PCNOC_A_CLK>;
+		};
+
diff --git a/include/dt-bindings/interconnect/qcom.h b/include/dt-bindings/interconnect/qcom.h
new file mode 100644
index 000000000000..2cd378d2f575
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom.h
@@ -0,0 +1,350 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm interconnect IDs
+ *
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __QCOM_INTERCONNECT_IDS_H
+#define __QCOM_INTERCONNECT_IDS_H
+
+#define FAB_BIMC 0
+#define FAB_SYS_NOC 1024
+#define FAB_MMSS_NOC 2048
+#define FAB_OCMEM_NOC 3072
+#define FAB_PERIPH_NOC 4096
+#define FAB_CONFIG_NOC 5120
+#define FAB_OCMEM_VNOC 6144
+
+#define MASTER_AMPSS_M0 1
+#define MASTER_AMPSS_M1 2
+#define APPSS_MASTER_FAB_MMSS 3
+#define APPSS_MASTER_FAB_SYSTEM 4
+#define SYSTEM_MASTER_FAB_APPSS 5
+#define MASTER_SPS 6
+#define MASTER_ADM_PORT0 7
+#define MASTER_ADM_PORT1 8
+#define SYSTEM_MASTER_ADM1_PORT0 9
+#define MASTER_ADM1_PORT1 10
+#define MASTER_LPASS_PROC 11
+#define MASTER_MSS_PROCI 12
+#define MASTER_MSS_PROCD 13
+#define MASTER_MSS_MDM_PORT0 14
+#define MASTER_LPASS 15
+#define SYSTEM_MASTER_CPSS_FPB 16
+#define SYSTEM_MASTER_SYSTEM_FPB 17
+#define SYSTEM_MASTER_MMSS_FPB 18
+#define MASTER_ADM1_CI 19
+#define MASTER_ADM0_CI 20
+#define MASTER_MSS_MDM_PORT1 21
+#define MASTER_MDP_PORT0 22
+#define MASTER_MDP_PORT1 23
+#define MMSS_MASTER_ADM1_PORT0 24
+#define MASTER_ROTATOR 25
+#define MASTER_GRAPHICS_3D 26
+#define MASTER_JPEG_DEC 27
+#define MASTER_GRAPHICS_2D_CORE0 28
+#define MASTER_VFE 29
+#define MASTER_VPE 30
+#define MASTER_JPEG_ENC 31
+#define MASTER_GRAPHICS_2D_CORE1 32
+#define MMSS_MASTER_APPS_FAB 33
+#define MASTER_HD_CODEC_PORT0 34
+#define MASTER_HD_CODEC_PORT1 35
+#define MASTER_SPDM 36
+#define MASTER_RPM 37
+#define MASTER_MSS 38
+#define MASTER_RIVA 39
+#define SYSTEM_MASTER_UNUSED_6 40
+#define MASTER_MSS_SW_PROC 41
+#define MASTER_MSS_FW_PROC 42
+#define MMSS_MASTER_UNUSED_2 43
+#define MASTER_GSS_NAV 44
+#define MASTER_PCIE 45
+#define MASTER_SATA 46
+#define MASTER_CRYPTO 47
+#define MASTER_VIDEO_CAP 48
+#define MASTER_GRAPHICS_3D_PORT1 49
+#define MASTER_VIDEO_ENC 50
+#define MASTER_VIDEO_DEC 51
+#define MASTER_LPASS_AHB 52
+#define MASTER_QDSS_BAM 53
+#define MASTER_SNOC_CFG 54
+#define MASTER_CRYPTO_CORE0 55
+#define MASTER_CRYPTO_CORE1 56
+#define MASTER_MSS_NAV 57
+#define MASTER_OCMEM_DMA 58
+#define MASTER_WCSS 59
+#define MASTER_QDSS_ETR 60
+#define MASTER_USB3 61
+#define MASTER_JPEG 62
+#define MASTER_VIDEO_P0 63
+#define MASTER_VIDEO_P1 64
+#define MASTER_MSS_PROC 65
+#define MASTER_JPEG_OCMEM 66
+#define MASTER_MDP_OCMEM 67
+#define MASTER_VIDEO_P0_OCMEM 68
+#define MASTER_VIDEO_P1_OCMEM 69
+#define MASTER_VFE_OCMEM 70
+#define MASTER_CNOC_ONOC_CFG 71
+#define MASTER_RPM_INST 72
+#define MASTER_RPM_DATA 73
+#define MASTER_RPM_SYS 74
+#define MASTER_DEHR 75
+#define MASTER_QDSS_DAP 76
+#define MASTER_TIC 77
+#define MASTER_SDCC_1 78
+#define MASTER_SDCC_3 79
+#define MASTER_SDCC_4 80
+#define MASTER_SDCC_2 81
+#define MASTER_TSIF 82
+#define MASTER_BAM_DMA 83
+#define MASTER_BLSP_2 84
+#define MASTER_USB_HSIC 85
+#define MASTER_BLSP_1 86
+#define MASTER_USB_HS 87
+#define MASTER_PNOC_CFG 88
+#define MASTER_V_OCMEM_GFX3D 89
+#define MASTER_IPA 90
+#define MASTER_QPIC 91
+#define MASTER_MDPE 92
+#define MASTER_USB_HS2 93
+#define MASTER_VPU 94
+#define MASTER_UFS 95
+#define MASTER_BCAST 96
+#define MASTER_CRYPTO_CORE2 97
+#define MASTER_EMAC 98
+#define MASTER_VPU_1 99
+#define MASTER_PCIE_1 100
+#define MASTER_USB3_1 101
+#define MASTER_CNOC_MNOC_MMSS_CFG 102
+#define MASTER_CNOC_MNOC_CFG 103
+#define MASTER_TCU_0 104
+#define MASTER_TCU_1 105
+#define MASTER_CPP 106
+#define MASTER_AUDIO 107
+
+#define SNOC_MM_INT_0 10000
+#define SNOC_MM_INT_1 10001
+#define SNOC_MM_INT_2 10002
+#define SNOC_MM_INT_BIMC 10003
+#define SNOC_INT_0 10004
+#define SNOC_INT_1 10005
+#define SNOC_INT_BIMC 10006
+#define SNOC_BIMC_0_MAS 10007
+#define SNOC_BIMC_1_MAS 10008
+#define SNOC_QDSS_INT 10009
+#define PNOC_SNOC_MAS 10010
+#define PNOC_SNOC_SLV 10011
+#define PNOC_INT_0 10012
+#define PNOC_INT_1 10013
+#define PNOC_M_0 10014
+#define PNOC_M_1 10015
+#define BIMC_SNOC_MAS 10016
+#define BIMC_SNOC_SLV 10017
+#define PNOC_SLV_0 10018
+#define PNOC_SLV_1 10019
+#define PNOC_SLV_2 10020
+#define PNOC_SLV_3 10021
+#define PNOC_SLV_4 10022
+#define PNOC_SLV_8 10023
+#define PNOC_SLV_9 10024
+#define SNOC_BIMC_0_SLV 10025
+#define SNOC_BIMC_1_SLV 10026
+#define MNOC_BIMC_MAS 10027
+#define MNOC_BIMC_SLV 10028
+#define BIMC_MNOC_MAS 10029
+#define BIMC_MNOC_SLV 10030
+#define SNOC_BIMC_MAS 10031
+#define SNOC_BIMC_SLV 10032
+#define CNOC_SNOC_MAS 10033
+#define CNOC_SNOC_SLV 10034
+#define SNOC_CNOC_MAS 10035
+#define SNOC_CNOC_SLV 10036
+#define OVNOC_SNOC_MAS 10037
+#define OVNOC_SNOC_SLV 10038
+#define SNOC_OVNOC_MAS 10039
+#define SNOC_OVNOC_SLV 10040
+#define SNOC_PNOC_MAS 10041
+#define SNOC_PNOC_SLV 10042
+#define BIMC_INT_APPS_EBI 10043
+#define BIMC_INT_APPS_SNOC 10044
+#define SNOC_BIMC_2_MAS 10045
+#define SNOC_BIMC_2_SLV 10046
+#define PNOC_SLV_5 10047
+#define PNOC_SLV_7 10048
+#define PNOC_INT_2 10049
+#define PNOC_INT_3 10050
+#define PNOC_INT_4 10051
+#define PNOC_INT_5 10052
+#define PNOC_INT_6 10053
+#define PNOC_INT_7 10054
+
+#define SLAVE_EBI_CH0 512
+#define SLAVE_EBI_CH1 513
+#define SLAVE_AMPSS_L2 514
+#define APPSS_SLAVE_FAB_MMSS 515
+#define APPSS_SLAVE_FAB_SYSTEM 516
+#define SYSTEM_SLAVE_FAB_APPS 517
+#define SLAVE_SPS 518
+#define SLAVE_SYSTEM_IMEM 519
+#define SLAVE_AMPSS 520
+#define SLAVE_MSS 521
+#define SLAVE_LPASS 522
+#define SYSTEM_SLAVE_CPSS_FPB 523
+#define SYSTEM_SLAVE_SYSTEM_FPB 524
+#define SYSTEM_SLAVE_MMSS_FPB 525
+#define SLAVE_CORESIGHT 526
+#define SLAVE_RIVA 527
+#define SLAVE_SMI 528
+#define MMSS_SLAVE_FAB_APPS 529
+#define MMSS_SLAVE_FAB_APPS_1 530
+#define SLAVE_MM_IMEM 531
+#define SLAVE_CRYPTO 532
+#define SLAVE_SPDM 533
+#define SLAVE_RPM 534
+#define SLAVE_RPM_MSG_RAM 535
+#define SLAVE_MPM 536
+#define SLAVE_PMIC1_SSBI1_A 537
+#define SLAVE_PMIC1_SSBI1_B 538
+#define SLAVE_PMIC1_SSBI1_C 539
+#define SLAVE_PMIC2_SSBI2_A 540
+#define SLAVE_PMIC2_SSBI2_B 541
+#define SLAVE_GSBI1_UART 542
+#define SLAVE_GSBI2_UART 543
+#define SLAVE_GSBI3_UART 544
+#define SLAVE_GSBI4_UART 545
+#define SLAVE_GSBI5_UART 546
+#define SLAVE_GSBI6_UART 547
+#define SLAVE_GSBI7_UART 548
+#define SLAVE_GSBI8_UART 549
+#define SLAVE_GSBI9_UART 550
+#define SLAVE_GSBI10_UART 551
+#define SLAVE_GSBI11_UART 552
+#define SLAVE_GSBI12_UART 553
+#define SLAVE_GSBI1_QUP 554
+#define SLAVE_GSBI2_QUP 555
+#define SLAVE_GSBI3_QUP 556
+#define SLAVE_GSBI4_QUP 557
+#define SLAVE_GSBI5_QUP 558
+#define SLAVE_GSBI6_QUP 559
+#define SLAVE_GSBI7_QUP 560
+#define SLAVE_GSBI8_QUP 561
+#define SLAVE_GSBI9_QUP 562
+#define SLAVE_GSBI10_QUP 563
+#define SLAVE_GSBI11_QUP 564
+#define SLAVE_GSBI12_QUP 565
+#define SLAVE_EBI2_NAND 566
+#define SLAVE_EBI2_CS0 567
+#define SLAVE_EBI2_CS1 568
+#define SLAVE_EBI2_CS2 569
+#define SLAVE_EBI2_CS3 570
+#define SLAVE_EBI2_CS4 571
+#define SLAVE_EBI2_CS5 572
+#define SLAVE_USB_FS1 573
+#define SLAVE_USB_FS2 574
+#define SLAVE_TSIF 575
+#define SLAVE_MSM_TSSC 576
+#define SLAVE_MSM_PDM 577
+#define SLAVE_MSM_DIMEM 578
+#define SLAVE_MSM_TCSR 579
+#define SLAVE_MSM_PRNG 580
+#define SLAVE_GSS 581
+#define SLAVE_SATA 582
+#define SLAVE_USB3 583
+#define SLAVE_WCSS 584
+#define SLAVE_OCIMEM 585
+#define SLAVE_SNOC_OCMEM 586
+#define SLAVE_SERVICE_SNOC 587
+#define SLAVE_QDSS_STM 588
+#define SLAVE_CAMERA_CFG 589
+#define SLAVE_DISPLAY_CFG 590
+#define SLAVE_OCMEM_CFG 591
+#define SLAVE_CPR_CFG 592
+#define SLAVE_CPR_XPU_CFG 593
+#define SLAVE_MISC_CFG 594
+#define SLAVE_MISC_XPU_CFG 595
+#define SLAVE_VENUS_CFG 596
+#define SLAVE_MISC_VENUS_CFG 597
+#define SLAVE_GRAPHICS_3D_CFG 598
+#define SLAVE_MMSS_CLK_CFG 599
+#define SLAVE_MMSS_CLK_XPU_CFG 600
+#define SLAVE_MNOC_MPU_CFG 601
+#define SLAVE_ONOC_MPU_CFG 602
+#define SLAVE_SERVICE_MNOC 603
+#define SLAVE_OCMEM 604
+#define SLAVE_SERVICE_ONOC 605
+#define SLAVE_SDCC_1 606
+#define SLAVE_SDCC_3 607
+#define SLAVE_SDCC_2 608
+#define SLAVE_SDCC_4 609
+#define SLAVE_BAM_DMA 610
+#define SLAVE_BLSP_2 611
+#define SLAVE_USB_HSIC 612
+#define SLAVE_BLSP_1 613
+#define SLAVE_USB_HS 614
+#define SLAVE_PDM 615
+#define SLAVE_PERIPH_APU_CFG 616
+#define SLAVE_PNOC_MPU_CFG 617
+#define SLAVE_PRNG 618
+#define SLAVE_SERVICE_PNOC 619
+#define SLAVE_CLK_CTL 620
+#define SLAVE_CNOC_MSS 621
+#define SLAVE_SECURITY 622
+#define SLAVE_TCSR 623
+#define SLAVE_TLMM 624
+#define SLAVE_CRYPTO_0_CFG 625
+#define SLAVE_CRYPTO_1_CFG 626
+#define SLAVE_IMEM_CFG 627
+#define SLAVE_MESSAGE_RAM 628
+#define SLAVE_BIMC_CFG 629
+#define SLAVE_BOOT_ROM 630
+#define SLAVE_CNOC_MNOC_MMSS_CFG 631
+#define SLAVE_PMIC_ARB 632
+#define SLAVE_SPDM_WRAPPER 633
+#define SLAVE_DEHR_CFG 634
+#define SLAVE_QDSS_CFG 635
+#define SLAVE_RBCPR_CFG 636
+#define SLAVE_RBCPR_QDSS_APU_CFG 637
+#define SLAVE_SNOC_MPU_CFG 638
+#define SLAVE_CNOC_ONOC_CFG 639
+#define SLAVE_CNOC_MNOC_CFG 640
+#define SLAVE_PNOC_CFG 641
+#define SLAVE_SNOC_CFG 642
+#define SLAVE_EBI1_DLL_CFG 643
+#define SLAVE_PHY_APU_CFG 644
+#define SLAVE_EBI1_PHY_CFG 645
+#define SLAVE_SERVICE_CNOC 646
+#define SLAVE_IPS_CFG 647
+#define SLAVE_QPIC 648
+#define SLAVE_DSI_CFG 649
+#define SLAVE_UFS_CFG 650
+#define SLAVE_RBCPR_CX_CFG 651
+#define SLAVE_RBCPR_MX_CFG 652
+#define SLAVE_PCIE_CFG 653
+#define SLAVE_USB_PHYS_CFG 654
+#define SLAVE_VIDEO_CAP_CFG 655
+#define SLAVE_AVSYNC_CFG 656
+#define SLAVE_CRYPTO_2_CFG 657
+#define SLAVE_VPU_CFG 658
+#define SLAVE_BCAST_CFG 659
+#define SLAVE_KLM_CFG 660
+#define SLAVE_GENI_IR_CFG 661
+#define SLAVE_OCMEM_GFX 662
+#define SLAVE_CATS_128 663
+#define SLAVE_OCMEM_64 664
+#define SLAVE_PCIE_0 665
+#define SLAVE_PCIE_1 666
+#define SLAVE_PCIE_0_CFG 667
+#define SLAVE_PCIE_1_CFG 668
+#define SLAVE_SRVC_MNOC 669
+#define SLAVE_USB_HS2 670
+#define SLAVE_AUDIO 671
+#define SLAVE_TCU 672
+#define SLAVE_APPSS 673
+#define SLAVE_PCIE_PARF 674
+#define SLAVE_USB3_PHY_CFG 675
+#define SLAVE_IPA_CFG 676
+
+#endif
