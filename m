Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6326C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860E1217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546532037;
	bh=TIQatImfXkjQTEboaAOgvQZYQrJ7cd5ujTi7x+odJ8Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DCt/xaBDlPP1hMMNb7mcFkO9z4v2nPpEBgItGPrEAno7V96WXKIVAmnPq5Jym48J8
	 oSGE2RQPGyqL7dVAdWomU3OisGk24XKfSJs7xZ/igWSup2fq+FF/7vY0VONrVsaUDH
	 sjY4Z9cDtK6ZSO6c5R/mtjTy0E3TBcJgm6NaRJm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbfACQN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:13:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732152AbfACQN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:13:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D2B27FD44;
        Thu,  3 Jan 2019 16:13:55 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7760B5D9C5;
        Thu,  3 Jan 2019 16:13:51 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Len Brown <len.brown@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        Zhang Rui <rui.zhang@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCHv3 0/2] tools: Various build flags fixes
Date:   Thu,  3 Jan 2019 17:13:48 +0100
Message-Id: <20190103161350.11446-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 03 Jan 2019 16:13:55 +0000 (UTC)
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

Any additional reviews would be great.. ;-)

v3 changes:
  - 4 more patches accepted, still 2 to go
  - rebased on top of Arnaldo's perf/core

v2 changes:
  - 4 patches already accepted, still 6 to go
  - adding more people to cc

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  tools/flags_v3

thanks,
jirka


Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Len Brown <len.brown@intel.com>
Cc: Markus Mayer <mmayer@broadcom.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Thomas Renninger <trenn@suse.com>
Cc: Zhang Rui <rui.zhang@intel.com>
---
Jiri Olsa (2):
      tools thermal tmon: Use -O3 instead of -O1 if available
      tools iio: Override CFLAGS assignments

 tools/iio/Makefile          | 2 +-
 tools/thermal/tmon/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
