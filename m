Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-524998-1519316661-2-4223277499367521272
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519316660; b=JJ/ym8orgJNw0dnHJTMtMHUcJR8yFnYhDfV6azwCBT4akj3
    RFVD4NqDeZIhn4DTMRUv44YBxo2kjpK0bNUCANjleuc/HKGp4+iwuYZOFyN6E6KK
    RxpX1aKR+v90g8r1csUXFI3dOzcf2guYq0hu9TnZMTxbDYRDBPfRU5kNIc6XYmtS
    YskCsPOLLjfnE3mHcHzh2ThzV8ZTnPBnstd4LoM684VLGyJQB4833iL1lLStdyj4
    376RS+lZipy9MVGtcK+nE0SGeZK8DcCvuN24fCR08/GvHVBz2iWD7dI8L2vix8qL
    38Rwb5KiOa8XxhoOuQ4nq9SOy29yIHjJTrm9EMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519316660; bh=fzDpBZUnfDwGAd4x8ePw8uAK0E
    3hZkhNdB/rb5CduS8=; b=KS3cwGCHBVGcTi2y9UaPNlO/KYVUqmhuz93NTO8R02
    eeJtZVgrMaUzwkwL8i2KAYB45E8D167KpJb3GH8R9/chnpy8aVzJDpV2MSmeVXK6
    SSyhpRkyCq9HFOsY++wDVk5rLuHEo4aLI8gl1FitYN7x7PoObY/+ElvJcH2odzPF
    1nzJleEZiStD0OxM7vH7Nzw+fu6WCJgZo9AIgpt2X8PdzAiFrpVQu93XVCWwp1M8
    +7H5uyA34cfVdj8AH4N4TfvDifbH9HftEikk7kaAtmi2Z68oux0ZVwJISOPCYVhL
    EaJjho1JhA1OYW7xmb1C9Mgg45HMN6XXweJ5O9wSV8fg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933295AbeBVQUb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 11:20:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933134AbeBVQU3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 11:20:29 -0500
From: David Howells <dhowells@redhat.com>
To: jmorris@namei.org
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [RFC][PATCH 0/6] KEYS: Fixes
Date: Thu, 22 Feb 2018 16:20:27 +0000
Message-Id: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


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
