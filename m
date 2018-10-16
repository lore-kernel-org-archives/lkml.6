Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774A4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA7120866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA7120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeJPW5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:57:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45493 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPW5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:57:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06D4C307D856;
        Tue, 16 Oct 2018 15:06:24 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CA6D58902;
        Tue, 16 Oct 2018 15:06:16 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Len Brown <len.brown@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Renninger <trenn@suse.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: [PATCH 00/10] tools: Various build flags fixes
Date:   Tue, 16 Oct 2018 17:06:05 +0200
Message-Id: <20181016150614.21260-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 16 Oct 2018 15:06:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
while hardening some of the tools rpm, we noticed we
can't pass build flags to some of them. 

Sending separate tools fixes for what we found. It's
mostly override for CFLAGS and adding LDFLAGS to the
build commands.

thanks,
jirka


Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Len Brown <len.brown@intel.com>
Cc: Markus Mayer <mmayer@broadcom.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Signed-off-by: Len Brown <len.brown@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Renninger <trenn@suse.com>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
---
Jiri Olsa (10):
      tools lib traceevent: Use LDFLAGS in the build commands
      tools perf: Pass build flags to traceevent build
      tools cpupower debug: Allow to use outside build flags
      tools cpupower: Override CFLAGS assignments
      tools power x86_energy_perf_policy: Override CFLAGS assignments and add LDFLAGS to build command
      tools thermal tmon: Override CFLAGS assignments
      tools thermal tmon: Use -O3 instead of -O1 if available
      tools power turbostat: Override CFLAGS assignments and add LDFLAGS to build command
      tools iio: Override CFLAGS assignments
      tools gpio: Override CFLAGS assignments

 tools/gpio/Makefile                             |  2 +-
 tools/iio/Makefile                              |  2 +-
 tools/lib/traceevent/Makefile                   |  4 ++--
 tools/perf/Makefile.perf                        |  2 +-
 tools/power/cpupower/Makefile                   | 12 ++++++------
 tools/power/cpupower/debug/x86_64/Makefile      |  4 ++--
 tools/power/x86/turbostat/Makefile              |  8 ++++----
 tools/power/x86/x86_energy_perf_policy/Makefile |  6 +++---
 tools/thermal/tmon/Makefile                     |  8 ++++----
 9 files changed, 24 insertions(+), 24 deletions(-)
