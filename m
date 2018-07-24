Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E77EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0904620856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv6VB+oU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0904620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbeGXMH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:07:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39670 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388241AbeGXMH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:07:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so2652503pgs.6;
        Tue, 24 Jul 2018 04:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xmpvMzlscU4+XRg1DQF4x2c498bXG5Yno3xaJ9QaGP8=;
        b=gv6VB+oU8tuhAf2ZMYNik6axsRY1J4iBDiyHUGn2gKwXCcg4wAhZbtm/GbHowE+Iar
         KIbgCEh6htuvLh9qT2ldR//YaJ3gVlgoQD8YvUNtUmgjB9CEtnmhuHPcyiPxdvwGWH/T
         5GgoD3lMgHjQFA9dvOUoRqKHed9YVuOjN24p4USYxJ6nM3Mnqi+wXQHh/h2ad9oL2Sa6
         JFzPA4OMgKj/JXlpVmUnLPia6rNjTojzE7gZxO2y8OyEZHtDFjiitOS27nGXu5C3R7JJ
         9w4KXEvJVqDR/5Eq5hph9wTTePuaJ53PpJzG9Ko1Bu4VsVpRapN1EpeVhn5v6wO7Ge0K
         W8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xmpvMzlscU4+XRg1DQF4x2c498bXG5Yno3xaJ9QaGP8=;
        b=CCd6KbCJykQHDgHB9Yrdbu1Q0oPNUr1VWzwkdRXxw7rnCbj0N22NJEWPzoh3OOdWJI
         MSU/BxV0wBOVrjVYl8q9OWPGfDhhlRJQAcvEsXjA7niK9xtVoMKClGcShJxbvcbpbuGz
         sor/zVAL86LMLiOMRScYf3iwmzGFRoQSxubvuL/DYCyOVUBEgbQ/9r9PMSE4IojeJb/b
         GPqZhZwRDYbohYgdiPDWEzmIRR30PxBZcmZjrmRHh/4wKTKLqmwTGGSxh6V5uBcB5Hbe
         bhONh82a/Nl12ESSRT0gVvJICs/rmVH5VUM9Xm0AWvxoriiyrzfCpYNKpcWLFxnwXZPi
         wz3Q==
X-Gm-Message-State: AOUpUlG21ZaCpXFrsuUGR9ca3hGGBGa6IeYXgEPpdqIsagA8LRwVLu4a
        UKbbBp4pOun3TIrTimhRcHQ=
X-Google-Smtp-Source: AAOMgpcjypEB7yzG4x2jr9g8MLXHOJ0sRcVuD5dG7+5lSRNboIqSdsDoz0ORJaa080V+Y84BDnQp+g==
X-Received: by 2002:a62:d693:: with SMTP id a19-v6mr17072466pfl.248.1532430124238;
        Tue, 24 Jul 2018 04:02:04 -0700 (PDT)
Received: from linux-l9pv.suse ([134.159.103.118])
        by smtp.gmail.com with ESMTPSA id l85-v6sm20481109pfk.34.2018.07.24.04.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Jul 2018 04:02:03 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH] x86/PCI: Claim the resources of firmware enabled IOAPIC before children bus
Date:   Tue, 24 Jul 2018 19:01:44 +0800
Message-Id: <20180724110144.16442-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a machine that the resource of firmware enabled IOAPIC conflicts
with the resource of a children bus when the PCI host bus be hotplug.

[ 3182.243325] PCI host bridge to bus 0001:40
[ 3182.243328] pci_bus 0001:40: root bus resource [io  0xc000-0xdfff window]
[ 3182.243330] pci_bus 0001:40: root bus resource [mem 0xdc000000-0xebffffff window]
[ 3182.243331] pci_bus 0001:40: root bus resource [mem 0x212400000000-0x2125ffffffff window]
[ 3182.243334] pci_bus 0001:40: root bus resource [bus 40-7e]
...
[ 3182.244737] pci 0001:40:05.4: [8086:6f2c] type 00 class 0x080020
[ 3182.244746] pci 0001:40:05.4: reg 0x10: [mem 0xdc000000-0xdc000fff]
...
[ 3182.246697] pci 0001:40:02.0: PCI bridge to [bus 41]
[ 3182.246702] pci 0001:40:02.0:   bridge window [mem 0xdc000000-0xdc7fffff]
...
pci 0001:40:05.4: can't claim BAR 0 [mem 0xdc000000-0xdc000fff]: address conflict with PCI Bus 0001:41 [mem 0xdc000000-0xdc7fffff]

The bus topology:

 +-[0001:40]-+-02.0-[41]--
 |           +-03.0-[41]--
 |           +-03.2-[41]--+-00.0  Intel Corporation I350 Gigabit Network Connection
 |           |            +-00.1  Intel Corporation I350 Gigabit Network Connection
 |           |            +-00.2  Intel Corporation I350 Gigabit Network Connection
 |           |            \-00.3  Intel Corporation I350 Gigabit Network Connection
 |           +-05.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Map/VTd_Misc/System Management
 |           +-05.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D IIO Hot Plug
 |           +-05.2  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D IIO RAS/Control Status/Global Errors
 |           \-05.4  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D I/O APIC

This problem causes that the NIC behine the child bus was not available
after PCI host bridge hotpluged.

Kernel does not want to change resource of firmware enabled IOAPIC, but
the priority of children bus's resources are higher than any other devices.
So this conflict can not be handled by the reassigning logic of kernel.

This patch claims the resources of firmware enabled IOAPIC before
children bus. Then kernel gets a chance to reassign the resources of
children bus to avoid the conflict.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 arch/x86/pci/i386.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index ed4ac215305d..6413eda87c72 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -230,13 +230,40 @@ static void pcibios_allocate_bridge_resources(struct pci_dev *dev)
 	}
 }
 
+static bool ioapic_firmware_enabled(struct pci_dev *dev)
+{
+	u16 class = dev->class >> 8;
+
+	if (class == PCI_CLASS_SYSTEM_PIC) {
+		u16 command;
+
+		pci_read_config_word(dev, PCI_COMMAND, &command);
+		if (command & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
+			return true;
+	}
+
+	return false;
+}
+
+static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass);
+
 static void pcibios_allocate_bus_resources(struct pci_bus *bus)
 {
 	struct pci_bus *child;
+	struct pci_dev *dev;
 
 	/* Depth-First Search on bus tree */
 	if (bus->self)
 		pcibios_allocate_bridge_resources(bus->self);
+
+	/* allocate firmware enabled APIC before children bus */
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (ioapic_firmware_enabled(dev)) {
+			pcibios_allocate_dev_resources(dev, 0);
+			pcibios_allocate_dev_resources(dev, 1);
+		}
+	}
+
 	list_for_each_entry(child, &bus->children, node)
 		pcibios_allocate_bus_resources(child);
 }
-- 
2.13.6

