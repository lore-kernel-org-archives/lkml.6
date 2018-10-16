Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6210C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B492087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6G8Q/xz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B492087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeJQHqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:46:51 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34127 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeJQHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:46:50 -0400
Received: by mail-pf1-f201.google.com with SMTP id i81-v6so25374689pfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z58nC2iAZa+aWGH30Fl4KryPGgLRMoTZOR6aRJpK+Rc=;
        b=X6G8Q/xz0LHNn4askpya4Qyjb5yi0UFIqxSD98dPg2XnCRxBCWVSS+vhfvpHxdgZ61
         c8MOcFdxRdS7RvaoTKOpSWmv/d588hkCfMLticT622iptne2B4SinvQthUHuCSQIzpmi
         5NRik3PeyN00lSHTmNDR8St6U112z+m9a6hYY7kin6bs8iBVJl7HO0o8Q/41uh51hyul
         U++OufyoHMd+uGcdmV29bmdotEcHuGPQyeR/9f43r460hzOU6CWx1kPp1gjqMGzIEwtV
         XySW/0X7EHZPSJQAX7MNzAqiyHRSZ1eGqanOxIYRR2Ho/7Yb/W03dhboQAwNc7myUD46
         zH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z58nC2iAZa+aWGH30Fl4KryPGgLRMoTZOR6aRJpK+Rc=;
        b=d7YGwYcX+D/sACZuR5io4CjoXlnYu+UjLeJnidKU80m+bEBdFnYtHKtIYLdWwrTbC2
         kTn/8Cs924Th03ifmYLhJhXqmo3rlNITnz9uHIOEluLj7N7JNI7rwTwllX8x07JHvcIT
         s9SFBE4s9CK4/oOgMmAHuCzuvcnFSSEpdDgTNA7e7jRhJUsYVrQykg/ncc8I1YhTLr+v
         LYBsqKBUDFwWiUPvdF6LsI2ms4YnV+RTurW6yT7EWWgH9XIPxpaI1Jfk5b3bmET2LY3B
         lyqrTffdFJHb2v9AorAwY0ggka0mtx78FT93wUCH6HFlLXHckVDJbExN8/7VDyxqCO9U
         d8AA==
X-Gm-Message-State: ABuFfoicbZTDdCrjjMCmlWTsaoB0NZfUTJpjH5z8vNHAiltdgu31mh+i
        gzK8ryHPxSMkWW0TjBVW0oSfF+gJq8ah0VsNIzyVnw==
X-Google-Smtp-Source: ACcGV63Eo+I6sCgcX/mpPbvZqH7+J7ycAASublcwpAXVYGmTf5rbFj1Qj6EfGfLoj+l0BjWoS2iTim6llDlsLHdgvElOGQ==
X-Received: by 2002:a62:908e:: with SMTP id q14-v6mr12401580pfk.62.1539734041297;
 Tue, 16 Oct 2018 16:54:01 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:50:55 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 06/31] arch: um: enabled running kunit from User Mode Linux
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes minimum number of changes outside of the KUnit directories for
KUnit to build and run using UML.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Makefile             | 2 +-
 arch/um/Kconfig.rest | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 863f58503beed..c8e659468ed49 100644
--- a/Makefile
+++ b/Makefile
@@ -944,7 +944,7 @@ endif
 
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/ kunit/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
diff --git a/arch/um/Kconfig.rest b/arch/um/Kconfig.rest
index 08327b9c0cbea..484c4cfcad1ef 100644
--- a/arch/um/Kconfig.rest
+++ b/arch/um/Kconfig.rest
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+
+source "kunit/Kconfig"
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
-- 
2.19.1.331.ge82ca0e54c-goog

