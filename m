Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C56C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBF82147D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE5IHTIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBF82147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeI0CHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:07:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53777 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeI0CHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:07:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so3529730wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BzgHSI1slKGhbYk9hADreH8YAgo5MrNatLGuvSEYzHU=;
        b=FE5IHTIrXQ0eJ7oW6arfzTpJG6mDSKykjIWPF9fo3+HRK7Jgvt+xACYWtYK713tnGC
         PuBp+lkEDU9QapQY6WEGAi7sfMlqwRTPg4ovW1PjYSyjS0kzOgNfXqIUk1rt1Yq+T2+h
         +d0bFgs1o+l/nsvvTk0qFRM8ioprbLL8Zj2pi1l0QGM5xebKRwg0883YEHqA2WkMKnk5
         BgMua5ipXDfG7PGe3bU+Itla0bYLwQ+gp1hCniGL6OhS8b59UMlp30PG9Dzh/YJAjjU3
         tZlIQtbM0Y/bQh8jMFINs7ihxPwV+17gklS5wl5ieU9Bqh498sdtPfrkvuUUw4CT/kAi
         St5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BzgHSI1slKGhbYk9hADreH8YAgo5MrNatLGuvSEYzHU=;
        b=iHj1Qpn31Z1mSx1DUth49Dm48YB0WojvU5LpL2LOpfy5NfbRUviE/tw1DyAE7pp5Pq
         HgKhQz9+IDuUf068it8w90AcY8rnpufH21H7MGkGgG+rLuRYT8XOk95I8AqmnoKRkAKU
         QkG90BgZwCJWMEmE7+rd6MGdtvwEvipUCSb9kVzCuv29hVmy5NqdVFWZt+LnYAfk3vTj
         QkIFI3ASxZO0gbZdCQQsV34oxDDy1MGUq/JcLz9n1p0KBjF1kOOhsoBAKk8v14vdDDJv
         aLqPLPR/9SJJLeu4H+U7W4G1LzcNVuQs/PKgRRprQnpjU1CIfcC1JQl7qSKv+DWKzim7
         wAkA==
X-Gm-Message-State: ABuFfoh3ZIPZrnFANsDmprQgFF+Z6P3x/gl3gVCtEpgzRO5veRPoozEe
        fVgNNpSSjNHVDjy/YI10tBiINw2oF9I=
X-Google-Smtp-Source: ACcGV60qxJ8Ky+cKs4lZsjrZBCpabHinkU2Qi3U8pxCtr5MPYubO8bgHOTNZaL9TtpvIrsMKevwTaw==
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr5239206wmd.144.1537991559877;
        Wed, 26 Sep 2018 12:52:39 -0700 (PDT)
Received: from hobbes.localnet (p200300EED3C0DF4226CD8554D45B4422.dip0.t-ipconnect.de. [2003:ee:d3c0:df42:26cd:8554:d45b:4422])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4719759wrq.7.2018.09.26.12.52.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:52:38 -0700 (PDT)
From:   Fabio Coatti <fabio.coatti@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: posix acl issue
Date:   Wed, 26 Sep 2018 21:52:37 +0200
Message-ID: <4171349.heAe9J7NaK@hobbes>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All, 
I'm seeing a weird behaviour wrt posix acl.
Basically it seems that they are not working, even though ACLs are enabled for 
all the filesystems on my machine.
attrs are working just fine for the same files.
Example:
> getfacl pippo 
# file: pippo 
# owner: cova 
# group: cova 
other::r-- 

> setfacl -m other::r-- pippo 
setfacl: pippo: Malformed access ACL `other::r--': Missing or wrong entry at 
entry 1 

============

also, udev uaccess rules are not applied and systemd-udevd spits out this 
message:
(this is when inserting a yubikey)
systemd-udevd[4921]: Failed to apply ACL on /dev/hidraw4: Invalid argument

kernel ACL setup:

=====
zcat /proc/config.gz | grep ACL 
CONFIG_EXT2_FS_POSIX_ACL=y 
CONFIG_EXT3_FS_POSIX_ACL=y 
CONFIG_EXT4_FS_POSIX_ACL=y 
CONFIG_XFS_POSIX_ACL=y 
CONFIG_BTRFS_FS_POSIX_ACL=y 
CONFIG_FS_POSIX_ACL=y 
CONFIG_TMPFS_POSIX_ACL=y 
CONFIG_JFFS2_FS_POSIX_ACL=y 
CONFIG_NFS_V3_ACL=y 
CONFIG_NFSD_V2_ACL=y 
CONFIG_NFSD_V3_ACL=y 
CONFIG_NFS_ACL_SUPPORT=m 
CONFIG_CIFS_ACL=y 

========
attrs seems to be ok:
> setfattr -n user.foo -v bar pippo 

> getfattr pippo 
# file: pippo 
user.foo 
=========

I tested this behaviour wit btrfs, tmpfs and ext4(ext2); 
dmesg reports that acl mount option is recognized : 
=======
EXT4-fs (dm-6): mounted filesystem with ordered data mode. Opts: acl
=======

but mount output seems to tell something different:

==========
/dev/mapper/vg0-test on /root/tt type ext4 (rw,relatime)
==========

and proc tells something even different:

==========
cat /proc/fs/ext4/dm-6/options 
rw 
bsddf 
nogrpid 
block_validity 
dioread_lock 
nodiscard 
delalloc 
nowarn_on_error 
journal_checksum 
barrier 
auto_da_alloc 
user_xattr 
acl 
noquota 
resuid=0 
resgid=0 
errors=continue 
commit=5 
min_batch_time=0 
max_batch_time=15000 
stripe=0 
data=ordered 
inode_readahead_blks=32 
init_itable=10 
max_dir_size_kb=0 
==========

Kernel is 4.18.10, but I tried several kernels on 4.18 and 4.17 series, no 
changes.
gcc 8.2.0

I'm running a gentoo machine, with vanilla sources so no external patches.
I checked all possible kernel config options and whatnot without finding 
anything obvious. 
Likely I'm missing something obvious, but after several days diggin I got no 
clues, so I would be glad of any hint or suggestions about where to look.
(please, keep me cc'ed in any answer).

Many thanks for any help.


