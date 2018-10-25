Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59160C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5292082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5292082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeJYSEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:04:15 -0400
Received: from namei.org ([65.99.196.166]:49086 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbeJYSEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:04:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w9P9WJwA031132;
        Thu, 25 Oct 2018 09:32:19 GMT
Date:   Thu, 25 Oct 2018 20:32:19 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] security: integrity subsystem updates for 4.20
Message-ID: <alpine.LRH.2.21.1810252029570.30470@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull.

From Mimi: "This pull request contains a couple of bug fixes, including 
one for a recent problem with calculating file hashes on overlayfs, and 
some code cleanup."

---

The following changes since commit e6123c524064a571616ec978b1317f1696eff0ae:

  security: fix LSM description location (2018-10-09 12:18:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-integrity

for you to fetch changes up to 34bccd61b139dbb452421aebf480e7af5f7a12ed:

  MAINTAINERS: add Jarkko as maintainer for trusted keys (2018-10-11 12:10:16 -0400)

----------------------------------------------------------------
Eric Biggers (4):
      vfs: require i_size <= SIZE_MAX in kernel_read_file()
      security/integrity: constify some read-only data
      security/integrity: remove unnecessary 'init_keyring' variable
      ima: fix showing large 'violations' or 'runtime_measurements_count'

Goldwyn Rodrigues (1):
      ima: open a new file instance if no read permissions

Mimi Zohar (1):
      MAINTAINERS: add Jarkko as maintainer for trusted keys

 MAINTAINERS                           |  1 +
 fs/exec.c                             |  8 +++---
 security/integrity/digsig.c           | 10 ++-----
 security/integrity/evm/evm_crypto.c   |  4 +--
 security/integrity/ima/ima.h          |  2 +-
 security/integrity/ima/ima_api.c      |  3 +-
 security/integrity/ima/ima_crypto.c   | 54 ++++++++++++++++++++++-------------
 security/integrity/ima/ima_fs.c       |  9 +++---
 security/integrity/ima/ima_init.c     |  2 +-
 security/integrity/ima/ima_main.c     |  2 +-
 security/integrity/ima/ima_template.c | 11 +++----
 11 files changed, 59 insertions(+), 47 deletions(-)
