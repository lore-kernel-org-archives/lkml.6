Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C88C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583B820673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crt7ql7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583B820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbeGSOvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:51:44 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46728 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeGSOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:51:44 -0400
Received: by mail-qt0-f193.google.com with SMTP id d4-v6so7253506qtn.13;
        Thu, 19 Jul 2018 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E59PwAxkiwoj5qeZWc5tDFcPlEYArmqVLtSNiMVTybs=;
        b=crt7ql7F/eknB8ZrG4zBakAd66+ONR/Sg1a4eYeZErtko12KCosoprZAy6APynOuHl
         CeQK7cNnJ98qqR9r0lCfNBj3DICqUIEAfYm6eNgxHD2CDvZDtpgwjn0/1BS4j7lxBPv5
         MriO/3yqXAZYTB1kUMpQ7TmiqEhIQJvpn2Btm4lJdXtGWC6sd4uLI1woBGFW9ic5EyUu
         hVWATEy4QEgsfOPI0QbtgdHStW2dXEXjAuDd34N914F4B1X34OuJmse6fJUHQaFcXWab
         nq+an3hHiPEApfLsePqO6s3D9dLdU3oPiDs26k2XKRADUR8bw1JjInXM22Z5xqtn9K/s
         2mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E59PwAxkiwoj5qeZWc5tDFcPlEYArmqVLtSNiMVTybs=;
        b=dM8VoYx8kcwG1Dn5EIA9F9vLcQRtRvcsMTMiR75tZCEKp1gPsxWGu1B23JYVTxZ2AH
         clMLfnzDBYC9yRY4F0H9i5V8JBG1ABeKe21IyQPOeqiYju6fnprZWLf7qHpm4RF2euUV
         05QBOqeA0AwxJnRfTbnRFr3sYgfCW1ghIP+B4+Bylp+yKwYdqkAK1N3g6O+Swx4dp5C0
         awi64/m7Ya7UsO2ufUC83MWkIE2UZk0vW0go9QQu2h/8lHrcY25M3EbArrqWmd8Kkh8D
         SGkAYiFujIu2CxfLlgwldJwsccVvnNPQeVM/LaWj3AYUVSt0tf4xYwTYfZk8emS9N0vs
         jECQ==
X-Gm-Message-State: AOUpUlHPZ9bwHj6RcIgSJu8lMArJxC7IaxnLifkYcbZMEhrCP6tZR9Bb
        E31r5s/6PedqBQPsmr60vg==
X-Google-Smtp-Source: AAOMgpeGuc5UGlar6+gk+RxCUQyBLm1rHkhT6rkzoA1u/aX72i+bN4pRP/bWnyrgClw6prVHBEmCug==
X-Received: by 2002:ac8:2374:: with SMTP id b49-v6mr9597432qtb.37.1532009302498;
        Thu, 19 Jul 2018 07:08:22 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q13-v6sm6200894qkl.97.2018.07.19.07.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 07:08:22 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH] EDAC, sb_edac: Fix out of bound in PCI multi segment env
Date:   Thu, 19 Jul 2018 10:07:45 -0400
Message-Id: <20180719140745.4503-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

KASAN reported the following slab-out-of-bounds when sb_edac
module was loaded on Broadwell machine which has two PCI segments.

==================================================================
BUG: KASAN: slab-out-of-bounds in sbridge_get_all_devices.constprop.14+0x75f/0x96a [sb_edac]
Read of size 8 at addr ffff8c0d44dfe850 by task modprobe/4221

CPU: 19 PID: 4221 Comm: modprobe Not tainted 4.18.0-rc5 #2
Call Trace:
 dump_stack+0xc2/0x16b
 ? show_regs_print_info+0x5/0x5
 ? kmsg_dump_rewind_nolock+0xd9/0xd9
 ? pci_get_dev_by_id+0x57/0x70
 ? pci_get_device+0x155/0x210
 print_address_description+0x6a/0x270
 kasan_report+0x258/0x380
 ? sbridge_get_all_devices.constprop.14+0x75f/0x96a [sb_edac]
 sbridge_get_all_devices.constprop.14+0x75f/0x96a [sb_edac]
...
Allocated by task 4221:
 kasan_kmalloc+0xa0/0xd0
 __kmalloc+0x112/0x230
 sbridge_get_all_devices.constprop.14+0x555/0x96a [sb_edac]
 sbridge_init+0x1ba/0x4000 [sb_edac]
 do_one_initcall+0xaa/0x401
 do_init_module+0x20b/0x676
 load_module+0x443f/0x6dc0
 __do_sys_finit_module+0x25f/0x2c0
 do_syscall_64+0x14e/0x4b0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
...
==================================================================

The out bounds happened because the index of sbridge_dev->pdev[] is over
than the allocated size.
---
static int sbridge_get_onedevice(struct pci_dev **prev,
...
        if (sbridge_dev->pdev[sbridge_dev->i_devs]) { <= !! out bounds HERE !!
                sbridge_printk(KERN_ERR,
                        "Duplicated device for %04x:%04x\n",
                        PCI_VENDOR_ID_INTEL, dev_descr->dev_id);
---

If a sbridge_dev which has the same bus as the new device is already exists,
the sbridge_dev is assigned to the new one.

---
static struct sbridge_dev *get_sbridge_dev(u8 bus, enum domain dom, int multi_bus,
                                           struct sbridge_dev *prev)
...
        list_for_each_entry_from(sbridge_dev, &sbridge_edac_list, list) {
                if (sbridge_dev->bus == bus && (dom == SOCK || dom == sbridge_dev->dom))
                        return sbridge_dev;
        }
---

If the system has multi PCI segment and the each bus number is same,
the same sbridge_dev is assigned. So, the index of sbridge_dev->pdev[]
is incremented by each segments.
As the result, the index is over than the allocated size, then the
out-of-bounds happens.

This patch introduces a segment member to sbridge_dev to separate
it each PCI segments.

Fixes: e2f747b1f42a ("EDAC, sb_edac: Assign EDAC memory controller per h/w controller")

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 drivers/edac/sb_edac.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 4a89c80..07726fb 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -352,6 +352,7 @@ struct pci_id_table {
 
 struct sbridge_dev {
 	struct list_head	list;
+	int			seg;
 	u8			bus, mc;
 	u8			node_id, source_id;
 	struct pci_dev		**pdev;
@@ -729,7 +730,8 @@ static inline int numcol(u32 mtr)
 	return 1 << cols;
 }
 
-static struct sbridge_dev *get_sbridge_dev(u8 bus, enum domain dom, int multi_bus,
+static struct sbridge_dev *get_sbridge_dev(int seg, u8 bus, enum domain dom,
+					   int multi_bus,
 					   struct sbridge_dev *prev)
 {
 	struct sbridge_dev *sbridge_dev;
@@ -747,14 +749,15 @@ static struct sbridge_dev *get_sbridge_dev(u8 bus, enum domain dom, int multi_bu
 				      : sbridge_edac_list.next, struct sbridge_dev, list);
 
 	list_for_each_entry_from(sbridge_dev, &sbridge_edac_list, list) {
-		if (sbridge_dev->bus == bus && (dom == SOCK || dom == sbridge_dev->dom))
+		if ((sbridge_dev->seg == seg) && (sbridge_dev->bus == bus) &&
+				(dom == SOCK || dom == sbridge_dev->dom))
 			return sbridge_dev;
 	}
 
 	return NULL;
 }
 
-static struct sbridge_dev *alloc_sbridge_dev(u8 bus, enum domain dom,
+static struct sbridge_dev *alloc_sbridge_dev(int seg, u8 bus, enum domain dom,
 					     const struct pci_id_table *table)
 {
 	struct sbridge_dev *sbridge_dev;
@@ -771,6 +774,7 @@ static struct sbridge_dev *alloc_sbridge_dev(u8 bus, enum domain dom,
 		return NULL;
 	}
 
+	sbridge_dev->seg = seg;
 	sbridge_dev->bus = bus;
 	sbridge_dev->dom = dom;
 	sbridge_dev->n_devs = table->n_devs_per_imc;
@@ -2246,6 +2250,7 @@ static int sbridge_get_onedevice(struct pci_dev **prev,
 	struct sbridge_dev *sbridge_dev = NULL;
 	const struct pci_id_descr *dev_descr = &table->descr[devno];
 	struct pci_dev *pdev = NULL;
+	int seg = 0;
 	u8 bus = 0;
 	int i = 0;
 
@@ -2276,10 +2281,12 @@ static int sbridge_get_onedevice(struct pci_dev **prev,
 		/* End of list, leave */
 		return -ENODEV;
 	}
+	seg = pci_domain_nr(pdev->bus);
 	bus = pdev->bus->number;
 
 next_imc:
-	sbridge_dev = get_sbridge_dev(bus, dev_descr->dom, multi_bus, sbridge_dev);
+	sbridge_dev = get_sbridge_dev(seg, bus, dev_descr->dom,
+				      multi_bus, sbridge_dev);
 	if (!sbridge_dev) {
 		/* If the HA1 wasn't found, don't create EDAC second memory controller */
 		if (dev_descr->dom == IMC1 && devno != 1) {
@@ -2292,7 +2299,7 @@ static int sbridge_get_onedevice(struct pci_dev **prev,
 		if (dev_descr->dom == SOCK)
 			goto out_imc;
 
-		sbridge_dev = alloc_sbridge_dev(bus, dev_descr->dom, table);
+		sbridge_dev = alloc_sbridge_dev(seg, bus, dev_descr->dom, table);
 		if (!sbridge_dev) {
 			pci_dev_put(pdev);
 			return -ENOMEM;
-- 
2.18.0

