Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2229CC65BA9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB162064E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB162064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeJERug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:50:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:11515 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbeJERug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:50:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 03:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,344,1534834800"; 
   d="scan'208";a="97669546"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.74])
  by orsmga002.jf.intel.com with ESMTP; 05 Oct 2018 03:52:19 -0700
Date:   Fri, 5 Oct 2018 13:52:19 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     jmorris@namei.org
Cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] tpmdd updates for Linux 4.20
Message-ID: <20181005105219.GA23402@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

These are the updates to v4.20. The only new feature is non-blocking
operation for /dev/tpm0.

/Jarkko

The following changes since commit 2ecefa0a15fd0ef88b9cd5d15ceb813008136431:

  keys: Fix the use of the C++ keyword "private" in uapi/linux/keyctl.h (2018-09-28 09:51:51 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20181005

for you to fetch changes up to e487a0f52301293152a6f8c4e217f2a11dd808e3:

  tpm: Restore functionality to xen vtpm driver. (2018-10-05 13:47:34 +0300)

----------------------------------------------------------------
tpmdd updates for Linux 4.20

----------------------------------------------------------------
Dr. Greg Wettstein (1):
      tpm: Restore functionality to xen vtpm driver.

Jarkko Sakkinen (1):
      tpm: fix response size validation in tpm_get_random()

Javier Martinez Canillas (1):
      tpm: suppress transmit cmd error logs when TPM 1.2 is disabled/deactivated

Peter Huewe (1):
      tpm: Make SECURITYFS a weak dependency

Tadeusz Struk (2):
      tpm: add ptr to the tpm_space struct to file_priv
      tpm: add support for nonblocking operation

 drivers/char/tpm/Kconfig          |   2 +-
 drivers/char/tpm/tpm-dev-common.c | 147 ++++++++++++++++++++++++++++----------
 drivers/char/tpm/tpm-dev.c        |  11 +--
 drivers/char/tpm/tpm-dev.h        |  18 +++--
 drivers/char/tpm/tpm-interface.c  |  30 ++++++--
 drivers/char/tpm/tpm.h            |   2 +
 drivers/char/tpm/tpm2-cmd.c       |   4 +-
 drivers/char/tpm/tpmrm-dev.c      |  15 +---
 drivers/char/tpm/xen-tpmfront.c   |   2 +-
 9 files changed, 157 insertions(+), 74 deletions(-)
