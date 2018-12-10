Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE73C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816142082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816142082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeLJKXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:23:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:31548 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbeLJKXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:23:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 02:23:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,338,1539673200"; 
   d="scan'208";a="128616903"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 10 Dec 2018 02:23:04 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 10 Dec 2018 12:23:03 +0200
Date:   Mon, 10 Dec 2018 12:23:03 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Thunderbolt changes for v4.21
Message-ID: <20181210102303.GC2469@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This includes automatic enabling of IOMMU based DMA protection from
possibly malicious devices connected through Thunderbolt ports. In
addition we make sure PCIe ATS (Address Translation Service) is not
enabled for such devices to prevent them from passing IOMMU protection.

Please pull, thanks!

The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-for-v4.21

for you to fetch changes up to dcc3c9e37fbd70e728d08cce0e50121605390fa0:

  thunderbolt: Export IOMMU based DMA protection support to userspace (2018-12-05 12:01:56 +0300)

----------------------------------------------------------------
thunderbolt: Changes for v4.21 merge window

----------------------------------------------------------------
Lu Baolu (1):
      iommu/vt-d: Force IOMMU on for platform opt in hint

Mika Westerberg (3):
      PCI / ACPI: Identify untrusted PCI devices
      iommu/vt-d: Do not enable ATS for untrusted devices
      thunderbolt: Export IOMMU based DMA protection support to userspace

 Documentation/ABI/testing/sysfs-bus-thunderbolt |  9 ++++
 Documentation/admin-guide/thunderbolt.rst       | 20 +++++++++
 drivers/acpi/property.c                         | 11 +++++
 drivers/iommu/dmar.c                            | 25 +++++++++++
 drivers/iommu/intel-iommu.c                     | 56 +++++++++++++++++++++++--
 drivers/pci/pci-acpi.c                          | 19 +++++++++
 drivers/pci/probe.c                             | 15 +++++++
 drivers/thunderbolt/domain.c                    | 17 ++++++++
 include/linux/dmar.h                            |  8 ++++
 include/linux/pci.h                             |  8 ++++
 10 files changed, 185 insertions(+), 3 deletions(-)
