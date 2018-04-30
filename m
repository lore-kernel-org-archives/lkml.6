Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrNQpJELMSP3gnlsr+jxG82q//8VuUdMDXBkB8Bmbly+dF/FuWoPhEq1ZoCw6JSeQNONRfH
ARC-Seal: i=1; a=rsa-sha256; t=1525116450; cv=none;
        d=google.com; s=arc-20160816;
        b=0ujoo3Th1riq6aXX3Imo/XWifzr1+sPVSqFn/oJG3TiBjcciBvII4y0XUw7NID1ynm
         /rxL3rhc8I+Vj1tNOHkk914sl7BkBgUpaoUDKzkaCZm7vYO1tzIVYcEk1SF6Vi+4Gpi9
         hziej0Wo6evYTJo1OG+MW9gIAx/aAMDPnWbGXuc9IpbLIab8Ps2xUj4QzQeh4mx/M30X
         a7M1qs0VYPqxogwsIjaXK46S5+I61+CpIXexK96W8zv+dxF4YXIP/WYRiWMNYxbfFTjr
         cgpQ+mgKMr41pV3fFMADuyQJR16MxoQCcXiUNh61KceGOk2Pf9dKu+GCUgBmWEudai4B
         gsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=+ZmhvW+3D5eGeYgk1QNvHg1FkL+TpwgHGmstgRgiyCw=;
        b=Dt3u2edlyV8PH9v/gAxe7Lt3mcl9YOeA5TQkESgUfKCHisfW+oS8lxKKshebXUvZtf
         sG6yyBb/qbZDcdtnPG8Ykf3d0BvwW0wJ/zjFK00GogZJWuGyASPirMyHRqz01AeCNzrT
         bvPEpMF24XzNW0PHeeIDWvlmtwuJPuzOKwx0Z8aoSKAh9lg56nInr96+fKkrrRH0emMc
         rUYH4D4haGCtItQzb05E/DKJM1E+eiXBmQjKl+ORZwHOy8v9fT3Z7lLjZ71vE9DUTuSF
         uYeVxmIax52lNT00AB3MN/qWA/S5f0viFNGduVISYGwTQg54MEU2v7nmwaZMplwWPp9t
         EWAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B018F22DC1
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
Subject: [PATCH 4.14 63/91] PCI: aardvark: Fix PCIe Max Read Request Size setting
Date: Mon, 30 Apr 2018 12:24:45 -0700
Message-Id: <20180430184007.441875556@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200572509818955?=
X-GMAIL-MSGID: =?utf-8?q?1599200506695385825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -32,6 +32,7 @@
 #define     PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT	5
 #define     PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE		(0 << 11)
 #define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT	12
+#define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SZ		0x2
 #define PCIE_CORE_LINK_CTRL_STAT_REG				0xd0
 #define     PCIE_CORE_LINK_L0S_ENTRY				BIT(0)
 #define     PCIE_CORE_LINK_TRAINING				BIT(5)
@@ -298,7 +299,8 @@ static void advk_pcie_setup_hw(struct ad
 	reg = PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE |
 		(7 << PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT) |
 		PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE |
-		PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT;
+		(PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SZ <<
+		 PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT);
 	advk_writel(pcie, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
 
 	/* Program PCIe Control 2 to disable strict ordering */
