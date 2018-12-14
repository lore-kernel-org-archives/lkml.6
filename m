Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDCFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6171A208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhfNz3FO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbeLNWgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:36:41 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:56249 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbeLNWgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:36:41 -0500
Received: by mail-qt1-f202.google.com with SMTP id b16so6936003qtc.22
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 14:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Hpzgkb+ogGIKg/j787d6nVH8o5+QCYiKn6+Dg9Y4Tz8=;
        b=JhfNz3FOcVMstZ3FKMfb+iXqWygEqsknFsC3o5+DZ7P1tH/7VaXpiiHHuvAaMY7v8k
         dHIgWOsVZL+Iy+a80bCiJpVVOU/GeiVJi9dC00pfpeI9JyOMceRK+cB2yP0Z9GekHZg3
         5NwzQnFB/EGr4FLOYWvWyxiRz3ohWbx2ukq0W0kaJudB2nwbFf+GUCIPCmplWy58hWWu
         g76Ic4n+ndaj5AOd1bm85ISwpiaQFlj3uLTfjLB5aBJqRVJeceU4YIgcMSO6RKgT0HEP
         wEIEnROaU63Pj3KXvUpvAKPNpYk0xLi6O7AOpvGewAP5hWeO8q7By5FhVg1a7NWRAcpr
         oWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Hpzgkb+ogGIKg/j787d6nVH8o5+QCYiKn6+Dg9Y4Tz8=;
        b=doq4pQVowGqGEBqPmaHp4nju3dc0GD5GV+O32KPpYNLopOyjqziFxVTr6Ze0oTkW2l
         RgaE0kBw3Fpu7NpCIuDGrIKRQuIO5X+aTw/ZD2+w1HhtwmZOQioPm/9pCsjmsdEkleZv
         SwZTnvQjmKdIKGEdOjz2bw+78bBzGdOjkbKlnp111d09j1AQ5Nc5vTM6uZ/UB8nYLtCZ
         IHXHyGT8Y4UEo4RGc1P+t7gL3M2lAerTjIEgsWl8E8psDawMImlpe4GFjSpzDRJneSAc
         pyFOGU6czga2UAy9IUp+lbeofMHRgTcsdMoUBYOUy03kyDvyJnVi5hpNtNy1u2t+dkMl
         IC2A==
X-Gm-Message-State: AA+aEWb83z2FuofvdZs3zCD1LxS17FK9tUa0SVz6QJu5ksj32g6jleW4
        97IEZJhhnkga9p96oc8S4cWf3Govdtt4ZoxOWcnOYT9YcLaGIY/wp+A0DHa/Pkc+9t/DpuR70rn
        oI/zVj5Gw6teb2PLukRox1khf0zbQUNPMTABCIosXgsdqcSWW73YwAgx3EW0/m1gdh1Ts3sjo3u
        KGHw==
X-Google-Smtp-Source: AFSGD/XjQ7sT2/5w/+3alNRLKjK1+b88wSQJkf9uVMf7sfwtFgmKI15iW5HDdfb2ArbVOD8Wi7nj2pYrRfyOOuk=
X-Received: by 2002:a0c:9e60:: with SMTP id z32mr4798720qve.0.1544826999928;
 Fri, 14 Dec 2018 14:36:39 -0800 (PST)
Date:   Fri, 14 Dec 2018 14:36:37 -0800
Message-Id: <20181214223637.35954-1-astrachan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH v2] x86: vdso: Pass --eh-frame-hdr to ld
From:   Alistair Strachan <astrachan@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Laura Abbott <labbott@redhat.com>, stable@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")
accidentally broke unwinding from userspace, because ld would strip the
.eh_frame sections when linking.

Originally, the compiler would implicitly add --eh-frame-hdr when
invoking the linker, but when this Makefile was converted from invoking
ld via the compiler, to invoking it directly (like vmlinux does),
the flag was missed. (The EH_FRAME section is important for the VDSO
shared libraries, but not for vmlinux.)

Fix the problem by explicitly specifying --eh-frame-hdr, which restores
parity with the old method.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201741
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1659295
Reported-by: Florian Weimer <fweimer@redhat.com>
Reported-by: Carlos O'Donell <carlos@redhat.com>
Reported-by: "H. J. Lu" <hjl.tools@gmail.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Fixes: 379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")
Cc: stable@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: X86 ML <x86@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: kernel-team@android.com
Signed-off-by: Alistair Strachan <astrachan@google.com>
---
v2: Updated commit message, no changes to the code
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 141d415a8c80..c3d7ccd25381 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -171,7 +171,8 @@ quiet_cmd_vdso = VDSO    $@
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
 VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
-	$(call ld-option, --build-id) -Bsymbolic
+	$(call ld-option, --build-id) $(call ld-option, --eh-frame-hdr) \
+	-Bsymbolic
 GCOV_PROFILE := n
 
 #
-- 
2.20.0.405.gbc1bbc6f85-goog

