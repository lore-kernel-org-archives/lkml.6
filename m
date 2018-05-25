Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968058AbeEYTZq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:25:46 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46884 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967587AbeEYTZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:25:45 -0400
X-Google-Smtp-Source: AB8JxZqXwW2Rjkns96TL0xfsu/Ql6I5aSOKIbv9SySTPt748lpVwXCsafS9+QGG3Avbhbw0gxCMDdQ==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable PCIe on msm8996 and db820c
Date: Fri, 25 May 2018 12:25:41 -0700
Message-Id: <20180525192541.12223-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msm8996 PCIe sits behind the "agnoc0", which is represented as a
simple-pm-bus, so enable support for this. Then enable the QMP phy
driver.

Also enable the atl1c ethernet driver and ath10k wlan driver to support
these components on the DragonBoard820c.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 895b2d92124d..e3687afdd64c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -173,6 +173,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
+CONFIG_SIMPLE_PM_BUS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
@@ -213,6 +214,7 @@ CONFIG_VETH=m
 CONFIG_VIRTIO_NET=y
 CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
+CONFIG_ATL1C=m
 CONFIG_MACB=y
 CONFIG_THUNDER_NIC_PF=y
 CONFIG_HNS_DSAF=y
@@ -254,6 +256,8 @@ CONFIG_USB_NET_SMSC75XX=m
 CONFIG_USB_NET_SMSC95XX=m
 CONFIG_USB_NET_PLUSB=m
 CONFIG_USB_NET_MCS7830=m
+CONFIG_ATH10K=m
+CONFIG_ATH10K_PCI=m
 CONFIG_BRCMFMAC=m
 CONFIG_MWIFIEX=m
 CONFIG_MWIFIEX_PCIE=m
@@ -615,6 +619,7 @@ CONFIG_PHY_HI6220_USB=y
 CONFIG_PHY_QCOM_USB_HS=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_MVEBU_CP110_COMPHY=y
+CONFIG_PHY_QCOM_QMP=m
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_EMMC=y
 CONFIG_PHY_ROCKCHIP_PCIE=m
-- 
2.17.0
