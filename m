Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052D9C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A268216E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="k1mIPfs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A268216E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeHOJNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 05:13:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37382 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeHOJNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 05:13:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id a26-v6so125723pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 23:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=g+ISm1ljg5V9oSRH1mbU49cY1vHYHrKukNYhfZdZ2lU=;
        b=k1mIPfs2Bc2qwcrWJkOBwPLDge+EPhmEUI7a4brw/Q8Je4CJwcubRdcS6rp2Q8to3H
         QEIuYIGD3i4KV/3xbEFI7wptvOAo3utQMIyl8f3Z3CUxdQSg1kSzbDneYVQpWP1bq5Jb
         pdgsIArjpoX40xJlVFfhHnSHt2W+DaCVlytIgyOjkua30iT5siP1jENkk/yRJPX2WqWs
         OJM+dyUpIBaMb1Za2KDAJA9alpf7LWfVjJvzoQmUaw34y5YCF+0LR/FW3SuoA+q+URMM
         SFZEY6IeBv5jVvq4SiPrjn8zRIo4/u1NhJZ7B86gfJg8Tou1POTiSR9LrqNg0TIE1yq8
         X49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g+ISm1ljg5V9oSRH1mbU49cY1vHYHrKukNYhfZdZ2lU=;
        b=AX7ys84bSRoEDHpEwDbdFVnunzrsZmzAeEo44auSwh1t75QIVeoWvNW4rnT4cXwsE/
         IY1P41HEcEsWAtGbvgoQOxOVMwp5UHl5Cy77vIez/cNf3KxBQ393N02IHBuM7TCUODS3
         WPDX+vsNGZcFGG+YoqjEE2p6STYY6gOj5TIvAev1rAtXbIN1talnakv+RN+aFdrNErtG
         uy9nq60Ma3mHLnmPN0MCcU+tSbWtCqM4qzgMJXbjdPEMPHIdErVRwlTAycMABSpCz4Zc
         UyvvrSjJ2rOY+Dd1J2xBpCGz2ioAc4zOQKSSkBdlK8MR7n5pczXimfTnIkR9rpyMq1C3
         hxAg==
X-Gm-Message-State: AOUpUlEajplTQgiG+oeyBtyOJ7nIyvAvZbJkCnxaMGC+QCtgwv+JXLYR
        wYsLW9Ca0xIwYrrviGXo5dqULQ==
X-Google-Smtp-Source: AA+uWPy37VbWHpgP+kou1dvqia/PNxV2b8EnultQo9eICAxGmg/KB1tMXhK0kUKxVJ32SWaDesEfRQ==
X-Received: by 2002:a62:5a01:: with SMTP id o1-v6mr26778330pfb.0.1534314140717;
        Tue, 14 Aug 2018 23:22:20 -0700 (PDT)
Received: from endless.endlessm-sf.com (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id u69-v6sm27304109pgd.43.2018.08.14.23.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 23:22:20 -0700 (PDT)
From:   <jian-hong@endlessm.com>
To:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] r8169: don't use MSI-X on RTL8106e
Date:   Wed, 15 Aug 2018 14:21:10 +0800
Message-Id: <20180815062110.16155-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Hong Pan <jian-hong@endlessm.com>

Found the ethernet network on ASUS X441UAR doesn't come back on resume
from suspend when using MSI-X.  The chip is RTL8106e - version 39.

asus@endless:~$ dmesg | grep r8169
[   21.848357] libphy: r8169: probed
[   21.848473] r8169 0000:02:00.0 eth0: RTL8106e, 0c:9d:92:32:67:b4, XID
44900000, IRQ 127
[   22.518860] r8169 0000:02:00.0 enp2s0: renamed from eth0
[   29.458041] Generic PHY r8169-200:00: attached PHY driver [Generic
PHY] (mii_bus:phy_addr=r8169-200:00, irq=IGNORE)
[   63.227398] r8169 0000:02:00.0 enp2s0: Link is Up - 100Mbps/Full -
flow control off
[  124.514648] Generic PHY r8169-200:00: attached PHY driver [Generic
PHY] (mii_bus:phy_addr=r8169-200:00, irq=IGNORE)

Here is the ethernet controller in detail:

asus@endless:~$ sudo lspci -nnvs 02:00.0
[sudo] password for asus:
02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller [10ec:8136]
(rev 07)
	Subsystem: ASUSTeK Computer Inc. RTL810xE PCI Express Fast
Ethernet controller [1043:200f]
	Flags: bus master, fast devsel, latency 0, IRQ 16
	I/O ports at e000 [size=256]
	Memory at ef100000 (64-bit, non-prefetchable) [size=4K]
	Memory at e0000000 (64-bit, prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [70] Express Endpoint, MSI 01
	Capabilities: [b0] MSI-X: Enable+ Count=4 Masked-
	Capabilities: [d0] Vital Product Data
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [160] Device Serial Number 01-00-00-00-36-4c-e0-00
	Capabilities: [170] Latency Tolerance Reporting
	Kernel driver in use: r8169
	Kernel modules: r8169

Here is the system interrupt table:

asus@endless:~$ cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
   0:         22          0          0          0   IO-APIC    2-edge
timer
   1:        157         42          0          0   IO-APIC    1-edge
i8042
   8:          0          0          1          0   IO-APIC    8-edge
rtc0
   9:         10         13          0          0   IO-APIC    9-fasteoi
acpi
  16:          0          0          0          0   IO-APIC   16-fasteoi
i2c_designware.0, i801_smbus
  17:       2445          0       3453          0   IO-APIC   17-fasteoi
i2c_designware.1, rtl_pci
 109:          2          0          0          1   IO-APIC  109-fasteoi
FTE1200:00
 120:          0          0          0          0   PCI-MSI 458752-edge
PCIe PME
 121:          0          0          0          0   PCI-MSI 466944-edge
PCIe PME
 122:          0          0          0          0   PCI-MSI 468992-edge
PCIe PME
 123:       1465          0          0      21263   PCI-MSI 376832-edge
ahci[0000:00:17.0]
 124:          0        530          0          0   PCI-MSI 327680-edge
xhci_hcd
 125:       5204          0          0          0   PCI-MSI 32768-edge
i915
 126:          0          0        149          0   PCI-MSI 514048-edge
snd_hda_intel:card0
 127:          0          0        337          0   PCI-MSI 1048576-edge
enp2s0
 NMI:          0          0          0          0   Non-maskable
interrupts
 LOC:      45049      39474      38978      46677   Local timer
interrupts
 SPU:          0          0          0          0   Spurious interrupts
 PMI:          0          0          0          0   Performance
monitoring interrupts
 IWI:        619          8          0          1   IRQ work interrupts
 RTR:          6          0          0          0   APIC ICR read
retries
 RES:       4918       4436       3835       2943   Rescheduling
interrupts
 CAL:       1399       1478       1598       1465   Function call
interrupts
 TLB:        608        513        723        559   TLB shootdowns
 TRM:          0          0          0          0   Thermal event
interrupts
 THR:          0          0          0          0   Threshold APIC
interrupts
 DFR:          0          0          0          0   Deferred Error APIC
interrupts
 MCE:          0          0          0          0   Machine check
exceptions
 MCP:          3          4          4          4   Machine check polls
 ERR:          0
 MIS:          0
 PIN:          0          0          0          0   Posted-interrupt
notification event
 NPI:          0          0          0          0   Nested
posted-interrupt event
 PIW:          0          0          0          0   Posted-interrupt
wakeup event

It is the IRQ 127 - PCI-MSI used by enp2s0.  However, lspci lists MSI is
disabled and MSI-X is enabled which conflicts to the interrupt table.

Falling back to MSI fixes the issue.

Here is the test result with this patch in dmesg:

asus@endless:~$ dmesg | grep r8169
[   22.017477] libphy: r8169: probed
[   22.017735] r8169 0000:02:00.0 eth0: RTL8106e, 0c:9d:92:32:67:b4, XID
44900000, IRQ 127
[   22.041489] r8169 0000:02:00.0 enp2s0: renamed from eth0
[   29.138312] Generic PHY r8169-200:00: attached PHY driver [Generic
PHY] (mii_bus:phy_addr=r8169-200:00, irq=IGNORE)
[   30.927359] r8169 0000:02:00.0 enp2s0: Link is Up - 100Mbps/Full -
flow control off
[  289.998077] r8169 0000:02:00.0 enp2s0: Link is Up - 100Mbps/Full -
flow control off
[  290.508084] Generic PHY r8169-200:00: attached PHY driver [Generic
PHY] (mii_bus:phy_addr=r8169-200:00, irq=IGNORE)
[  290.745690] r8169 0000:02:00.0 enp2s0: Link is Down
[  292.367717] r8169 0000:02:00.0 enp2s0: Link is Up - 100Mbps/Full -
flow control off

lspci lists MSI is enabled and MSI-X is disabled with this patch:

asus@endless:~/linux-net$ sudo lspci -nnvs 02:00.0
[sudo] password for asus:
02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller [10ec:8136]
(rev 07)
	Subsystem: ASUSTeK Computer Inc. RTL810xE PCI Express Fast
Ethernet controller [1043:200f]
	Flags: bus master, fast devsel, latency 0, IRQ 127
	I/O ports at e000 [size=256]
	Memory at ef100000 (64-bit, non-prefetchable) [size=4K]
	Memory at e0000000 (64-bit, prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [70] Express Endpoint, MSI 01
	Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
	Capabilities: [d0] Vital Product Data
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [160] Device Serial Number 01-00-00-00-36-4c-e0-00
	Capabilities: [170] Latency Tolerance Reporting
	Kernel driver in use: r8169
	Kernel modules: r8169

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/net/ethernet/realtek/r8169.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 0d9c3831838f..0efa977c422d 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7071,17 +7071,20 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 {
 	unsigned int flags;
 
-	if (tp->mac_version <= RTL_GIGA_MAC_VER_06) {
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
 		RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
 		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~MSIEnable);
 		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
 		flags = PCI_IRQ_LEGACY;
-	} else if (tp->mac_version == RTL_GIGA_MAC_VER_40) {
+		break;
+	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_40:
 		/* This version was reported to have issues with resume
 		 * from suspend when using MSI-X
 		 */
 		flags = PCI_IRQ_LEGACY | PCI_IRQ_MSI;
-	} else {
+		break;
+	default:
 		flags = PCI_IRQ_ALL_TYPES;
 	}
 
-- 
2.11.0

