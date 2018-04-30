Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpmh5DsVmWXfG9v+7A0s70xkQGh+vEhgBClRv0mgINyTMWMx/BmuErnwAnjoEuEJ8gVoOJr
ARC-Seal: i=1; a=rsa-sha256; t=1525116513; cv=none;
        d=google.com; s=arc-20160816;
        b=AbuQNK8Kit3FHoCN+HsXN6v89E5nMZ9ZmaCglbHvqSiXISDVK5Du7hRBCBoWTwYevy
         K6iKVghpC/MHyqC1Stg0tKmAxXKTFCkw4Wsz87p4gXS99NxYyN2okFZFgpsER9VNdJrd
         /UlcRNXz+skmNSeoVKKmkk5z/Ji9ZtIWGB81XJn9AFQqnii7l3t3qbOiBPLQGyhVMVZO
         MQeYunpI1wswUEsP0APYk8banyf4cXY988BA66hCQYV/qlYbT5qf2Vss7Q9LRPCfE9h5
         A1m+Zmv/2sgR2wKqqg31423nddB7BdAcjGaj78ZFhx/9Zrt0Jhe0ucv7ObeEOQF6NMLV
         4Rrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=36HfO4/q51279GysW14/5a5EcP/NeRE2duXkaKPx0Ug=;
        b=WJIYUYDIkwPb9ownI5lTdYOO9kM13PIaFN8JDILeXWLr/lvscscSiw336oFR9wzAbk
         94mOqO5mvrpW75N6jfK30XZZ7Ol/yf7OeM5pS2NviIp4iKmcjy/CqOQzrXkWbcz3dMt2
         UBT5ZfjaXNRL07A7BqIoNRGwuHkTUfAIBtxhFpyzRSjC42VctfM0Kys8TL6dB8UkQcoq
         YlwtQxToIgMZYmIaW2OPOQldHNW+jJdKq7eg1Jx1En4NYVBDZqjat3y+MjAR/mgAgS5E
         inmqDGNkkoHdQxYCyzOGDLbPdpDlavjqu9Vlrba9ML87g8fy3RRaE7knxz1Ps5PdhXzd
         ouJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830E522DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Evan Wang <xswang@marvell.com>,
	Victor Gu <xigu@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.16 072/113] PCI: aardvark: Fix PCIe Max Read Request Size setting
Date: Mon, 30 Apr 2018 12:24:43 -0700
Message-Id: <20180430184018.258016604@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200572509818955?=
X-GMAIL-MSGID: =?utf-8?q?1599200572509818955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Evan Wang <xswang@marvell.com>

commit fc31c4e347c9dad50544d01d5ee98b22c7df88bb upstream.

There is an obvious typo issue in the definition of the PCIe maximum
read request size: a bit shift is directly used as a value, while it
should be used to shift the correct value.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Evan Wang <xswang@marvell.com>
Reviewed-by: Victor Gu <xigu@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
[Thomas: tweak commit log.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pci-aardvark.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -29,6 +29,7 @@
 #define     PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT	5
 #define     PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE		(0 << 11)
 #define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT	12
+#define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SZ		0x2
 #define PCIE_CORE_LINK_CTRL_STAT_REG				0xd0
 #define     PCIE_CORE_LINK_L0S_ENTRY				BIT(0)
 #define     PCIE_CORE_LINK_TRAINING				BIT(5)
@@ -295,7 +296,8 @@ static void advk_pcie_setup_hw(struct ad
 	reg = PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE |
 		(7 << PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT) |
 		PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE |
-		PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT;
+		(PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SZ <<
+		 PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT);
 	advk_writel(pcie, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
 
 	/* Program PCIe Control 2 to disable strict ordering */
