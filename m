Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FBAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920B82083B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920B82083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933447AbeGJAsC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:48:02 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42016 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933326AbeGJAqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:46:15 -0400
Received: by mail-qt0-f194.google.com with SMTP id z8-v6so8486352qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 17:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fMMWWjSXVmIYjP+bqeMR5GcK88w+ADcuRU163HYC/58=;
        b=ZAMtmWqF+igFO28qXoIccXcCFWWumd5+euvzn5Ckbz0zETVg92f24J5XfBih4HZxjz
         LlJFOYSQ1i5E1VxUjFqDj0xh0vIfWFQDYYD3YLF8K4XmMHwIjL0SdacomJm2HMO4Kxz9
         LCO+S0MkrOZOikHVqbmLEEbyKCSQinXg0uDabwohuQX5LEVQzB3n7JWDWjufSgEaJnw6
         Tkc14dGLH8DWaMRfAVqtYaBwuT+Vw42JHErASA19jmFC7GcAWm8hjnk7rfBoOe2JAmi6
         Nrx6MTFWZyC5M5wUv7fQTZU6BUNRkWBo7uRcbOwM/TjhVGgwKDxsBDCaGplWrPkQkuy8
         5RSQ==
X-Gm-Message-State: APt69E1M18ikECzQXhM3ha+YFS87CQamN+F+7KeqFhRjfjnjjDst1mIn
        wWA0Zgy8wTz6XLuhUybKCWDOJA==
X-Google-Smtp-Source: AAOMgpcwt/Wd8AG2tgvwDjxHhE7IdoUvZ4L2KI/597JyPSTZcszD66eoFHhhu+rpBxdDqPOx+nUaIQ==
X-Received: by 2002:a0c:f98d:: with SMTP id t13-v6mr19653021qvn.172.1531183574546;
        Mon, 09 Jul 2018 17:46:14 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::1941])
        by smtp.gmail.com with ESMTPSA id l36-v6sm1816792qtk.12.2018.07.09.17.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 17:46:13 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCHv2 1/7] tools: build: Fixup host c flags
Date:   Mon,  9 Jul 2018 17:45:56 -0700
Message-Id: <20180710004602.21599-2-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710004602.21599-1-labbott@redhat.com>
References: <20180710004602.21599-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0c3b7e42616f ("tools build: Add support for host programs format")
introduced host_c_flags which referenced CHOSTFLAGS. The actual name of the
variable is HOSTCFLAGS. Fix this up.

Fixes: 0c3b7e42616f ("tools build: Add support for host programs format")
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Also fixed another instance in perf pmu-events.
---
 tools/build/Build.include   | 2 +-
 tools/perf/pmu-events/Build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/build/Build.include b/tools/build/Build.include
index a4bbb984941d..b5c679cd441c 100644
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -98,4 +98,4 @@ cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXX
 ###
 ## HOSTCC C flags
 
-host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CHOSTFLAGS) -D"BUILD_STR(s)=\#s" $(CHOSTFLAGS_$(basetarget).o) $(CHOSTFLAGS_$(obj))
+host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 17783913d330..215ba30b8534 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,7 +1,7 @@
 hostprogs := jevents
 
 jevents-y	+= json.o jsmn.o jevents.o
-CHOSTFLAGS_jevents.o	= -I$(srctree)/tools/include
+HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
 pmu-events-y	+= pmu-events.o
 JDIR		=  pmu-events/arch/$(SRCARCH)
 JSON		=  $(shell [ -d $(JDIR) ] &&				\
-- 
2.17.1

