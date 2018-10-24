Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34E7ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8492082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8492082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeJYIQE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:16:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:33192 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbeJYIQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:16:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 16:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,422,1534834800"; 
   d="scan'208";a="244119569"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga004.jf.intel.com with ESMTP; 24 Oct 2018 16:45:55 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 16:45:55 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.58]) with mapi id 14.03.0319.002;
 Wed, 24 Oct 2018 16:45:54 -0700
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: [GIT PULL] libnvdimm for 4.20
Thread-Topic: [GIT PULL] libnvdimm for 4.20
Thread-Index: AQHUa/O0x+6C58JiCEiR2fF9VQPW9Q==
Date:   Wed, 24 Oct 2018 23:45:54 +0000
Message-ID: <47580ee876c884c91fdb8c29791257cf715facfa.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.8.242]
Content-Type: text/plain; charset="utf-7"
Content-ID: <AF22FDF13B095F4B8774C951FE46689C@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.20

...to receive the libnvdimm updates for this cycle. No interactions
with other trees this time around. There are updates to the core to
improve driver initialization time, and updates to the 'nfit' driver
for fixing ARS corner cases and exposing some more hardware attributes
to userspace. It has all been in -next for a few releases now with no
reported issues.

---

The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.20

for you to fetch changes up to 594861215c834e4b59a30d4b794f6372717bc197:

  acpi, nfit: Further restrict userspace ARS start requests (2018-10-17 14:02:32 -0700)

----------------------------------------------------------------
libnvdimm for 4.20

+ACo- Improve the efficiency and performance of reading nvdimm-namespace
  labels. Reduce the amount of label data read at driver load time by a
  few orders of magnitude. Reduce heavyweight call-outs to
  platform-firmware routines.

+ACo- Handle media errors located in the 'struct page' array stored on a
  persistent memory namespace. Let the kernel clear these errors rather
  than an awkward userspace workaround.

+ACo- Fix Address Range Scrub (ARS) completion tracking. Correct occasions
  where the kernel indicates completion of ARS before submission.

+ACo- Fix asynchronous device registration reference counting.

+ACo- Add support for reporting an nvdimm dirty-shutdown-count via sysfs.

+ACo- Fix various small libnvdimm core and uapi issues.

----------------------------------------------------------------
Alexander Duyck (7):
      libnvdimm: Hold reference on parent while scheduling async init
      libnvdimm: Set device node in nd+AF8-device+AF8-register
      nvdimm: Sanity check labeloff
      nvdimm: Clarify comment in sizeof+AF8-namespace+AF8-index
      nvdimm: Remove empty if statement
      nvdimm: Split label init out from the logic for getting config data
      nvdimm: Use namespace index data to reduce number of label reads needed

Dan Williams (9):
      libnvdimm, region: Fail badblocks listing for inactive regions
      libnvdimm, pmem: Fix badblocks population for 'raw' namespaces
      libnvdimm, dimm: Maximize label transfer size
      libnvdimm, label: Fix sparse warning
      acpi, nfit: Introduce nfit+AF8-mem flags
      acpi, nfit: Collect shutdown status
      tools/testing/nvdimm: Populate dirty shutdown data
      acpi, nfit: Fix Address Range Scrub completion tracking
      acpi, nfit: Further restrict userspace ARS start requests

David Howells (2):
      UAPI: ndctl: Fix g+-+--unsupported initialisation in headers
      UAPI: ndctl: Remove use of PAGE+AF8-SIZE

GuangZhe Fu (1):
      libnvdimm, namespace: Drop the repeat assignment for variable dev-+AD4-parent

Pankaj Gupta (1):
      libnvdimm: remove duplicate include

Vishal Verma (1):
      libnvdimm, pfn: during init, clear errors in the metadata area

 drivers/acpi/nfit/core.c              +AHw- 297 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+------------
 drivers/acpi/nfit/intel.h             +AHw-  38 +-+-+-+-+-
 drivers/acpi/nfit/nfit.h              +AHw-  21 +-+--
 drivers/nvdimm/bus.c                  +AHw-  20 +-+--
 drivers/nvdimm/dimm.c                 +AHw-   6 +--
 drivers/nvdimm/dimm+AF8-devs.c            +AHw-  60 +-+-+-----
 drivers/nvdimm/label.c                +AHw- 144 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+--
 drivers/nvdimm/label.h                +AHw-   4 +--
 drivers/nvdimm/namespace+AF8-devs.c       +AHw-   1 -
 drivers/nvdimm/nd-core.h              +AHw-   1 -
 drivers/nvdimm/nd.h                   +AHw-   2 +-
 drivers/nvdimm/pfn+AF8-devs.c             +AHw-  61 +-+-+-+-+-+--
 drivers/nvdimm/pmem.c                 +AHw-   4 +--
 drivers/nvdimm/region+AF8-devs.c          +AHw-  11 +--
 include/linux/ndctl.h                 +AHw-  22 +-+-+-
 include/uapi/linux/ndctl.h            +AHw-  52 +-+-+----
 tools/testing/nvdimm/Kbuild           +AHw-   1 +-
 tools/testing/nvdimm/acpi+AF8-nfit+AF8-test.c +AHw-   8 +-
 tools/testing/nvdimm/test/nfit.c      +AHw-   4 +--
 tools/testing/nvdimm/test/nfit+AF8-test.h +AHw-  24 ---
 20 files changed, 564 insertions(+-), 217 deletions(-)
 create mode 100644 drivers/acpi/nfit/intel.h
 create mode 100644 include/linux/ndctl.h
