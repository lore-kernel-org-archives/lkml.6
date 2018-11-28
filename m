Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AA1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E567208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E567208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeK1UyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:54:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:51816 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbeK1UyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:54:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 01:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="113684917"
Received: from shbuild999.sh.intel.com ([10.239.146.218])
  by fmsmga004.fm.intel.com with ESMTP; 28 Nov 2018 01:53:05 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 0/2] panic: Add options to dump system info on panic 
Date:   Wed, 28 Nov 2018 17:54:00 +0800
Message-Id: <1543398842-19295-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel panic issues are always painful to debug, partially
because it's not easy to get enough information of the
context when panic happens.

And we have ramoops and kdump for that, while this commit
tries to provide a easier way to show the system info by adding
a cmdline parameter, referring some idea from sysrq handler.

The patches have been used by us and did help on solving some nasty
panic cases.

Please help to review, thanks!

- Feng

Changelog:

  v3:
    - Add one patch to add the "panic_print" into sysctl as
      suggested by Steven Rostedt

  v2:
    - change text "dump/DUMP" to "print/PRINT" which
      is more accurate, suggested by Andrew Morton 
    - add code to print ftrace buffer 

Feng Tang (2):
  panic: Add options to print system info when panic happens
  kernel/sysctl: Add panic_print into sysctl

 Documentation/admin-guide/kernel-parameters.txt |  8 +++++++
 Documentation/sysctl/kernel.txt                 | 17 +++++++++++++++
 include/linux/kernel.h                          |  1 +
 include/uapi/linux/sysctl.h                     |  1 +
 kernel/panic.c                                  | 28 +++++++++++++++++++++++++
 kernel/sysctl.c                                 |  7 +++++++
 kernel/sysctl_binary.c                          |  1 +
 7 files changed, 63 insertions(+)

-- 
2.7.4

