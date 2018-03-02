Return-Path: <richard.gong@linux.intel.com>
X-Google-Smtp-Source: AG47ELsKN6mKPr7r2wfja0xq/mCqohkOc6k1mTBuZ+Sd9m4l+o+aOvkgAkens11bBa3ttH6nzXaX
ARC-Seal: i=1; a=rsa-sha256; t=1519950215; cv=none;
        d=google.com; s=arc-20160816;
        b=tk4Rfd3le1wco4+gq5xtR7TLbkgHD/2gHgcuneovBn3QWlNr3KvOfApxI4vzOMVoMj
         dMNDOXwEtP+nMDURUhj0GCAOEEDDY2in5bfgw++ZbND/Y4t24ZXeGtqg7oGb6O93Yp6B
         0DHelSgsYbauxCPrUZ/zwDX4b2aa4jWKe8zk4WPs2Xp7goXcGSNmYdnil9rcStMuXVks
         DkVF5BZD6om9Yxvcwdk7PQbx1IB/79oaGOrM4LFGKLuYfnPRU1VQCPbdXqVZj+9PGld4
         RUHNAPNPFAX3IipBX+7AubMGaMJMwYCn+gXlsG+FSkK2lqrwVUwX/5Ui0TjweDm9aa0a
         XFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=pBN1YMAcGO98BYPXF0cVRo6eOcWlrl9rQLh+1DfGofU=;
        b=ayw5ZntknDCW5/rHXfqSSbZfGSYT1pXWz/4FecJQi4JRDGo2ahjeDBGmR+IqjKv9kE
         o1y6sfuGkWmKUnqqTcgKwW/cE8dq5Ecrta3gpvk/zLMrRoXS3KUOHJmx7hUB771xU2FO
         7AKR+BQdWRBofV/3qmYddlby06uLov9qWLxO8heunPFa9Njf9YbzFYO1wv1Sg8IzN9MV
         PnzGI5e/92pmKfDUvDRyHRj38qwG4kcYOZMaGraqTeJo5UxB1BF2Jj0DrAPoDvEBsIN+
         0bFsNVCMVPlmAG9NbjYJpVGcW7po5ihOquM3edBZq3s1a8t7Ba1kVDZlqaPIP6Pq2p5A
         fg4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="35279681"
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
	Richard Gong <richard.gong@intel.com>
Subject: [PATCHv2 7/7] defconfig: enable fpga and service layer
Date: Thu,  1 Mar 2018 18:19:35 -0600
Message-Id: <1519949975-13548-8-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593783316545310604?=
X-GMAIL-MSGID: =?utf-8?q?1593783316545310604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

Enable fpga framework, Stratix 10 SoC FPGA manager, and Intel Service Layer

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: this patch is added in patch set version 2
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
