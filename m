Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933204AbeBVQSA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:18:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933108AbeBVQR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:17:57 -0500
Subject: [RFC][PATCH 0/6] KEYS: Fixes
From: David Howells <dhowells@redhat.com>
To: jmorris@namei.org
Cc: dhowells@redhat.com, linux-security-module@vger.kernel.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 22 Feb 2018 16:17:54 +0000
Message-ID: <151931627456.27289.17918204393283127682.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

Here's a collection of fixes for Linux keyrings, mostly thanks to Eric
Biggers, if you could pass them along to Linus.  They include:

 (1) Fix some PKCS#7 verification issues.

 (2) Fix handling of unsupported crypto in X.509.

 (3) Fix too-large allocation in big_key.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/tag/?h=keys-fixes-20180222

And also on the keys-fixes branch.

David
---
David Howells (1):
      KEYS: Use individual pages in big_key for crypto buffers

Eric Biggers (5):
      PKCS#7: fix certificate chain verification
      PKCS#7: fix certificate blacklisting
      PKCS#7: fix direct verification of SignerInfo signature
      X.509: fix BUG_ON() when hash algorithm is unsupported
      X.509: fix NULL dereference when restricting key with unsupported_sig


 crypto/asymmetric_keys/pkcs7_trust.c  |    1 
 crypto/asymmetric_keys/pkcs7_verify.c |   12 ++--
 crypto/asymmetric_keys/public_key.c   |    4 +
 crypto/asymmetric_keys/restrict.c     |   21 ++++--
 security/keys/big_key.c               |  110 ++++++++++++++++++++++++++-------
 5 files changed, 111 insertions(+), 37 deletions(-)
