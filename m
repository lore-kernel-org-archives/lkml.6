Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PqOzGaRwGVvcaAAAmS7hNA
	; Thu, 07 Jun 2018 17:51:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5A0396074D; Thu,  7 Jun 2018 17:51:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 913E0601C3;
	Thu,  7 Jun 2018 17:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 913E0601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935036AbeFGRv3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:51:29 -0400
Received: from namei.org ([65.99.196.166]:58478 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933071AbeFGRv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:51:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w57HpQhU031388;
        Thu, 7 Jun 2018 17:51:26 GMT
Date: Fri, 8 Jun 2018 03:51:26 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Security subsystem: TPM updates for v4.18
Message-ID: <alpine.LRH.2.21.1806080346090.27121@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull these updates for the TPM subsystem.

>From Jarkko: "this purely a bug fix release. The only major change is to 
move the event log code to its own subdirectory because there starts to be 
so much of it."

---

The following changes since commit 890e2abe1028c39e5399101a2c277219cd637aaa:

  dh key: get rid of stack allocated array for zeroes (2018-05-11 13:07:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm

for you to fetch changes up to 2d06236ab3276000665ef55eccc111c3bbf90589:

  Merge tag 'tpmdd-next-20180602' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm (2018-06-04 09:08:21 -0700)

----------------------------------------------------------------
Colin Ian King (2):
      tpm: st33zp24: remove redundant null check on chip
      tpm/st33zp24: Fix spelling mistake in macro ST33ZP24_TISREGISTER_UKNOWN

James Morris (2):
      Merge tag 'tpmdd-next-20180518' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm
      Merge tag 'tpmdd-next-20180602' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm

Jerry Snitselaar (1):
      tpm_tis: verify locality released before returning from release_locality

Ji-Hun Kim (2):
      tpm: replace kmalloc() + memcpy() with kmemdup()
      tpm: replace kmalloc() + memcpy() with kmemdup()

Nayna Jain (3):
      tpm: move the delay_msec increment after sleep in tpm_transmit()
      tpm: reduce poll sleep time in tpm_transmit()
      tpm: reduce polling time to usecs for even finer granularity

Tadeusz Struk (2):
      tpm: fix use after free in tpm2_load_context()
      tpm: fix race condition in tpm_common_write()

Thiebaud Weksteen (4):
      tpm: Add explicit endianness cast
      tpm: Move eventlog files to a subdirectory
      tpm: Move shared eventlog functions to common.c
      tpm: Move eventlog declarations to its own header

Winkler, Tomas (1):
      tpm: tpm_crb: relinquish locality on error path.

 drivers/char/tpm/Makefile                          |  10 +-
 .../tpm/{tpm_eventlog_acpi.c => eventlog/acpi.c}   |   3 +-
 drivers/char/tpm/eventlog/common.c                 | 195 ++++++++++++++++++++
 drivers/char/tpm/eventlog/common.h                 |  35 ++++
 .../tpm/{tpm_eventlog_efi.c => eventlog/efi.c}     |   6 +-
 .../char/tpm/{tpm_eventlog_of.c => eventlog/of.c}  |  11 +-
 .../char/tpm/{tpm1_eventlog.c => eventlog/tpm1.c}  | 200 ++-------------------
 .../char/tpm/{tpm2_eventlog.c => eventlog/tpm2.c}  |   3 +-
 drivers/char/tpm/st33zp24/spi.c                    |   4 +-
 drivers/char/tpm/st33zp24/st33zp24.c               |   2 -
 drivers/char/tpm/tpm-dev-common.c                  |  40 ++---
 drivers/char/tpm/tpm-dev.h                         |   2 +-
 drivers/char/tpm/tpm-interface.c                   |   5 +-
 drivers/char/tpm/tpm.h                             |  32 +---
 drivers/char/tpm/tpm2-space.c                      |   3 +-
 drivers/char/tpm/tpm_crb.c                         |  10 +-
 drivers/char/tpm/tpm_tis_core.c                    |  58 +++++-
 17 files changed, 350 insertions(+), 269 deletions(-)
 rename drivers/char/tpm/{tpm_eventlog_acpi.c => eventlog/acpi.c} (98%)
 create mode 100644 drivers/char/tpm/eventlog/common.c
 create mode 100644 drivers/char/tpm/eventlog/common.h
 rename drivers/char/tpm/{tpm_eventlog_efi.c => eventlog/efi.c} (91%)
 rename drivers/char/tpm/{tpm_eventlog_of.c => eventlog/of.c} (91%)
 rename drivers/char/tpm/{tpm1_eventlog.c => eventlog/tpm1.c} (58%)
 rename drivers/char/tpm/{tpm2_eventlog.c => eventlog/tpm2.c} (99%)
