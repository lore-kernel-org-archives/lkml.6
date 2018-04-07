Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeDGXh4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 19:37:56 -0400
Received: from namei.org ([65.99.196.166]:55850 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752446AbeDGXhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 19:37:54 -0400
Date: Sun, 8 Apr 2018 09:37:53 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL][SECURITY] TPM updates for v4.17
Message-ID: <alpine.LRH.2.21.1804080935130.1486@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull these changes for TPM, via Jarkko:

"This release contains only bug fixes. There are no new major features 
added."

The following changes since commit 5893ed18a26d1f56b97c0290b0cbbc2d49d6de28:

  Merge tag 'v4.16-rc6' into next-general (2018-03-23 08:26:16 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm

for you to fetch changes up to ed807f6aaf787b83885a571268c5d803068f60a6:

  Merge tag 'tpmdd-next-20180323' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm (2018-03-24 07:48:26 +1100)

----------------------------------------------------------------
Chris Chiu (1):
      tpm: self test failure should not cause suspend to fail

James Bottomley (2):
      tpm: add retry logic
      tpm: fix intermittent failure with self tests

James Morris (1):
      Merge tag 'tpmdd-next-20180323' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm

Tomas Winkler (3):
      tpm: cmd_ready command can be issued only after granting locality
      tpm_crb: use __le64 annotated variable for response buffer address
      tpm2: add longer timeouts for creation commands.

Winkler, Tomas (2):
      tpm: tpm-interface: fix tpm_transmit/_cmd kdoc
      tpm: fix buffer type in tpm_transmit_cmd

 drivers/char/tpm/tpm-interface.c | 158 +++++++++++++++++++++++++++++++--------
 drivers/char/tpm/tpm.h           |  32 +++++---
 drivers/char/tpm/tpm2-cmd.c      |  62 ++++++---------
 drivers/char/tpm/tpm_crb.c       | 113 +++++++++++++++++++---------
 drivers/char/tpm/tpm_tis_core.c  |   4 +-
 include/linux/tpm.h              |   2 +-
 6 files changed, 250 insertions(+), 121 deletions(-)
