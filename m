Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6094EC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED0920873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED0920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeG1PsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 11:48:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:17289 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbeG1PsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 11:48:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jul 2018 07:21:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,414,1526367600"; 
   d="scan'208";a="61462512"
Received: from valeriof-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.48.151])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2018 07:21:31 -0700
Date:   Sat, 28 Jul 2018 17:21:30 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     jmorris@namei.org
Cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] tpmdd 4.19 updates
Message-ID: <20180728142130.GA13541@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 87ea58433208d17295e200d56be5e2a4fe4ce7d6:

  security: check for kstrdup() failure in lsm_append() (2018-07-17 21:27:06 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20180728

for you to fetch changes up to ec403d8ed08c8272cfeeeea154fdebcd289988c8:

  ima: Get rid of ima_used_chip and use ima_tpm_chip != NULL instead (2018-07-28 17:03:11 +0300)

----------------------------------------------------------------
tpmdd updates for Linux 4.19

----------------------------------------------------------------
Jarkko Sakkinen (5):
      tpm: migrate tpm2_shutdown() to use struct tpm_buf
      tpm: migrate tpm2_probe() to use struct tpm_buf
      tpm: migrate tpm2_get_tpm_pt() to use struct tpm_buf
      tpm: migrate tpm2_get_random() to use struct tpm_buf
      tpm: replace TPM_TRANSMIT_RAW with TPM_TRANSMIT_NESTED

Linus Walleij (1):
      tpm_tis_spi: Pass the SPI IRQ down to the driver

Louis Collard (1):
      tpm: Allow tpm_tis drivers to set hwrng quality.

Peter Rosin (1):
      tpm/tpm_i2c_infineon: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Ricardo Schwarzmeier (1):
      tpm: Return the actual size when receiving an unsupported command

Stefan Berger (5):
      tpm: rename tpm_chip_find_get() to tpm_find_get_ops()
      tpm: Implement tpm_default_chip() to find a TPM chip
      tpm: Convert tpm_find_get_ops() to use tpm_default_chip()
      ima: Use tpm_default_chip() and call TPM functions with a tpm_chip
      ima: Get rid of ima_used_chip and use ima_tpm_chip != NULL instead

Tomas Winkler (1):
      tpm: separate cmd_ready/go_idle from runtime_pm

 drivers/char/tpm/tpm-chip.c         |  68 +++++++---
 drivers/char/tpm/tpm-interface.c    |  72 +++++++---
 drivers/char/tpm/tpm.h              |  31 +++--
 drivers/char/tpm/tpm2-cmd.c         | 258 +++++++++++++++---------------------
 drivers/char/tpm/tpm2-space.c       |  12 +-
 drivers/char/tpm/tpm_crb.c          | 101 ++++----------
 drivers/char/tpm/tpm_i2c_infineon.c |   8 +-
 drivers/char/tpm/tpm_tis_core.c     |   2 +
 drivers/char/tpm/tpm_tis_core.h     |   1 +
 drivers/char/tpm/tpm_tis_spi.c      |   9 +-
 drivers/char/tpm/tpm_vtpm_proxy.c   |   2 +-
 include/linux/tpm.h                 |   7 +
 security/integrity/ima/ima.h        |   2 +-
 security/integrity/ima/ima_crypto.c |   4 +-
 security/integrity/ima/ima_init.c   |  16 +--
 security/integrity/ima/ima_queue.c  |   4 +-
 16 files changed, 289 insertions(+), 308 deletions(-)
