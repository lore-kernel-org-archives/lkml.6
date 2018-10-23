Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E17C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C952082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3V+4wjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C952082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJXMLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:11:07 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:44130 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeJXMLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:11:07 -0400
Received: by mail-io1-f73.google.com with SMTP id s15-v6so2908624iob.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 20:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UeZvXjFGINLPP7Y+ScLiOfP2c4sV2r65nCnlN9aBCLM=;
        b=U3V+4wjnjb7vyQ315gbwgGzHJcnjv0qgpqLsrRq3caQWaNq+oKPK1jXgz4ywdz0w2p
         7E6bDU2HR1JHhadd0AF+yU8y8us7k27HZ5grkEpgUZ5jHs9ET1pKd/Vj4oWOPkV2yNZ1
         uqa9CWlTHPGDb+WZ9Zy5dXruWBgTwnZmT1gs4fPlUoXpCI2y2KJf5hCyCpgVTzRNG5K6
         kIt9k7r1AEbEI40IDhRdaQGvz6Mz+T1Y/FE20a/gcgDsjwMDy9FjOujG4rey7THcmQ4r
         20ehdWpL+HVfMzfDos1C3xS/HXjssVBOfdsVmiO/jQeqwtaHvDqvHvL8nSd022Y+5VQu
         c7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UeZvXjFGINLPP7Y+ScLiOfP2c4sV2r65nCnlN9aBCLM=;
        b=KwB1jeoRPEii6Tk6xsdtyfR8R7CwUdr4wykKeFtv1wFgayBpcSE2mTlRKUrpXDBLiY
         rYdzDG6etqdZCA26bDqdXjT2+jvbA+ix4dkQRO36lfuaIvO4ObjbCnFA8C9GrEwNPzst
         /D8ZJ6Gi4ukRTcIbHgSDlHGzVZQ4bAmyzhjmXprAv6flIDpkZTZIjAFJUhwklOroQhwT
         Eq9RhA1+5F5hVXBLRdAQxYwaE4XRfmSAergLT5fD0MyRQiBk3PiTRZvhQfQ7DLPrx4qE
         p0ejp51NOEK32s6SqTrCzwAFeiC1a02glrEYreLJbAQ65w1B8HRtYQCdQwIyTU/YJV5J
         706w==
X-Gm-Message-State: AGRZ1gJRCnPS2bIerJo6Fon+YfweKbWTmFgdI187vhMhHNQk5mswtGpy
        f41f2+G71dzGkHsWb3LKIQcBF3vkByxEdZ3z9kMx0A==
X-Google-Smtp-Source: AJdET5cw0S0HznSKHP0+iquFGIIlvvgRXnFUidX+MYUkyxj0BqvSsWghJpZuUDW+NmpkujXsQUXP3a0nvAjOpf/ULDHU3A==
X-Received: by 2002:a24:484a:: with SMTP id p71-v6mr229981ita.23.1540339192953;
 Tue, 23 Oct 2018 16:59:52 -0700 (PDT)
Date:   Tue, 23 Oct 2018 16:57:42 -0700
In-Reply-To: <20181023235750.103146-1-brendanhiggins@google.com>
Message-Id: <20181023235750.103146-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC v2 06/14] arch: um: enable running kunit from User Mode Linux
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make minimum number of changes outside of the KUnit directories for
KUnit to build and run using UML.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Kconfig  | 2 ++
 Makefile | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 48a80beab6853..10428501edb78 100644
--- a/Kconfig
+++ b/Kconfig
@@ -30,3 +30,5 @@ source "crypto/Kconfig"
 source "lib/Kconfig"
 
 source "lib/Kconfig.debug"
+
+source "kunit/Kconfig"
diff --git a/Makefile b/Makefile
index 69fa5c0310d83..197f01cbddf03 100644
--- a/Makefile
+++ b/Makefile
@@ -966,7 +966,7 @@ endif
 
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/ kunit/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
-- 
2.19.1.568.g152ad8e336-goog

