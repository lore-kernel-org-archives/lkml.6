Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2182782-1527602175-2-14970395091421502310
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527602174; b=O9W8dbajspLTH8ZZu9sL6jDG8ebnyRoI8mxe1GV0GkOA7SQiWA
    opF6lJu2o908jTpehdUYEOD+N+h54A1bgclHym8CdMr1LLPY7gfXmzJnZR2PvNU1
    e4RjE6ODF67uVrPYGg62EiUJVByVY4b3+MRaghB18TrzADJq5tAakSgy1pqE6BqR
    xf8bOqx+PzaoCCvXOFIwYsR9b/zeMRE0W8zFAPzZ0KP8iyt0aSjq/aBtfFbi1+NH
    34iKQsmSmMETAytm66XSR4AAeb7HfgiideAqu0KDaS7Wk3tc18Qq6wwvhQmh9Hu3
    jNp2whbUVuWx8nOfcnZT1sUaa8226IlrF7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:mime-version
    :content-type:content-id:content-transfer-encoding:date
    :message-id:sender:list-id; s=fm2; t=1527602174; bh=wKj7UJJTng4y
    gOqB01lOF4HEOpl1m54yiN4h4QjGm6A=; b=WNtr2C9sQzF758TzifFsOu0PpB0k
    3oazyb67OuvRF98n3s1NroJJt5tm5EBAO1PYwyT5kYWWhD1DxBnrxs9OUO4bQvBg
    EPvWBcOCRHwNJGeT2M/Im3QVaA4+RJOQ6jMfaTMjg7Radfozd+dfFHNv7m/gDdwa
    i/cK5feaXxB/lJWxIbyzwjuSQuuzjHc8XWwOh+6ok5WNT35WcP2jhEl3sfWYrgHI
    q3YzTpsAme9/iwu6ukb7X3QcjHtZvASxuO/kFHEOQUJ4D7WXNCu6vS3678Y/+6DD
    lie19WIhI14WDtTMDpGO0MvlPrVc89jcbGmzyER9l2nSIJmvr7PLkiK3ZQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB4Is9EDm3v14/hjveV0FITeO8pZFOky5rHvP4a0HxAVlN7MXtzGaeoKXXXt6B2Zo2dcVQKTReeLZD59t7x7ugY+gq9HzZPBhBcWpaCIKWYh6j3/psz2
    YKY6rrwqw8MSCVgK5sHGYm9bwu/52dMgHIcB8ItiasdqHNYy+XdHX0F+XfB/VqIIDsMPGfCqip9k73tqQb3ZMmghktfD/dGwob6At7IBnYHuI/iuy9o99hMR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=QP_mjHWvzBFhRzTkgxUA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934584AbeE2Nzx convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Tue, 29 May 2018 09:55:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933755AbeE2Nzw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 09:55:52 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: A couple of fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31070.1527602145.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Tue, 29 May 2018 14:55:45 +0100
Message-ID: <31071.1527602145@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Linus,

Here's a couple of fixes for the AFS filesystem:

 (1) Fix a BUG triggerable from faccessat().

 (2) Fix the mounting of backup volumes.

David
---
The following changes since commit 21b9f1c7e319f654de3b2574fe8d4e4114c9143f:

  Merge tag 'afs-fixes-20180514' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs (2018-05-15 10:48:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20180529

for you to fetch changes up to 1fba5868eed82766fb374c7d367166706f9269d5:

  afs: Fix mounting of backup volumes (2018-05-16 21:35:23 +0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (1):
      afs: Fix directory permissions check

Marc Dionne (1):
      afs: Fix mounting of backup volumes

 fs/afs/security.c | 10 +++-------
 fs/afs/vlclient.c | 19 ++++++++++---------
 2 files changed, 13 insertions(+), 16 deletions(-)
