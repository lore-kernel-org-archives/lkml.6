Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3667791-1525410095-2-6641860621173489952
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525410093; b=gxVWKZqyXuZ7roBh1qMzLi5yAN3MoCLFC/Zo57gbcLVDIVQpZ3
    0YZOOQNAM8M/s7lpVzM9ellV5FoJp2vdvW9tTW/9uyqzedFqvkE9Vrfi5CnMxJ5t
    TDzAwpa0vJeRC5aRZFEnts48apHgOagnDzIGZ3dlKSm+KtrcJhx7nuRer0L+Qs48
    s1AlOtY7NPqXSHDGR6K3MKpaynMQ19jag/MGa+eSadlAt27NnDiHTM9NItbv3MvE
    g0BtymkBpeGaj6nCOVOge8Og1CmOlnsjSqO77/dqcQe5jJwPOrTxopF3F5al3SqW
    4NBV0RZj7FnSL8beUe0A4SKVAvnJiHFcrlIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525410093; bh=LNkIG
    o+DyokIiNMDxvLvL4GdVzwwpvNa0lp0t4zEqCI=; b=FruYmS4wFZV2ZZAn8mBsX
    RwiWpasle/05OhKTrfedB4NlxQLifTtcnbUOurOWfTSjxbNcv5xUKzq4XDC6GTtN
    OoWnh2Nby2UtQ1cNwoKwVuEywD4z4SkgmOmHrjcOfAv8pFgmTe9YWXf4FABHgkuC
    MaXiQiTUgjl+WVvo02pXIuzbGgE7qvRP2fubICH5qYCR8mDZnfv70VYNxBWzM9va
    L8Sx4ReA+3QyEFjgJNk/pX3mc/LeywFCQHXfMk9U7ChzsOY7QCUe6uBtGHPo1BVE
    Oh7++cbe1lFuTriGN1Dn7GPCjIOceVzqu/9Pd6eueeCGTq+m+XJfLzTKbvupsjfd
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=brown.name header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=brown.name header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEEeRsZa9MzW5GX2GYkjeD7BniMcFYL7mSi7oBe/Kwn9tL4ctT+q7k/SHuP0UVsiOhyfzq/RujRfy9SztC/3F+qtcW8d8Swq6ctVHhlV9rmKTHk52o6Y
    1ZJVYL8lELRAtc4mxSBdsmHjbqBwRpTCuRltybZ1pX8Ya51SMS1zEaqxvMVT/t9p5kY5KrGqYgVqt8kLEBkpe61tqpGQd9hz1SDLeumIpn+xsjcBNXc7ixZD
    5DsLmZJZqRfBOYJHoilxxQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=VUJBJC2UJ8kA:10 a=qEKT6kP3PEYA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ZZnuYtJkoWoA:10 a=DDOyTI_5AAAA:8 a=hvb4E0EZvg1QZLyvD4QA:9
    a=tgLVWfHEyX5EvBOS:21 a=fS--FbwQ45HYDDQC:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 04 May 2018 14:58:36 +1000
Subject: [PATCH 7/8] staging: mt7621-pci: remove some dead code.
Message-ID: <152540991631.12190.9879547396075931701.stgit@noble>
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

Some code is dead because it is commented out.
Some is dead because it is uninteresting printks.
Some is dead because it declares unused functions.

Remove it all.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-pci/pci-mt7621.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 5094e90eaf69..edd95013faf3 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -56,9 +56,6 @@
 
 #include <ralink_regs.h>
 
-extern void pcie_phy_init(void);
-extern void chk_phy_pll(void);
-
 /*
  * These functions and structures provide the BIOS scan and mapping of the PCI
  * devices.
@@ -364,11 +361,8 @@ pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 void
 set_pcie_phy(u32 *addr, int start_b, int bits, int val)
 {
-//	printk("0x%p:", addr);
-//	printk(" %x", *addr);
 	*(unsigned int *)(addr) &= ~(((1<<bits) - 1)<<start_b);
 	*(unsigned int *)(addr) |= val << start_b;
-//	printk(" -> %x\n", *addr);
 }
 
 void
@@ -497,7 +491,6 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	val |= RALINK_PCIE2_RST;
 
 	ASSERT_SYSRST_PCIE(RALINK_PCIE0_RST | RALINK_PCIE1_RST | RALINK_PCIE2_RST);
-	printk("pull PCIe RST: RALINK_RSTCTRL = %x\n", RALINK_RSTCTRL);
 
 	*(unsigned int *)(0xbe000060) &= ~(0x3<<10 | 0x3<<3);
 	*(unsigned int *)(0xbe000060) |= 0x1<<10 | 0x1<<3;
@@ -513,12 +506,10 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	val |= RALINK_PCIE2_RST;
 
 	DEASSERT_SYSRST_PCIE(val);
-	printk("release PCIe RST: RALINK_RSTCTRL = %x\n", RALINK_RSTCTRL);
 
 	if ((*(unsigned int *)(0xbe00000c)&0xFFFF) == 0x0101) // MT7621 E2
 		bypass_pipe_rst();
 	set_phy_for_ssc();
-	printk("release PCIe RST: RALINK_RSTCTRL = %x\n", RALINK_RSTCTRL);
 
 	read_config(0, 0, 0, 0x70c, &val);
 	printk("Port 0 N_FTS = %x\n", (unsigned int)val);
@@ -614,8 +605,6 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 		RALINK_PCI_PCICFG_ADDR |= 0x1 << 24;	//port2
 		break;
 	}
-	printk(" -> %x\n", RALINK_PCI_PCICFG_ADDR);
-	//printk(" RALINK_PCI_ARBCTL = %x\n", RALINK_PCI_ARBCTL);
 
 /*
 	ioport_resource.start = mt7621_res_pci_io1.start;
@@ -653,7 +642,6 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 	case 7:
 		read_config(0, 2, 0, 0x4, &val);
 		write_config(0, 2, 0, 0x4, val|0x4);
-		// write_config(0, 1, 0, 0x4, val|0x7);
 		read_config(0, 2, 0, 0x70c, &val);
 		val &= ~(0xff)<<8;
 		val |= 0x50<<8;
@@ -663,7 +651,6 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 	case 6:
 		read_config(0, 1, 0, 0x4, &val);
 		write_config(0, 1, 0, 0x4, val|0x4);
-		// write_config(0, 1, 0, 0x4, val|0x7);
 		read_config(0, 1, 0, 0x70c, &val);
 		val &= ~(0xff)<<8;
 		val |= 0x50<<8;
@@ -671,7 +658,6 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 	default:
 		read_config(0, 0, 0, 0x4, &val);
 		write_config(0, 0, 0, 0x4, val|0x4); //bus master enable
-		// write_config(0, 0, 0, 0x4, val|0x7); //bus master enable
 		read_config(0, 0, 0, 0x70c, &val);
 		val &= ~(0xff)<<8;
 		val |= 0x50<<8;


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
