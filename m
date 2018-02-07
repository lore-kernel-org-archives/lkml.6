Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754646AbeBGQV3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:21:29 -0500
Received: from smtpbg64.qq.com ([103.7.28.238]:15352 "EHLO smtpbg64.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754463AbeBGQV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:21:28 -0500
X-QQ-mid: esmtp12t1518020055twe4bg5cd
X-QQ-SSF: A0000000000000F00H100700000000R
X-QQ-FEAT: nNqzOPJj1O6UpQJS1eS2EY8qOiaAJhG5YNSAWJU6Pxf0YNGSvGW8uhdl/9xDt
        SEdat7JMYZA17KBFa5EHTkY5+PnjAsCti+Q4agiMb4B1mPy86l9Lh+RiRvCplQjiyl17mmD
        4rvprXybo1ZcQbWD4prhy8eKtDlRpQ4nD0/W0RsRLoaDObl7j+494rcRPib7RwiyaerHjGs
        VfCA3TDa7NyDzGOx6oz/YwGEACXae7NoZ73zqcnag/Z9DsW81BEOhm0AkkUdp2sa7dd/V+E
        f6BowsLFulw0M3IcTwDUedXHU=
X-QQ-GoodBg: 0
From: Chen Guanqiao <chen.chenchacha@foxmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        pali.rohar@gmail.com, Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH v9 0/3] fs: fat: add ioctl to modify fat filesystem partion volume label
Date: Thu,  8 Feb 2018 00:14:04 +0800
Message-Id: <20180207161407.30507-1-chen.chenchacha@foxmail.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgweb:bgweb117
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FAT filesystem partition volume label can be read with
FAT_IOCTL_GET_VOLUME_LABEL and written with FAT_IOCTL_SET_VOLUME_LABEL.

FAT volume label (volume name) is exactly same stored in boot sector and root
directory. Thus, the boot sector just needs to be upgrade when the label
writing.

And, Ignore the volume label in struct msdos_sb_info.

The volume label format reference from Pali Rohár <pali.rohar@gmail.com> testing
results in the previous mail.

v9:
1. Add necessary lock to protect write method.
2. Fix some code bug.

v8...v1:
write the patch

Chen Guanqiao (3):
  fs: fat: Add fat filesystem partition volume label in local structure
  fs: fat: Add volume label entry method function
  fs: fat: add ioctl method in fat filesystem driver

 fs/fat/dir.c                  |  47 ++++++++++++++
 fs/fat/fat.h                  |   6 ++
 fs/fat/file.c                 | 145 ++++++++++++++++++++++++++++++++++++++++++
 fs/fat/inode.c                |   6 ++
 include/uapi/linux/msdos_fs.h |   2 +
 5 files changed, 206 insertions(+)

--
2.14.3
