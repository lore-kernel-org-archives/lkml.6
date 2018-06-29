Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C87CC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD85527C44
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJsXWbjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD85527C44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966400AbeF2JUX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:20:23 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36758 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932880AbeF2JUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:20:21 -0400
Received: by mail-ot0-f193.google.com with SMTP id c15-v6so9233548otl.3;
        Fri, 29 Jun 2018 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=d2e0RwmE/BAv6zbkuaex2HLxyElwlflwpet52+Z7FKI=;
        b=RJsXWbjvLa1nc/BfHOSJMl+kOrhMyyNmR9tPgsxImOBONqK07n+JxWfqmUgle8u9ZC
         cU7LAGFX9EWiNZySQJfNxbMrez2WfiXxj6wn1s20m5lpRF/wYS/nyAYCXTxrkT7zsVSx
         xycweLO2iUYxv0ZhAyu/T88BQuWdwA8IScngA7hQ+/1/Lg5DEuMJkGyscr97TZMLuijT
         3TalhE9PieYRSqch4lomZoUBLxnqPgjaxBAZgEKWF3C0t9KCF+er8RmYmPcKYA+cici0
         HN6oBD0jAijzcQzzuFeZGjWcovM6LN1EGmVLGsbZtGH/HKHPlCerhiXp8EqwifHnzsXm
         LFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=d2e0RwmE/BAv6zbkuaex2HLxyElwlflwpet52+Z7FKI=;
        b=pVKY68AGQ6fN/JWsOxhEVHX+xKhWv+H9yE/owyILx0t9ujp1KggJMPmZC+u1uSvaiy
         dACi+1y4bu1qsmwsRSYqMdRo4feHH52Z64iNOUnZczHwmWMNHq/RMeR6pJhWc54tmgDN
         NH3ChSjFgzHFqN8mpBe4b2t0NPOum7VwQsgcqT+9pdyVyOQvXiC2rODqDPyUrHMK2opN
         bHAfvFlv3+SgmZeiaq1yI93gskW+KQC7dTN6UOD5/yltd+D4k+/y2qtlJWVo0WulRQqR
         wLTOtY68+4565DNd7737D/my/yAMFdZlFe0l+KkHoYVq4oi5I3FsRKUqv/D46s6hjYrr
         5FsQ==
X-Gm-Message-State: APt69E2VybkeTweXfBjJ2IHJqDuH+4vXNA2fPFhXkuVPeaNPcQdb8yKc
        LtJM+M4QGofyt7QTtVvplQT3hOFrYqJll9B0ieFwaA==
X-Google-Smtp-Source: AAOMgpcDEdvSQlv1lx3uWV3jT7uSrphA0kAebzh56tux/jxHWcxlcLTAAtCJN53tGCrLI4kYWDGqNl548f+ow7ikI+0=
X-Received: by 2002:a9d:2e68:: with SMTP id c37-v6mr4726721otd.271.1530264020578;
 Fri, 29 Jun 2018 02:20:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1427:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 02:20:20
 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Jun 2018 11:20:20 +0200
X-Google-Sender-Auth: 9EjPN-5Zm-K8f-gygXf8ByQLRQY
Message-ID: <CAJZ5v0ip3jHZTmu6U5bjeHVjYpEhvvNM0zducPu63vo7z07enw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v4.18-rc3
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
 pm-4.18-rc3

with top-most commit e27b4d4a7b987ffa93a5a1249dd83dcb69f8d040

 Merge branch 'pm-domains'

on top of commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819

 Linux 4.18-rc2

to receive power management fixes for 4.18-rc3.

These fix up recently added features (the Kryo cpufreq driver
and performance states coverage in the generic power domains
framework), add missing documentation for a recently added
sysfs knob in the intel_pstate driver and fix an error in its
documentation.

Specifics:

 - Fix the initialization time error handling in the recently added
   Kryo cpufreq driver (Dan Carpenter).

 - Fix up the recently added coverage of performance states in the
   generic power domains (genpd) framework (Viresh Kumar).

 - Add missing documentation of the new hwp_dynamic_boost sysfs knob
   in the intel_pstate driver (Rafael Wysocki).

 - Fix incorrect sysfs path in the intel_pstate driver documentation
   (Rafael Wysocki).

Thanks!


---------------

Dan Carpenter (1):
      cpufreq: qcom-kryo: Fix error handling in probe()

Rafael J. Wysocki (2):
      Documentation: admin-guide: intel_pstate: Fix sysfs path
      Documentation: intel_pstate: Describe hwp_dynamic_boost sysfs knob

Viresh Kumar (2):
      PM / Domains: Fix return value of of_genpd_opp_to_performance_state()
      PM / Domains: Rename opp_node to np

---------------

 Documentation/admin-guide/pm/intel_pstate.rst | 14 ++++++++++++--
 drivers/base/power/domain.c                   |  7 +++----
 drivers/cpufreq/qcom-cpufreq-kryo.c           |  8 ++++----
 include/linux/pm_domain.h                     |  6 +++---
 4 files changed, 22 insertions(+), 13 deletions(-)
