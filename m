Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABA5C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB382070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbfACNWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:22:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60405 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfACNWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:22:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DLnvc1385315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:21:49 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DLnFY1385312;
        Thu, 3 Jan 2019 05:21:49 -0800
Date:   Thu, 3 Jan 2019 05:21:49 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-4ccc98a48958da9f89beb71c66a4e05468727951@git.kernel.org>
Cc:     jolsa@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        andriy.shevchenko@linux.intel.com, jic23@kernel.org,
        lars@metafoo.de, acme@redhat.com, herton@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, knaack.h@gmx.de
Reply-To: lars@metafoo.de, acme@redhat.com, herton@redhat.com,
          jolsa@kernel.org, mingo@kernel.org, jic23@kernel.org,
          tglx@linutronix.de, andriy.shevchenko@linux.intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, knaack.h@gmx.de
In-Reply-To: <20181212102537.25902-7-jolsa@kernel.org>
References: <20181212102537.25902-7-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools gpio: Allow overriding CFLAGS
Git-Commit-ID: 4ccc98a48958da9f89beb71c66a4e05468727951
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4ccc98a48958da9f89beb71c66a4e05468727951
Gitweb:     https://git.kernel.org/tip/4ccc98a48958da9f89beb71c66a4e05468727951
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 12 Dec 2018 11:25:37 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:33:08 -0300

tools gpio: Allow overriding CFLAGS

So that the user can specify outside CFLAGS values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hartmut Knaack <knaack.h@gmx.de> <knaack.h@gmx.de>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Link: http://lkml.kernel.org/r/20181212102537.25902-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/gpio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
index 240eda014b37..6ecdd1067826 100644
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -12,7 +12,7 @@ endif
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 
-CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
 ALL_TARGETS := lsgpio gpio-hammer gpio-event-mon
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
