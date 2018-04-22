Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753354AbeDVARa convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 20:17:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:22035 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753280AbeDVAR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 20:17:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,308,1520924400";
   d="scan'208";a="33682791"
From: "Williams, Dan J" <dan.j.williams@intel.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: [GIT PULL] libnvdimm fixes for 4.17-rc2
Thread-Topic: [GIT PULL] libnvdimm fixes for 4.17-rc2
Thread-Index: AQHT2c9K+WXJ8X2m5kSEW8QU81zYwg==
Date: Sun, 22 Apr 2018 00:17:25 +0000
Message-ID: <1524356236.26036.13.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.112.51]
Content-Type: text/plain; charset="utf-7"
Content-ID: <07665B705A136D459F8F248D670F4E73@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

...to receive, a regression fix, new unit test infrastructure and a
build fix.

+ACo- The regression fix addresses support for the new NVDIMM label storage
area access commands (+AF8-LSI, +AF8-LSR, and +AF8-LSW). The Intel specific version
of these commands communicated the +ACI-Device Locked+ACI- status on the label-
storage-information command. However, these new commands (standardized
in ACPI 6.2) communicate the +ACI-Device Locked+ACI- status on the label-
storage-read command, and the driver was missing the indication.
Reading from locked persistent memory is similar to reading unmapped
PCI memory space, returns all 1's.

+ACo- Unit test infrastructure is added to regression test the +ACI-Device
Locked+ACI- detection failure.

+ACo- A build fix is included to allow the +ACI-of+AF8-pmem+ACI- driver to be built as
a module and translate an Open Firmware described device to its local
numa node.

---

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

for you to fetch changes up to c5794510d7b5f210f05531ff9e82432cf7244367:

  MAINTAINERS: Add backup maintainers for libnvdimm and DAX (2018-04-19 15:22:50 -0700)

----------------------------------------------------------------
Dan Williams (6):
      libnvdimm, dimm: handle EACCES failures from label reads
      tools/testing/nvdimm: allow custom error code injection
      tools/testing/nvdimm: support nfit+AF8-test+AF8-dimm attributes under nfit+AF8-test.1
      tools/testing/nvdimm: fix missing newline in nfit+AF8-test+AF8-dimm 'handle' attribute
      tools/testing/nvdimm: enable labels for nfit+AF8-test.1 dimms
      Revert +ACI-libnvdimm, of+AF8-pmem: workaround OF+AF8-NUMA+AD0-n build error+ACI-

Dave Jiang (2):
      device-dax: allow MAP+AF8-SYNC to succeed
      MAINTAINERS: Add backup maintainers for libnvdimm and DAX

Rob Herring (1):
      libnvdimm, of+AF8-pmem: use dev+AF8-to+AF8-node() instead of of+AF8-node+AF8-to+AF8-nid()

 MAINTAINERS                      +AHw- 15 +-+-+-+-+-+-+-
 drivers/dax/device.c             +AHw-  2 +-
 drivers/nvdimm/Kconfig           +AHw-  3 +--
 drivers/nvdimm/dimm+AF8-devs.c       +AHw- 22 +-+-+-+-+-+------
 drivers/nvdimm/of+AF8-pmem.c         +AHw-  2 +--
 tools/testing/nvdimm/test/nfit.c +AHw- 84 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+----------
 6 files changed, 96 insertions(+-), 32 deletions(-)
