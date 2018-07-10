Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60622C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205C42083B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205C42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754700AbeGJArc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:47:32 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36197 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933132AbeGJAqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:46:22 -0400
Received: by mail-qk0-f196.google.com with SMTP id a132-v6so10714348qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 17:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gm35+dAUKxJSsV7Va8vSnfvMwVNW19/CTo4IIgw4uQo=;
        b=Ng8YWXJ097QSB1BH9US/vQ6MHjbW7S2EH5uYgQGHUhMRMLjhNKZkjuof5JUjebotWk
         Oe9ohzBy0+rg42uL5Ow9co4U0R32QzuLnqz9EbJDQy1YI9DKlETFwVVJomsBqd8xWmi1
         ArAmirJteO7NtJe3tDzZS6jjUovjALhT4Db/vT3pVLcL7rbpsfrMt+baJ3Tq789B8HCc
         KsUdnXaRkqjmCUmf2cx9FqCFk81EUBhlj+JH54W49LnvFRYPCjAiL1YVvg4LqX8xjxGI
         ewE2MqBeWEOQm7nsE2JKsAGWwrPtf4/ApAB5aMdUlE6djg24IsD7rvnlaZGGYyXJ/AHd
         GA0A==
X-Gm-Message-State: APt69E1EEhnAe4AA7KKIA+VKr9CKK9IHIfX7ZGNfwSI3FuNTuu9xqT4J
        h8InMb9blZ8xipRYF72ict0D6g==
X-Google-Smtp-Source: AAOMgpdHe+NSbCT7X2MsCVyQgxwbCQrxZroyi0WaIDod4UVj4b/Id1Vi8PIPaInbScgG+Emjyuhxiw==
X-Received: by 2002:a37:e103:: with SMTP id c3-v6mr19377857qkm.33.1531183581360;
        Mon, 09 Jul 2018 17:46:21 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::1941])
        by smtp.gmail.com with ESMTPSA id l36-v6sm1816792qtk.12.2018.07.09.17.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 17:46:20 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCHv2 4/7] treewide: Rename HOSTCXXFLAGS to KBUILD_HOSTCXXFLAGS
Date:   Mon,  9 Jul 2018 17:45:59 -0700
Message-Id: <20180710004602.21599-5-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710004602.21599-1-labbott@redhat.com>
References: <20180710004602.21599-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for enabling command line CXXFLAGS, re-name HOSTCXXFLAGS to
KBUILD_HOSTCXXFLAGS as the internal use only flags. This should not have any
visible effects.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Dropped name change for individual files (still HOSTCXXFLAGS_foo)
---
 Makefile              | 4 ++--
 scripts/Makefile.host | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 1feec222f3c1..857ccd28dc36 100644
--- a/Makefile
+++ b/Makefile
@@ -361,7 +361,7 @@ HOSTCC       = gcc
 HOSTCXX      = g++
 KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
 		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
-HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
+KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
 HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
 HOST_LOADLIBES := $(HOST_LFS_LIBS)
 
@@ -432,7 +432,7 @@ GCC_PLUGINS_CFLAGS :=
 export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
 export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
-export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
+export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 09f00dae21fe..455d85aa1d37 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -64,7 +64,7 @@ host-cxxshobjs	:= $(addprefix $(obj)/,$(host-cxxshobjs))
 
 _hostc_flags   = $(KBUILD_HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
                  $(HOSTCFLAGS_$(basetarget).o)
-_hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
+_hostcxx_flags = $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
                  $(HOSTCXXFLAGS_$(basetarget).o)
 
 ifeq ($(KBUILD_SRC),)
-- 
2.17.1

