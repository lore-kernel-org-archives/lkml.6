Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755434AbeDCLoj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:44:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:58672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755135AbeDCLoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:44:37 -0400
Date: Tue, 3 Apr 2018 13:44:33 +0200
From: Borislav Petkov <bp@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC tree for 4.17
Message-ID: <20180403114432.GA29513@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here's this round of EDAC updates. Noteworthy is the NVDIMM support
by Tony Luck.

Please pull,
thanks!

---
The following changes since commit bf8486709ac7fad99e4040dea73fe466c57a4ae1:

  EDAC, sb_edac: Fix out of bound writes during DIMM configuration on KNL (2018-02-23 12:05:37 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_for_4.17

for you to fetch changes up to 6fd052665274b4e7570491ba272f2dbb09cbbcd5:

  EDAC, sb_edac: Remove variable length array usage (2018-03-17 05:24:55 +0100)

----------------------------------------------------------------
* Add NVDIMM support to EDAC (Tony Luck)

* misc fixes

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      EDAC, sb_edac: Remove variable length array usage

Rasmus Villemoes (1):
      EDAC, layerscape: Allow building for LS1021A

Tony Luck (5):
      EDAC: Drop duplicated array of strings for memory type names
      EDAC: Add new memory type for non-volatile DIMMs
      acpi, nfit: Add function to look up nvdimm device and provide SMBIOS handle
      firmware, DMI: Add function to look up a handle and return DIMM size
      EDAC, skx_edac: Detect non-volatile DIMMs

 drivers/acpi/nfit/core.c     | 27 ++++++++++++++++++
 drivers/edac/Kconfig         |  7 +++--
 drivers/edac/edac_mc.c       | 41 ++++++++++++++-------------
 drivers/edac/edac_mc_sysfs.c | 26 ++---------------
 drivers/edac/sb_edac.c       | 12 ++++----
 drivers/edac/skx_edac.c      | 67 ++++++++++++++++++++++++++++++++++++++++----
 drivers/firmware/dmi_scan.c  | 31 ++++++++++++++++++++
 include/acpi/nfit.h          | 18 ++++++++++++
 include/linux/dmi.h          |  2 ++
 include/linux/edac.h         |  3 ++
 10 files changed, 175 insertions(+), 59 deletions(-)
 create mode 100644 include/acpi/nfit.h

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
