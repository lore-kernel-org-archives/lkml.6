Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF90C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD974218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2AtEKWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfAaSrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:47:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46708 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAaSrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:47:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so1709898pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6dsOnCFxfIDVb3Xp4oLLINOMaTRi9MeMgOxwf7sFMUA=;
        b=U2AtEKWJCT3eEoJlJ9/lLlwKpctPOGXDCmUQQ+/Odv6ccDR4GVBoQ9SprSmIqTqOVk
         Hh9BU8IdddzmczJWQ0UTOvDy4k5eV8A/lfGzBTdB1eS4+utcYcNH7zsZMKAKIbX/kbgI
         Upl3jJGrpLoC00r0MpUYBUhePBELJvTYa9X+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6dsOnCFxfIDVb3Xp4oLLINOMaTRi9MeMgOxwf7sFMUA=;
        b=M/2uQ0G3am/Jb7oJgNxLs9d1gSi2zWCSbs+ZMJHGUYebHfQAFmf3I7ZgytItmDO8Dc
         iJ9dbFmYoKTSlEJNIEQl44hhtKNP3u1/FCNCLpBOxT5k5/s56pnAztbdCk2gQwqyJXfH
         T8n/mGkAtyY7ft8jesLP/4mAcHJzLqTtvb6nS3UYiTgTao3Kj2eNyi1VEuq2ZCvVhOVm
         rgJ4WcvL2UXJZh2pPrBmzjrCAvDUAtKmM2ObJ47uMamMmL2r9iD/udTRXW3pyNBbcKoY
         JCcmpsIr7CRmR+EszpOiR2kC4VZwNduw56XqIdPYB18BIjxCHw6nE6uKo6nF2rbrOhTD
         bKRg==
X-Gm-Message-State: AJcUukcBZUokYCzkCQ7nxOmLYvVOBLB4YT2/jxF3YfZV0s/zAciuAuk0
        h68hwnR2ks79FoQ2peAjwX98LA==
X-Google-Smtp-Source: ALg8bN44f60OMhTD5z0UBl7ucNLcBF9kGWLfbLrJstu2KplNXgOHx1uUOPfi8pd99IuwVaJYTjhigA==
X-Received: by 2002:a62:6f49:: with SMTP id k70mr35555339pfc.7.1548960437133;
        Thu, 31 Jan 2019 10:47:17 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o66sm6236234pgo.75.2019.01.31.10.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:47:16 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org
Cc:     suzuki.poulose@arm.com, gregkh@linuxfoundation.org,
        mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/7] perf: Communicate sink via event::attr:config2
Date:   Thu, 31 Jan 2019 11:47:07 -0700
Message-Id: <20190131184714.20388-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third revision of a patchset allowing multiple sources to select
the same sink for a session which is a prerequisite for the support of CoreSight
CPU-wide trace scenarios.

The sink ID is communicated to the kernel by way of the event's configuration
attribute (event::attr:config2).  The ID itself is an hash of the sink's name,
something that is readily available and unique.

With this set the mechanic to communicate sink selection to the kernel via
sysfs is no longer needed and removed.

Applies cleanly and tested on 5.0-rc4.

Thanks,
Mathieu

Changes for V3:
* Rebased to rc4.
* Fixed a perf tools command line problem (reported by Suzuki).
* Enhanced error handling in etm_perf_add_symlink_sink().
* Modified memory allocation to used devm_xyx() API.
* Went from using struct device_attribute to struct dev_ext_attribute.

Changes for V2:
* Addressed memory leak in etm_perf_add_symlink_sink()
* Keep track of device attribute for future removal.
* Added PMU attribure for config2.
* Fixed email address signature.

Mathieu Poirier (7):
  perf/aux: Make perf_event accessible to setup_aux()
  coresight: perf: Add "sinks" group to PMU directory
  coresight: Use event attributes for sink selection
  perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU header file
  perf tools: Use event attributes to send sink information to kernel
  perf tools: Removing CoreSight set_drv_config() API
  perf tools: Remove PMU::set_drv_config API

 arch/s390/kernel/perf_cpum_sf.c               |   6 +-
 arch/x86/events/intel/bts.c                   |   4 +-
 arch/x86/events/intel/pt.c                    |   5 +-
 .../hwtracing/coresight/coresight-etm-perf.c  | 112 +++++++++++++++---
 .../hwtracing/coresight/coresight-etm-perf.h  |   6 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   1 +
 drivers/hwtracing/coresight/coresight.c       |  60 ++++++++++
 drivers/perf/arm_spe_pmu.c                    |   6 +-
 include/linux/coresight.h                     |   7 +-
 include/linux/perf_event.h                    |   2 +-
 kernel/events/ring_buffer.c                   |   2 +-
 tools/perf/arch/arm/util/cs-etm.c             |  98 +++++++--------
 tools/perf/arch/arm/util/cs-etm.h             |   3 -
 tools/perf/arch/arm/util/pmu.c                |   2 -
 tools/perf/builtin-record.c                   |  10 --
 tools/perf/builtin-stat.c                     |   9 --
 tools/perf/builtin-top.c                      |  13 --
 tools/perf/util/Build                         |   1 -
 tools/perf/util/drv_configs.c                 |  78 ------------
 tools/perf/util/drv_configs.h                 |  26 ----
 tools/perf/util/pmu.c                         |   2 -
 tools/perf/util/pmu.h                         |   2 +-
 22 files changed, 227 insertions(+), 228 deletions(-)
 delete mode 100644 tools/perf/util/drv_configs.c
 delete mode 100644 tools/perf/util/drv_configs.h

-- 
2.17.1

