Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2043643-1521572842-2-15996973384167673133
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521572841; b=s2CnyXdTig4MaDB8HAqK80LVObbwP8uUts10CXtkPxGayWk
    8Ggnxw6nfxeKSCscxIqvLtpurR5iNE0enC1De3fZGt4ndK1RmOJc/Rz/DXgY6tIK
    YasKEUhBgbcVtGDSaTHFjgP0+g8Z71LGR518xJUHNCqL7wDupnCT2k+4+ZbdOB2g
    WUzW3hK9XgG5AAgFOqTavJlJ3oBr8dizWHGZNw2+ShTbKeWa2SjiLyCEDd0QP/UZ
    DaPBWU5k1I28+uoSow/rniEx3CT87D1pj26KJEOCfC4iBspt5lh86pCz+9guMx8B
    IVi1SEcDJauvGWq5dHEXkzMSfmAld7lOlXniv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521572841; bh=6o4uEB2BvlLAq7zTTIcLRRSqeQ
    70eueiVJwCH87v0+0=; b=PhlEOZrGobtIr2QjRImJsFY/hk10UC090bN/YntOzO
    LgeZA10la8zrudDkHPpPUUPtHr4bakBOeyZ3PeMYAVKHA89tmMVp/HQr//BBK1hw
    O2ItDlGqR3WNfj/kroxQLPQhnkn8dUMWcK11msF8bWs+aRkKUlOmMfVtoINZ2oA7
    CZ/qqBmDEJg+jxkKtZ7v7POsixvsOlwb6nlNTv9Nj9C33DpVc4z/0AjMswfO6AlA
    2zSQewRWV45tnyl1tGo8YCuSaSmlC9TAbC0XKn/KbLlFjTYAEMvucBc656jo7NH5
    WMQ5ASkAeBmtoUGvJTJabv2lkn8OcDA1KurFn5cXSiVg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeCTTHS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 15:07:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:56373 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbeCTTHR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 20 Mar 2018 15:07:17 -0400
Date: Tue, 20 Mar 2018 11:55:03 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org
Cc: mhocko@kernel.org, mtk.manpages@gmail.com,
        robert.kettler@outlook.com, manfred@colorfullife.com,
        ebiederm@xmission.com, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2 0/3] sysvipc: introduce STAT_ANY commands
Message-ID: <20180320185503.nimh3htpprbg7nth@linux-n805>
References: <20180215162458.10059-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180215162458.10059-1-dave@stgolabs.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 15 Feb 2018, Davidlohr Bueso wrote:

>Once (if) merged, I will submit the necesary manpage updates. But I'm
>thinking something like:

Hi Michael, here are the updated manpage entries. As always, please feel
free to modify the descriptions as you see fit.

Thanks,
Davidlohr


------------8<----------------------------------------------------------
[PATCH] sysvipc: add *_STAT_ANY command descriptions

The *ctl syscall descriptions have been updated to reflect the
new commands in msg queues, semaphores and shmem.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 man2/msgctl.2 | 20 +++++++++++++++++---
 man2/semctl.2 | 19 ++++++++++++++++++-
 man2/shmctl.2 | 17 +++++++++++++++--
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/man2/msgctl.2 b/man2/msgctl.2
index df74c750457a..31b1a1f12fb0 100644
--- a/man2/msgctl.2
+++ b/man2/msgctl.2
@@ -33,6 +33,7 @@
 .\"	Language and formatting clean-ups
 .\"	Added msqid_ds and ipc_perm structure definitions
 .\" 2005-08-02, mtk: Added IPC_INFO, MSG_INFO, MSG_STAT descriptions
+.\" 2018-03-20, dbueso: Added MSG_STAT_ANY description.
 .\"
 .TH MSGCTL 2 2017-09-15 "Linux" "Linux Programmer's Manual"
 .SH NAME
@@ -222,10 +223,23 @@ Return a
 structure as for
 .BR IPC_STAT .
 However, the
-.I msqid
+.I msgid
 argument is not a queue identifier, but instead an index into
 the kernel's internal array that maintains information about
 all message queues on the system.
+.TP
+.BR MSG_STAT_ANY " (Linux-specific)"
+Return a
+.I msqid_ds
+structure as for
+.BR MSG_STAT .
+However, the
+.I msg_perm.mode
+is not checked for read access for
+.IR msqid ,
+resembing the behaviour of
+/proc/sysvipc/msg.
+.PP
 .SH RETURN VALUE
 On success,
 .BR IPC_STAT ,
@@ -241,10 +255,10 @@ operation returns the index of the highest used entry in the
 kernel's internal array recording information about all
 message queues.
 (This information can be used with repeated
-.B MSG_STAT
+.B MSG_STAT or MSG_STAT_ANY
 operations to obtain information about all queues on the system.)
 A successful
-.B MSG_STAT
+.B MSG_STAT or MSG_STAT_ANY
 operation returns the identifier of the queue whose index was given in
 .IR msqid .
 .PP
diff --git a/man2/semctl.2 b/man2/semctl.2
index 02930d2c74ae..0ebe0434c05f 100644
--- a/man2/semctl.2
+++ b/man2/semctl.2
@@ -37,6 +37,7 @@
 .\"	Rewrote semun text
 .\"	Added semid_ds and ipc_perm structure definitions
 .\" 2005-08-02, mtk: Added IPC_INFO, SEM_INFO, SEM_STAT descriptions.
+.\" 2018-03-20, dbueso: Added SEM_STAT_ANY description.
 .\"
 .TH SEMCTL 2 2017-09-15 "Linux" "Linux Programmer's Manual"
 .SH NAME
@@ -240,6 +241,17 @@ argument is not a semaphore identifier, but instead an index into
 the kernel's internal array that maintains information about
 all semaphore sets on the system.
 .TP
+.BR SEM_STAT_ANY " (Linux-specific)"
+Return a
+.I seminfo
+structure containing the same information as for
+.BR SEM_STAT .
+However, the
+.I sem_perm.mode
+is not checked for read access for
+.IR semid ,
+resembing the behaviour of
+/proc/sysvipc/sem.
 .B GETALL
 Return
 .B semval
@@ -367,7 +379,7 @@ the index of the highest used entry in the
 kernel's internal array recording information about all
 semaphore sets.
 (This information can be used with repeated
-.B SEM_STAT
+.B SEM_STAT or SEM_STAT_ANY
 operations to obtain information about all semaphore sets on the system.)
 .TP
 .B SEM_INFO
@@ -377,6 +389,10 @@ as for
 .B SEM_STAT
 the identifier of the semaphore set whose index was given in
 .IR semid .
+.TP
+.B SEM_STAT_ANY
+as for
+.BR SEM_STAT .
 .PP
 All other
 .I cmd
@@ -397,6 +413,7 @@ has one of the values
 .BR GETZCNT ,
 .BR IPC_STAT ,
 .BR SEM_STAT ,
+.BR SEM_STAT_ANY ,
 .BR SETALL ,
 or
 .B SETVAL
diff --git a/man2/shmctl.2 b/man2/shmctl.2
index 7bb503999941..42c47d9f4350 100644
--- a/man2/shmctl.2
+++ b/man2/shmctl.2
@@ -41,6 +41,7 @@
 .\" 2005-04-25, mtk -- noted aberrant Linux behavior w.r.t. new
 .\"	attaches to a segment that has already been marked for deletion.
 .\" 2005-08-02, mtk: Added IPC_INFO, SHM_INFO, SHM_STAT descriptions.
+.\" 2018-03-20, dbueso: Added SHM_STAT_ANY description.
 .\"
 .TH SHMCTL 2 2017-09-15 "Linux" "Linux Programmer's Manual"
 .SH NAME
@@ -242,6 +243,18 @@ However, the
 argument is not a segment identifier, but instead an index into
 the kernel's internal array that maintains information about
 all shared memory segments on the system.
+.TP
+.BR SHM_STAT_ANY " (Linux-specific)"
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
+.B SHM_STAT or SHM_STAT_ANY
 operations to obtain information about all shared memory segments
 on the system.)
 A successful
@@ -328,7 +341,7 @@ isn't accessible.
 \fIshmid\fP is not a valid identifier, or \fIcmd\fP
 is not a valid command.
 Or: for a
-.B SHM_STAT
+.B SHM_STAT or SHM_STAT_ANY
 operation, the index value specified in
 .I shmid
 referred to an array slot that is currently unused.
-- 
2.13.6

