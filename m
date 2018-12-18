Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA95BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A781C214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fUMMv5Hc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeLRABf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:01:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43346 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeLRABf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:01:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so6893763plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RmOO9VKq0r0xgA2YxKezp2wUCVCNy3JV4iVGZoGUUKo=;
        b=fUMMv5HcBMCNGerwqW93eAf9nK+JHZ6y6GTYxGv/22NZ76Sn2uWN+IB5bOR5ESnuA8
         jJQUHYAWJKDaCtjVy51tmLYaHu0qXOp6Jm5wjnI+o96HGp7a7v0deNNShWP1ca3a7TON
         vFH+7QzixQkoQrbc2ymx8f0y4XIlKkNIscKhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RmOO9VKq0r0xgA2YxKezp2wUCVCNy3JV4iVGZoGUUKo=;
        b=NC9r+CsflY53ZzLEQ4MobqHvCJAVz6XayNVAkqERYO6lkgUnhG3oKXAvouduAe8FFy
         de/r0KkDKWWZk69MKotAMVHoSpyosY159InT8dDOGr0PW+uu2jmUgs4hwMLPTLV6buTh
         gcmfprPtg1/k7f5zI7krDT1HLQIxPW0ImF1G2ujL9rRsnL/FXzXjTnme/Wzd2lxcm5tT
         MOcNmE3MGqZegXkJQYoY2kYm9MoG+hSAacSkag5jBpDojG+yM6ix8QIKUevC3qwfas0h
         BiIdt9hn3CsuZODUMtBBbl9MyOlfWJT+gR8lN9YpALGXULSprMAmj8kSla89J8IvOmPS
         GLWw==
X-Gm-Message-State: AA+aEWYaCwuTSUXmt270Xk3CC0BzIWWbe1R5sHTCFg8M2WRUdVxiDGE3
        Diexc0Y4RCH3Bq02BAMUTFts8w==
X-Google-Smtp-Source: AFSGD/V0KIlupiNcm0cufv6o19x4P74F/irPvWEbvROxK/0fEmi1vVS//xllGD5ShPJq1gVe9QEuXg==
X-Received: by 2002:a17:902:714c:: with SMTP id u12mr14296586plm.234.1545091294533;
        Mon, 17 Dec 2018 16:01:34 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t2sm21626669pfm.32.2018.12.17.16.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 16:01:33 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:01:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Emese Revfy <re.emese@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        Nicolas Pitre <nico@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [GIT PULL] gcc-plugins update for v4.21-rc1
Message-ID: <20181218000132.GA19073@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this gcc-plugin addition for v4.21-rc1. Both arm and arm64 are
gaining per-task stack canaries (to match x86), but arm is being done with
a gcc plugin, hence it going through the gcc-plugins tree.

Thanks!

-Kees

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v4.21-rc1

for you to fetch changes up to 189af4657186da08a2e79fb8e906cfd82b2ccddc:

  ARM: smp: add support for per-task stack canaries (2018-12-12 13:20:07 -0800)

----------------------------------------------------------------
New gcc-plugin:

- Enable per-task stack protector for ARM (Ard Biesheuvel)

----------------------------------------------------------------
Ard Biesheuvel (1):
      ARM: smp: add support for per-task stack canaries

 arch/arm/Kconfig                              |  15 ++++
 arch/arm/Makefile                             |  12 +++
 arch/arm/boot/compressed/Makefile             |   1 +
 arch/arm/include/asm/stackprotector.h         |  12 ++-
 arch/arm/include/asm/thread_info.h            |   3 +
 arch/arm/kernel/asm-offsets.c                 |   4 +
 arch/arm/kernel/process.c                     |   6 +-
 scripts/Makefile.gcc-plugins                  |   6 ++
 scripts/gcc-plugins/Kconfig                   |   4 +
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 103 ++++++++++++++++++++++++++
 10 files changed, 163 insertions(+), 3 deletions(-)
 create mode 100644 scripts/gcc-plugins/arm_ssp_per_task_plugin.c

-- 
Kees Cook
