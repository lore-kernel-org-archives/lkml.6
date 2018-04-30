Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpT7nfNthuTavearPra2fDlToGbJsgZ0J2nQYcylwO2C/looBHujiSQNGadowc/dzCHLZ93
ARC-Seal: i=1; a=rsa-sha256; t=1525116409; cv=none;
        d=google.com; s=arc-20160816;
        b=xy1LCJIPazmYj/b/22QmXfhqMu0GwIKSTOGrVWFA103aEVqrB9s5F/+RByuc14jbLN
         lmkgVEwgFTsOoqhnLUKxqhiy9Ttp9bgKlUvm8Ty1REuVvLTezkxkSaU0JFXzt9ALdItd
         TIsJr981PpDCgSmifHQD9Oye/J38V91OBJM+UAXWx69pVqoWoW22Nurbz/dgZXBt/zUN
         Ngr2K7BFQJvoc49W8ip8sn43mhChgoGqlOjxbQ8d8aVQ5zcZ9y4LEwUmFS3JXkqx8+ky
         oJHsf1vVLu2GPU+MY07Wy4/01XoSL1hAr17lH0iYMgUfzj6jkMS7TLJx0sdLOnDSFCcZ
         YlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=CxEa+KOqxqkRUQ+g81IZMLTIKp7TQEo2ppFwcFYNxWw=;
        b=x8ir1bd0QQhhWNq276R3UaE76JLXCTAJaOaJaEqycfMGy5rmSxCRldfP7y6JCUjGvo
         pf4o8xDm7yaFqtHAKSkuAfc1m07n9t18rhh9nSadSFSJMCCSNub06ZRXTbC6iI9lBnty
         hKBuPbqKBSfkF6wTj4x7B0UQhOYQ3mhjSUaQNHB9GFGFlC//GnNSGzKgsONTjby1Q/Kn
         VdSeUudDNJrJglcxMhlqVW8zgI/565ZDMTTascuZlGDv0lzQFTN4t/3ZdwjQw9O70l1a
         bIrZbGfNdznU5YhB6QoT4qEg7JJt0JrrmXqpqWTebgpyO4ICig6xECS5MCnAdy616Qkq
         N11w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AB522DBF
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
Subject: [PATCH 4.9 42/61] PCI: aardvark: Set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
Date: Mon, 30 Apr 2018 12:24:45 -0700
Message-Id: <20180430183954.895591878@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200464256377805?=
X-GMAIL-MSGID: =?utf-8?q?1599200464256377805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -458,7 +456,7 @@ static int advk_pcie_rd_conf(struct pci_
 	advk_writel(pcie, reg, PIO_CTRL);
 
 	/* Program the address registers */
-	reg = PCIE_BDF(devfn) | PCIE_CONF_REG(where);
+	reg = PCIE_CONF_ADDR(bus->number, devfn, where);
 	advk_writel(pcie, reg, PIO_ADDR_LS);
 	advk_writel(pcie, 0, PIO_ADDR_MS);
 
