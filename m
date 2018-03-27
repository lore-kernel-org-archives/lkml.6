Return-Path: <richard.gong@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/kBFznn3c4tvuXVokSY6FgxBrS/amcv4/1KgTqTnJ1gpNZPZn6rdeN0YHx/R8HVhEPTl7a
ARC-Seal: i=1; a=rsa-sha256; t=1522182240; cv=none;
        d=google.com; s=arc-20160816;
        b=MWIXMuKrMKORSEs+RvTLoCxJSiiEAyX3e4DwjrGax7v8uEvZ09NPK740oRK4p8971e
         lOXY1Yc/fw3wXJm6k3/7Gg0twtjh0ie+j8K3cN8wqX5i4J/L/F5nCLQGhLBNbppNtIbF
         rjYMlKXaVvz657iyQrx9yvK4XvSWYhBG9efuOafXToYQt8Px7c4Osny7I8++LW4IZiSa
         /zDF1Hm0YfrkDBlWJLH6zeKiL2ijDCG9biGtiStM7E8sc6mTpzInLa5ihh4G/1ARtFZC
         IBJM0m6VoQGLyFyqEqFHstFKOQx0WPjfbn/hAg2f6h2CF+9AR/n/uGMIMQRcMeb6cpmb
         7JNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=LAonW7hBloZwU6+Yr1kR3n4bA4Q6TJCecOKpo0Nul+E=;
        b=dYrim4cRFBzRyKQPIu5vetTdWsx+mkf5NXSHdcAPkCJmgvMlEjYEgD7Rus7PX3lNJL
         3xpUCjHy9z1oG3wOL6qyrUyAHbFbeqkDUW1gp+slNHes4kLvdqeVmeD7XKawu5LuUa9A
         EZK2l5B5/woxU1JmmyljQvWmHQ3eXM1OzjBtZP1WaBlL9e+efg2CRSfgo34D7eE8fHDs
         B7Cm9EuIS3p9G2eLKOCdqkCFBuuo+PX0o0FS7ik3d3C0z3UHotzyo6Dz7c+PV0PYAPkI
         S7FguOky/AgxvbrYjzl0Mjvg5bAR8c5LCm3o61ce4QqNPYGcQmuqwkC2EwqZrnyUosPq
         6qFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,368,1517904000";
   d="scan'208";a="215401755"
From: richard.gong@linux.intel.com
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	dinguyen@kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	atull@kernel.org,
	mdf@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	yves.vandervennet@linux.intel.com,
	richard.gong@linux.intel.com,
	richard.gong@intel.com
Subject: [PATCHv3 7/7] defconfig: enable fpga and service layer
Date: Tue, 27 Mar 2018 15:20:14 -0500
Message-Id: <1522182014-7338-8-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596123765147512132?=
X-GMAIL-MSGID: =?utf-8?q?1596123765147512132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

Enable fpga framework, Stratix 10 SoC FPGA manager, and Intel Service Layer

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: this patch is added in patch set version 2
v3: no change
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 634b373..44b226b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -169,6 +169,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_NVME=m
+CONFIG_INTEL_SERVICE=y
 CONFIG_SRAM=y
 CONFIG_EEPROM_AT25=m
 # CONFIG_SCSI_PROC_FS is not set
@@ -559,6 +560,10 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_EMMC=y
 CONFIG_PHY_ROCKCHIP_PCIE=m
 CONFIG_PHY_XGENE=y
+CONFIG_FPGA=y
+CONFIG_FPGA_REGION=y
+CONFIG_FPGA_MGR_STRATIX10_SOC=y
+CONFIG_FPGA_BRIDGE=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
-- 
2.7.4
