Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF07C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5AB20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeLaESk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 23:18:40 -0500
Received: from namei.org ([65.99.196.166]:53804 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbeLaESj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 23:18:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBV4IchJ001884;
        Mon, 31 Dec 2018 04:18:38 GMT
Date:   Mon, 31 Dec 2018 15:18:38 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] security: TPM changes for v4.21
Message-ID: <alpine.LRH.2.21.1812311516290.1435@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Jarkko:

"
* Support for partial reads of /dev/tpm0.
* Clean up for TPM 1.x code: move the commands to tpm1-cmd.c and make
  everything to use the same data structure for building TPM commands
  i.e. struct tpm_buf.
"


The following changes since commit 8bd8ea195f6d135a8d85201116314eb5237ad7e7:

  Merge tag 'v4.20-rc7' into next-general (2018-12-17 11:24:28 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm

for you to fetch changes up to 0db51ef26e87845d1748c363702585e2f0a06266:

  Merge tag 'tpmdd-next-20181217' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm (2018-12-17 11:31:58 -0800)

----------------------------------------------------------------
James Morris (1):
      Merge tag 'tpmdd-next-20181217' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm

Tadeusz Struk (1):
      tpm: add support for partial reads

Tomas Winkler (24):
      tpm: tpm_i2c_nuvoton: use correct command duration for TPM 2.x
      tpm2: add new tpm2 commands according to TCG 1.36
      tpm: sort objects in the Makefile
      tpm: factor out tpm 1.x duration calculation to tpm1-cmd.c
      tpm: add tpm_calc_ordinal_duration() wrapper
      tpm: factor out tpm_get_timeouts()
      tpm: move tpm1_pcr_extend to tpm1-cmd.c
      tpm: move tpm_getcap to tpm1-cmd.c
      tpm: factor out tpm1_get_random into tpm1-cmd.c
      tpm: move tpm 1.x selftest code from tpm-interface.c tpm1-cmd.c
      tpm: factor out tpm 1.x pm suspend flow into tpm1-cmd.c
      tpm: factor out tpm_startup function
      tpm: add tpm_auto_startup() into tpm-interface.c
      tpm: tpm-interface.c drop unused macros
      tpm: tpm-space.c remove unneeded semicolon
      tpm: tpm1: rewrite tpm1_get_random() using tpm_buf structure
      tpm1: implement tpm1_pcr_read_dev() using tpm_buf structure
      tpm1: rename tpm1_pcr_read_dev to tpm1_pcr_read()
      tpm1: reimplement SAVESTATE using tpm_buf
      tpm1: reimplement tpm1_continue_selftest() using tpm_buf
      tpm: use u32 instead of int for PCR index
      tpm: tpm_try_transmit() refactor error flow.
      tpm: fix kdoc for tpm2_flush_context_cmd()
      tpm: tpm_ibmvtpm: fix kdoc warnings

 drivers/char/tpm/Makefile            |  16 +-
 drivers/char/tpm/st33zp24/st33zp24.c |   2 +-
 drivers/char/tpm/tpm-chip.c          |  11 +-
 drivers/char/tpm/tpm-dev-common.c    |  52 ++-
 drivers/char/tpm/tpm-dev.h           |   5 +-
 drivers/char/tpm/tpm-interface.c     | 832 +++--------------------------------
 drivers/char/tpm/tpm-sysfs.c         |  52 +--
 drivers/char/tpm/tpm.h               |  97 ++--
 drivers/char/tpm/tpm1-cmd.c          | 781 ++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c          | 308 +++++++------
 drivers/char/tpm/tpm2-space.c        |   2 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  11 +-
 drivers/char/tpm/tpm_ibmvtpm.c       |   6 +-
 drivers/char/tpm/tpm_tis_core.c      |  10 +-
 include/linux/tpm.h                  |  11 +-
 security/integrity/ima/ima_crypto.c  |   5 +-
 16 files changed, 1133 insertions(+), 1068 deletions(-)
 create mode 100644 drivers/char/tpm/tpm1-cmd.c
