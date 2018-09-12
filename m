Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8397C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B8520880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ylf5Z5qp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B8520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeILWAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeILWAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:00:51 -0400
Received: from localhost (unknown [146.7.4.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 181E1206B6;
        Wed, 12 Sep 2018 16:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536771327;
        bh=brKWleqYoSK6gpr7eBJhol9g3Jb29URg7NqcMjhLcig=;
        h=Subject:From:To:Cc:Date:From;
        b=ylf5Z5qpkeWaToLwvMVdH0AD/eRUUYVL81xaoeViR62N/PJwDmW1vCA3IW1it/Zj3
         jc+3UslZq231N0TFzYQJXs+L3MsX5wcHOLhSQwk8WAbEseslYvIEQOB4mB7Lc8t4eu
         /06G1fn1S+zILMyz2LwgUwkR0uWGDGKYxMOSaVzM=
Subject: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Sep 2018 11:55:26 -0500
Message-ID: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The original PCI error recovery functionality was for the powerpc-specific
IBM EEH feature.  PCIe subsequently added some similar features, including
AER and DPC, that can be used on any architecture.

We want the generic PCI core error handling support to work with all of
these features.  Driver error recovery callbacks should be independent of
which feature the platform provides.

Add the generic PCI core error recovery files to the powerpc EEH
MAINTAINERS entry so the powerpc folks will be copied on changes to the
generic PCI error handling strategy.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e10ba65bfe4..d6699597fd89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11202,6 +11202,10 @@ PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
 M:	Russell Currey <ruscur@russell.cc>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
+F:	Documentation/PCI/pci-error-recovery.txt
+F:	drivers/pci/pcie/aer.c
+F:	drivers/pci/pcie/dpc.c
+F:	drivers/pci/pcie/err.c
 F:	Documentation/powerpc/eeh-pci-error-recovery.txt
 F:	arch/powerpc/kernel/eeh*.c
 F:	arch/powerpc/platforms/*/eeh*.c

