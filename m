Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932DFC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387EC20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Y1MNZlkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387EC20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754101AbeFUOGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:06:22 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:56867 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeFUOGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:06:21 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 39DE91E04F7;
        Thu, 21 Jun 2018 16:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529589980; bh=iRYspSVN3Y6+T0zHKmdQc4YXnfDbtUDuAktjmBMkHgE=;
        h=From:To:Cc:Subject:Date:From;
        b=Y1MNZlkxcOiTuOhBnP1yp0mGz5SbVtdr+K+5e+83ajSXkfdLdyqJT9oMU9jMAf0Qz
         s2T3n+79+C5GibTwZ/0D3EkYNrXzfMSzyElP0LSmfK8sjPI689frzYJQfDaexx4pi8
         YGKF8YKfP3flZvgi23CStV56YK7fIfrI87Ohy3Xtm/QF4EffXvRkioaroy7nBd5sQj
         YjyI4455OUxiEhbIWCSWMzWD2wmuzZJCR6dPJh5yqRGDYRvi76emrJD3sftX/jHlK8
         SjHdwujVnu3dw3QPPq9Txf2YR60wzmCf2VkwQ5FryRhKT17I372fPME7VBB8vj5X33
         d+b41vgBiRDuA==
Received: from pt02.synopsys.com (pt02.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6A7645306;
        Thu, 21 Jun 2018 07:06:19 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id A9F7A8856;
        Thu, 21 Jun 2018 15:06:18 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     Vineet.Gupta1@synopsys.com, eugeniy.paltsev@synopsys.com,
        Alexey.Brodkin@synopsys.com, robh@kernel.org, bhelgaas@google.com,
        joao.pinto@synopsys.com
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v2] ARC: Add PCIe support for ARC HSDK platform
Date:   Thu, 21 Jun 2018 15:06:14 +0100
Message-Id: <e1d274a5ed756f86ced3df50538ef8c7e67ef4b6.1529589452.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCI support to the ARC HSDK platform allowing to use the generic PCI
setup functions.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
---
 arch/arc/plat-hsdk/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/plat-hsdk/Kconfig b/arch/arc/plat-hsdk/Kconfig
index 19ab3cf..556bc5e 100644
--- a/arch/arc/plat-hsdk/Kconfig
+++ b/arch/arc/plat-hsdk/Kconfig
@@ -9,3 +9,4 @@ menuconfig ARC_SOC_HSDK
 	bool "ARC HS Development Kit SOC"
 	select CLK_HSDK
 	select RESET_HSDK
+	select MIGHT_HAVE_PCI
-- 
2.7.4


