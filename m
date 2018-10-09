Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B86C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617D321479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617D321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeJIRzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:55:01 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57957 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIRzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:55:01 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MPGJh-1gK5ky2TKX-00PgFX; Tue, 09 Oct 2018 12:38:01 +0200
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MPGJh-1gK5ky2TKX-00PgFX; Tue, 09 Oct 2018 12:38:01 +0200
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Dmitry Safonov <dima@arista.com>, linux-api@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        containers@lists.linux-foundation.org,
        Jann Horn <jannh@google.com>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [RFC v5 0/1] ns: introduce binfmt_misc namespace
Date:   Tue,  9 Oct 2018 12:37:51 +0200
Message-Id: <20181009103752.21482-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:QeX9N1r3/x5ikq5r7LMsqel+4qjmCsmMMlBrRmVHmHOXzWH1dYw
 DjRfdGh0Yu5VfbKSkbqFmW5TSTxenL7lbzdoCYNmzSxPYUJKUpzmU08KV12etHsbVpPJ1/7
 D6fZQboGJF3S9hgA71KFELxYMsstcC8/HZ9DVyq7BlFWpl3T/SSnIsPrOm9CoNF8lwRSqyd
 Lnw7xQltXYCnZ9efsietg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mKp3dvc7ZVE=:d8RaGrN1dItKFWSYR2XVEi
 UWStEIPsXFP0LzZ2qRYLoNKsUsfURSnvvVG5BN9r9ZY4SbSaV6P0frdgRThynbSoHKTGcRvQn
 hbxypt38V4Wb3463JlMRwgRASpe13gxHTP560muplQKMczq5FFdOYHCW/3OmDpa5u4FaGbKCs
 7Srx+bhA1GWzdO9cA2Q9YD5GRPCmGiomKc9PTI189G7V44mpYYNWtUh6hYIRX2G4qUxu8qC0j
 ZoJ9YT6J6p/QTWRL9mqF2Elb64nNy6CIMCraEjiNb+dM3ABZaaR9ejtE9mn5mm+4xooxLVAaC
 ZrmFLIBZgBnLmXm6l38u8e7RrEfm1HuEml/JzpKsXMev40MEvySHRC0+Ervod3TZ5A//VDC6z
 wWHKd0x/rJTCfg3AJDazDPRBRjoGN4woIdN547O2di0ivwDtZyBsXTvP3JXPdDUz5MRyJf1wI
 68snkaZ56bZdCCeoFixe/UHjDAOmiykJpgoDF9g7/cmwK7PraPK7LquT79gwTCQnXVxX2pncr
 9rFVgr86WMYxB5UzpXN01EglZI19wfFHKP4KhqReJnJfYuv8TEwr5QGJUPQ4CPfPqWDlwthv+
 Z6T+GwXCC7ftimDfxXN4G2cDm+Jkj9pG3QADaBPe0pcw+oR1jQU0U857ESd/G/VUNOsOUMTZ6
 xs4DjHnpq2jUaUKFGs7zfnMDML51R2AeBYOcqByBuBxFo6/VGRmu+gHZewoE59OMQ4rk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5: Use READ_ONCE()/WRITE_ONCE()
    move mount pointer struct init to bm_fill_super() and add smp_wmb()
    remove useless NULL value init
    add WARN_ON_ONCE()

v4: first user namespace is initialized with &init_binfmt_ns,
    all new user namespaces are initialized with a NULL and use
    the one of the first parent that is not NULL. The pointer
    is initialized to a valid value the first time the binfmt_misc
    fs is mounted in the current user namespace.
    This allows to not change the way it was working before:
    new ns inherits values from its parent, and if parent value is modified
    (or parent creates its own binfmt entry by mounting the fs) child
    inherits it (unless it has itself mounted the fs).

v3: create a structure to store binfmt_misc data,
    add a pointer to this structure in the user_namespace structure,
    in init_user_ns structure this pointer points to an init_binfmt_ns
    structure. And all new user namespaces point to this init structure.
    A new binfmt namespace structure is allocated if the binfmt_misc
    filesystem is mounted in a user namespace that is not the initial
    one but its binfmt namespace pointer points to the initial one.
    add override_creds()/revert_creds() around open_exec() in
    bm_register_write()

v2: no new namespace, binfmt_misc data are now part of
    the mount namespace
    I put this in mount namespace instead of user namespace
    because the mount namespace is already needed and
    I don't want to force to have the user namespace for that.
    As this is a filesystem, it seems logic to have it here.

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
   --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/qemu-ppc:OC" \
   --root=/chroot/powerpc/jessie /bin/bash -l
 # uname -a
 Linux fedora28-wor-2 4.19.0-rc5+ #18 SMP Mon Oct 1 00:32:34 CEST 2018 ppc GNU/Linux
 # id
uid=0(root) gid=0(root) groups=0(root),65534(nogroup)
 # ls -l
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

    --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/bin/qemu-ppc-static:OCF"

With the 'F' flag, qemu-ppc-static will be then loaded from the main root
filesystem before switching to the chroot.

Laurent Vivier (1):
  ns: add binfmt_misc to the user namespace

 fs/binfmt_misc.c               | 106 ++++++++++++++++++++++++---------
 include/linux/user_namespace.h |  13 ++++
 kernel/user.c                  |  13 ++++
 kernel/user_namespace.c        |   3 +
 4 files changed, 107 insertions(+), 28 deletions(-)

-- 
2.17.1

