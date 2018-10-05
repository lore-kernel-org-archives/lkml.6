Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044EDC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B640A206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B640A206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeJETlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:41:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:8943 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJETlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:41:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 05:43:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,344,1534834800"; 
   d="scan'208";a="97687768"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Oct 2018 05:43:12 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 00/16] stm class: Updates for 4.20
Date:   Fri,  5 Oct 2018 15:42:50 +0300
Message-Id: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

These are the STM device class updates for the char-misc-next. No
dependencies in this patchset, it can be either pulled directly or
applied, the individual patches follow.

These are basically the MIPI SyS-T protocol and all the necessary
infrastructure changes.

These were aired previously; they also address review comments from
Mathieu, who also gave his Tested-By for the series. Also I received
a Reviewed-By from Andy for the memcat_p() stuff, like you asked.

As usual, these are aiaiai-clean (sparse/smatch/coccinelle/cppcheck).
Please consider pulling or applying. Thanks!

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/stm-for-greg-20181005

for you to fetch changes up to b493be37ccb3f7fc64c3bd52fcdee067013d6b22:

  stm class: Use memcat_p() (2018-10-05 14:59:08 +0300)

----------------------------------------------------------------
stm class: Updates for 4.20

These are:
  * infrastructure changes to introduce the concept of "protocol driver"
  * factoring out the existing framing pattern into a protocol driver
  * adding a new protocol driver for MIPI SyS-T protocol
  * documentation updates
  * adding a helper to paste 2 pointer arrays together: memcat_p()

----------------------------------------------------------------
Alexander Shishkin (16):
      stm class: Rework policy node fallback
      stm class: Clarify configfs root type/operations names
      stm class: Clean up stp_configfs_init
      stm class: Introduce framing protocol drivers
      stm class: Add a helper for writing data packets
      stm class: Factor out default framing protocol
      stm class: Switch over to the protocol driver
      stm class: Add MIPI SyS-T protocol support
      stm class: p_sys-t: Add support for CLOCKSYNC packets
      stm class: p_sys-t: Document the configfs interface
      stm class: Document the MIPI SyS-T protocol usage
      stm class: Update documentation to match the new identification rules
      stm class: SPDX-ify the documentation
      stm class: heartbeat: Fix whitespace
      lib: Add memcat_p(): paste 2 pointer arrays together
      stm class: Use memcat_p()

 .../ABI/testing/configfs-stp-policy-p_sys-t        |  41 +++
 Documentation/trace/stm.rst                        |  38 +-
 Documentation/trace/sys-t.rst                      |  62 ++++
 drivers/hwtracing/stm/Kconfig                      |  29 ++
 drivers/hwtracing/stm/Makefile                     |   6 +
 drivers/hwtracing/stm/core.c                       | 292 +++++++++++++---
 drivers/hwtracing/stm/heartbeat.c                  |   2 +-
 drivers/hwtracing/stm/p_basic.c                    |  48 +++
 drivers/hwtracing/stm/p_sys-t.c                    | 382 +++++++++++++++++++++
 drivers/hwtracing/stm/policy.c                     | 147 ++++++--
 drivers/hwtracing/stm/stm.h                        |  56 ++-
 include/linux/string.h                             |   7 +
 lib/Kconfig.debug                                  |   8 +
 lib/Makefile                                       |   1 +
 lib/string.c                                       |  31 ++
 lib/test_memcat_p.c                                | 115 +++++++
 16 files changed, 1164 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-stp-policy-p_sys-t
 create mode 100644 Documentation/trace/sys-t.rst
 create mode 100644 drivers/hwtracing/stm/p_basic.c
 create mode 100644 drivers/hwtracing/stm/p_sys-t.c
 create mode 100644 lib/test_memcat_p.c

-- 
2.19.0

