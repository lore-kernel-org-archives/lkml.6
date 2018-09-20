Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1AFECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238C621529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238C621529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbeITS3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:29:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:24357 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387453AbeITS3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:29:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 05:46:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="87820837"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2018 05:46:09 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [QUEUED v20180920 00/16] stm class/intel_th: Queued updates for v4.20
Date:   Thu, 20 Sep 2018 15:45:37 +0300
Message-Id: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These are patches I have queued so far, that I'm planning to send to
Greg for the next merge window. This is mainly support for MIPI SyS-T
protocol and all the infrastructure changes to make it possible.

MIPI SyS-T is a public standard [0] for a software-level trace protocol
that in this instance we use on top of STM devices (if we choose to) and
MIPI STP protocol.

The old "protocol" is preserved for compatibility.

[0] http://www.mipi.org/specifications/sys-t

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
  intel_th: SPDX-ify the documentation
  stm class: SPDX-ify the documentation
  stm class: heartbeat: Fix whitespace
  lib: Add memcat_p(): paste 2 pointer arrays together
  stm class: Use memcat_p()

 .../ABI/testing/configfs-stp-policy-p_sys-t   |  41 ++
 Documentation/trace/intel_th.rst              |   2 +
 Documentation/trace/stm.rst                   |   2 +
 Documentation/trace/sys-t.rst                 |  62 +++
 drivers/hwtracing/stm/Kconfig                 |  29 ++
 drivers/hwtracing/stm/Makefile                |   6 +
 drivers/hwtracing/stm/core.c                  | 292 +++++++++++---
 drivers/hwtracing/stm/heartbeat.c             |   2 +-
 drivers/hwtracing/stm/p_basic.c               |  47 +++
 drivers/hwtracing/stm/p_sys-t.c               | 381 ++++++++++++++++++
 drivers/hwtracing/stm/policy.c                | 148 +++++--
 drivers/hwtracing/stm/stm.h                   |  57 ++-
 include/linux/string.h                        |   7 +
 lib/Kconfig.debug                             |   8 +
 lib/Makefile                                  |   1 +
 lib/string.c                                  |  31 ++
 lib/test_memcat_p.c                           | 115 ++++++
 17 files changed, 1138 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-stp-policy-p_sys-t
 create mode 100644 Documentation/trace/sys-t.rst
 create mode 100644 drivers/hwtracing/stm/p_basic.c
 create mode 100644 drivers/hwtracing/stm/p_sys-t.c
 create mode 100644 lib/test_memcat_p.c

-- 
2.18.0

