Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbeENNfA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:35:00 -0400
Received: from foss.arm.com ([217.140.101.70]:42700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932193AbeENNe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:34:58 -0400
From: Robin Murphy <robin.murphy@arm.com>
To: will.deacon@arm.com, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pawel.moll@arm.com, suzuki.poulose@arm.com
Subject: [PATCH v2 0/3] perf: make Arm CCI driver modular
Date: Mon, 14 May 2018 14:34:50 +0100
Message-Id: <cover.1526303815.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.0.dirty
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that it has been surgically removed from the MCPM port-control code,
we can let the CCI PMU driver be modular. Probing the PMU in the first
place still depends on the bus driver stub being built-in, but it's a
small price to pay compared to the major upheaval of completely reworking
the DT-handling code across the two drivers.

Robin.

v2: Fix Kconfig dependencies per kbuild robot report

Robin Murphy (3):
  perf/arm-cc*: Fix MODULE_LICENSE() tags
  perf/arm-cci: Remove pointless PMU disabling
  perf/arm-cci: Allow building as a module

 drivers/perf/Kconfig   | 34 ++++++++++++++++++----------------
 drivers/perf/arm-cci.c | 32 ++++++++++++++++++++------------
 drivers/perf/arm-ccn.c |  2 +-
 3 files changed, 39 insertions(+), 29 deletions(-)

-- 
2.17.0.dirty
