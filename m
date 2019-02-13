Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CB4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835F7206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NrU5+qFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394800AbfBMVc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:32:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33114 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfBMVc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:27 -0500
Received: by mail-qk1-f196.google.com with SMTP id x9so2362215qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jeR2I5IojtYAamul0y48I1Mhpe9MYXqM4mVdF+g8Y5s=;
        b=NrU5+qFQdXpZTR58bQV9WIf4d0/ZdwCj1mt0LprtsOc8Vr9XZd7/MSJgSu40k6+qXS
         td5VCvGcsxX5HdLsOptsYXpqXreUMM4pq7snvXh2W7ndqspqFtwFlK3yM65qtHpS7bj7
         loYJIaLRCuBUx4r5uLZGaVNNf4h27hlBk7xMN578cfY+7sHrb8QPA2f7G8iSSTgWKlC+
         qUzwd5Qm3JI4QshWlp6YFORUzvCnrayk4ydXpbWM+oCXBNIzRstW+7vuKcn20s2DwfKn
         6RbtInr4emIhZb+Xm8JqVhoJWEDlWBldm0Refdvcxkb6paJMKUaa3Xp/gMftKNoXxWJ/
         9+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jeR2I5IojtYAamul0y48I1Mhpe9MYXqM4mVdF+g8Y5s=;
        b=C0SIqhZ/abvu1CzwyOB0A7cVixJtr97X4J+8csI/Z09KtppM//W9dTGw8acQ33n4Tn
         HkHbAqoK2zF8YzZv80hrI+TIsSI4RcGXsSJDGDd1BOQgWgBlCPlA3tKshpXaSqJgRuog
         wbNbGq2fzH/uxN/A54YxrWvWHVdYGnWSpUOy0K0CBTzZjPJITm8acsRTC4fgO/0c5ZH5
         pkAh/iFtEqe1uECDUzZaWfyZAcSp76aj2FfeOKb2VPdrhlHnkCVac6h6Pwj8HolWbQYs
         HgjhlrhzLQAZXTAM227xktlAK/mQ0L/i9RKk+Mm/bcb2J/i1/zzR7DCxWk1xFdOBUYzN
         7BEQ==
X-Gm-Message-State: AHQUAuaVJl0BK4QgqaCzHY/Xh+9FiNxWV1vKk8Q8LJjxPgvLWt/+EvNJ
        Df3SMCrpg6whFhK+EKsxwuxxWQ==
X-Google-Smtp-Source: AHgI3IajxPNIjcLo2SapeuwjtwO4nAnrbwdq/eflzWSra88S+jdpn2lZmuxPhphtbWMmAL+bYc5Zqg==
X-Received: by 2002:a37:4701:: with SMTP id u1mr175025qka.357.1550093546032;
        Wed, 13 Feb 2019 13:32:26 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:25 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.19 00/17] V4.19 backport of more 32-bit arm spectre patches
Date:   Wed, 13 Feb 2019 16:32:06 -0500
Message-Id: <20190213213223.916-1-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David A. Long" <dave.long@linaro.org>

V4.19 backport of spectre patches from Russell M. King's spectre branch.
Patches have been kvm-unit-test'ed on an arndale, run through kernelci, and
handed off to ARM for functional testing.

Julien Thierry (10):
  ARM: 8789/1: signal: copy registers using __copy_to_user()
  ARM: 8790/1: signal: always use __copy_to_user to save iwmmxt context
  ARM: 8791/1: vfp: use __copy_to_user() when saving VFP state
  ARM: 8792/1: oabi-compat: copy oabi events using __copy_to_user()
  ARM: 8793/1: signal: replace __put_user_error with __put_user
  ARM: 8794/1: uaccess: Prevent speculative use of the current
    addr_limit
  ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()
  ARM: 8796/1: spectre-v1,v1.1: provide helpers for address sanitization
  ARM: 8797/1: spectre-v1.1: harden __copy_to_user
  ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc

Russell King (7):
  ARM: make lookup_processor_type() non-__init
  ARM: split out processor lookup
  ARM: clean up per-processor check_bugs method call
  ARM: add PROC_VTABLE and PROC_TABLE macros
  ARM: spectre-v2: per-CPU vtables to work around big.Little systems
  ARM: ensure that processor vtables is not lost after boot
  ARM: fix the cockup in the previous patch

 arch/arm/include/asm/assembler.h   | 11 ++++
 arch/arm/include/asm/cputype.h     |  1 +
 arch/arm/include/asm/proc-fns.h    | 61 ++++++++++++++++++-----
 arch/arm/include/asm/thread_info.h |  4 +-
 arch/arm/include/asm/uaccess.h     | 49 +++++++++++++++---
 arch/arm/kernel/bugs.c             |  4 +-
 arch/arm/kernel/head-common.S      |  6 +--
 arch/arm/kernel/setup.c            | 40 +++++++++------
 arch/arm/kernel/signal.c           | 80 ++++++++++++++++--------------
 arch/arm/kernel/smp.c              | 31 ++++++++++++
 arch/arm/kernel/sys_oabi-compat.c  |  8 ++-
 arch/arm/lib/copy_from_user.S      |  6 +--
 arch/arm/lib/copy_to_user.S        |  6 ++-
 arch/arm/lib/uaccess_with_memcpy.c |  3 +-
 arch/arm/mm/proc-macros.S          | 10 ++++
 arch/arm/mm/proc-v7-bugs.c         | 17 +------
 arch/arm/vfp/vfpmodule.c           | 20 +++-----
 17 files changed, 245 insertions(+), 112 deletions(-)

-- 
2.17.1

