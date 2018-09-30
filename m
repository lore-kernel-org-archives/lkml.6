Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE04DC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 23:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96615206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 23:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96615206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeJAGWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 02:22:08 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:51561 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbeJAGWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 02:22:08 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mpkwn-1fNWi32jCn-00qDNg; Mon, 01 Oct 2018 01:46:38 +0200
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mpkwn-1fNWi32jCn-00qDNg; Mon, 01 Oct 2018 01:46:38 +0200
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-api@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@openvz.org>,
        containers@lists.linux-foundation.org,
        Laurent Vivier <laurent@vivier.eu>
Subject: [RFC 0/2] ns: introduce binfmt_misc namespace
Date:   Mon,  1 Oct 2018 01:46:26 +0200
Message-Id: <20180930234628.25528-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:h7ZxYlqTEwGJYfdXMNCiuyjy6YAGhrPsSxrUXkxn8T/t6ILN6LP
 s7gnsvWoHJSdzPezoVqUsffhxxMmD+wdeVWzCCsfpQUN3TAtFAt6WPHE4f5lH52K379PW/f
 P1cgFn86GCFODxGORI3ABnBh+LmwOK9zSvXAFOtTJO3T3hP2bTTer7uF48izV5oxXb2tELX
 GKyZBpG6ZjWUuxSVh9nxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:isBErN8T5yc=:rtKtPzKW41OU46auNEcNaQ
 ZpG97vCA0KiXOtAeB4mtycVKJbZ1vKP5wtGrm+iyDXJLUIJqYsprFAq6YhKqnv/9HeLe7v4du
 jrNfZzNsB1HqlWJk3EjVz9tUE93PVKyb/zP/yq4jV6l+HdH5nSqz2KlfTlv3j1D+PwZPUevdN
 47PvvGsWeQJKdgxG56wI1uMQPSAsC9HFJeW7OIWZ3sHHKKRrsirRLAWHRHlQbKACQbbvtmBjo
 55y9wyb0VVltPPE5i5IAxDgIFPVAgsLteGDCwMyfEAH03ddM75ZyDwdvHakdFZPEGLPCgNWl9
 fUrhIWd9sGK5gEHDUrVcWqGSUlzWs/7GlHolY4/tPALE4oFeRLAPtN9eJ9+5BUvd99cR+wTat
 TnSNbHGWQpZxMxutzNX5boD1e0DcnRkCv9KMf1DcxLe8T1A2Mb4+dppdKuw0Ks+OdGpgglegR
 unjNjyGwVtOcNKOYgoVDnqJ9/uc7cMij8Z3pzh4U/bLYIRamf0pX79DxKqQb0qi6/ZY13TYCt
 2coMagvTuuO9Pa4wmbiAbj1CPpzHw11siUBKZFhRkahhus4h9OXQP3iGBp4uSYhzh8FnmBQ74
 b1YKDzmqaSCmwZQy51qGCvuZelB97axzgIGt9r9r4ZcXWV6hLexiazheonf7fP7p1FdLQ/N3y
 nEBGx6mFYHmxJl3fg/bQvsZ3tFw2NZKqV5NOhZlgB4nu9AOBNZh7yn71I8adA5BB3tao=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a new namespace for binfmt_misc.

This allows to define a new interpreter for each new container.

But the main goal is to be able to chroot to a directory
using a binfmt_misc interpreter without being root.

I have a modified version of unshare at:

  git@github.com:vivier/util-linux.git branch unshare-chroot

with some new options to unshare binfmt_misc namespace and to chroot
to a directory.

If you have a directory /chroot/powerpc/jessie containing debian for powerpc
binaries and a qemu-ppc interpreter, you can do for instance:

$ uname -a
Linux fedora28-wor-2 4.19.0-rc5+ #18 SMP Mon Oct 1 00:32:34 CEST 2018 x86_64 x86_64 x86_64 GNU/Linux
$ ./unshare --map-root-user --fork --pid \
  --load-binfmt ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/qemu-ppc:OC" \
  --root=/chroot/powerpc/jessie /bin/bash -l
Linux fedora28-wor-2 4.19.0-rc5+ #18 SMP Mon Oct 1 00:32:34 CEST 2018 ppc GNU/Linux
uid=0(root) gid=0(root) groups=0(root),65534(nogroup)
total 5940
drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:58 bin
drwxr-xr-x.   2 nobody nogroup    4096 Jun 17 20:26 boot
drwxr-xr-x.   4 nobody nogroup    4096 Aug 12 00:08 dev
drwxr-xr-x.  42 nobody nogroup    4096 Sep 28 07:25 etc
drwxr-xr-x.   3 nobody nogroup    4096 Sep 28 07:25 home
drwxr-xr-x.   9 nobody nogroup    4096 Aug 12 00:58 lib
drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 media
drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 mnt
drwxr-xr-x.   3 nobody nogroup    4096 Aug 12 13:09 opt
dr-xr-xr-x. 143 nobody nogroup       0 Sep 30 23:02 proc
-rwxr-xr-x.   1 nobody nogroup 6009712 Sep 28 07:22 qemu-ppc
drwx------.   3 nobody nogroup    4096 Aug 12 12:54 root
drwxr-xr-x.   3 nobody nogroup    4096 Aug 12 00:08 run
drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:58 sbin
drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 srv
drwxr-xr-x.   2 nobody nogroup    4096 Apr  6  2015 sys
drwxrwxrwt.   2 nobody nogroup    4096 Sep 28 10:31 tmp
drwxr-xr-x.  10 nobody nogroup    4096 Aug 12 00:08 usr
drwxr-xr-x.  11 nobody nogroup    4096 Aug 12 00:08 var

If you want to use the qemu binary provided by your distro, you can use

    --load-binfmt ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/bin/qemu-ppc-static:OCF"

With the 'F' flag, qemu-ppc-static will be then loaded from the main root
filesystem before switching to the chroot.

Laurent Vivier (2):
  ns: introduce binfmt_misc namespace
  binfmt_misc: move data to binfmt_namespace

 fs/binfmt_misc.c                 |  50 +++++-----
 fs/proc/namespaces.c             |   3 +
 include/linux/binfmt_namespace.h |  63 ++++++++++++
 include/linux/nsproxy.h          |   2 +
 include/linux/proc_ns.h          |   2 +
 include/linux/user_namespace.h   |   1 +
 include/uapi/linux/sched.h       |   1 +
 init/Kconfig                     |   8 ++
 kernel/Makefile                  |   1 +
 kernel/binfmt_namespace.c        | 164 +++++++++++++++++++++++++++++++
 kernel/fork.c                    |   3 +-
 kernel/nsproxy.c                 |  18 +++-
 12 files changed, 289 insertions(+), 27 deletions(-)
 create mode 100644 include/linux/binfmt_namespace.h
 create mode 100644 kernel/binfmt_namespace.c

-- 
2.17.1

