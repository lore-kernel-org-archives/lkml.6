Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-570328-1518544342-2-4342894839156114723
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518544341; b=FGZHIrfhoOMU6LhUUMNdUBynJK58wvXKK465lLDw0wNzXOI
    gtHoQkbPH6wF3QoFBv68LK8fQCr5ZCQX67X+KtzTxSfYQWKunMHL7ulplgLaEmfD
    4e40i6yMJwfHBEJI1ji4UtJaVQ2Y4csgnYMOEaOVMnfOxj5zSB1DEFM6SZ+XlNmQ
    8oCdy+g/MH5ayPVtUtcTtqx51luof+MdZ4F5ZlhAYeAE+U+VBTnUS7XvcdfE/Zr3
    8B+ql7HckscwR1b1sBN5JkuoDYL5E6FBtMAJg40uR29fcNqCO0CqwTpXb8LIaf8O
    o8z7sfekpAx8nUaUiJBTuD8I4fsGXcN+FhDcHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518544341; bh=EQEZ/PMfbcyFUifg8HmwjVXigX
    aVwiZNS9uWgnl6jVk=; b=Jr+JnphsVZGUdvO30upwxaqPyoEMXIbs5SLseZSL4U
    tCz2EmhBac3Q+2sYE9lWi16fguBT6GBFzMt/J3gf/Du0ritmwa8BuopMDxa3s/Om
    l97WJD3EFWw6c1lv9JzS/bqSpWQVptu9K2UZxriOpiUqKoBpOHhVnjEMEEsGrKyc
    r0bJ2A43iMbnSI6A42/7PwA6QtSHjX25uu703SOzBdIKsD5gPkawb5Thecg7KR5c
    l3zWtVEhameGUeWFJz9bIJd/Ozi3fVsOlBOXA7jI8HvpxHR2hetyadWDJqHZiSKb
    Ol6tau3TNHvbj8nu/FxErmb8AcJC+v8F66r63Xzq+w7A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965290AbeBMRwE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 12:52:04 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:54567 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965350AbeBMRvE (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Tue, 13 Feb 2018 12:51:04 -0500
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org
Cc: mhocko@kernel.org, mtk.manpages@gmail.com, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH -next 0/3] sysvipc: introduce STAT_ALL commands
Date: Tue, 13 Feb 2018 09:41:33 -0800
Message-Id: <20180213174136.6346-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

The following patches adds the discussed[1] new command for shm
as well as for sems and msq as they are subject to the same discrepancies
for ipc object permission checks between the syscall and via procfs.
These new commands are justified in that (1) we are stuck with this
semantics as changing syscall and procfs can break userland; and (2) some
users can benefit from performance (for large amounts of shm segments,
for example) from not having to parse the procfs interface.

Once (if) merged, I will submit the necesary manpage updates. But I'm
thinking something like:

diff --git a/man2/shmctl.2 b/man2/shmctl.2
index 7bb503999941..bb00bbe21a57 100644
--- a/man2/shmctl.2
+++ b/man2/shmctl.2
@@ -41,6 +41,7 @@
 .\" 2005-04-25, mtk -- noted aberrant Linux behavior w.r.t. new
 .\"	attaches to a segment that has already been marked for deletion.
 .\" 2005-08-02, mtk: Added IPC_INFO, SHM_INFO, SHM_STAT descriptions.
+.\" 2018-02-13, dbueso: Added SHM_STAT_ALL description.
 .\"
 .TH SHMCTL 2 2017-09-15 "Linux" "Linux Programmer's Manual"
 .SH NAME
@@ -242,6 +243,18 @@ However, the
 argument is not a segment identifier, but instead an index into
 the kernel's internal array that maintains information about
 all shared memory segments on the system.
+.TP
+.BR SHM_STAT_ALL " (Linux-specific)"
+Return a
+.I shmid_ds
+structure as for
+.BR SHM_STAT .
+However, the
+.I shm_perm.mode
+is not checked for read access for
+.IR shmid ,
+resembing the behaviour of
+/proc/sysvipc/shm.
 .PP
 The caller can prevent or allow swapping of a shared
 memory segment with the following \fIcmd\fP values:
@@ -287,7 +300,7 @@ operation returns the index of the highest used entry in the
 kernel's internal array recording information about all
 shared memory segments.
 (This information can be used with repeated
-.B SHM_STAT
+.B SHM_STAT/SHM_STAT_ALL
 operations to obtain information about all shared memory segments
 on the system.)
 A successful
@@ -328,7 +341,7 @@ isn't accessible.
 \fIshmid\fP is not a valid identifier, or \fIcmd\fP
 is not a valid command.
 Or: for a
-.B SHM_STAT
+.B SHM_STAT/SHM_STAT_ALL
 operation, the index value specified in
 .I shmid
 referred to an array slot that is currently unused.


Thanks!

[1] https://lkml.org/lkml/2017/12/19/220

Davidlohr Bueso (3):
  ipc/shm: introduce shmctl(SHM_STAT_ALL)
  ipc/sem: introduce shmctl(SEM_STAT_ALL)
  ipc/msg: introduce shmctl(MSG_STAT_ALL)

 include/uapi/linux/msg.h |  1 +
 include/uapi/linux/sem.h |  1 +
 include/uapi/linux/shm.h |  5 +++--
 ipc/msg.c                | 17 ++++++++++++-----
 ipc/sem.c                | 17 ++++++++++++-----
 ipc/shm.c                | 23 ++++++++++++++++++-----
 security/selinux/hooks.c |  3 +++
 7 files changed, 50 insertions(+), 17 deletions(-)

-- 
2.13.6

