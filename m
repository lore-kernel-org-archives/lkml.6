Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoTxJ5tNmBalwcw9+iurOG8POD4Gen2qBTF5dSJteAcZTQ1raeXrdqL9TkF4RZKPcs/GyI8
ARC-Seal: i=1; a=rsa-sha256; t=1525116448; cv=none;
        d=google.com; s=arc-20160816;
        b=Mjx0dvDQ1CSuQl/NhfQLlHvTGS5lql5I3JnLdZKFz75YhDFryqBmh0JnGmbok0WmZ/
         qEG6ju1kWHObO0/c4ka4ka95AqfEwfy8HbDWZMbCikpHXhAQwXkeFzdmqbwAuCGnfcOl
         wGSJ81FRbKPlt4a7HHdMA21mHj1ZMvCW7iJWENbHTbiW+7vRMxyepi6BcfwQYG78y6fr
         Wq07Rn4Z4Bib4lsqZt1nqFst8vxGwUhL6JwgvZH9Ut//zmErG6X01udijdy/TZue4NQW
         tinn/EoPlwgePeRuOv2bCoPdycU3WvXxk1Pbf+E96Meijo/snj8QFJxKLuKLGfnnWjxR
         iTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=0X9NAwGzEfxFUCrK0sBJrnNHz38SFchcONvnAkqNcbA=;
        b=zMM4+lnX4RMIz9A0ABPx0+V2owUKI+oMb2q5sqwUJSjdY2lVMGGT71HHumUEXE9Fbu
         SHwnGD1qPCvabsed67DzaS8XBhxq56uMVCznpMuDiTuid7cCIEVvhLYs0ffpX+UPbkJn
         E/SNu3VEEs9Zcl1tGadGBXcSjZZtfp5xLIvaNyoO5x1OFsayA2LX7J4Ce480pCpZSbXR
         4mBmb/ne4X1+TJgMDi7Bfsa/Sb7+UsGKEMz2gB0MzJAf8EeLnUTaJndWBQWZhcOzkWAc
         nFsj6V8ZG1ylu+mUcA4ZJ3cSuHO4oI8yNGuon3CmMr+JZDr5vBNmgChwlc7N/rWZkbCR
         g3Gw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311F222DBF
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
Subject: [PATCH 4.14 61/91] PCI: aardvark: Set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
Date: Mon, 30 Apr 2018 12:24:43 -0700
Message-Id: <20180430184007.357954537@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200464256377805?=
X-GMAIL-MSGID: =?utf-8?q?1599200505268076190?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -175,8 +175,6 @@
 #define PCIE_CONFIG_WR_TYPE0			0xa
 #define PCIE_CONFIG_WR_TYPE1			0xb
 
-/* PCI_BDF shifts 8bit, so we need extra 4bit shift */
-#define PCIE_BDF(dev)				(dev << 4)
 #define PCIE_CONF_BUS(bus)			(((bus) & 0xff) << 20)
 #define PCIE_CONF_DEV(dev)			(((dev) & 0x1f) << 15)
 #define PCIE_CONF_FUNC(fun)			(((fun) & 0x7)	<< 12)
@@ -459,7 +457,7 @@ static int advk_pcie_rd_conf(struct pci_
 	advk_writel(pcie, reg, PIO_CTRL);
 
 	/* Program the address registers */
-	reg = PCIE_BDF(devfn) | PCIE_CONF_REG(where);
+	reg = PCIE_CONF_ADDR(bus->number, devfn, where);
 	advk_writel(pcie, reg, PIO_ADDR_LS);
 	advk_writel(pcie, 0, PIO_ADDR_MS);
 
