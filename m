Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3667791-1525410070-2-8297742382343293474
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525410069; b=DHc1jqm7YSvMVFg6uoPCszzwvisk1oZGnvryZJ/fQ0xwyQ5TqX
    wfPAWVYvK7X8sxuTXJr+61Cr+IxbgwMbZ4Fl0KqZMXXE+QxhrkjYH/5u9I/2J1/m
    x9Yac6aVt7t82jg35hG9Zb5W8o0IbrM6ZFAvIHCHj6KseivhbjQQr1Ij9fZv3VBd
    F1hSZlH5+wgTB8teDXKJeimG0eRyIqcfn/3KEYOI16yLQ4G5mvVkTXkeHyEBODXP
    +lbaUeVGnayk/S+wsn3HWwlFVjZFd/wLLIw/WXo870Oqxjmz9BJQQnguTOOa1St1
    4WGhYI+zzFEUk5YGU2UplecKdnDl9txC6fkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525410069; bh=M2DFI
    X288rETHhja4nRtIF44VqU0ORDiT3jazHPwZuM=; b=cYKyR+4149jz0WxDZlXEZ
    wqpJxgfHs01NnQY/MrYkqjEu79nHiNiQpm05yioCzOwbyrBs/lHfcLNggZ3li+7T
    +6Fs1RRvX6Njo2KuhtbOg1otWsSN8HhfU8DBszxZjVyXbGQhVhZxNxKIxFehx0iA
    rss61g4JxdFnl8Iee68Te6T3bQ9W0jXoAGoE+Jgd6yuhVWRQZFWMdcg9cV59nrS5
    OfOSkd9hnlHYDA5Ky7UzIdPNXsuAzS2jml/T+HMkFE+/cdO7/LcfER1MX07Mb1/F
    fZst7nWlEjsZ+EX785pzSdcz8MqAesPBSX6uk2+7LapegNpb+iJwnAqQCgrvviOk
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=brown.name header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=brown.name header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB2X25ksRchw3iq4MmzrgrRXSUBj54LenkSzPAa+AwuS73WHftb4mpJEgmL/uTI7Jm3u1lp9IpRxT5wcHo8aXzNYYZPtpqoskHWs+CRLYD3BaJinTUVU
    s+arg2AIeUc4L4FNOXr4wm7U9tg3CFhIE0q1fox7/wwXSDniGoNxwoz1037aIwWIYr+ce8V3HfDoLdZv90iXWyUjw4eL18IGQxawfJjoB/z2oifoh6UVjb2g
    JD/AQXH123z7MRA718IGLg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=VUJBJC2UJ8kA:10 a=qEKT6kP3PEYA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ZZnuYtJkoWoA:10 a=DDOyTI_5AAAA:8 a=jCHawt1mkOhekbYsmXoA:9
    a=ULmsQtJGQJf4d5jO:21 a=3Tg21ec0rfKtkRmk:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 04 May 2018 14:58:36 +1000
Subject: [PATCH 3/8] staging: mt7621-pci: improve interrupt mapping
Message-ID: <152540991599.12190.16303092955078809939.stgit@noble>
In-Reply-To: <152540982998.12190.15220622955317261586.stgit@noble>
References: <152540982998.12190.15220622955317261586.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As the Interrupts for the PCI adapters are listed in
devicetree we shouldn't need to have them explicit in the code.

The simplest way to do this is to use of_irq_parse_and_map_pci()
and specify an interrupt-map which identifies the different
PCI hosts by bus/slot numbers.
This has the advantage that the hwirq number are mapped to virq
numbers for us, so the ugly hack can go.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-dts/mt7621.dtsi  |    9 ++-
 drivers/staging/mt7621-pci/pci-mt7621.c |   90 +++----------------------------
 2 files changed, 14 insertions(+), 85 deletions(-)

diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt7621-dts/mt7621.dtsi
index ebcaa8b1fc81..9d941b531712 100644
--- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -429,10 +429,11 @@
 			0x01000000 0 0x00000000 0x1e160000 0 0x00010000 /* io space */
 		>;
 
-		interrupt-parent = <&gic>;
-		interrupts = <GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH
-				GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH
-				GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0xF0000 0 0 1>;
+		interrupt-map = <0x10000 0 0 1 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
+				<0x20000 0 0 1 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
+				<0x30000 0 0 1 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
 
 		status = "disabled";
 
diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index c49442c9b187..cc89d464ef7f 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -73,12 +73,6 @@ extern void chk_phy_pll(void);
 
 #define RALINK_PCI_CONFIG_ADDR                         0x20
 #define RALINK_PCI_CONFIG_DATA_VIRTUAL_REG     0x24
-#define SURFBOARDINT_PCIE0       11      /* PCIE0 */
-#define RALINK_INT_PCIE0         SURFBOARDINT_PCIE0
-#define RALINK_INT_PCIE1         SURFBOARDINT_PCIE1
-#define RALINK_INT_PCIE2         SURFBOARDINT_PCIE2
-#define SURFBOARDINT_PCIE1       31     /* PCIE1 */
-#define SURFBOARDINT_PCIE2       32     /* PCIE2 */
 #define RALINK_PCI_MEMBASE              *(volatile u32 *)(RALINK_PCI_BASE + 0x0028)
 #define RALINK_PCI_IOBASE               *(volatile u32 *)(RALINK_PCI_BASE + 0x002C)
 #define RALINK_PCIE0_RST                (1<<24)
@@ -367,68 +361,12 @@ pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	u16 cmd;
 	u32 val;
-	int irq = 0;
-
-	if ((dev->bus->number == 0) && (slot == 0)) {
-		write_config(0, 0, 0, PCI_BASE_ADDRESS_0, MEMORY_BASE);
-		read_config(0, 0, 0, PCI_BASE_ADDRESS_0, (unsigned long *)&val);
-		printk("BAR0 at slot 0 = %x\n", val);
-		printk("bus=0x%x, slot = 0x%x\n",dev->bus->number, slot);
-	} else if((dev->bus->number == 0) && (slot == 0x1)) {
-		write_config(0, 1, 0, PCI_BASE_ADDRESS_0, MEMORY_BASE);
-		read_config(0, 1, 0, PCI_BASE_ADDRESS_0, (unsigned long *)&val);
-		printk("BAR0 at slot 1 = %x\n", val);
-		printk("bus=0x%x, slot = 0x%x\n",dev->bus->number, slot);
-	} else if((dev->bus->number == 0) && (slot == 0x2)) {
-		write_config(0, 2, 0, PCI_BASE_ADDRESS_0, MEMORY_BASE);
-		read_config(0, 2, 0, PCI_BASE_ADDRESS_0, (unsigned long *)&val);
-		printk("BAR0 at slot 2 = %x\n", val);
-		printk("bus=0x%x, slot = 0x%x\n",dev->bus->number, slot);
-	} else if ((dev->bus->number == 1) && (slot == 0x0)) {
-		switch (pcie_link_status) {
-		case 2:
-		case 6:
-			irq = RALINK_INT_PCIE1;
-			break;
-		case 4:
-			irq = RALINK_INT_PCIE2;
-			break;
-		default:
-			irq = RALINK_INT_PCIE0;
-		}
-		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n",dev->bus->number, slot, dev->irq);
-	} else if ((dev->bus->number == 2) && (slot == 0x0)) {
-		switch (pcie_link_status) {
-		case 5:
-		case 6:
-			irq = RALINK_INT_PCIE2;
-			break;
-		default:
-			irq = RALINK_INT_PCIE1;
-		}
-		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n",dev->bus->number, slot, dev->irq);
-	} else if ((dev->bus->number == 2) && (slot == 0x1)) {
-		switch (pcie_link_status) {
-		case 5:
-		case 6:
-			irq = RALINK_INT_PCIE2;
-			break;
-		default:
-			irq = RALINK_INT_PCIE1;
-		}
-		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n",dev->bus->number, slot, dev->irq);
-	} else if ((dev->bus->number ==3) && (slot == 0x0)) {
-		irq = RALINK_INT_PCIE2;
-		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n",dev->bus->number, slot, dev->irq);
-	} else if ((dev->bus->number ==3) && (slot == 0x1)) {
-		irq = RALINK_INT_PCIE2;
-		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n",dev->bus->number, slot, dev->irq);
-	} else if ((dev->bus->number ==3) && (slot == 0x2)) {
-		irq = RALINK_INT_PCIE2;
-		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n",dev->bus->number, slot, dev->irq);
-	} else {
-		printk("bus=0x%x, slot = 0x%x\n",dev->bus->number, slot);
-		return 0;
+	int irq;
+
+	if (dev->bus->number == 0) {
+		write_config(0, slot, 0, PCI_BASE_ADDRESS_0, MEMORY_BASE);
+		read_config(0, slot, 0, PCI_BASE_ADDRESS_0, (unsigned long *)&val);
+		printk("BAR0 at slot %d = %x\n", slot, val);
 	}
 
 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 0x14);  //configure cache line size 0x14
@@ -436,20 +374,10 @@ pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	cmd = cmd | PCI_COMMAND_MASTER | PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
 	pci_write_config_word(dev, PCI_COMMAND, cmd);
+
+	irq = of_irq_parse_and_map_pci(dev, slot, pin);
+
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
-#ifdef	CONFIG_DTB_GNUBEE1
-	/*
-	 * 'irq' here is a hwirq, but a virq is needed.  Until we know how and where
-	 * to convert one to the other, we have this hack for the GNUBEE1
-	 * Similarly 31->23 and 32->24.
-	 */
-	if (irq == 11)
-		return 22;
-	if (irq == 31)
-		return 23;
-	if (irq == 32)
-		return 24;
-#endif
 	return irq;
 }
 


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
