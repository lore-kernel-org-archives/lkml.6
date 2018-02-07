Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeBGN40 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:56:26 -0500
Received: from foss.arm.com ([217.140.101.70]:51228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753763AbeBGN4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:56:25 -0500
From: Robert Walker <robert.walker@arm.com>
To: acme@kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Robert Walker <robert.walker@arm.com>, coresight@lists.linaro.org
Subject: [PATCH 0/2] Perf inject for ETM trace
Date: Wed,  7 Feb 2018 13:56:00 +0000
Message-Id: <1518011762-23925-1-git-send-email-robert.walker@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches add support for using perf inject to generate branch events,
instruction events and branch stacks from CoreSight ETM traces.

They apply to linus's tree with the memory cleanup fix from
https://lkml.org/lkml/2018/1/25/432

Regards

Rob Walker

Robert Walker (2):
  perf tools: inject capabilitity for CoreSight traces
  perf inject: Emit instruction records on ETM trace discontinuity

 Documentation/trace/coresight.txt               |  51 +++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  74 +++-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |   2 +
 tools/perf/util/cs-etm.c                        | 471 +++++++++++++++++++++---
 4 files changed, 532 insertions(+), 66 deletions(-)

-- 
2.7.4
