Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C96AECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 19:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBA621473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 19:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBA621473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeJGClJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 22:41:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:52057 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeJGClJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 22:41:09 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MEVBa-1fu4G13pQw-00Fwrw; Sat, 06 Oct 2018 21:35:56 +0200
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MEVBa-1fu4G13pQw-00Fwrw; Sat, 06 Oct 2018 21:35:56 +0200
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        containers@lists.linux-foundation.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [RFC v4 0/1] ns: introduce binfmt_misc namespace
Date:   Sat,  6 Oct 2018 21:35:45 +0200
Message-Id: <20181006193546.29340-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:+Kvt9WFDI/E6BY1U2N/r4Nr+27TYi+G9xxUbaMtN0h9CDbNAZvA
 EVxq/EhdHlaVuht4a3DxxT2nLEpznGUIEyrFVZdipGID3CGCK7RdJQ4zGzbFpEhTISlwL0W
 95OAes/dN5yCDf4oq0bUQZJNcPxr9yPO/sJpNjvQ4cybjk9vkoAdQ91kXy2csP7dAUSLj2f
 GqXa5gNs5DM8KKr1qWfTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dRU2zxGcm18=:7f+rtkdcHU07O3d5pCO6L3
 e62kZ6NWJvoEA4KLzfq9+pO8UxiiYwZKH1s04Y6F1cnSRoBHc6xdIu0j6hz0YLZ9z3pBCrPQV
 wQEwXRMOJUOJC2rkfM4YwmKujTKqfLKO0lzu+pVC6dZZebPWD9ZCgiolNDt3uQ92tV1yx6B7/
 uB2Bnhj8hT8uKWLK/6ffGZ6ChflLsxwFj01D09CMPklMADVqS7NPl4cEqpxNss2dnuuCxDhFu
 cmTP3KbDpsUIZE7xHKOjSJ0w42MjUBa691VF+jtVzaZXA0oYCh/iwft/1YGBe0ULTkVNPwwcB
 kcd5pqPNNlifAG4NqdZUbcC0pfRnVhasMMMZNpJ/ULZIbCOTAvfR2LU6KKQRdvP3fQ2VP7FI2
 w4x0/ahko5317xlfrkJbLDZ0Go55V/0YPucKA2TTGrLgesJMejT1FwnlB1w2w8x/vOo0BAwx+
 37ohtS+swwmm1gdQ3MIlOo8ee58EhGbL/5D0FCtA72nfGuiPP+vFNRl04zBjusAwA+kE8WVaj
 KGibr6GF6d2el1a4wz5UwmvY6jSWd4eD9+k6rEQLEtR0R1T5oGXf7HTaXEnxoFE6GyuJIthhM
 yNVLwIobDM+U7ya+wAKpmW9fwQE7VGzGO4BhpgsTo58AcDRfUIRy3eLwmXyH847V0F/8pewc9
 Qwt5S2s9W1PmwuIFIRIU6ZCj4K+gBmGjc4aKmHFf9hK6zvAzNemGobl6UhzLbUK2BBHY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4: first user namespace is initialized with &init_binfmt_ns,
    all new user namespaces are initialized with a NULL and use
    the one of the first parent that is not NULL. The pointer
    is initialized to a valid value the first time the binfmt_misc
    fs is mounted in the current user namespace.
    This allows to not change the way it was working before:
    new ns inherits values from its parent, and if parent values are
    modified (or parent creates its own binfmt entry by mounting the fs)
    child inherits it (unless it has itself mounted the fs).

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

 fs/binfmt_misc.c               | 99 ++++++++++++++++++++++++----------
 include/linux/user_namespace.h | 13 +++++
 kernel/user.c                  | 13 +++++
 kernel/user_namespace.c        |  7 +++
 4 files changed, 104 insertions(+), 28 deletions(-)

-- 
2.17.1

