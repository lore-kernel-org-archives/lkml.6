Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6FDC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 04:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAB02081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 04:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N6c8MEDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfBEE5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 23:57:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36444 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBEE5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 23:57:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so970651pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 20:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WkJmB+BrKyHkx4yoLek7I8SEG9gwE2YrB6tAPNV0c6s=;
        b=N6c8MEDcJG2BD3kTmiD93vPxcNfc+18jUvANl5nFpvtwCL9DJBqxu9jgcKf72grGoQ
         X9RbmQyU1m5E11+pwaHo+ubWWuGL5TK6VlI/wIwxXVQywxgLRyrxxDmMudimhIVOy+h6
         njfZZ7EUFTy7pIMW2gXtWCgIBQMkG79scGLpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WkJmB+BrKyHkx4yoLek7I8SEG9gwE2YrB6tAPNV0c6s=;
        b=nsMiubV6/tG3uNJkfReiXRjLk5heMCAlvZ935kPpdZSrRybAhulyOEGaMjn/e3ibhb
         g06hUFNLhHhlFYmVBblfBDt1YUbpNfMviQ8L6vLDR/eys+EtPlm5UHgfGZDsfnFtsbez
         h7dq2xfq/zmjdKssKQ3GL/PTrWFEa04XHsJw9LuHWfBlc9x3mWpqlLG9xaVHH08NoYyr
         5tfL9E7EDCDDF6rG+xsv28vBt5uyYXJGLHmkXWz4l72X2RKgo5dLpEnw/biMoquR8NZd
         O/uG8f+hPKEEeuHBnjqdGCXC60hhcmdONsVJA3Do2ZJ6kZs3GY1qYJFEYmagESAhC6Iw
         9P1w==
X-Gm-Message-State: AHQUAubpdkoENClEYNdK55CNddkjEtzVGlXCeTcNY7lZJ55+jEh4Yp9T
        SEhRCl1tDlaiuYbvk/7YkTtiVQ==
X-Google-Smtp-Source: AHgI3IZjMztjKf9AXbNfCHv6tS/BXENsLuqUXlYWI5uu26VeMEEvKNs1UTTzU67jk+Mo5+GuWI8UHw==
X-Received: by 2002:a65:528c:: with SMTP id y12mr2321430pgp.317.1549342666157;
        Mon, 04 Feb 2019 20:57:46 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r76sm2895164pfb.69.2019.02.04.20.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Feb 2019 20:57:45 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 0/2] Add IPROC PCIe new features
Date:   Tue,  5 Feb 2019 10:26:59 +0530
Message-Id: <1549342622-9929-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set extends support of new IPROC PCIe host controller features
 - Add CRS check using controller register status flags
 - Add 32bit outbound window mapping configuration

This patch set is based on Linux-5.0-rc2.

Changes from v1:
  - Addressed Bjorn Helgaas comments.
  - Removed set order mode patch from patchset.

Srinath Mannam (2):
  PCI: iproc: Add CRS check in config read
  PCI: iproc: Add PCIe 32bit outbound memory configuration

 drivers/pci/controller/pcie-iproc.c | 44 +++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

-- 
2.7.4

