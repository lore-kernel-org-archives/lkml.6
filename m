Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D448CC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 19:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5BA21850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 19:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbeLXTzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 14:55:02 -0500
Received: from namei.org ([65.99.196.166]:53132 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbeLXTzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 14:55:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBOJt0u1002778;
        Mon, 24 Dec 2018 19:55:00 GMT
Date:   Tue, 25 Dec 2018 06:55:00 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] security: general updates for v4.21
Message-ID: <alpine.LRH.2.21.1812250652420.2714@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these general updates for the security subsystem for v4.21.

The main changes here are Paul Gortmaker's removal of unneccesary module.h 
infrastructure.

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

for you to fetch changes up to b49d564344f773d8afee982153c8493e5f2eaf38:

  security: integrity: partial revert of make ima_main explicitly non-modular (2018-12-20 09:59:12 -0800)

----------------------------------------------------------------
James Morris (2):
      Merge tag 'v4.20-rc2' into next-general
      Merge tag 'v4.20-rc7' into next-general

Paul Gortmaker (6):
      security: integrity: make ima_main explicitly non-modular
      keys: remove needless modular infrastructure from ecryptfs_format
      security: integrity: make evm_main explicitly non-modular
      security: audit and remove any unnecessary uses of module.h
      security: fs: make inode explicitly non-modular
      security: integrity: partial revert of make ima_main explicitly non-modular

Yangtao Li (1):
      tomoyo: fix small typo

 security/apparmor/apparmorfs.c                   | 2 +-
 security/commoncap.c                             | 1 -
 security/inode.c                                 | 6 ++----
 security/integrity/evm/evm_crypto.c              | 2 +-
 security/integrity/evm/evm_main.c                | 5 +----
 security/integrity/evm/evm_posix_acl.c           | 1 -
 security/integrity/evm/evm_secfs.c               | 2 +-
 security/integrity/iint.c                        | 2 +-
 security/integrity/ima/ima_api.c                 | 1 -
 security/integrity/ima/ima_appraise.c            | 2 +-
 security/integrity/ima/ima_fs.c                  | 2 +-
 security/integrity/ima/ima_init.c                | 2 +-
 security/integrity/ima/ima_main.c                | 5 ++---
 security/integrity/ima/ima_policy.c              | 2 +-
 security/integrity/ima/ima_queue.c               | 1 -
 security/keys/encrypted-keys/ecryptfs_format.c   | 5 ++---
 security/keys/encrypted-keys/masterkey_trusted.c | 1 -
 security/keys/gc.c                               | 1 -
 security/keys/key.c                              | 2 +-
 security/keys/keyctl.c                           | 1 -
 security/keys/keyring.c                          | 2 +-
 security/keys/permission.c                       | 2 +-
 security/keys/proc.c                             | 1 -
 security/keys/process_keys.c                     | 1 -
 security/keys/request_key.c                      | 2 +-
 security/keys/request_key_auth.c                 | 1 -
 security/keys/user_defined.c                     | 2 +-
 security/security.c                              | 2 +-
 security/tomoyo/util.c                           | 2 +-
 29 files changed, 22 insertions(+), 39 deletions(-)
