Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F0BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1601214FB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1601214FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbeHPBnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:43:13 -0400
Received: from namei.org ([65.99.196.166]:43388 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbeHPBnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:43:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w7FMmxCR026126;
        Wed, 15 Aug 2018 22:48:59 GMT
Date:   Thu, 16 Aug 2018 08:48:59 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] security subsystem: Integrity updates for v4.19
Message-ID: <alpine.LRH.2.21.1808160842350.19586@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Mimi Zohar:

"This pull request adds support for EVM signatures based on larger
digests, contains a new audit record AUDIT_INTEGRITY_POLICY_RULE to
differentiate the IMA policy rules from the IMA-audit messages,
addresses two deadlocks due to either loading or searching for crypto
algorithms, and cleans up the audit messages."


The following changes since commit 87ea58433208d17295e200d56be5e2a4fe4ce7d6:

  security: check for kstrdup() failure in lsm_append() (2018-07-17 21:27:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-integrity

for you to fetch changes up to 3dd0f18c70d94ca2432c78c5735744429f071b0b:

  EVM: fix return value check in evm_write_xattrs() (2018-07-22 14:49:11 -0400)

----------------------------------------------------------------
Matthew Garrett (2):
      evm: Don't deadlock if a crypto algorithm is unavailable
      evm: Allow non-SHA1 digital signatures

Mikhail Kurinnoi (1):
      integrity: prevent deadlock during digsig verification.

Stefan Berger (4):
      ima: Call audit_log_string() rather than logging it untrusted
      ima: Use audit_log_format() rather than audit_log_string()
      ima: Do not audit if CONFIG_INTEGRITY_AUDIT is not set
      ima: Differentiate auditing policy rules from "audit" actions

Sudeep Holla (1):
      integrity: silence warning when CONFIG_SECURITYFS is not enabled

Wei Yongjun (1):
      EVM: fix return value check in evm_write_xattrs()

 crypto/api.c                           |  2 +-
 include/linux/crypto.h                 |  5 ++++
 include/linux/integrity.h              | 13 +++++++++
 include/uapi/linux/audit.h             |  1 +
 security/integrity/digsig_asymmetric.c | 23 ++++++++++++++++
 security/integrity/evm/Kconfig         |  1 +
 security/integrity/evm/evm.h           | 10 +++++--
 security/integrity/evm/evm_crypto.c    | 50 ++++++++++++++++++----------------
 security/integrity/evm/evm_main.c      | 19 ++++++++-----
 security/integrity/evm/evm_secfs.c     |  4 +--
 security/integrity/iint.c              |  9 ++++--
 security/integrity/ima/Kconfig         |  1 +
 security/integrity/ima/ima_policy.c    |  9 ++++--
 security/integrity/integrity.h         | 15 ++++++++++
 security/integrity/integrity_audit.c   |  6 +---
 security/security.c                    |  7 ++++-
 16 files changed, 128 insertions(+), 47 deletions(-)


