Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46264C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F096B2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxUhz5eR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F096B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbeLJWcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:32:04 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:52312 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJWcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:32:01 -0500
Received: by mail-vk1-f202.google.com with SMTP id x202so2956692vke.19
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 14:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uz3a0ZuaTys1qNjTLk3P2XYMEjHLTYAmhI4J70kb0Fg=;
        b=KxUhz5eR3j1aR5G6iQw8EJSmQWIRNSmaPQItXPxr1/PnRLgbDpb+MZYqgVQFhXyCrl
         t6bRy8u9y7OhAsvZyZ5KUE7etiWHBlTZUeUD119Z3HoUY0DFnJO2FA9nt76LRaUNM+Fn
         0+29qq9PEPBscBd+U85ktCGa0USCfP6ftGlBFZVfIwcKMUm1Nm1TfnSAHSTqyOpb4Bwk
         WDEdy3spIz0q9ROjOcVCR71IrgI2mdhBeJVpR4l0jGEKnDzWjlPTEMnPIvTqliLBn/Hk
         5hKHapat5RZNpsStET5FV4OCfT5xmW40TANWDOgcQ3kE9QHvmc4ynYS/aJdvyeogkDpM
         XmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uz3a0ZuaTys1qNjTLk3P2XYMEjHLTYAmhI4J70kb0Fg=;
        b=gaBZUR5l3p3+jtz/OwPfhKDwoTAk5jvN77oKsbR0lKUwEj0e2Lv+glUHnMY16X4ZCj
         TeQBz2OH5At1hq2OfZKzCTiJ4YkSbZEtUktikuD+VJoJ/ukWtj9TCm6SxcUrkckZcVyT
         /a+TAuMP/VJpI7lgBbrR9mVXzl1jO7P7eW0q/c6vVt2TsJu4ZIiog9kaEqQZLD9MpelK
         KZHpecK3YX+goPLhKQjEXNqKRiwuu9vMtUJhF3lH2Plhb+pduV0YYAEvBtBLvXVToIlX
         QJr0hd92zWY3G5mXOAzAb3Jvdcthd5ysvszM7PvCe/srNWEkQK/yX8YTbdetJ7HKQE/n
         7XGw==
X-Gm-Message-State: AA+aEWY5BFx/n7XTMMsYV3FSNzIIUo6ooRpg5yifm4CyJcSTeqHeBa1n
        mFgJtayLW/urY4SbHl0JHjDXqqhD1Dz7IW7EUdw=
X-Google-Smtp-Source: AFSGD/X2dH7oE25tcCkNOqXBxQn0bRNSmoG5phQ8wOgqDSkJ6riP9VcRg1mX+ubwtVCF+2fJlV1Y7DRlHvoJmg1VNLQ=
X-Received: by 2002:a1f:91d4:: with SMTP id t203mr11768131vkd.2.1544481119764;
 Mon, 10 Dec 2018 14:31:59 -0800 (PST)
Date:   Mon, 10 Dec 2018 14:31:32 -0800
Message-Id: <20181210223133.22667-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH] ARM: VDSO: Drop implicit common-page-size linker flag
From:   ndesaulniers@google.com
To:     linux@armlinux.org.uk
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GNU linker's -z common-page-size's default value is based on the target
architecture. arch/arm/vdso/Makefile sets it to the architecture
default, which is implicit and redundant. Drop it.

Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index f4efff9d3afb..8f2fac5acbc8 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -11,7 +11,7 @@ ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
 VDSO_LDFLAGS := -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1
-VDSO_LDFLAGS += -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
+VDSO_LDFLAGS += -Wl,-z,max-page-size=4096
 VDSO_LDFLAGS += -nostdlib -shared
 VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
 VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--build-id)
-- 
2.20.0.rc2.403.gdbc3b29805-goog

