Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3709C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F29F2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfASVBV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 16:01:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:49968 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbfASVBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 16:01:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2019 13:01:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,497,1539673200"; 
   d="scan'208";a="127113997"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jan 2019 13:01:20 -0800
Received: from orsmsx108.amr.corp.intel.com ([169.254.2.237]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.140]) with mapi id 14.03.0415.000;
 Sat, 19 Jan 2019 13:01:20 -0800
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: libnvdimm fixes 5.0-rc3
Thread-Topic: libnvdimm fixes 5.0-rc3
Thread-Index: AQHUsDogIzT3WH5js0iYSomPiaDT/Q==
Date:   Sat, 19 Jan 2019 21:01:19 +0000
Message-ID: <1992f8e8823f44f583a36d6d027f6e6ef5b3909a.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.19.186]
Content-Type: text/plain; charset="utf-7"
Content-ID: <049E1EF1D7C85743BC795666A8AC3979@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.0-rc3

...to receive a crash fix, a build warning fix, a miscellaneous small
cleanups.

In case anyone is looking for them, there was a regression caught by
testing that caused 2 patches to be dropped from this update. Those
patches +AFs-1+AF0- +AFs-2+AF0- have been reworked and will soak for another week / re-
target 5.0-rc4.

+AFs-1+AF0-: +ACI-acpi/nfit: Block function zero DSMs+ACI-
https://patchwork.kernel.org/patch/10765211/
+AFs-2+AF0-: +ACI-acpi/nfit: Fix command-supported detection+ACI- 
https://patchwork.kernel.org/patch/10772123/

Everything else has been in -next release with no reported issues.

---

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.0-rc3

for you to fetch changes up to faa8bd6e12e6aeea289d8e6ba74777b72a69434c:

  libnvdimm/security: Fix nvdimm+AF8-security+AF8-state() state request selection (2019-01-15 13:54:33 -0800)

----------------------------------------------------------------
libnvdimm v5.0-rc3

+ACo- Fix driver initialization crash due to the inability to report an
  'error' state for a DIMM's security capability.
+ACo- Build warning fix for little-endian ARM64 builds
+ACo- Fix a potential race between the EDAC driver's usage of the NFIT
  SMBIOS id for a DIMM and the driver shutdown path.
+ACo- A small collection of one-line benign cleanups for duplicate variable
  assignments, a duplicate header include and a mis-typed function
  argument.

----------------------------------------------------------------
Dan Williams (1):
      libnvdimm/dimm: Fix security capability detection for non-Intel NVDIMMs

Dave Jiang (1):
      libnvdimm/security: Fix nvdimm+AF8-security+AF8-state() state request selection

Nathan Chancellor (1):
      nfit: Mark some functions as +AF8AXw-maybe+AF8-unused

Tony Luck (1):
      acpi/nfit: Fix race accessing memdev in nfit+AF8-get+AF8-smbios+AF8-id()

Wei Yang (1):
      acpi/nfit: Remove duplicate set nd+AF8-set in acpi+AF8-nfit+AF8-init+AF8-interleave+AF8-set()

Xiaochun Lee (2):
      ACPI/nfit: delete the redundant header file
      ACPI/nfit: delete the function to+AF8-acpi+AF8-nfit+AF8-desc

 drivers/acpi/nfit/core.c  +AHw- 20 +-+-+-+-+-+-+--------------
 drivers/acpi/nfit/intel.c +AHw-  8 +-+-+-+-----
 drivers/nvdimm/nd-core.h  +AHw-  4 +-+---
 include/linux/libnvdimm.h +AHw-  1 +-
 4 files changed, 14 insertions(+-), 19 deletions(-)
