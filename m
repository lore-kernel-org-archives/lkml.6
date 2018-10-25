Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE838C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816C62083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgZ+swB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816C62083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeJZC3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:29:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39926 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeJZC3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:29:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so4354260pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RGtaFss1HF8dJPqV8E/bhlIgb1auMeWrV87q5PX6a2A=;
        b=OgZ+swB8NCYBe5kQvsAnHCwtIG8LQKRsXOzBAkmvx+XxUZSsb94dPrAqZtgFZGVpyu
         j0UbRCpCZ8RCzYI06mmkz8gthz/In5ocqMJJFU57TzonHoLt/fBc+sBAAmUNTPEBxHPn
         2YecUQbico+eXIl3sstvuE8AcdW2Y5DA/uyBk5QHMcw4/DCkKFka7k478q84l0QYzJAx
         It8YozQbd6xs83qUoZ+2/BCYBTf9Fislr+TIDqqastGN+V4thm8ScalvSctFNa1H5U0v
         GFKK7opq/+WdMHVURfWbJGjlQqoJ/R/HZJWYosmwtj6A4dwNZQz+KhcpIqXsH9A0Aio2
         lhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RGtaFss1HF8dJPqV8E/bhlIgb1auMeWrV87q5PX6a2A=;
        b=Rvui3k6mCUDMWN3YoAj8uDjnjwv8nIgTW/zhEs8WUiDAfVGv/BfKOTLKtG8BIs3bXp
         wpy0LdBUe3j5APMCpRnlJefpqOObvlzfzgXKWZV6LCNnwfCkKBNB1SyTjr/S8aljhROQ
         X/gTmHqPLRdFhWK+lneFFXvLmoQdDID7GDAv2kbTPp0Wt01tvmwbZqdRSG3ECRQk8nrF
         mLjA2+oEtQz3a5yWmNIHa0FcAIlPmzINfgDYkRdFoffX3FGKUvjU34QC/DPaxGzRUYVd
         q5BC5S9AKI7SCbobUYMds1KEL7VNOSuT8t88BDRRsr5Q2p3vBE9DGoUu2IIYm+1GHfnX
         We5A==
X-Gm-Message-State: AGRZ1gJz2Vx3hH9S81V6H7yB2ua50wHV2lMItYUKp8Ne62iYLWgU9Ym+
        AygpkEYi5DXE14ol2UVIkj7G0VBj
X-Google-Smtp-Source: AJdET5dFSSIqT3dMl65Tib4ZivtZGPPAPjEkuCg/uAJ+AJG318SG/cEf+Zhnj2+FfaQuUkIf2KMtUw==
X-Received: by 2002:a62:104b:: with SMTP id y72-v6mr194139pfi.113.1540490142149;
        Thu, 25 Oct 2018 10:55:42 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id p19-v6sm2261885pff.172.2018.10.25.10.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 10:55:41 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de
Subject: [PATCH v2 0/2] perf tests: Check for ARM [vectors] page
Date:   Thu, 25 Oct 2018 10:55:06 -0700
Message-Id: <20181025175508.6967-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just painfully learned that perf would segfault when
CONFIG_KUSER_HELPERS is disabled because it unconditionally makes use of
it. This patch series adds an ARM test for that by leveraging the
existing find_vdso_map() function and making it more generic and capable
of location any map within /proc/self/maps.

Changes in v2:

- use strlen() instead of sizeof() -1 since we made the page name a
  parameter
- use TEST_OK/TEST_FAIL in lieu of 0/-1
- added an error message indicating CONFIG_KUSER_HELPERS might be
  disabled

Florian Fainelli (2):
  perf tools: Make find_vdso_map() more modular
  perf tests: Add a test for the ARM 32-bit [vectors] page

 tools/perf/arch/arm/tests/Build          |  1 +
 tools/perf/arch/arm/tests/arch-tests.c   |  4 +++
 tools/perf/arch/arm/tests/vectors-page.c | 24 ++++++++++++++++++
 tools/perf/tests/tests.h                 |  5 ++++
 tools/perf/util/find-map.c               | 31 ++++++++++++++++++++++++
 tools/perf/util/find-vdso-map.c          | 30 +++--------------------
 6 files changed, 68 insertions(+), 27 deletions(-)
 create mode 100644 tools/perf/arch/arm/tests/vectors-page.c
 create mode 100644 tools/perf/util/find-map.c

-- 
2.17.1

