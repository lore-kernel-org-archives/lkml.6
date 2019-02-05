Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BA7C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5179217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vStZKTeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfBEXZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:25:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40637 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfBEXZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:25:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so2223977plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 15:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=D6m7CRodh/5/YlGIlRz4UJH8J7WubmYTTIvewhZXqRU=;
        b=vStZKTeFssW5spCaYPYAW7lYGyYoVFdWjqki1J0IYTxKl0Brd8dz8blOECkVlsa64e
         8ZZI84ngeH/XTiwC1yIttd8pF9CnW2LXVOTLio6fYXZHWtRzQ16N/iXf7JIMEKb7nrI5
         lv6dmR52WZHnaiZ/ZewDAndqdjomWEitZ0RTlRXwUwbwX83HOqX2iIiTaoYf7ycQNNv5
         dSJ/m8dI3+DwFKZFJi/+Wzdkn8aHdOJmD/KHl0JE4l5g8ajMbEukxTfEZ5KijnXRpHqy
         PJCkPyNxwFbWiOactJeGPFl+IzFYXZ4d4Yf6m/DJ46gpkUqPu8Er/iggcSxTeNcn8+ea
         NjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D6m7CRodh/5/YlGIlRz4UJH8J7WubmYTTIvewhZXqRU=;
        b=mWVxbS3ssfXhbHMArQTvMzRykVApWrxwysviODX4K/XI7upvyFcjXlURFzkE/TwL2x
         SLMcvN+XDLfg4WirMbBeSRtItmiRbgC2tqBx5WWsFxVtFmAAxgOdAGTZ6JmVGWJxf5xd
         qyNPQsujSutciPlfNK6gh0TkcHtlC5dq4FDRt9RrYtKIsoTCcJb0dxqMsX6eS9F3iJeP
         p1Gy3zXWhaLZvt48aPjywnU6vAVewDJciYYr3U/her0xy9/REQHJR6RRSKRPIvyiLI55
         ZsEnhCwHenr/6prTUbpd++QXaXoc60pC7ihjlsh/3d74DkwN4Xf1gcKrG+YtqMj8hIfq
         J5tA==
X-Gm-Message-State: AHQUAubmNUqh0gsJTuXJlVBvBQsFxVbZXy+E2r5sH2RDgz+aT4cvrHuJ
        vUUvUBRB2FGI6m0M0LW2SlszysoO8FlN9w==
X-Google-Smtp-Source: AHgI3IZdi4iZPABPFMSthoi5pV537yzWe4jmP3gIZW6mxxRnLZiEiI8UgLFafNCh7evuevhkdyAgWQ==
X-Received: by 2002:a17:902:9887:: with SMTP id s7mr7443761plp.199.1549409100461;
        Tue, 05 Feb 2019 15:25:00 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g136sm5926917pfb.154.2019.02.05.15.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:24:59 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] coresight: next v5.0-rc5 
Date:   Tue,  5 Feb 2019 16:24:52 -0700
Message-Id: <20190205232458.7074-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is what I collected for inclusion in the 5.1 cycle, please have a look when
you have a minute.

Applies cleanly on the char-misc-next branch (9f23379c67fa).

Thanks,
Mathieu

Leo Yan (1):
  coresight: cpu-debug: Support for CA73 CPUs

Mathieu Poirier (3):
  perf/aux: Make perf_event accessible to setup_aux()
  coresight: perf: Add "sinks" group to PMU directory
  coresight: Use event attributes for sink selection

Rob Herring (1):
  coresight: Use of_node_name_eq for node name comparisons

YueHaibing (1):
  coresight: stm: Remove set but not used variable 'res_size'

 arch/s390/kernel/perf_cpum_sf.c               |   6 +-
 arch/x86/events/intel/bts.c                   |   4 +-
 arch/x86/events/intel/pt.c                    |   5 +-
 .../hwtracing/coresight/coresight-cpu-debug.c |   4 +
 .../hwtracing/coresight/coresight-etm-perf.c  | 112 +++++++++++++++---
 .../hwtracing/coresight/coresight-etm-perf.h  |   6 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   1 +
 drivers/hwtracing/coresight/coresight-stm.c   |  12 +-
 drivers/hwtracing/coresight/coresight.c       |  60 ++++++++++
 drivers/hwtracing/coresight/of_coresight.c    |   4 +-
 drivers/perf/arm_spe_pmu.c                    |   6 +-
 include/linux/coresight.h                     |   7 +-
 include/linux/perf_event.h                    |   2 +-
 kernel/events/ring_buffer.c                   |   2 +-
 14 files changed, 192 insertions(+), 39 deletions(-)

-- 
2.17.1

