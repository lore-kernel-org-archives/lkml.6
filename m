Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1477DC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DE323FF8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DE323FF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbeFVJ7l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:59:41 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:37788 "EHLO
        wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbeFVJ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:58:21 -0400
X-IronPort-AV: E=Sophos;i="5.51,256,1526367600"; 
   d="scan'208";a="346278391"
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by wolverine01.qualcomm.com with ESMTP; 22 Jun 2018 02:58:20 -0700
X-IronPort-AV: E=McAfee;i="5900,7806,8931"; a="222664696"
Received: from westreach.qualcomm.com ([10.228.196.125])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 22 Jun 2018 02:58:18 -0700
Received: by westreach.qualcomm.com (Postfix, from userid 467151)
        id 072181F2C; Fri, 22 Jun 2018 05:58:17 -0400 (EDT)
From:   Oza Pawandeep <poza@codeaurora.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc:     Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v2 0/6] Fix issues and cleanup for ERR_FATAL and ERR_NONFATAL
Date:   Fri, 22 Jun 2018 05:58:08 -0400
Message-Id: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are follow up patches for the series which modifies ERR_FATAL handling.
although there were couple of problems existed before which, itis also fixing.

patch-1:
Fixes the problem where ERR_FATAL and ERR_NONFATAL status should be cleared
taking severity mask into account.

patch-2:
Takes care of clearing error fatal status

patch-3:
Follow up patch where no more need of handling ERR_FATAL
case.

patch-4:
Fixes clearing device status in case of uncorrectable errors.
(e.g. ERR_FATAL and ERR_NONFATAL)

patch-5:
Fixes clearing device status in case of correctable errors.

patch-6:
Follow up patch where no more need of handling pci_channel_io_frozen
in pcie_portdrv_slot_reset()

Oza Pawandeep (6):
  PCI/AER: Take severity mask into account while clearing error bits
  PCI/AER: Clear uncorrectable fatal error status bits
  PCI/ERR: Cleanup ERR_FATAL of error broadcast
  PCI/AER: Clear device error status bits during ERR_FATAL and
    ERR_NONFATAL
  PCI/AER: Fix correctable status bits clearing in device register
  PCI/PORTDRV: Remove ERR_FATAL handling from pcie_portdrv_slot_reset()

 drivers/pci/pcie/aer.c         | 35 +++++++++++++++++++++++------------
 drivers/pci/pcie/err.c         | 15 +++++++--------
 drivers/pci/pcie/portdrv_pci.c | 18 ------------------
 include/linux/aer.h            |  5 +++++
 4 files changed, 35 insertions(+), 38 deletions(-)

-- 
2.7.4

