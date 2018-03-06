Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeCFJeN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:34:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:24940 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750899AbeCFJeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:34:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="205860693"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 0/4] tpm: factor out tpm1 code into tpm1-cmd.c
Date: Tue,  6 Mar 2018 11:30:37 +0200
Message-Id: <20180306093041.11996-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move tpm 1.x implementation to tpm1-cmd.c similarly to tpm2-cmd.c
This is work in progress of possible dropping compiling out
one tpm 1.x or tpm 2.x in case not needed on a target platform.

Tomas Winkler (4):
  tmp: move tpm1_pcr_extend to tpm1-cmd.c
  tmp: move tpm_getcap to tpm1-cmd.c
  tmp: factor out tpm1_get_random into tpm1-cmd.c
  tpm: move tpm1 selftest code from tpm-interface tpm1-cmd.c

 drivers/char/tpm/st33zp24/st33zp24.c |   2 +-
 drivers/char/tpm/tpm-interface.c     | 273 +----------------------------------
 drivers/char/tpm/tpm-sysfs.c         |  50 +++----
 drivers/char/tpm/tpm.h               |  12 +-
 drivers/char/tpm/tpm1-cmd.c          | 267 +++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm_tis_core.c      |   4 +-
 6 files changed, 303 insertions(+), 305 deletions(-)

-- 
2.14.3
