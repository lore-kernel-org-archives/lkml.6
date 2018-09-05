Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E26C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C719C2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFVk4HUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C719C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeIEHyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 03:54:09 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35430 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeIEHyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 03:54:09 -0400
Received: by mail-vk0-f65.google.com with SMTP id w193-v6so2167852vke.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 20:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=M8nr/uMhop05vUG6pEcpRnXCrDzdaJukWW8V3v94SzA=;
        b=qFVk4HUMiDJSBd7pzdI7hcFkf/cT7xFcLA2hte65MtmvUoGf0P6XrFrwz/zY5KJA9h
         oBLJhZZMMgmbot2iyTcCqu+wW697Jzei08KDF4VnSk/LMie+t26i0G/1rYliim2ZrVOM
         OsIo68kJ7/2+RopCsN5rQW/LYgzCxX9u24thUyTXopQRbL7ZoVkdv7/7cMETULdB+K40
         F/7QdWkCukjCESHf2NuH5Kjrx9I7Qbx2jCl/hi3fPQrIws1kftmwI9vKdDPw4IeqZtL9
         HwCYGAcySUJMjlM7Bi0/gk0KkHcTn1blOM4czu4NNTCRUBFiujdXXAQN/SFgpF7G77cS
         qG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=M8nr/uMhop05vUG6pEcpRnXCrDzdaJukWW8V3v94SzA=;
        b=J+yfhcH/sSzAmKhLsJo4t7E3sDs0jrXcLMiMN1aZeY7g9fIx8zE5qcH4IfLS0/ORfr
         0zGULHJLr35OXCsK+HU9Ripiflc6yPMWcUXSAWzip9hSWFgAlY6a+zoEeFNBZDbojVol
         U2mGHVZq+J3MKnLvOVDbaDYFvZ4JF/tVn+n1YmCK3tgjRrNpwlflGueXb1kME0oHBiWM
         mEapM/Ml1R0gYBbUUlSI1opnQXt5IFIALn5a7rR4Wtnqnr3sTagaZolunBYw2eDTLTUZ
         SJ8KSRAiGpxiJHI8TidYITVv0xBJMJHpjbhx54777pD3/2kLb3+NThGV5GXpALTEZvRX
         gpvQ==
X-Gm-Message-State: APzg51Cccwq5ShvfBd535npIyivm6HB1yVeoWaAxVL1PAMhWkQrRKZU/
        K6lMnLIZtUww8DWIv+25ipNvDtg1eCztLIQdk0krOQvt
X-Google-Smtp-Source: ANB0VdaH/rq3pFcRAk0xmRfXs4oeJ9/udLdSHw03ASBQla11fADX6bEeB4eybtkXd09otIAKLbVrqP6dBS1KKaCgdsI=
X-Received: by 2002:a1f:8948:: with SMTP id l69-v6mr17944540vkd.132.1536117964889;
 Tue, 04 Sep 2018 20:26:04 -0700 (PDT)
MIME-Version: 1.0
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 5 Sep 2018 11:25:28 +0800
Message-ID: <CAEbi=3d0JgsT1CXBAyVKkL08w4ySp0_FxzPb1UbgAbZMHoW-rA@mail.gmail.com>
Subject: [GIT PULL] nds32 updates for v4.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git
tags/nds32-for-linus-4.19-tag1

for you to fetch changes up to 3350139c0ff3c95724b784f7109987d533cb3ecd:

  nds32: linker script: GCOV kernel may refers data in __exit
(2018-09-05 10:16:26 +0800)

----------------------------------------------------------------
nds32 patches for 4.19

Here is the nds32 patch set based on 4.19-rc2.
Contained in here are the bug fixes, building error fixes and ftrace support
for nds32.

These are the LTP20170427 testing results.

Total Tests: 1902
Total Skipped Tests: 592
Total Failures: 420
Kernel Version: 4.19.0-rc2-00018-g2c9d30cc16f0-dirty
Machine Architecture: nds32

Signed-off-by: Greentime Hu <greentime@andestech.com>

----------------------------------------------------------------
Greentime Hu (5):
      nds32: fix logic for module
      nds32: Only print one page of stack when die to prevent printing
too much information.
      nds32: Fix a kernel panic issue because of wrong frame pointer access.
      nds32: fix build error because of wrong semicolon
      nds32: linker script: GCOV kernel may refers data in __exit

YueHaibing (1):
      nds32: add NULL entry to the end of_device_id array

Zong Li (12):
      nds32: Fix empty call trace
      nds32: Fix get_user/put_user macro expand pointer problem
      nds32: Clean up the coding style
      nds32: Extract the checking and getting pointer to a macro
      nds32/ftrace: Support static function tracer
      nds32/ftrace: Support static function graph tracer
      nds32/ftrace: Add RECORD_MCOUNT support
      nds32/ftrace: Support dynamic function tracer
      nds32/ftrace: Support dynamic function graph tracer
      nds32/stack: Get real return address by using ftrace_graph_ret_addr
      nds32: Remove the deprecated ABI implementation
      nds32: Add macro definition for offset of lp register on stack

 arch/nds32/Kconfig               |   4 ++
 arch/nds32/Makefile              |   4 ++
 arch/nds32/include/asm/elf.h     |   4 +-
 arch/nds32/include/asm/ftrace.h  |  46 ++++++++++++++++++++++
 arch/nds32/include/asm/nds32.h   |   1 +
 arch/nds32/include/asm/uaccess.h | 229
++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------
 arch/nds32/kernel/Makefile       |   6 +++
 arch/nds32/kernel/atl2c.c        |   3 +-
 arch/nds32/kernel/ex-entry.S     |   2 +-
 arch/nds32/kernel/ex-exit.S      |   4 +-
 arch/nds32/kernel/ftrace.c       | 309
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/module.c       |   4 +-
 arch/nds32/kernel/stacktrace.c   |   6 ++-
 arch/nds32/kernel/traps.c        |  42 +++++---------------
 arch/nds32/kernel/vmlinux.lds.S  |  12 ++++++
 scripts/recordmcount.pl          |   3 ++
 16 files changed, 527 insertions(+), 152 deletions(-)
 create mode 100644 arch/nds32/include/asm/ftrace.h
 create mode 100644 arch/nds32/kernel/ftrace.c
