Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2DEC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4098720878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4098720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeJBREG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:04:06 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51621 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeJBREF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:04:05 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1q8m-1g9Uij13X6-002KQI; Tue, 02 Oct 2018 12:21:01 +0200
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1q8m-1g9Uij13X6-002KQI; Tue, 02 Oct 2018 12:21:01 +0200
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@openvz.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Laurent Vivier <laurent@vivier.eu>
Subject: [RFC v2 v2 0/1] ns: introduce binfmt_misc namespace
Date:   Tue,  2 Oct 2018 12:20:53 +0200
Message-Id: <20181002102054.13245-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:jMg8MAk4HUS6vowL+GJRyitwnPutqRANjO1x3UzgEWhtiNjLct8
 76imB0V5h+HnKFG3nMDCO3Ud0D061hRsOoY3TLKEF+dHQhaa6ykAgPWrhy+bv1raiKqCY23
 7sCSGF2y3KnOpLlR0PYsB7WWPqy/gN8/jNhTTcyfzn8wlmcRgUiUn7TAhbhEw7Rk9QNXRgA
 tz2YWaWo81vumWz+/Qxqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1EplV7zUx9Y=:LXcJxvoKvIkzZSd9cN5jBB
 KxsFqRkp+HGJqajPQJkyuJFBXlPuuAvwuSW4NqS8WrSUisYC2EAg9oRdQZFg3k3RKwG5pURzZ
 K6Y9dmfbDrvXpUHg93jqn86QJJm8HpLM96WHoYzd78p/yf2tKVZsSPT4GuQcTRkrhzBY6ZS7B
 ID4n0XW5hR+lMByDgJwzP/BrElJ6sNLrUwGzchF6Wh7kCGeqcPdRDukbZjwwPzogLBmGB/2dx
 jdYbwRtZFKOUorVOOMapIVL5qV5HPDSlbCE5uuzTpKXJYXxun/lPWL3wN+NB1Qletfmw6eGGF
 ejPn3E4QzHyccXLRZsO3BxCEqJpOGSp4CkgL5Ma0u4B0kuPB79vSZ4IuG+FqN/+ESInmnTZzj
 v5/9zjPvJ/XOqXjySvjOzMfHj9Nc/U3F2gSLYuVEr93RdqvoNZbEuWqLBGl6N9ta7hK7ZsEOy
 rit6pNgiAepEQMbsJzoljXhHsLZL9zakWArWP3ru5w3I/ER6BN2Y8QOQeMBqpEuWKBQyctNgJ
 QMEmoU3EalseZvcT+7qta2YSK700bpqyXOQm+eudO+ku0vbrxBlJfZRvNfu3PmnQh+DtDqsPA
 bumyRYq1JpbAxERmoNA9GHtm0N38GxwaaZGGGYQplMDVwEWuYNtWZjPw7KBwccp975Z28x5Y3
 p5paWhbBygoCpWaeodPkLGLC06h59pawGl8qKgb0xN26Ft00EJ8kxXPVsntfJygG6NZU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  ns: add binfmt_misc to the mount namespace

 fs/binfmt_misc.c | 50 +++++++++++++++++++++++++-----------------------
 fs/mount.h       |  8 ++++++++
 fs/namespace.c   |  6 ++++++
 3 files changed, 40 insertions(+), 24 deletions(-)

-- 
2.17.1

