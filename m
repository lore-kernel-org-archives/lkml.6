Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96715ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EDA2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EDA2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeJYSHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:07:17 -0400
Received: from namei.org ([65.99.196.166]:49094 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbeJYSHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:07:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w9P9ZKDX031382;
        Thu, 25 Oct 2018 09:35:20 GMT
Date:   Thu, 25 Oct 2018 20:35:20 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] security: TPM updates for v4.20
Message-ID: <alpine.LRH.2.21.1810252032230.30470@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull.

From Jarkko: "These are the updates to v4.20. The only new feature is 
non-blocking operation for /dev/tpm0."

---

The following changes since commit 2ecefa0a15fd0ef88b9cd5d15ceb813008136431:

  keys: Fix the use of the C++ keyword "private" in uapi/linux/keyctl.h (2018-09-28 09:51:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm

for you to fetch changes up to b8d7b758145252e60ea0198e531a8b00a75b8895:

  Merge tag 'tpmdd-next-20181005' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm (2018-10-05 11:21:23 -0700)

----------------------------------------------------------------
Dr. Greg Wettstein (1):
      tpm: Restore functionality to xen vtpm driver.

James Morris (1):
      Merge tag 'tpmdd-next-20181005' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm

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
