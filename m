Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965332AbeBWTK3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:10:29 -0500
Received: from namei.org ([65.99.196.166]:50440 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965202AbeBWTK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 14:10:27 -0500
Date: Sat, 24 Feb 2018 06:10:23 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Security subsystem fixes for v4.16-rc3
Message-ID: <alpine.LRH.2.21.1802240605510.3023@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull these updates, which include:

- Keys fixes via David Howells:

  "Here's a collection of fixes for Linux keyrings, mostly thanks to Eric
   Biggers, if you could pass them along to Linus.  They include:

   (1) Fix some PKCS#7 verification issues.

   (2) Fix handling of unsupported crypto in X.509.

   (3) Fix too-large allocation in big_key."

- Seccomp updates via Kees Cook:

  "Please pull these seccomp changes for v4.16-rc3. These are fixes for 
   the get_metadata interface that landed during -rc1. While the new 
   selftest is strictly not a bug fix, I think it's in the same spirit of 
   avoiding bugs."

And also an IMA build fix from Randy Dunlap.

---

The following changes since commit af3e79d29555b97dd096e2f8e36a0f50213808a8:

  Merge tag 'leds_for-4.16-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds (2018-02-20 10:05:02 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.16-rc3

for you to fetch changes up to 120f3b11ef88fc38ce1d0ff9c9a4b37860ad3140:

  integrity/security: fix digsig.c build error with header file (2018-02-22 20:09:08 -0800)

----------------------------------------------------------------
David Howells (1):
      KEYS: Use individual pages in big_key for crypto buffers

Eric Biggers (5):
      PKCS#7: fix certificate chain verification
      PKCS#7: fix certificate blacklisting
      PKCS#7: fix direct verification of SignerInfo signature
      X.509: fix BUG_ON() when hash algorithm is unsupported
      X.509: fix NULL dereference when restricting key with unsupported_sig

James Morris (2):
      Merge tag 'seccomp-v4.16-rc3' of https://git.kernel.org/.../kees/linux into fixes-v4.16-rc3
      Merge tag 'keys-fixes-20180222-2' of https://git.kernel.org/.../dhowells/linux-fs into fixes-v4.16-rc3

Randy Dunlap (1):
      integrity/security: fix digsig.c build error with header file

Tycho Andersen (3):
      seccomp, ptrace: switch get_metadata types to arch independent
      ptrace, seccomp: tweak get_metadata behavior slightly
      seccomp: add a selftest for get_metadata

 crypto/asymmetric_keys/pkcs7_trust.c          |   1 +
 crypto/asymmetric_keys/pkcs7_verify.c         |  12 +--
 crypto/asymmetric_keys/public_key.c           |   4 +-
 crypto/asymmetric_keys/restrict.c             |  21 +++--
 include/uapi/linux/ptrace.h                   |   4 +-
 kernel/seccomp.c                              |   6 +-
 security/integrity/digsig.c                   |   1 +
 security/keys/big_key.c                       | 110 ++++++++++++++++++++------
 tools/testing/selftests/seccomp/seccomp_bpf.c |  61 ++++++++++++++
 9 files changed, 179 insertions(+), 41 deletions(-)
