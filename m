Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753030AbeEKO3V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:29:21 -0400
Received: from foss.arm.com ([217.140.101.70]:42376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751204AbeEKO3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:29:20 -0400
From: Robin Murphy <robin.murphy@arm.com>
To: will.deacon@arm.com, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pawel.moll@arm.com, suzuki.poulose@arm.com
Subject: [PATCH 0/3] perf: make Arm CCI driver modular
Date: Fri, 11 May 2018 15:29:11 +0100
Message-Id: <cover.1526048005.git.robin.murphy@arm.com>
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


Robin Murphy (3):
  perf/arm-cc*: Fix MODULE_LICENSE() tags
  perf/arm-cci: Remove pointless PMU disabling
  perf/arm-cci: Allow building as a module

 drivers/perf/Kconfig   | 31 +++++++++++++++++--------------
 drivers/perf/arm-cci.c | 32 ++++++++++++++++++++------------
 drivers/perf/arm-ccn.c |  2 +-
 3 files changed, 38 insertions(+), 27 deletions(-)

-- 
2.17.0.dirty
