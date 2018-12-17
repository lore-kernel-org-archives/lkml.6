Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7160EC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5312133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbeLQNUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:20:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:9259 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732878AbeLQNUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:20:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 05:20:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="119477509"
Received: from zhangxi4-mobl5.ccr.corp.intel.com (HELO localhost) ([10.249.254.207])
  by orsmga001.jf.intel.com with ESMTP; 17 Dec 2018 05:20:34 -0800
Date:   Mon, 17 Dec 2018 15:20:33 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     jmorris@namei.org
Cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] tpmdd updates for Linux v4.21
Message-ID: <20181217132033.GA31729@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

v4.21 updates:

* Support for partial reads of /dev/tpm0.
* Clean up for TPM 1.x code: move the commands to tpm1-cmd.c and make
  everything to use the same data structure for building TPM commands
  i.e. struct tpm_buf.

/Jarkko

The following changes since commit 26b76320a8a550472bbb8f42257df83fcb8d8df6:

  Merge tag 'v4.20-rc2' into next-general (2018-11-12 09:07:41 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20181217

for you to fetch changes up to 9488585b21bef0df1217e510c7134905d1d376a7:

  tpm: add support for partial reads (2018-12-17 13:45:10 +0200)

----------------------------------------------------------------
tpmdd updates for Linux v4.21

----------------------------------------------------------------
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
