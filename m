Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AFBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CE421915
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbeLTULw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:11:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:41368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728835AbeLTULv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:11:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18AE8ACC4;
        Thu, 20 Dec 2018 20:11:49 +0000 (UTC)
Date:   Thu, 20 Dec 2018 21:11:45 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC pile for 4.21
Message-ID: <20181220201137.GD24975@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest pile of shiny new EDAC Christmas patches in the
upcoming merge window of what is going to be 4.21 or maybe the 5.0
kernel. I guess the new number will be a Christmas miracle. :-)

Thx.

------------------>

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_for_4.21

for you to fetch changes up to 75dfa87035f9a2659dd0c48af6b4d9899e79cdc9:

  EDAC, fsl_ddr: Add LS1021A to the list of supported hardware (2018-12-19 11:57:45 +0100)

----------------------------------------------------------------
- Support for ZynqMP DDR controller support to synopsys_edac along
with a driver cleanup and generalization for the addition of support for
the new IP. (Manish Narani)

- Removal of the /sys/bus/edac devices hierarchy. This enabled us to get
rid of the silly memory controllers maximum number notion. (Tony Luck
and Borislav Petkov)

- skx_edac improvements and fixes. (Qiuxu Zhuo and Tony Luck)

- The usual garden variety of small cleanups and fixes.

----------------------------------------------------------------
Alexandre Belloni (2):
      EDAC, i82975x: Fix spelling mistake "reserverd" -> "reserved"
      MAINTAINERS, EDAC: Drop bouncing email

Borislav Petkov (1):
      EDAC: Drop per-memory controller buses

Colin Ian King (1):
      EDAC: Fix indentation issues in several EDAC drivers

Dan Carpenter (1):
      EDAC, qcom_edac: Remove irq_handled local variable

Manish Narani (10):
      EDAC, synopsys: Improve code readability
      EDAC, synopsys: Shorten static function names
      EDAC, synopsys: Correct comments
      EDAC, synopsys: Return void for functions always returning 0
      EDAC, synopsys: Add platform specific structures for the DDR Controller
      EDAC, synopsys: Add error handling for the of_device_get_match_data() result
      dt: bindings: Document ZynqMP DDRC in Synopsys documentation
      EDAC, synopsys: Add macro defines for ZynqMP DDRC
      EDAC, synopsys: Add ECC support for ZynqMP DDR controller
      EDAC, synopsys: Add Error Injection support for ZynqMP DDR controller

Patrick Havelange (1):
      EDAC, fsl_ddr: Add LS1021A to the list of supported hardware

Qiuxu Zhuo (4):
      EDAC, skx: Fix function calling order in skx_exit()
      EDAC, skx: Prepend hex formatting with '0x'
      EDAC, skx: Move debugfs node under EDAC's hierarchy
      EDAC, skx: Let EDAC core show the decoded result for debugfs

Tony Luck (2):
      EDAC, skx: Fix randconfig builds in a better way
      EDAC: Don't add devices under /sys/bus/edac

York Sun (1):
      EDAC, fsl: Move error injection under CONFIG_EDAC_DEBUG

YueHaibing (2):
      EDAC, i82975x: Remove set but not used variable dtype
      EDAC, i5000: Remove set but not used local variables

 .../bindings/memory-controllers/synopsys.txt       |   27 +-
 MAINTAINERS                                        |    1 -
 drivers/edac/Kconfig                               |    6 +-
 drivers/edac/e752x_edac.c                          |    4 +-
 drivers/edac/edac_mc.c                             |    9 +-
 drivers/edac/edac_mc_sysfs.c                       |   33 +-
 drivers/edac/fsl_ddr_edac.c                        |    8 +-
 drivers/edac/fsl_ddr_edac.h                        |    4 +-
 drivers/edac/i3000_edac.c                          |    4 +-
 drivers/edac/i5000_edac.c                          |   13 +-
 drivers/edac/i7core_edac.c                         |    2 +-
 drivers/edac/i82975x_edac.c                        |   21 +-
 drivers/edac/qcom_edac.c                           |    8 +-
 drivers/edac/skx_edac.c                            |  151 +--
 drivers/edac/synopsys_edac.c                       | 1204 +++++++++++++++++---
 include/linux/adxl.h                               |    5 -
 include/linux/edac.h                               |    6 -
 17 files changed, 1174 insertions(+), 332 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
