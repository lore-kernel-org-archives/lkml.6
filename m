Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E14C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC03722531
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC03722531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932839AbeGGBHh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:07:37 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43574 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932725AbeGGBHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:07:34 -0400
Received: by mail-qt0-f196.google.com with SMTP id f18-v6so11396432qtp.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 18:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f9d344neXZWN4aoiynTLIMpXG5XG0b/evkeNLNEn5NE=;
        b=bnt2R05rqodHqCapsp4jv6CvR3eUvt9hre62FMHZ8F3tOb1EXowkH2zNYNk2BxHhle
         qC+tmDfTC7vxvuKcauuqGS4QnLByu8gQ/W/c3s9KYcaQBj0aj1eVDvhLxNBiO8lA5t9d
         PMEXhX+dJKwz108+NO7Ny4h9RUIkztgc0OskiJEJIU30aaGstld4bzGvzaTme0nnclWt
         WRwQzrpO2qFAQh8s773XGQxQcs1NehhAUpLZFg66CB2VCzikyRkIY08MfwBOJim5/lPU
         Illa8hU6a13J56eq/vZEcNDjnA1Jbkd+BjO1TMt3whaeLwoLWdTtu5fFjijaOeschfDh
         /nsQ==
X-Gm-Message-State: APt69E1MpzznsUaI+HMy3Vk9jUzUF1ntiFdt5LvtxrhGIAJYlEnoIDir
        MUzKFDQqvh2E0OJQw/lGp9FpNQ==
X-Google-Smtp-Source: AAOMgpf76po+6zW7b9oulRp2eo41GKuUbKKYXv2NNtmxLmNex0qlbnxBpWs0nf5tlgEVB56WtT66vA==
X-Received: by 2002:ac8:25ac:: with SMTP id e41-v6mr9428201qte.66.1530925653474;
        Fri, 06 Jul 2018 18:07:33 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id b3-v6sm3359698qtg.20.2018.07.06.18.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 18:07:32 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCH 4/7] treewide: Rename HOSTCXXFLAGS to KBUILD_HOSTCXXFLAGS
Date:   Fri,  6 Jul 2018 18:07:06 -0700
Message-Id: <20180707010709.16648-5-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707010709.16648-1-labbott@redhat.com>
References: <20180707010709.16648-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In preparation for enabling command line CXXFLAGS, re-name HOSTCXXFLAGS to
KBUILD_HOSTCXXFLAGS as the internal use only flags. This should not have any
visible effects.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 Makefile                 | 4 ++--
 scripts/Makefile.host    | 4 ++--
 scripts/kconfig/Makefile | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 16cab22b1f40..9c3f1864d678 100644
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
index 7a4c90f2b0ce..1c153cc5b530 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -64,8 +64,8 @@ host-cxxshobjs	:= $(addprefix $(obj)/,$(host-cxxshobjs))
 
 _hostc_flags   = $(KBUILD_HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
                  $(KBUILD_HOSTCFLAGS_$(basetarget).o)
-_hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
-                 $(HOSTCXXFLAGS_$(basetarget).o)
+_hostcxx_flags = $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
+                 $(KBUILD_HOSTCXXFLAGS_$(basetarget).o)
 
 ifeq ($(KBUILD_SRC),)
 __hostc_flags	= $(_hostc_flags)
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index f98a22618e1f..37605d92c597 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -192,7 +192,7 @@ qconf-cxxobjs	:= qconf.o
 qconf-objs	:= zconf.tab.o
 
 HOSTLOADLIBES_qconf	= $(shell . $(obj)/.qconf-cfg && echo $$libs)
-HOSTCXXFLAGS_qconf.o	= $(shell . $(obj)/.qconf-cfg && echo $$cflags)
+KBUILD_HOSTCXXFLAGS_qconf.o	= $(shell . $(obj)/.qconf-cfg && echo $$cflags)
 
 $(obj)/qconf.o: $(obj)/.qconf-cfg $(obj)/qconf.moc
 
-- 
2.17.1

