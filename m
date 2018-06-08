Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Hl5BMADjGltxOgAAmS7hNA
	; Fri, 08 Jun 2018 20:12:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BAD8C607DC; Fri,  8 Jun 2018 20:12:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XECFSpx0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 51B1F605A5;
	Fri,  8 Jun 2018 20:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51B1F605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbeFHUMD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbeFHUMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:12:02 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8A9206B7;
        Fri,  8 Jun 2018 20:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488721;
        bh=9GGfx1XtxYqqKm6GYFeF5giQdtAFRVNje2CuH/OPu0M=;
        h=Subject:From:To:Cc:Date:From;
        b=XECFSpx0PULkvIvon4r2VDckoEuXDNxLUzDs+b45Q81X6zMkQv5dEE8Crew9LR2Fg
         71pL6nzpAL95rBzTxijvLNjuD/3opqtOc0IIc00WL75s0PCitJBmAcxOiUVo4aB2mw
         RLTGuohIwvL/hSOtbajSZ2NyCe3jBWbn+21SuVag=
Subject: [RFC PATCH v1 0/9] PCI/portdrv: Squash into one file
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:00 -0500
Message-ID: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The portdrv code is scattered across several files, which makes it a bit of
a hassle to browse.  Consolidate it all in a single file.

This is all pure code moves; no functional changes intended.  Well, there
is a function rename, but it shouldn't change any behavior.

---

Bjorn Helgaas (9):
      PCI/portdrv: Rename resume_iter() to prevent name collision
      PCI/portdrv: Squash pieces of portdrv_core.c into portdrv_pci.c
      PCI/portdrv: Squash PM-related code into portdrv_pci.c
      PCI/portdrv: Squash device removal code into portdrv_pci.c
      PCI/portdrv: Squash lookup interfaces into portdrv_pci.c
      PCI/portdrv: Squash service driver registration into portdrv_pci.c
      PCI/portdrv: Move private definitions to portdrv_pci.c
      PCI/portdrv: Clean up whitespace
      PCI/portdrv: Rename portdrv_pci.c to portdrv.c


 drivers/pci/pcie/Makefile       |    6 
 drivers/pci/pcie/portdrv.c      |  822 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h      |   15 -
 drivers/pci/pcie/portdrv_core.c |  578 ---------------------------
 drivers/pci/pcie/portdrv_pci.c  |  261 ------------
 5 files changed, 824 insertions(+), 858 deletions(-)
 create mode 100644 drivers/pci/pcie/portdrv.c
 delete mode 100644 drivers/pci/pcie/portdrv_core.c
 delete mode 100644 drivers/pci/pcie/portdrv_pci.c
