Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4986C282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 07:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E03218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 07:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbr1xqDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfAZHNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 02:13:42 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46036 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfAZHNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 02:13:42 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so9042775edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 23:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J0kp8B9HmB+wcP5oDChY0w57/hqJWzBplit1QEBozDs=;
        b=qbr1xqDDysAA0Hc5kKLvhu8bvEWPgHAW2ooE4QVW2+5wxilh7oNEkSMQGeZR/pEzWk
         1FMjBrqBxAc+Fve2c2FdjN1Mxzl58MauFoWc2nXYzvWceP11Asb8mIZXcFaOmZHVrDaa
         fgw6SSmQndnL/Y4XAgaq4I0m3cWJEjNvkTQ6rvOle+GROFEut1pHNamql/FHP8GCkLg/
         Cgejv3/x+DjIeKSnamoaOPQk7HkrRoLZRlvD/tlAd7NOCGN2x0VuFv3qR6YByp8aVMzB
         5kG5+5tviDNkXPJ2mE5XTDfrCpF8SXr2LTmwvilAYHwgMEGKY3Hvy5uRNsVuzVOVSB6o
         8r0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J0kp8B9HmB+wcP5oDChY0w57/hqJWzBplit1QEBozDs=;
        b=kopOQ4RbeEkCml4BFFkKS6V7MKkWSae6L6UXy6P76xBJqeXhqdZVdOkEhC5WR7XWRR
         Yc/awTLLwILUvlKVb+JFGzjuFpbXc+HBNW8Wozcv/HYfI/QiT4BrT477DuZh6Dt9SJrf
         sLvyyENuin0WUuudXBhwX+asbXpf1XN/oTjuVKNVa84ZILp2/G/J5YM1kSDAnD/g3K3j
         ew3OlcEl9zJ+CbHhOFPmlAzTBiFRfTtHPwgO/60CRQ3T19ZlJXoKL4Sh4Pmy5Tj2TnCQ
         SVc2q/zWX+ytg9/RJFE+rtXzcj7bc7IX6NgxEQQrdjg10L3yM/sAW2QmyPYuEuyZfJTt
         fl7Q==
X-Gm-Message-State: AJcUukc5GcPD8wkP1RRqSxCmXcPC/BeuWypjybM9w1sFTPNUl6mCjjPl
        IkLZ4gs2JeiGzFQ4n5Ew+BMJmhKHtDkEyQ==
X-Google-Smtp-Source: ALg8bN65vgYyS6424V+SJz3qZ4N77S4UNLql7LRB25on3npDBWeIpeJF0tc5zt2rg36QOoyrxqtXSQ==
X-Received: by 2002:a17:906:f212:: with SMTP id gt18mr12313480ejb.201.1548486820395;
        Fri, 25 Jan 2019 23:13:40 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id k31sm13148692ede.5.2019.01.25.23.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 23:13:39 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] drm/i915: Disable -Wuninitialized
Date:   Sat, 26 Jan 2019 00:11:23 -0700
Message-Id: <20190126071122.24557-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning is disabled by default in scripts/Makefile.extrawarn when
W= is not provided but this Makefile adds -Wall after this warning is
disabled so it shows up in the build when it shouldn't:

In file included from drivers/gpu/drm/i915/intel_breadcrumbs.c:895:
drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c:350:34: error:
variable 'wq' is uninitialized when used within its own initialization
[-Werror,-Wuninitialized]
        DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
                                        ^~
./include/linux/wait.h:74:63: note: expanded from macro
'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
        struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
                               ~~~~                                  ^~~~
./include/linux/wait.h:72:33: note: expanded from macro
'__WAIT_QUEUE_HEAD_INIT_ONSTACK'
        ({ init_waitqueue_head(&name); name; })
                                       ^~~~
1 error generated.

Explicitly disable the warning like commit 46e2068081e9 ("drm/i915:
Disable some extra clang warnings").

Link: https://github.com/ClangBuiltLinux/linux/issues/220
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Rather than disable the warning for the problematic folder, disable it
  for the entire folder like Matthias's commit.

 drivers/gpu/drm/i915/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 8300efe60fe1..210d0e8777b6 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -22,6 +22,7 @@ subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
 subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
 subdir-ccflags-y += $(call cc-disable-warning, sometimes-uninitialized)
 subdir-ccflags-y += $(call cc-disable-warning, initializer-overrides)
+subdir-ccflags-y += $(call cc-disable-warning, uninitialized)
 subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
 
 # Fine grained warnings disable
-- 
2.20.1

