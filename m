Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79705C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE37205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgDgZb3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE37205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbeK2Gkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:40:43 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53174 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbeK2Gkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:40:42 -0500
Received: by mail-pg1-f201.google.com with SMTP id o9so12729213pgv.19
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7o3/F9U9IKjkZ6IM9Sx8c0EMfVbluC0QKxi+aoA3j2Q=;
        b=cgDgZb3/4GE+EvO6c9q7nE9BKZSxXWI4PGb6FWRR91b4opTteDHUaFx8xi20/y7Mez
         JpV/5thabDhCBRUHZLG8pUs7FTtMY7V9eWyGJ7TlKv6bSu2qSYQ6ra7+6BdeJTOGyvoX
         s2bfpnjVtcKcxe12lu/NVowxn4Bu2K1qKFYTgllss2oVmmCQYTwicr29tnrSvAvJVmz7
         R5jtAtTMjo8zBdo5vhchlp5rMhkZHvfRa6eZ8sfP8z95YloomWgnnyj2jApAZFQVFRe3
         QjI8OiAPTG/swfACWqG2o6vT4kdLvD/tLiqlk8UsEnbfTON19tkBffPA19nL7KKQL9w8
         anvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7o3/F9U9IKjkZ6IM9Sx8c0EMfVbluC0QKxi+aoA3j2Q=;
        b=Qu+g6+xcrRcmkN910oJejzmqc4yEJGtS3kIWPkHPe01TGWY3kq6eatvhAYRWHD9QUi
         rZtAohD1AW6MKj1VbV1FmMlbu1AHUNMxrj01iGvqmlFkM4ybf52DBGadc7I2IumKv6Fu
         S13YQMKZRrCSOphXtEwEX0i+qYY+I5XTiAunSYGNjDoOeWYZ3TNkaiMkS/rxTsjxNUOL
         pVW/WXIqyX1f56OUav6rqY4UbHVbWtuJ+EMyz/HWGiygQlXrBgdtrPxIYGPDMCNLk1Sx
         qkRHE8g8djUVnA3cYy93GjB9aX8FvcyQo5kAh4qiup400AUnaY+v00XryhySsLARus3Y
         Z4wA==
X-Gm-Message-State: AA+aEWaY2by1sXsq+S3zibUYxOuQcLZoH2j8eAENVOW/ELJDavb+WjoS
        K4UOV4izG6U0lPsSYeYzMtt3MUFPNnTmZuXeT9RYjA==
X-Google-Smtp-Source: AFSGD/WZCpu2E2XeyMSRagVO1P9amlU5ZIT0i7TxLE9lAIM/bsuosh+GUdbMWKiKnSx20YGh5Rl4K/RvwPKxAslB8knGdQ==
X-Received: by 2002:a17:902:1023:: with SMTP id b32mr2501651pla.121.1543433877985;
 Wed, 28 Nov 2018 11:37:57 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:36:23 -0800
In-Reply-To: <20181128193636.254378-1-brendanhiggins@google.com>
Message-Id: <20181128193636.254378-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [RFC v3 06/19] arch: um: enable running kunit from User Mode Linux
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
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com,
        knut.omang@oracle.com, Brendan Higgins <brendanhiggins@google.com>
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
2.20.0.rc0.387.gc7a69e6b6c-goog

