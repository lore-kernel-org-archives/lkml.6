Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFE0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629192147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NxSwpJ0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629192147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392263AbeHPTRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:17:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33985 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbeHPTRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:17:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180816161826euoutp02cb07e3bb4f2f178a7d002dde0f4726b7~LabDgFt8J0430504305euoutp02Q;
        Thu, 16 Aug 2018 16:18:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180816161826euoutp02cb07e3bb4f2f178a7d002dde0f4726b7~LabDgFt8J0430504305euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1534436306;
        bh=W9QJbDIDoz4luUJQ6cERZI/1lcR7oHTxfvkVrFV6ouQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=NxSwpJ0v4RirtJG91QunOE8hKjJoZdv0LrMFWlSqumtQuETuSNYy2onFvGDclhVdl
         dWSDadlRowLw0b9IJXfkv2vjV2RFMsoPASIvWh++4fTnPz0Q5QN7V0SS83MGVsBnx/
         DfFi0Ps4tgZDBPnKyUisIU4WEJh9Zm7silY8nlyw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180816161825eucas1p1dcd139201001b7e985cbfd565c4e1440~LabDAUbkm3258532585eucas1p1Q;
        Thu, 16 Aug 2018 16:18:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DF.E7.04441.1D3A57B5; Thu, 16
        Aug 2018 17:18:25 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180816161825eucas1p11be9cea5d622b905154590bae90a47a4~LabCVaRU71523315233eucas1p1c;
        Thu, 16 Aug 2018 16:18:25 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-22-5b75a3d114ca
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 10.75.04128.0D3A57B5; Thu, 16
        Aug 2018 17:18:24 +0100 (BST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from mcdsrvbld02.digital.local ([106.116.37.23]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PDK00I11AMJUK70@eusync4.samsung.com>;
        Thu, 16 Aug 2018 17:18:24 +0100 (BST)
From:   Andrzej Pietrasiewicz <andrzej.p@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Michael Forney <forney@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Forsman?= <bjorn.forsman@gmail.com>
Subject: [PATCH] Revert
 "kbuild: create deterministic initramfs directory listings"
Date:   Thu, 16 Aug 2018 18:18:17 +0200
Message-id: <20180816161817.12267-1-andrzej.p@samsung.com>
X-Mailer: git-send-email 2.11.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsWy7djPc7oXF5dGG3Q0KFvMetnOYtExczG7
        xcezV9gtLu+aw2ax995nRgdWj52z7rJ7LNhU6tG3ZRWjx4np31k8Pm+SC2CN4rJJSc3JLEst
        0rdL4MpYcO87Y0G3ZsWOj1cZGxgnKHYxcnJICJhILJj9jq2LkYtDSGAFo8THvReZQBJCAp8Z
        JS7e8IYp2rnlDSNE0TJGiSdzljKCJHgFBCV+TL7H0sXIwcEsIC9x5FI2SJhZQFNi6+717BD1
        TUwSPWfeg9WzCRhL7D3YAWaLCChIbO59xgpSxCxwjFHi6vsLzCAJYYFQiaZXbewgNouAqsSu
        Q6fYIJZZSVw6eYQd4iJ5iV1tF8GaJQSmsElca74KlXCRaD/VDGULS7w6vgXKlpG4PLmbBcKu
        l9j0ZQ8bhD2FUeLeXKg3rSUOHwcZCvICn8SkbdOZQT6TEOCV6GgTgijxkJj1+z8LJIRiJR7M
        Wsg0gVF6FlJYzEKExSyksFjAyLyKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMLpP/zv+
        aQfj10tJhxgFOBiVeHg79EuihVgTy4orcw8xSnAwK4nwupeURgvxpiRWVqUW5ccXleakFh9i
        lOZgURLn5dNKixYSSE8sSc1OTS1ILYLJMnFwSjUwzsjZfcy86kvhs88KLdJss9iBSeC0oryn
        4q7kneyPjqduDfqy0f3vz/O/nKMD16Zxai24YbFvnmBVhfLKC65z9JazzpnO8slLPDpd01k+
        fYfoNB6/HzmaWlGHNO/zrCp9M7uT4ZUry5x3iokrKtVjEnrDG1TLZ2St2WBwx/T7wyn5SwrX
        mN1SYinOSDTUYi4qTgQAAqsWh+oCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVy+t/xa7oXFpdGG3RsN7eY9bKdxaJj5mJ2
        i49nr7BbXN41h81i773PjA6sHjtn3WX3WLCp1KNvyypGjxPTv7N4fN4kF8AaxWWTkpqTWZZa
        pG+XwJWx4N53xoJuzYodH68yNjBOUOxi5OSQEDCR2LnlDWMXIxeHkMASRonzv14xgiR4BQQl
        fky+x9LFyMHBLCAvceRSNkiYWUBdYtK8RcwQ9S1MEsc/r2AGSbAJGEvsPdgB1isioCCxufcZ
        K0gRs8AJRomTL96wgSSEBUIlml61sYPYLAKqErsOnWKDWGYlcenkEXaIi+QldrVdZJ3AyDsL
        yR2zEO6YheSOBYzMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQKDcNuxn1t2MHa9Cz7EKMDB
        qMTD+8CwJFqINbGsuDL3EKMEB7OSCK97SWm0EG9KYmVValF+fFFpTmrxIUZpDhYlcd7zBpVR
        QgLpiSWp2ampBalFMFkmDk6pBsbO/QoB18yWL94+y8Jln+/+GY8NzgbbZxZ1hdYwRQZkzZtl
        f8G6km15GrPxl6yFc7+wZmcd+lClfdU7+WnMfxWNgkk7tTOLCyfX1MyyXSj891Rqw4dk3fcp
        bzZEOp0wD830EU/9XbPT4PQBpV8JLs7/f96/qVtooc1t5CN/KfNibs3+4owXrkosxRmJhlrM
        RcWJAOftjwk+AgAA
X-CMS-MailID: 20180816161825eucas1p11be9cea5d622b905154590bae90a47a4
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180816161825eucas1p11be9cea5d622b905154590bae90a47a4
References: <CGME20180816161825eucas1p11be9cea5d622b905154590bae90a47a4@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9e6e0d5f2a2713402cf9dce69b9f9b516e4185d2.

The reverted commit introduces broken builds. Even though the cpio archive
does contain all the specified files, it seems that the kernel, while
populating rootfs, scans the cpio buffer linearly and fails to create
files whose parent directories are nonexistent at the moment of this failed
creation. As a result, such files are not accessible when kernel boots into
initramfs.

Here is how to reproduce, from inside kernel source directory, with the
patch in question not reverted:

$ mkdir -p ../test/find/me/if/you/can
$ touch ../test/find/me/if/you/can/file.txt
$ cat ../initramfs.list
file /busybox-x86_64 ../initramfs/busybox-x86_64 0755 0 0
dir /sbin 0755 0 0
dir /proc 0755 0 0
dir /sys 0755 0 0
dir /bin 0755 0 0
dir /usr 0755 0 0
dir /usr/sbin 0755 0 0
dir /usr/bin 0755 0 0
dir /etc 0755 0 0
dir /etc/init.d 0755 0 0
file /etc/inittab ../initramfs/inittab 0755 0 0
file /etc/init.d/rcS ../initramfs/rcS-x86_64 0755 0 0
dir /lib 0755 0 0
dir /lib/modules 0755 0 0
$ ls ../initramfs
busybox-x86_64  inittab  rcS-x86_64
$ cat ../initramfs/inittab
::sysinit:/etc/init.d/rcS
::askfirst:-/bin/sh
::ctrlaltdel:/sbin/reboot
::shutdown:/sbin/swapoff -a
::shutdown:/sbin/umount -a -r
::restart:/sbin/init
$ cat ../initramfs/rcS-x86_64
#!/busybox-x86_64 sh

/busybox-x86_64 --install

mount -t proc none /proc
mount -t sysfs none /sys

mdev -s
echo /sbin/mdev > /proc/sys/kernel/hotplug
$ scripts/gen_initramfs_list.sh ../test/ ../initramfs.list

#####################
# ../test/
# Last modified: 1534428527.0818855150

file /find/me/if/you/can/file.txt ../test/find/me/if/you/can/file.txt 664 1000 1000
dir /find/me/if/you/can 775 1000 1000
dir /find/me/if/you 775 1000 1000
dir /find/me/if 775 1000 1000
dir /find/me 775 1000 1000
dir /find 775 1000 1000

#####################
# ../initramfs.list
# Last modified: 1534433777.8384497600

file /busybox-x86_64 ../initramfs/busybox-x86_64 0755 0 0
dir /sbin 0755 0 0
dir /proc 0755 0 0
dir /sys 0755 0 0
dir /bin 0755 0 0
dir /usr 0755 0 0
dir /usr/sbin 0755 0 0
dir /usr/bin 0755 0 0
dir /etc 0755 0 0
dir /etc/init.d 0755 0 0
file /etc/inittab ../initramfs/inittab 0755 0 0
file /etc/init.d/rcS ../initramfs/rcS-x86_64 0755 0 0
dir /lib 0755 0 0
dir /lib/modules 0755 0 0

$ cat ../initramfs.cpio | cpio -t
find/me/if/you/can/file.txt
find/me/if/you/can
find/me/if/you
find/me/if
find/me
find
busybox-x86_64
sbin
proc
sys
bin
usr
usr/sbin
usr/bin
etc
etc/init.d
etc/inittab
etc/init.d/rcS
lib
lib/modules
1961 bloków

BUT:

$ qemu-system-x86_64 -nographic -serial mon:stdio \
	-kernel arch/x86/boot/bzImage \
	-append "root=/dev/ram console=ttyS0 rdinit=/busybox-x86_64 init" \
	-M q35 -initrd ../initramfs.cpio

# ls
bin             etc             linuxrc         sbin
busybox-x86_64  find            proc            sys
dev             lib             root            usr
/ # ls -l find
total 0

With the patch reverted the file /find/me/if/you/can/file.txt
is accessible:

$ scripts/gen_initramfs_list.sh ../test/ ../initramfs.list

#####################
# ../test/
# Last modified: 1534428527.0818855150

dir /find 775 1000 1000
dir /find/me 775 1000 1000
dir /find/me/if 775 1000 1000
dir /find/me/if/you 775 1000 1000
dir /find/me/if/you/can 775 1000 1000
file /find/me/if/you/can/file.txt ../test/find/me/if/you/can/file.txt 664 1000 1000

#####################
# ../initramfs.list
# Last modified: 1534433777.8384497600

file /busybox-x86_64 ../initramfs/busybox-x86_64 0755 0 0
dir /sbin 0755 0 0
dir /proc 0755 0 0
dir /sys 0755 0 0
dir /bin 0755 0 0
dir /usr 0755 0 0
dir /usr/sbin 0755 0 0
dir /usr/bin 0755 0 0
dir /etc 0755 0 0
dir /etc/init.d 0755 0 0
file /etc/inittab ../initramfs/inittab 0755 0 0
file /etc/init.d/rcS ../initramfs/rcS-x86_64 0755 0 0
dir /lib 0755 0 0
dir /lib/modules 0755 0 0

$ cat ../initramfs.cpio | cpio -t
find
find/me
find/me/if
find/me/if/you
find/me/if/you/can
find/me/if/you/can/file.txt
busybox-x86_64
sbin
proc
sys
bin
usr
usr/sbin
usr/bin
etc
etc/init.d
etc/inittab
etc/init.d/rcS
lib
lib/modules
1961 bloków

$ qemu-system-x86_64 -nographic -serial mon:stdio \
	-kernel arch/x86/boot/bzImage \
	-append "root=/dev/ram console=ttyS0 rdinit=/busybox-x86_64 init" \
	-M q35 -initrd ../initramfs.cpio

# find find/
find/
find/me
find/me/if
find/me/if/you
find/me/if/you/can
find/me/if/you/can/file.txt
/ #

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
---
 scripts/gen_initramfs_list.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gen_initramfs_list.sh b/scripts/gen_initramfs_list.sh
index 10e528b..e5d7b03 100755
--- a/scripts/gen_initramfs_list.sh
+++ b/scripts/gen_initramfs_list.sh
@@ -174,7 +174,7 @@ dir_filelist() {
 	${dep_list}header "$1"
 
 	srcdir=$(echo "$1" | sed -e 's://*:/:g')
-	dirlist=$(find "${srcdir}" -printf "%p %m %U %G\n" | sort)
+	dirlist=$(find "${srcdir}" -printf "%p %m %U %G\n")
 
 	# If $dirlist is only one line, then the directory is empty
 	if [  "$(echo "${dirlist}" | wc -l)" -gt 1 ]; then
-- 
2.7.4

