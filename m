Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0F5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C768C20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zqp1SGab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C768C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeIHBJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:09:12 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45880 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeIHBJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:09:12 -0400
Received: by mail-pg1-f202.google.com with SMTP id 186-v6so7627273pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 13:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HPeS88KNIjQVlbvUr7jP09u90T8uU//QpUwSNI1RzRs=;
        b=Zqp1SGabBIHAg7e/rC0NyUUFXDZE0UjIA0BzorcSjGmpA4fkREYhT8KuaPFDj2S95B
         RjWoNs426NWUePhol4xuCOU76cqu4AAYk1d162dVaBWCSYLY3Kfal8aOzEbxLctbg2FI
         Osk+0P41AZoNvmwQEucR1ABTCvbo5ICdlLbHFL4y5z9KE3alTPk+R1JdQkvPADOBcEP8
         mAoFjHwVtgL1ukxmtkoqzSf9+wqZ375thEUwXJmogg/SBXhTJ1/qou8pIAVsWpOw7GVV
         66iWcfKpyzsU2koHckzsb0mfmbXetuywq48v7dtWs6NalX76q+UaC5AjM1jS+WxxUNoW
         Qviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HPeS88KNIjQVlbvUr7jP09u90T8uU//QpUwSNI1RzRs=;
        b=XuaojxcF6NJeeJOAfIEn7nHQLoJ3C/3I3aWz5uMqySVyb7wq+i89uj+kcKylBReGEB
         keaY5thigEQiFIoOyYLJP5y15Bn+0Rsw8yPSMi2FavDH4aE8KGHgPgxSpddaDzfM/PxQ
         XOoZjFq6O/D7xpZRu1w0PZS06HwLZE4xWfKkOhfKDq0vP5Emj1aHHi9/YEaJYcCYjl8c
         IxYRGc+Y6eB8HxxOO7U7NQyVw/CVCevqr7dhrrR8N2zypkC9IvzO5UWczcpT6+TQBnWL
         0ZlrGFWZyQtcwqSXIygPM6QKEYbiNQApZYq4lwN3h5PtYFYf3Bq3StchuXeFVSHtROja
         tXYA==
X-Gm-Message-State: APzg51D1O7o+8DA0qHTVm/A/CKuVUvWoepiO4pgK5lpdxYf9ojdfxXbQ
        mMSdLO7YFSMKnlU7pYb4pAgbuA1nebOSOfjPxgM=
X-Google-Smtp-Source: ANB0VdapJIpg9AjZ67qlFdbFK5jZ8iDoeXkLaR1F/Ca2cS4joAdlXWRMExp8sbf5UbPtyDwLGXmZxFCM7+G+voefBOs=
X-Received: by 2002:a63:a505:: with SMTP id n5-v6mr715951pgf.31.1536351997128;
 Fri, 07 Sep 2018 13:26:37 -0700 (PDT)
Date:   Fri,  7 Sep 2018 13:26:16 -0700
Message-Id: <20180907202618.258569-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH] x86/boot: define CC_HAVE_ASM_GOTO
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Borislav Petkov <bp@suse.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this file steamrolls KBUILD_CFLAGS, we have to redefine these
symbols. This will prevent warnings in source files in this directory
when Clang supports asm goto.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/boot/compressed/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 28764dacf018..158c0b4e178a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -56,6 +56,13 @@ KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
 endif
 LDFLAGS_vmlinux := -T
 
+# check for 'asm goto'
+ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
+  CC_HAVE_ASM_GOTO := 1
+  KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
+  KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
+endif
+
 hostprogs-y	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

