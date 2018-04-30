Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq1QEmL4ccDYKfiGA7SxemCQM0GozExEWQZurKRWhFVFzxE4B7GmM8A06Xe/d9HvIKSDi0O
ARC-Seal: i=1; a=rsa-sha256; t=1525116511; cv=none;
        d=google.com; s=arc-20160816;
        b=Y1urRB6H2HQW7D9bkZMB0JSSORiK6RABG7QmHQeGhqbbCsLHk8EHdhXmTD7qgUiv0N
         OzuxcvGuZ9aa4U4HRYzt6CRvm9uf0hwX8Pn+X+n9e6ybxgL4oMC6qyT5o2/0K700nF4Z
         6ngBO8ujEEsWoUN8uuMQ0IaMmS9sBXzDVaRPva1baigyT6IkJKIOAf02w6OIAoVvJ4nh
         2aGZduEx2CpSdH9XQSlqqxFyNqUPm+BKNmfLsnazDnMW79QYHk/yCqsW1iYiV53bKSGh
         JLxr08uYjtrIW0ttvFgg+p2c45oxMVh558luIpXv4dKGfvDXFd/ZwE9Oyt5M+tuE/K9v
         64Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=lzipe47cCOJN3hupaiXh6s8k0v0wlJ3kLO8jp7eoWNs=;
        b=HwJQjYV+1pxBVwJ/9FI+/VxCTLpQKee+rIp4bQZa4CNl4b84p57WMopRiU0sKFesEz
         vxOSAI5ILMH1/7Zfa0hhKR1f/Xzw3vteCpYjvGi8q0Q0VMuIcP0EhvyqUK29xVPJcRys
         D+i/x0KmlESVG0hOxLJQb5oFr4x0n/FGqD85T2zXgDycKCx6Fd3FiSgVinOvboO3h1W5
         rgiagvvM3RvmiPwLJtfstOy97toxTefmepdSKW/RSFYCQ+k1MPYpqceiD9lU0WkvUELe
         4VIh1xoCa94dRfo/Q2inQRGDwxmNcPtxzrSNkUwYWTVS9HBvm246afEnUnUBR1yNrSWC
         A11w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4424222DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Victor Gu <xigu@marvell.com>,
	Wilson Ding <dingwei@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.16 070/113] PCI: aardvark: Set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
Date: Mon, 30 Apr 2018 12:24:41 -0700
Message-Id: <20180430184018.181832334@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200464256377805?=
X-GMAIL-MSGID: =?utf-8?q?1599200571831504364?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Victor Gu <xigu@marvell.com>

commit 4fa3999ee672c54a5498ce98e20fe3fdf9c1cbb4 upstream.

When setting the PIO_ADDR_LS register during a configuration read, we
were properly passing the device number, function number and register
number, but not the bus number, causing issues when reading the
configuration of PCIe devices.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Victor Gu <xigu@marvell.com>
Reviewed-by: Wilson Ding <dingwei@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
[Thomas: tweak commit log.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pci-aardvark.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -172,8 +172,6 @@
 #define PCIE_CONFIG_WR_TYPE0			0xa
 #define PCIE_CONFIG_WR_TYPE1			0xb
 
-/* PCI_BDF shifts 8bit, so we need extra 4bit shift */
-#define PCIE_BDF(dev)				(dev << 4)
 #define PCIE_CONF_BUS(bus)			(((bus) & 0xff) << 20)
 #define PCIE_CONF_DEV(dev)			(((dev) & 0x1f) << 15)
 #define PCIE_CONF_FUNC(fun)			(((fun) & 0x7)	<< 12)
@@ -456,7 +454,7 @@ static int advk_pcie_rd_conf(struct pci_
 	advk_writel(pcie, reg, PIO_CTRL);
 
 	/* Program the address registers */
-	reg = PCIE_BDF(devfn) | PCIE_CONF_REG(where);
+	reg = PCIE_CONF_ADDR(bus->number, devfn, where);
 	advk_writel(pcie, reg, PIO_ADDR_LS);
 	advk_writel(pcie, 0, PIO_ADDR_MS);
 
