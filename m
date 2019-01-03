Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C101CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916732070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519649;
	bh=FHgDh/Er8Kj1+Pq+Iv5Ug0tTK417L106Kdsr0CDePW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1r6eE7YZdyT2ukXsYPZuCj3FSRmdIczotO0k4vSUgT4+MtjNOdTA5DlRMCfjYyj9q
	 mqyYP3BrfRI2Z0ro5L9XiaavGknbiSyd3e7nii8L9EiwgIoSf7uy0TWKfFyt/tS8Yb
	 m6wJ+RWOzHY86F79u9WRlbjwNkKrO+N3QsIYOVlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbfACMr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731586AbfACMrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:25 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E0A217F5;
        Thu,  3 Jan 2019 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519644;
        bh=FHgDh/Er8Kj1+Pq+Iv5Ug0tTK417L106Kdsr0CDePW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nn9jHsSCLFKeZXbw2tEeccpr0j9nccZG0l7nuxrPTG8v92zwTJJ34AQKs3ymSTvIL
         5CU+dsk6oVqnVUMpv+cWfjzyZKJf6S+KKadC89xXXsUfsTfBXg0cDJcJgB6+9zS6xg
         ghQZyjAzfEG6Noro1F7a0KB7e13RiJliXEISGmxc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Herton Krzesinski <herton@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/29] tools gpio: Allow overriding CFLAGS
Date:   Thu,  3 Jan 2019 09:46:01 -0300
Message-Id: <20190103124609.29672-22-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.19.2

