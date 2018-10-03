Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E89C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D743A2147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D743A2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeJDFl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:41:29 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:38611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeJDFl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:41:29 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8hMn-1g3B8d02Kn-004ijJ; Thu, 04 Oct 2018 00:50:34 +0200
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8hMn-1g3B8d02Kn-004ijJ; Thu, 04 Oct 2018 00:50:34 +0200
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Andrei Vagin <avagin@openvz.org>,
        containers@lists.linux-foundation.org,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, Laurent Vivier <laurent@vivier.eu>
Subject: [RFC v3 0/1] ns: introduce binfmt_misc namespace
Date:   Thu,  4 Oct 2018 00:50:21 +0200
Message-Id: <20181003225022.32033-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:Itdnkg1CbJ89sYCoqiKuXvDDz+lmArH/O9tmqMBNe87MnWNBQ60
 4YGX16RHE+iANIlPPOIwwSLxGnm38Z/v8vH5Eh/rhT5ZV4PQiR5cpbeYYTt3tQ1SY06u9Rp
 M3ds6YP0Xz73STW7e/8owzAdcvT91QbCo5onkMWesARcXmrf4YSSVXOlg1M2tpEb6ot6YCP
 2lXr07xhpm915FTaVTwOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3z+Cxg6sXT8=:76nfUU6ZoUEhzwHqzm4z6F
 hV3mchLKYKEM7gCZlsXUJNsD+u+Wo14P8J1vGYjhihFOMtRSb32suUnUi1uyGkgeFklDHokX4
 bATxfoXV87S5gUaXstCCt1HhaO8Gu+ogvqmWAC93pLoeW8rh0nj8QUsrQNxad5yLtjdpT193c
 NYSiOk/cMzvdZNM4K7RDRLOlTo1MdjgV9M5x9wanqGff5GHgb93mNkPbxp3+koxIrITD7Bhn/
 F0Ab/3geb1Rj/8qWmXX/4XyHmpCSvQzANAzdRx/sIgHJ7VSTlEm2QOfw35RkjHyLd9NnC/rcj
 UoIJZAm2hFHAwDKRtwQfmwPiZ+m7GEcnq18BqarDP1e4sF0Smvl7XwwWQYs1SFLwfGSAYIUOd
 jPkn3XoHVcNLbtM1VDOtSji44DeRHP11hyjOvR0RKLODrjnP1fqmgWvYC/JW3mh65A28gnRbi
 0XgfbMRNGD5uhBVhiXDNZBrm9M5T3alZmHUUVeTfz4B5rSJ92bLnrkJsx4eXao27eX73TlYJM
 dTwjQ2UjnPrP41hrxkF+N2bj0j6EzCbdbq9t7eGuEQqiFZRlkAJA9nfPdbyQ/JX82JkIw9fpa
 tMJ+rdjV8WNm0S7S+kOmlJ4Z3onoNhbBzYSy0NWR9u6Okb9OE0FvY5UXIHEG1e86TvlDX0BmA
 GtJ/Mesv3Ll7cfZVLl8XSvT9fC2+Y5uxjAHIP3/WB7cN/AsxAxy75J9sG9RtiXq+vwic=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 fs/binfmt_misc.c               | 85 +++++++++++++++++++++++-----------
 include/linux/user_namespace.h | 15 ++++++
 kernel/user.c                  | 14 ++++++
 kernel/user_namespace.c        |  9 ++++
 4 files changed, 95 insertions(+), 28 deletions(-)

-- 
2.17.1

