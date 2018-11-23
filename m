Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5580AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0E920820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0E920820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409246AbeKWUys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:54:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33422 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393883AbeKWUys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:54:48 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so10247669otl.0;
        Fri, 23 Nov 2018 02:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RTrc90gfMlxCZgiwBCO8uE6FvP/TrDmZK/B99S04B0U=;
        b=OkbdQxg1l5zIQmb2g5pGpVdpqN+MFmX/+k6fdbjwSouNGUCFBGRhZcGwRerqbGESNY
         Lthh3S/o0O5S6SZYFNBlOSnpzAFHs3erb0X1oXsVGpClmQ2Lm9ZFoktvocGgGniaVcST
         SHvC2+/gskJOXMpID1fT7oNCBHCAHN6lj9bMpmbEmHGRCEH3xwZW5RLdL4fso4K9/N3Q
         XqdK8CRv1H7Pelot5Lh9AZkCataZ9JnEk1HDTXLpULAIAxj1oK8jPK9cZU/yxWehqVj7
         PvF6ZAr4LEtjIsNPIFMWM7yu76+RaVflTS5dovRZ7P6ABV/XQ65DY2bHehWE0lK32rP5
         79Ug==
X-Gm-Message-State: AA+aEWYbciAsHzLud8oPI1EyVyIDydjK6heCgy+yfqjcXH8ImP3Hxety
        M6gAdmHPy30DFuUx47PNfyyHMpo4cvYbOu4JqhOWLbT9
X-Google-Smtp-Source: AFSGD/UwTw1KO4D6rQes8oGKviBgfjVpVtMSGwouOt6gh7gve7IcpFzJG5uSnpBnd/all6cHGzWG/Vy4JNbK+5djtxw=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr7821043otq.119.1542967870142;
 Fri, 23 Nov 2018 02:11:10 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Nov 2018 11:10:58 +0100
Message-ID: <CAJZ5v0hpS244DB8nT82TyGFyyNkwg4rgHg834ocrt=+c7wa5CA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v4.20-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.20-rc4

with top-most commit 1d50088ca3956e5dcd2751a658e7869b9af10bb4

 Merge branches 'pm-cpufreq' and 'pm-sleep'

on top of commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6

 Linux 4.20-rc3

to receive power management fixes for 4.20-rc4.

These fix two issues in the Operating Performance Points (OPP)
framework, one cpufreq driver issue, one problem related to the
tasks freezer and a few build-related issues in the cpupower
utility.

Specifics:

 - Fix tasks freezer deadlock in de_thread() that occurs if one
   of its sub-threads has been frozen already (Chanho Min).

 - Avoid registering a platform device by the ti-cpufreq driver
   on platforms that cannot use it (Dave Gerlach).

 - Fix a mistake in the ti-opp-supply operating performance points
   (OPP) driver that caused an incorrect reference voltage to be
   used and make it adjust the minimum voltage dynamically to avoid
   hangs or crashes in some cases (Keerthy).

 - Fix issues related to compiler flags in the cpupower utility
   and correct a linking problem in it by renaming a file with
   a duplicate name (Jiri Olsa, Konstantin Khlebnikov).

Thanks!


---------------

Chanho Min (1):
      exec: make de_thread() freezable

Dave Gerlach (1):
      cpufreq: ti-cpufreq: Only register platform_device when supported

Jiri Olsa (2):
      tools cpupower debug: Allow to use outside build flags
      tools cpupower: Override CFLAGS assignments

Keerthy (2):
      opp: ti-opp-supply: Dynamically update u_volt_min
      opp: ti-opp-supply: Correct the supply in _get_optimal_vdd_voltage call

Konstantin Khlebnikov (1):
      tools/power/cpupower: fix compilation with STATIC=true

---------------

 drivers/cpufreq/ti-cpufreq.c               | 26 +++++++++++++++++++++-----
 drivers/opp/ti-opp-supply.c                |  5 ++++-
 fs/exec.c                                  |  5 +++--
 tools/power/cpupower/Makefile              | 12 ++++++------
 tools/power/cpupower/bench/Makefile        |  2 +-
 tools/power/cpupower/debug/x86_64/Makefile |  4 ++--
 tools/power/cpupower/lib/cpufreq.c         |  2 +-
 tools/power/cpupower/lib/cpuidle.c         |  2 +-
 tools/power/cpupower/lib/cpupower.c        |  4 ++--
 tools/power/cpupower/lib/cpupower_intern.h |  2 +-
 10 files changed, 42 insertions(+), 22 deletions(-)
