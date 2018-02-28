Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934023AbeB1T6d (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:58:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:63631 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933687AbeB1T6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:58:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="207770199"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/5] Migrate all TPM 2.0 commands to use struct tpm_buf
Date: Wed, 28 Feb 2018 21:58:13 +0200
Message-Id: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make struct tpm_buf the first class object for constructing TPM
commands, this patch set migrates all TPM 2.0 commands to use it. The next
step after this is to migrate TPM 1.2 commands in a subsequent patch set.
Finally, tpm_transmit_cmd() can take simply struct tpm_buf as its argument
and this interface can be exported to be used by the kernel keyring.

The ultimate goal of this work is to make constructing TPM commands inside
the kernel simple and robust.

Alexander Steffen (1):
  tpm: Trigger only missing TPM 2.0 self tests

Jarkko Sakkinen (4):
  tpm: migrate tpm2_shutdown() to use struct tpm_buf
  tpm: migrate tpm2_probe() to use struct tpm_buf
  tpm: migrate tpm2_get_tpm_pt() to use struct tpm_buf
  tpm: migrate tpm2_get_random() to use struct tpm_buf

 drivers/char/tpm/tpm-interface.c |  20 ++-
 drivers/char/tpm/tpm.h           |   3 +-
 drivers/char/tpm/tpm2-cmd.c      | 266 ++++++++++++++-------------------------
 3 files changed, 112 insertions(+), 177 deletions(-)

-- 
2.15.1
