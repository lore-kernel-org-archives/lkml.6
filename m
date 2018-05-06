Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3852358-1525646902-2-16555607815904823469
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525646901; b=cp0Qo3TssakKwQyEiBgnTV7qOqoJXrxnkzGbd/td/uYmVOKkoO
    XHWb2FpgCnMHWGSFIZpGNYxna6cjcby/oALXKrwtwDFSFYWfm+wctzmUwZuLHYIZ
    1CH3+WUZprD6saiHS0lM7hTBIwxmKPP5c2hnKWyOYGLCT5FiqiK8WWVgMoBDcH/d
    CgygxAH2vlIpwSPPWziFGEqYRv7lGu36wH7NZT5004FmWT8pPsfbxO7k5l5Ygezi
    pjEOabOnMddomj4jbtn7C1yGTlIvu9d+3op2bfNFOcRhL0CD2o8LfnE8k7Eqd/2p
    OzyURD3RhmIrxOpHP3xq5k7W0VSSCPBHf82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525646901; bh=qNEMyWjk0lWt31am/YRhZziN71tiD1
    c7pxvdatNz/+I=; b=AIkp4KVg8+JOPpRWV4DHTxgFh75yZIGEr6ymxAJyT3V4+N
    qOuJkg2F1KT+LpFi7n5heX1Mr8A3RLFjPvqdlNa7qhl3fLqm7MTRmUOIbbFXs1lf
    OjCjRyFXX15hYtYAJeSps8S6qz/VbIOwgD+C5sFwJifvxVJVDFWWXraFT/4OHXnR
    7iBwPT4GaW9Fx6cFdALp9qHUmeB/HnqWCQfv1xKekW8VFk8FTu9LC9qkA6LDppYq
    elp7fsUU45Y+1/6IuNUhzZHbtMy3Zyo8wHtJBhR00BxlWiVNemUxUI6xIZTKruZB
    JIk++8+29IsEWKAaj9FqX0S73gmTcJ4yygPmqtHA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ubuntu.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=VD0kiHVT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ubuntu.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ubuntu.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=VD0kiHVT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ubuntu.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAOmnJVxQu/B8jGgi5q2yblnjZwflvY/iNOQPL4m4NCP1FpjGBAzd0R29j36a1SQ17rOEtusHckzzQlAv3ZCj/Eo31feTUcrYrd3KCiiNkJb7CdQnCpB
    LZ7UJPMUZciuEIm+fp8g0Mlfh5ulZJ4b8oRvzH2DCCQsp39H2x47yh3+HUWZIZLw/JEeO0BwktiakTwUjogJkcUPEbWE6rLALFE9/W4zhnv2XzqQQvhD/1Jk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=se4zhiC73Y2lUqnZhy0A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeEFWsS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 6 May 2018 18:48:18 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32797 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752104AbeEFWsJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 May 2018 18:48:09 -0400
X-Google-Smtp-Source: AB8JxZry8Xy54GSvyQCsT2ECIHBk6Ln7F4QDcdRR8bEMOZh7q9XJgNBkW/7dR+iM4HRK37vnfFrWQA==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/6 v1] statfs: handle mount propagation
Date: Mon,  7 May 2018 00:46:58 +0200
Message-Id: <20180506224704.14669-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey,

This is v1 of this patchset. All changes from v0 to v1 are non-functional.
Specifically, the commit messages and justification have been extended as
requested by Linus and Al.

This little series does the following:

- unify the definition of constants in statfs.h and fs.h:
  The definitions for MS_* flags are currently a mixture between hex values
  and bit-shifts. All higher values are already initialized with bit-shifts
  for MS_* constants starting with (1<<16). This patch switches the
  definitions for MS_* constants over to uniformly use bit-shifts and
  alignes the definitions of ST_* flags too.
  Initializing them identically let's userspace easily detect when flags
  indicate the same property but use a different value in doing so.

- extend statfs to handle mount propagation:
  For all cases the only way to do this right now is by parsing
  /proc/<pid>/mountinfo. Yes, it is doable but still it is somewhat costly
  and annoying as e.g. those mount propagation fields are optional.
  1. prevent propagation from happening:
     From a userspace perspective we often run into the case where we
     simply want to know whether a given mountpoint is MS_SHARED or is
     MS_SLAVE. If it is we remount it as MS_PRIVATE to prevent any
     propagation from happening. We don't care about the peer
     relationship or how the propagation is exactly setup. We only want
     to prevent any propagation from happening.
     These mountpoints might be known in advance so parsing
     /proc/<pid>/mountinfo should not be needed.
  2. differentiate between MS_SLAVE and MS_SHARED mountpoints:
     Mountpoints that are MS_SLAVE are kept intact and mountpoints that
     are MS_SHARED are made MS_PRIVATE. These mountpoint might be known in
     advance so parsing /proc/<pid>/mountinfo should not be needed.
  3. retrieve propagation properties when procfs is not mounted:
     When the set of interesting mountpoints is known and /proc is not
     mounted calling statfs() is the only good way to reliably determine
     the propagation property of a mountpoint.
  4. inspecting file descriptors to mountpoints for propagation
     properties:
     When file descriptors to mountpoints are passed around between
     processes it is useful to have fstatvfs() handle mount propagation
     properties too.
  To this end the flags:
  - ST_UNBINDABLE
  - ST_SHARED
  - ST_PRIVATE
  - ST_SLAVE
  are added. They have the same value as their MS_* counterparts.

- Testing:
  I verified that now userspace can do e.g.

  int ret;
  char *s = "/some/path";
  struct statvfs sb;

  ret = statvfs(s, &sb);
  if (ret < 0)
          return false;

  if (sb.f_flag & ST_SHARED) {
          ret = mount("", s, NULL, MS_SLAVE | MS_REC, NULL);
          if (ret < 0)
                  return -1;
  }

Thanks!
Christian

Christian Brauner (6):
  fs: use << for MS_* flags
  statfs: use << to align with fs header
  statfs: add ST_UNBINDABLE
  statfs: add ST_SHARED
  statfs: add ST_SLAVE
  statfs: add ST_PRIVATE

 fs/statfs.c             | 16 +++++++++++++++-
 include/linux/statfs.h  | 30 +++++++++++++++++-------------
 include/uapi/linux/fs.h | 33 +++++++++++++++++----------------
 3 files changed, 49 insertions(+), 30 deletions(-)

-- 
2.17.0

