Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8F7C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC352254D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC352254D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbeGGBH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:07:28 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46229 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754119AbeGGBH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:07:26 -0400
Received: by mail-qt0-f196.google.com with SMTP id h5-v6so11388857qtm.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 18:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=63m2DSry2Zy3gaTy7mxFX4kt/SfYSz+zIiPxtpmcTw4=;
        b=Av8OLbNZQpVJRLhk9QAfjyUkGwyi7tk8SiCBYkoIVYImKoXYqUUE/EG/sIiYcPSUsk
         MiL/9+bhJhOrMaGKNgsw86p9F5l5IZJ8eaNbv6ImDDGsTKVNfMkqeQXbFNglABqQDNdk
         eYQqmA4G18vMIiXJpucKna8u3HQZ2FUSSiK0d9tvUOyct9b0DDBbj14/sNrZQTqlHUfD
         ZUxv6TkI9Zwral0AnZVkiAEz3ExgXXheh4yB+CcDtSmzr/X1B+FjPS4fUob1IKUDa9vA
         hrnE/d44NwAzD3l7poaLrHoNCKPdXIVIJ482nxoV5v63r9c4OAv3Mh/po8cuAxG1fYjm
         n+LA==
X-Gm-Message-State: APt69E30ayFM9T3VSCVGohSabkEi1JN01bQs8qYvcxW2NKXp+GfxwK6a
        tvULRTqHhxRxvoTv3c268PyKrQ==
X-Google-Smtp-Source: AAOMgpeWoETL2Bp8FNWxBoGUmNlvB+fXVV++xcI95guMPPuvjeXk96br5oq1Lrbj0QLID8yy9FAtAg==
X-Received: by 2002:ac8:2d94:: with SMTP id p20-v6mr11722069qta.338.1530925646272;
        Fri, 06 Jul 2018 18:07:26 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id b3-v6sm3359698qtg.20.2018.07.06.18.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 18:07:25 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCH 1/7] tools: build: Fixup host c flags
Date:   Fri,  6 Jul 2018 18:07:03 -0700
Message-Id: <20180707010709.16648-2-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707010709.16648-1-labbott@redhat.com>
References: <20180707010709.16648-1-labbott@redhat.com>
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
This seemed like a typo to the best of my understanding and certain
things wouldn't link properly until this was fixed.
---
 tools/build/Build.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/Build.include b/tools/build/Build.include
index a4bbb984941d..b5c679cd441c 100644
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -98,4 +98,4 @@ cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXX
 ###
 ## HOSTCC C flags
 
-host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CHOSTFLAGS) -D"BUILD_STR(s)=\#s" $(CHOSTFLAGS_$(basetarget).o) $(CHOSTFLAGS_$(obj))
+host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
-- 
2.17.1

