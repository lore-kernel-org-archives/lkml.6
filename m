Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A859ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93ED20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HUSUWcyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93ED20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbeKAIpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:45:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38886 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbeKAIHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so8085363pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 16:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:cc:from:to:message-id;
        bh=taxbZLCJehS6KXdYbTRFCpaWx1QA6noR3r+ATRV96No=;
        b=HUSUWcyOf2qeYvt+325vt07Zwer09etmhSbPJMZSfHPLyT0xlH9O7VAEALUOh434PP
         /Zco+y8vehgkxNfxWt+ob9s2mZgMGbNszzjULekfLRxEo6E6xPiiNXp3LCW196TRQ4kO
         BmfZ4og379Huq91AE42k9jZEGJiHeZlhfMnjVKwOp31BgMwXbZHDDSftsg4HHosdmo6/
         GwKDzCGWfCs6vft3J15qfNBceG2EHc+NHCnEbnZimZcUXcl3RdhZOElhRFgRqCUZFq65
         0lUtpmZxGu4tiwA+bLWwpnLmx7FKR2Oe3K+R6hV76A1FGF5IEGSuG1OFzq5h5LL48O1D
         fpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=taxbZLCJehS6KXdYbTRFCpaWx1QA6noR3r+ATRV96No=;
        b=THTte5URNkTLKKVRik+SBEkqHAkqyzghYr01GmVZNr/+rPUplisn56JSCL9EzQ830R
         w3hk68cbCcFD8t8tch8LaD4Fri5HBAbdqmxprCLOfzqPTqxw0z1LCrjBBwi1Q9e9fNzS
         XmGuaO04pLTBaRYn2y5dEf4FXMhm/wzbOi6ZQmuM5F/pOO6jfCgI3ZR9vu4RpNqYZuAD
         1FV+KYKYtpitWB6sV+8NzFcfKfKqnumH+IK8xJF/dNuZD4P/PonEoLt8oCeUa1wE1czd
         MF+fn7wMUoqNjuY7c0lzWEfnvkeZcNZUxe68If3gm40AYXJQGft3IgQQ7RpiOyZsfokW
         RO9A==
X-Gm-Message-State: AGRZ1gLoYKxj+S0sfVbKoh6OWr71gLusvLRp8NxwfK0MPdRc9Jgu7Mpk
        TPuxTZh+QY33YIserw1MVkEFO9npSvU=
X-Google-Smtp-Source: AJdET5cKmvN85ghIyrTumOyLVVuMKVBpw0c7DIdYFPoggROTIlRu5yLG5k86he6l0hI/CYdKHzdGtw==
X-Received: by 2002:a62:dbc6:: with SMTP id f189-v6mr5330004pfg.130.1541027234241;
        Wed, 31 Oct 2018 16:07:14 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id o195-v6sm12075490pfg.112.2018.10.31.16.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 16:07:13 -0700 (PDT)
Date:   Wed, 31 Oct 2018 16:07:13 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Oct 2018 16:07:06 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 4.20 Merge Window, Part 2 v2
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-ddfcf75a-ffa5-43b1-a785-23da232023ad@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d26c4bbf992463c043fdee4b3e5efa3f08990862:

  RISC-V: SMP cleanup and new features (2018-10-22 17:41:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-4.20-mw2

for you to fetch changes up to ef70696a63c773280ef46f5764a6cda39ef2f383:

  lib: Remove umoddi3 and udivmoddi4 (2018-10-31 12:13:54 -0700)

----------------------------------------------------------------
RISC-V Patches for the 4.20 Merge Window, Part 2 v2

This tag contains the follow-on patches I'd like to target for the 4.20
merge window.  I'm being somewhat conservative here, as while there are
a few patches on the mailing list that were posted early in the merge
window I'd like to let those bake for another round -- this was a fairly
big release as far as RISC-V is concerened, and we need to walk before
we can run.

As far as the patches that made it go:

* A patch to ignore offline CPUs when calculating AT_HWCAP.  This should
  fix GDB on the HiFive unleashed, which has an embedded core for hart
  0 which is exposed to Linux as an offline CPU.
* A move of EM_RISCV to elf-em.h, which is where it should have been to
  begin with.
* I've also removed the 64-bit divide routines.  I know I'm not really
  playing by my own rules here because I posted the patches this
  morning, but since they shouldn't be in the kernel I think it's better
  to err on the side of going too fast here.

I don't anticipate any more patch sets for the merge window.

Changes since v1:

* Use a consistent base to merge from so the history isn't a mess.

----------------------------------------------------------------
Andreas Schwab (1):
      RISC-V: properly determine hardware caps

Palmer Dabbelt (4):
      Revert "RISC-V: Select GENERIC_LIB_UMODDI3 on RV32"
      Revert "lib: Add umoddi3 and udivmoddi4 of GCC library routines"
      Move EM_RISCV into elf-em.h
      lib: Remove umoddi3 and udivmoddi4

 arch/riscv/Kconfig             |   1 -
 arch/riscv/include/asm/elf.h   |   3 -
 arch/riscv/kernel/cpufeature.c |   8 +-
 include/uapi/linux/elf-em.h    |   1 +
 lib/Kconfig                    |   3 -
 lib/Makefile                   |   1 -
 lib/udivmoddi4.c               | 310 -----------------------------------------
 lib/umoddi3.c                  |  32 -----
 8 files changed, 6 insertions(+), 353 deletions(-)
 delete mode 100644 lib/udivmoddi4.c
 delete mode 100644 lib/umoddi3.c
