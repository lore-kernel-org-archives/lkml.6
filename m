Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD1EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8622208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyLAJjqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8622208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbeGJXes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:34:48 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43389 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbeGJXes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:34:48 -0400
Received: by mail-qt0-f194.google.com with SMTP id f18-v6so19916989qtp.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 16:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DQ3Q5ni1BUTrqTlFeX8/hjQC3zgMplxPnB0/ndUndJc=;
        b=QyLAJjqJwyLEjbhrAPC9iCgPfkdhAgP1tO77UbHVtXYtrNlaj5ZB2br5JkO+H8tkRm
         P8MLsX84GhX0BKtH5Iom6xPprpxQEOVVF9t55QBsGedIVAY8Hu/GkbfDYD9S02pwllwe
         5EH4JbCtGPnp+PTrfhzbbtkuwVKDDDiLWuywdqzn6qDmzQJN3u1qt/m19yeQYB6H2uko
         a658oT8nyybov/Pemf7KBnyR2xTk0iOLl7+3iy/vfl4eTmFun50JC9BgYIjvSdAid9Ko
         QEupqgv8uWoQwqoQxWhwr34oIrZg0/mdV7I5Aa7bA8rkxexyeG3V6AAuKwvPnLJDTZoG
         XAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DQ3Q5ni1BUTrqTlFeX8/hjQC3zgMplxPnB0/ndUndJc=;
        b=l9A3BH5IyMGZIQWcUN8jWrX+sQcXzrjHuePqmK39k0pP3ImQGZ11J3NVtLyiwDMAgB
         YAXqKDDY2iZTFEp/0IetunjA5KJbTHMRTiBGvhXHqPruH7fznO60kUrt/gs0lh5RNf2t
         gM0c0CWnTJNtAVwaVeaC9PqJtVHa5Qh0Z27VYD7bI9FpjrJuwPL3VzIV5PkJFZkwBgD5
         8QhYp+Nn8rWCQ3BuG0TpoyF5Eo4ET+CaH1tqebmQWAHCLpmZgrJMaJbZUUGuT0MUuKPY
         PN6E5lzJqU5K8s5O4Ia5leZuEoaDttzdCCXAcyb9AFLyiSzJzMEjyGjoBHbezMAqIBWO
         0q/w==
X-Gm-Message-State: APt69E3gqblBKyWVc+tnVJAbgFg8DxOPlpORdTZyDGOPQRHBBPuk8qDq
        rO9P+YdJdbyUHp3pdJBQDA==
X-Google-Smtp-Source: AAOMgpeUFRkN29D/KRMQR+c6Qn1UEeNJ35aJSVmu+t0riM+lxQf1RCBnwmPsXBZ5NcCCnwOkwFfs7Q==
X-Received: by 2002:ac8:41d1:: with SMTP id o17-v6mr25447668qtm.265.1531265603679;
        Tue, 10 Jul 2018 16:33:23 -0700 (PDT)
Received: from gabell.redhat.com ([2601:18f:600:d880:c4d8:8eb3:1883:691d])
        by smtp.gmail.com with ESMTPSA id 4-v6sm14071401qtq.24.2018.07.10.16.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 16:33:23 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH] [RESEND] perf/x86/intel/uncore: Fix the index of PCU.3 Broadwell CPUs
Date:   Tue, 10 Jul 2018 19:31:58 -0400
Message-Id: <20180710233158.21037-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

commit 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for
Broadwell CPUs") introduced PCU.3 for Broadwell CPU. Unfortunately,
the driver_data of PCU.3 conflicts to QPI Port 2 filter.

    { /* QPI Port 2 filter  */
            PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
            .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 2),

    { /* PCU.3 (for Capability registers) */
            PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
            .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
                                               HSWEP_PCI_PCU_3),
                             // HSWEP_PCI_PCU_3 == 2

As the result, the index for each device gets same, so the pci device
is overwrited in uncore_extra_pci_dev[pkg].dev[idx] when it is probed.

static int uncore_pci_probe(struct pci_dev *pdev,...
{
...
        if (UNCORE_PCI_DEV_TYPE(id->driver_data) == UNCORE_EXTRA_PCI_DEV) {
                int idx = UNCORE_PCI_DEV_IDX(id->driver_data); // HERE!!

                uncore_extra_pci_dev[pkg].dev[idx] = pdev;     // HERE!!
                pci_set_drvdata(pdev, NULL);
                return 0;
        }

Due to the overwriting, the following warning message are shown
while CPU hot-removing.

  WARNING: CPU: 126 PID: 6 at arch/x86/events/intel/uncore.c:988
  uncore_pci_remove+0x10b/0x150
  Call Trace:
   pci_device_remove+0x42/0xd0
   device_release_driver_internal+0x148/0x220
   pci_stop_bus_device+0x76/0xa0
   pci_stop_root_bus+0x44/0x60
   acpi_pci_root_remove+0x1f/0x80
   acpi_bus_trim+0x57/0x90
   acpi_bus_trim+0x2e/0x90
   acpi_device_hotplug+0x2bc/0x4b0
   acpi_hotplug_work_fn+0x1a/0x30
   process_one_work+0x174/0x3a0
   worker_thread+0x4c/0x3d0
   kthread+0xf8/0x130

To avoid the conflict, this patch changes the PCU.3 driver_data.
And also increase UNCORE_EXTRA_PCI_DEV_MAX to handle the new index.

Fixes: 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for Broadwell CPUs")

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/events/intel/uncore.h       | 2 +-
 arch/x86/events/intel/uncore_snbep.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index c9e1e0b..e17ab88 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -28,7 +28,7 @@
 #define UNCORE_PCI_DEV_TYPE(data)	((data >> 8) & 0xff)
 #define UNCORE_PCI_DEV_IDX(data)	(data & 0xff)
 #define UNCORE_EXTRA_PCI_DEV		0xff
-#define UNCORE_EXTRA_PCI_DEV_MAX	3
+#define UNCORE_EXTRA_PCI_DEV_MAX	4
 
 #define UNCORE_EVENT_CONSTRAINT(c, n) EVENT_CONSTRAINT(c, n, 0xff)
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 87dc026..62f007c 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1030,6 +1030,7 @@ enum {
 	SNBEP_PCI_QPI_PORT0_FILTER,
 	SNBEP_PCI_QPI_PORT1_FILTER,
 	HSWEP_PCI_PCU_3,
+	BDX_PCI_PCU_3,
 };
 
 static int snbep_qpi_hw_config(struct intel_uncore_box *box, struct perf_event *event)
@@ -3070,11 +3071,11 @@ void bdx_uncore_cpu_init(void)
 	if (boot_cpu_data.x86_model == 86) {
 		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
 	/* Detect systems with no SBOXes */
-	} else if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
+	} else if (uncore_extra_pci_dev[pkg].dev[BDX_PCI_PCU_3]) {
 		struct pci_dev *pdev;
 		u32 capid4;
 
-		pdev = uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3];
+		pdev = uncore_extra_pci_dev[pkg].dev[BDX_PCI_PCU_3];
 		pci_read_config_dword(pdev, 0x94, &capid4);
 		if (((capid4 >> 6) & 0x3) == 0)
 			bdx_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
@@ -3299,7 +3300,7 @@ static const struct pci_device_id bdx_uncore_pci_ids[] = {
 	{ /* PCU.3 (for Capability registers) */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
 		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
-						   HSWEP_PCI_PCU_3),
+						   BDX_PCI_PCU_3),
 	},
 	{ /* end: all zeroes */ }
 };
-- 
2.16.1

