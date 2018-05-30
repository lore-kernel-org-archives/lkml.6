Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932317AbeE3UpA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:45:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:28219 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932225AbeE3Uo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:44:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,461,1520924400";
   d="scan'208";a="43451066"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-kernel@vger.kernel.org (open list),
        tpmdd-devel@lists.sourceforge.net (moderated list:TPM DEVICE DRIVER)
Subject: [PATCH v2 0/2] fixes for v4.4
Date: Wed, 30 May 2018 23:44:38 +0300
Message-Id: <20180530204440.27299-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decided to add Enric's commit because it is also a bug fix instead
of modifying Chris commit.

Chris Chiu (1):
  tpm: self test failure should not cause suspend to fail

Enric Balletbo i Serra (1):
  tpm: do not suspend/resume if power stays on

 drivers/char/tpm/tpm-chip.c      | 12 ++++++++++++
 drivers/char/tpm/tpm-interface.c |  7 +++++++
 drivers/char/tpm/tpm.h           |  1 +
 3 files changed, 20 insertions(+)

-- 
v2: moved the check from tpm_of.c to tpm-chip.c as in v4.4 chip is
unreachable otherwise. I did compilation test now with BuildRoot
for power arch.
2.17.0
