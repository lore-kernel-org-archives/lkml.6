Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA75DC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B222531B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B222531B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030988AbeGAQhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:37:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031367AbeGAQhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:37:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D6EF4ACC;
        Sun,  1 Jul 2018 16:37:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gabriel Craciunescu <nix.or.die@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.17 014/220] hwmon: (k10temp) Add support for Stoney Ridge and Bristol Ridge CPUs
Date:   Sun,  1 Jul 2018 18:20:38 +0200
Message-Id: <20180701160908.954134856@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit ccaf63b4d6eaf3447037cefbb0b1038fa80c6639 upstream.

Add support for Stoney Ridge and Bristol Ridge (Family 15h Model 0x70)
CPUs. Registers match those of Family 15h Model 0x60.

Cc: stable@vger.kernel.org # v4.16+
Tested-by: Gabriel Craciunescu <nix.or.die@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/k10temp.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -37,6 +37,10 @@ MODULE_PARM_DESC(force, "force loading o
 /* Provide lock for writing to NB_SMU_IND_ADDR */
 static DEFINE_MUTEX(nb_smu_ind_mutex);
 
+#ifndef PCI_DEVICE_ID_AMD_15H_M70H_NB_F3
+#define PCI_DEVICE_ID_AMD_15H_M70H_NB_F3	0x15b3
+#endif
+
 #ifndef PCI_DEVICE_ID_AMD_17H_DF_F3
 #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #endif
@@ -320,6 +324,7 @@ static const struct pci_device_id k10tem
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M10H_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M30H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M60H_NB_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M70H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },


