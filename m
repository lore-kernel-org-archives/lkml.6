Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DF1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED30221582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DBOPArhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED30221582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388736AbeKOIlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:41:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40577 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeKOIlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:41:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id x2-v6so8618630pfm.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:cc:from:to:message-id;
        bh=9Dp7WGU2YOFNh5xvbP6+9+Ra/pBeP8yaU+pKqramhNI=;
        b=DBOPArhyPSaJhy2iJ6bAn+MMW2bXNb2HFXrlV5zB/aws8Uym4xvSpZmINA9HWSInMK
         k3oX5b4Lvc/Ro5A82JdHigmeHli6Uxp+pYgswjSTkUsph1ATPVb2boSvUi4x+9SD3z+0
         iXKY9robdGWxntYLIUk0UTl1UXgBDSUETw0bjuPV6pYYNwCGD8VHOu2CZUtRxt4M1fga
         lZf3PBtmwnmJkhHyk3DObzgnjvpjP8PSt5UC8zGLVkxf5h0MIplBzJ+qdFLEh/EwPbTT
         paHWzOFCsqFdGtys6Md4oMee7qe13g3W0tlJTm6vxHQre9M4skZC0u91qtrqIymJmP7D
         MY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=9Dp7WGU2YOFNh5xvbP6+9+Ra/pBeP8yaU+pKqramhNI=;
        b=bUY4oDj5dbss2VkdWC4ZpRIxMDAmFpoWvw3AJ92xy8x6wRoyoNGGjH4/lzkZahStG5
         cDEt3D3VouwUQP0AoYlFCieRxqGypVmGkXFcphYQ0w0586laNUDef0wK0QDGVYi02ye1
         DQl5Khe2YeHDcP0ARbhxUIpm0dSPjJMJ5dyTD9z7sMDpb5YW5XNbcfUleKqffZVl0UCI
         +l2P6XAY7FvWriUpcYOZ/sYbxNs+t/8pXlYM1v6ubY+sxAFFLUmI9vkBZnfuZVbD0ftR
         JD8wJuHQSYgU7cZ68wYSW4xEp8ZhtvbU9kKiP/jFfjw5PAElJ/5NO82oosDs8bz4PDTI
         aaRw==
X-Gm-Message-State: AGRZ1gKFuRKp6ajzC+NzBFiPM0o4PGPvX21QHdv1WVbjXTgnlHki6IS0
        jwq7XAoztV/JHJwqLD/7VpEoFKUu1d5W0w==
X-Google-Smtp-Source: AJdET5fy1q78lo1m59VihoFp762iThHb9oY4kw4v7ey3cniQkkjmDQBFnamO5Sl9Y0tP4iC9AaT80w==
X-Received: by 2002:a65:434d:: with SMTP id k13mr3493264pgq.269.1542234955220;
        Wed, 14 Nov 2018 14:35:55 -0800 (PST)
Received: from localhost ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id h10sm23549852pgn.11.2018.11.14.14.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:35:54 -0800 (PST)
Date:   Wed, 14 Nov 2018 14:35:54 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 14:35:38 PST (-0800)
Subject: [GIT PULL] RISC-V Patches for 4.20-rc2
CC:      linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-abc25686-4eaa-4d2a-bb97-2306b418b9fe@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-4.20-rc2

for you to fetch changes up to ef3a61406618291c46da168ff91acaa28d85944c:

  RISC-V: Silence some module warnings on 32-bit (2018-11-12 18:12:24 -0800)

----------------------------------------------------------------
RISC-V Patches for 4.20-rc2

This pull request contains a for unrelated patches that fix various
issues in the RISC-V port:

* A patch that enables printk timestamps in the RISC-V defconfig.
* A whitespace fix to "struct pt_regs".
* A patch that adds a "vdso_install" target for RISC-V.
* A pair of build fixes: one to fix a typo in our makefile, and one to
  clean up some warnings.

There will probably be more patches from us for 4.20, but I don't have
anything that's ready to go right now so I'm going to hold off a bit.
Right now the only concrete thing I know I want to make sure gets sorted
out is our 32-bit stat interface, which I don't want sitting in limbo
for another cycle as we have to get RV32I glibc done.

----------------------------------------------------------------
Anup Patel (1):
      RISC-V: defconfig: Enable printk timestamps

David Abdurachmanov (2):
      riscv: fix spacing in struct pt_regs
      riscv: add missing vdso_install target

Olof Johansson (2):
      RISC-V: lib: Fix build error for 64-bit
      RISC-V: Silence some module warnings on 32-bit

 arch/riscv/Makefile             |  4 ++++
 arch/riscv/configs/defconfig    |  1 +
 arch/riscv/include/asm/ptrace.h |  4 ++--
 arch/riscv/kernel/module.c      | 12 ++++++------
 arch/riscv/lib/Makefile         |  2 +-
 5 files changed, 14 insertions(+), 9 deletions(-)
