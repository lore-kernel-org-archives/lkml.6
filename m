Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E14C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC6821525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4ZJVVuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC6821525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbeIUBDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42754 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388566AbeIUBDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so4816009pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=01WmUgIW1OWlyPapIkQEl4ZrjagA1ZB1X+PpdEEUliU=;
        b=S4ZJVVuXSJzZeINhHnsuWaB8TyQ6TgeAC4uh97k6JK+dpoMbMOXOxSpD5lhDu/EjlV
         3c7Ybvi3nxLfwi8ux79bEr8icJlFIw5iS1Y+Hy4C3H7GJpRS1l8QEHjvzEYYyv9CGJQI
         qrA8D4b3w7KKXlSqxAKSC8K5k2bhksbrIX13Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=01WmUgIW1OWlyPapIkQEl4ZrjagA1ZB1X+PpdEEUliU=;
        b=U/mE9ALQf73MCvEYJyQrmShc6obrPnE82ExcSqxHlTn++B41TyFE55uJWnnea9S2kc
         QhgRSCkmdOc04H7/cXt8Rk6LMjeU5Zs20psvDBilIMtRdA3ksCYeB9VBG3qRjz98PFGo
         sGbNyG3QDBpDXXWKnEJ5KLdCri26Zfc79xvqPDDXk/sk5Zbm+Iavq99I/2beio5CDj5I
         d2cylnhUDebt2U53Og2JC+6StSrKWtGwS9lFeD2zWdryyqHPOq2vjR3uO+sev416jQ6u
         SQRmUm65oRpcTO7lQ6Rv4Lz8rVii9tE1GFczo2adynnsj0ym/la9SunpV78LDfZYNE32
         Q2Rg==
X-Gm-Message-State: APzg51D7bKlIGKeqXVxRQVW6eq5Rsl2ENsQHQ1+XeKzoaG4Sp+eCtLs3
        xpJxAgZ6WcQP044vlh+xBzNQgw==
X-Google-Smtp-Source: ANB0VdbrUKqlfGH17b7x0EMnMOVYEVbq7vzsUnnB3M2zON+/gPhry0vs3EkN1/1eklwzFJYVsM4PAw==
X-Received: by 2002:a62:5290:: with SMTP id g138-v6mr42138275pfb.46.1537471101140;
        Thu, 20 Sep 2018 12:18:21 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:20 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 00/44] coresight: next v4.19-rc4 
Date:   Thu, 20 Sep 2018 13:17:35 -0600
Message-Id: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Greg,

To start with here is the tally I gathered for inclusion in the 4.20
cycle - please consider at your convenience.  As usual everything applies
cleanly on your char-misc-next branch (f685fc6ab051).

Second, given the increasing number of patches coming into the coresight
subsystem and your new reponsabilities, I was wondering if you'd rather receive
a pull request from hereon.  Let me know what works best for you.

Cordially,
Mathieu 


Leo Yan (2):
  coresight: tmc: Refactor loops in etb dump
  coresight: tmc: Fix byte-address alignment for RRP

Mathieu Poirier (2):
  coresight: etb10: Refactor etb_drvdata::mode handling
  coresight: etb10: Splitting function etb_enable()

Suzuki K Poulose (37):
  coresight: Document error handling in coresight_register
  coresight: platform: Refactor graph endpoint parsing
  coresight: platform: Fix refcounting for graph nodes
  coresight: platform: Fix leaking device reference
  coresight: Fix remote endpoint parsing
  coresight: Add helper to check if the endpoint is input
  coresight: platform: Cleanup coresight connection handling
  coresight: Cleanup coresight DT bindings
  coresight: Fix handling of sinks
  coresight: etb10: Fix handling of perf mode
  coresight: perf: Fix per cpu path management
  coresight: perf: Avoid unncessary CPU hotplug read lock
  coresight: perf: Allow tracing on hotplugged CPUs
  coresight: perf: Disable trace path upon source error
  coresight: tmc-etr: Handle driver mode specific ETR buffers
  coresight: tmc-etr: Relax collection of trace from sysfs mode
  coresight: Convert driver messages to dev_dbg
  coresight: perf: Remove reset_buffer call back for sinks
  coresight: perf: Add helper to retrieve sink configuration
  coresight: perf: Remove set_buffer call back
  coresight: etm-perf: Add support for ETR backend
  coresight: Handle failures in enabling a trace path
  coresight: tmc-etr: Refactor for handling errors
  coresight: tmc-etr: Handle errors enabling CATU
  coresight: tmc-etb/etf: Prepare to handle errors enabling
  coresight: etm4x: Add support for handling errors
  coresight: etm3: Add support for handling errors
  coresight: etb10: Handle errors enabling the device
  coresight: dynamic-replicator: Handle multiple connections
  coresight: Add support for CLAIM tag protocol
  coresight: etmx: Claim devices before use
  coresight: funnel: Claim devices before use
  coresight: catu: Claim device before use
  coresight: dynamic-replicator: Claim device for use
  coreisght: tmc: Claim device before use
  coresight: dts: binding: Fix example for TPIU component
  coresight: dts: binding: Update coresight binding examples

Tomasz Nowicki (1):
  coresight: etm4x: Configure EL2 exception level when kernel is running
    in HYP

zhong jiang (2):
  coresight: Use ERR_CAST instead of ERR_PTR
  coresight: Remove redundant null pointer check before of_node_put and
    put_device

 .../devicetree/bindings/arm/coresight.txt          | 120 ++++---
 drivers/hwtracing/coresight/coresight-catu.c       |   6 +
 .../coresight/coresight-dynamic-replicator.c       |  81 ++++-
 drivers/hwtracing/coresight/coresight-etb10.c      | 183 ++++++----
 drivers/hwtracing/coresight/coresight-etm-perf.c   | 132 +++----
 drivers/hwtracing/coresight/coresight-etm-perf.h   |  26 ++
 drivers/hwtracing/coresight/coresight-etm3x.c      |  58 +++-
 drivers/hwtracing/coresight/coresight-etm4x.c      |  93 +++--
 drivers/hwtracing/coresight/coresight-funnel.c     |  28 +-
 drivers/hwtracing/coresight/coresight-priv.h       |   9 +-
 drivers/hwtracing/coresight/coresight-replicator.c |   4 +-
 drivers/hwtracing/coresight/coresight-stm.c        |   4 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    | 198 ++++++-----
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 385 ++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc.c        |   4 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |   4 +
 drivers/hwtracing/coresight/coresight-tpiu.c       |   6 +-
 drivers/hwtracing/coresight/coresight.c            | 184 +++++++---
 drivers/hwtracing/coresight/of_coresight.c         | 262 +++++++++-----
 include/linux/coresight.h                          |  41 ++-
 20 files changed, 1268 insertions(+), 560 deletions(-)

-- 
2.7.4

