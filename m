Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191B3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82662146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547202087;
	bh=d1zyP+G6G6EkFdhsKI8WrtSIEUBIXjsyJXCz8U5NWzk=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=L4EFTlDoti5MAzF2pEk/dtypgQyjFOuY96LyETzy5h171VJuE6vkjYkz6KXHg2Rh7
	 HA5aWbWXoy5kzLT8oifgwJeXQtFeMpsePKVVFvQhajhGJ5TdvH1O8LZTo2472NGckd
	 d/No6hVpbh9rr1x9hFSqp8MRetqzRQetNhb32lZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfAKKVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:21:25 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34879 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730164AbfAKKVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:21:24 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so11795434oif.2;
        Fri, 11 Jan 2019 02:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xt3xzfGKFaeM9YZnA/yUUgzRI517iPRUbga06+q0/78=;
        b=YYQcBoDS2efjzUMQbttUgH8EYWErOK21ZXZu0m7ad5JGl4ohv1hdEJq0LAyPmlpnz4
         SVrEfPYsEqjVA8nZcpLfEVSSWqj1RW/j0Ori2woPtuetqeLeLHkHCM2tBsRJVIlsNobo
         lf3JVEaMw1oQ1Z91WkLLrsz3y9YHkChvjumE01nqoithyDyQEZqyC6FQcoifLNLQPjtb
         QIkaIryvfHSWhMEN/l7tRQeriat8quGsZWizbtzlxm7gRyeX6MRALCKbUkna73NfU/rD
         Gwrc+cc8afucTEoazQgnhzRPTmBHUVW4qEAaPvjmui82Qj3mUfylOmtlnIQaH8EmznTP
         jGsw==
X-Gm-Message-State: AJcUukd3b+1Oma23njNj4VsCxHWKbnS6meeDlJRxiGt/t4fnoe5twTSU
        GJ/DsXboEAu1SoyJACzmclnDbgEeSORTUoGntMmdi5kg
X-Google-Smtp-Source: ALg8bN7ZZSFdxqgcloJ/3PDvYJkCBgHviiloxepGaJyXSMEWXalZiQrA8Bb0anSMDik49QuS5QAeT8Q0wzei2sz01wE=
X-Received: by 2002:aca:368a:: with SMTP id d132mr9264614oia.193.1547202082404;
 Fri, 11 Jan 2019 02:21:22 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Jan 2019 11:21:11 +0100
Message-ID: <CAJZ5v0gs=38z8y67j8Y-qbAComzfyucouK0-T7YL1ajoTK3RhQ@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.0-rc2
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
 pm-5.0-rc2

with top-most commit 343e60e52a3a093bb7baeca441789724fcac4bb5

 Merge branches 'pm-cpuidle', 'pm-cpufreq' and 'pm-sleep'

on top of commit bfeffd155283772bbe78c6a05dec7c0128ee500c

 Linux 5.0-rc1

to receive power management updates for 5.0-rc2.

These fix fallout after starting to use hrtimers in the runtime PM
framework, fix a few cpufreq issues, fix a recently broken reference
to cpuidle documentation, update MAINTAINERS entries for cpufreq and
cpuidle and make the recently added system suspend and resume support
in devfreq actually work.

Specifics:

 - Prevent integer overflows from occurring on 32-bit when
   converting milliseconds to nanoseconds in the runtime PM
   framework and update comments that still refer to jiffies
   in it (Vincent Guittot, Ladislav Michl).

 - Fix the SCMI cpufreq driver to always use the same frequency
   units for arch_set_freq_scale() and make the scale-invariant
   load tracking acutally work with this driver (Quentin Perret).

 - Fix freeing of dynamic OPPs in the SCPI and SCMI cpufreq drivers
   broken during the 4.20 defelopment cycle (Viresh Kumar).

 - Prevent the cpufreq core from attempting to return the current
   frequency of offline CPUs (Sudeep Holla).

 - Add devfreq suspend and resume hooks (missed previously) to the
   PM core to make the recently added system suspend and resume
   support in devfreq actually work (Lukasz Luba).

 - Update MAINTAINERS entries for cpufreq and cpuidle, mostly to add
   references to new/current documentation to them (Rafael Wysocki).

 - Fix a recently broken reference to cpuidle documentation (Otto
   Sabart).

Thanks!


---------------

Ladislav Michl (1):
      PM-runtime: Fix 'jiffies' in comments after switch to hrtimers

Lukasz Luba (1):
      PM: sleep: call devfreq suspend/resume

Otto Sabart (1):
      doc: trace: fix reference to cpuidle documentation file

Quentin Perret (1):
      cpufreq: scmi: Fix frequency invariance in slow path

Rafael J. Wysocki (2):
      cpufreq / Documentation: Update cpufreq MAINTAINERS entry
      cpuidle / Documentation: Update cpuidle MAINTAINERS entry

Sudeep Holla (1):
      cpufreq: check if policy is inactive early in __cpufreq_get()

Vincent Guittot (1):
      PM-runtime: Fix autosuspend_delay on 32bits arch

Viresh Kumar (1):
      cpufreq: scpi/scmi: Fix freeing of dynamic OPPs

---------------

 Documentation/trace/coresight-cpu-debug.txt |  2 +-
 MAINTAINERS                                 |  7 +++-
 drivers/base/power/main.c                   |  3 ++
 drivers/base/power/runtime.c                | 11 +++--
 drivers/cpufreq/cpufreq.c                   | 12 ++----
 drivers/cpufreq/scmi-cpufreq.c              |  8 ++--
 drivers/cpufreq/scpi-cpufreq.c              |  4 +-
 drivers/opp/core.c                          | 63 ++++++++++++++++++++++++++---
 include/linux/pm_opp.h                      |  5 +++
 9 files changed, 89 insertions(+), 26 deletions(-)
