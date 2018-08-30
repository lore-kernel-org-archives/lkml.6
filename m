Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7E9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3023420837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IfkjmFho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3023420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeH3PnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:43:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33327 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbeH3PnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:43:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id i134-v6so1623968wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmU2UyMtUBNWrj8mk4LYzQ193g4/d71hDCIWAiq7WI0=;
        b=IfkjmFhoYEchL2Isulzy2HGRhwUAvap8gk4OyFAK0S+ltBBXHbvrenzzgK+qvOksep
         rT9yKFfHZfQEV/a2ynV/OdX/nQGjRmi7he70z1eH6qrLQ3lwq4LuweIieHCRhK4Enyhv
         Y/gq3YABwR6a0aXat6gq+Lyr8Eio3epXuS7ZQuLPUltrbA2hH36lxQ5P/tM2cGhNAW/m
         EKAhVkg4m1MQR7TLAVQizX9UGMu7fl5t03okJs3F5vVf+fiG5emA5xD+U4Z9YlGmcW0B
         +eTkHSvtA0rc7e598IGlPLS/QkOhICrwKPD9gy6G9xIi+jtUcHw7zIgHTM2WTQBPhKfc
         xocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmU2UyMtUBNWrj8mk4LYzQ193g4/d71hDCIWAiq7WI0=;
        b=nmw9vMMG4yv+qwdyPNwrXr6JIBgznCzKgElIf2yQvIIRLfgVJur6bqi8iXDofbeY3L
         dcWQfIfDUHn01UTxXDwxUQS2R94OWLE+ZVnH2KjA2phTFtD7BIIxs72INLI7mUR97vqj
         yPinPTygc30ACA2p6a11f9rGXymG3GD/zBB/QqxDLmt9ejCjaA07PI/rbyHDf79TdmRp
         sGD+t7N5ojwnnLsLWNOx7gxvu2xRzKlqoYspJPsr9V3UIRTBVsTq0rTahK1zzHlT4gZ0
         NFT/xr8pIOggG03U6Iwya9ZvrlhoWAf/INPph1t4rhmrNwWOSfTr53bzCL6f63jJ6h6N
         A52w==
X-Gm-Message-State: APzg51AcQPFeS18kjLhl4Yl/oSUYgZ6TjXqIp4YDEFqVuP0ymskz1/xY
        +4SmoT8wxTtH3D1sMFNEwOOGVQ==
X-Google-Smtp-Source: ANB0VdZKEPoV77ehl9ywVOCWQ7xqiHdmHuPpuz7eJeQGWHYp02kmszcINUT2okmEOJZE3BRog9Lg5Q==
X-Received: by 2002:a1c:b6d6:: with SMTP id g205-v6mr1662119wmf.17.1535629280841;
        Thu, 30 Aug 2018 04:41:20 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z184-v6sm2175218wmz.0.2018.08.30.04.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 04:41:19 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v6 00/11] arm64: untag user pointers passed to the kernel
Date:   Thu, 30 Aug 2018 13:41:05 +0200
Message-Id: <cover.1535629099.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 has a feature called Top Byte Ignore, which allows to embed pointer
tags into the top byte of each pointer. Userspace programs (such as
HWASan, a memory debugging tool [1]) might use this feature and pass
tagged user pointers to the kernel through syscalls or other interfaces.

This patch makes a few of the kernel interfaces accept tagged user
pointers. The kernel is already able to handle user faults with tagged
pointers and has the untagged_addr macro, which this patchset reuses.

Thanks!

[1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

Changes in v6:
- Added annotations for user pointer casts found by sparse.
- Rebased onto 050cdc6c (4.19-rc1+).

Changes in v5:
- Added 3 new patches that add untagging to places found with static
  analysis.
- Rebased onto 44c929e1 (4.18-rc8).

Changes in v4:
- Added a selftest for checking that passing tagged pointers to the
  kernel succeeds.
- Rebased onto 81e97f013 (4.18-rc1+).

Changes in v3:
- Rebased onto e5c51f30 (4.17-rc6+).
- Added linux-arch@ to the list of recipients.

Changes in v2:
- Rebased onto 2d618bdf (4.17-rc3+).
- Removed excessive untagging in gup.c.
- Removed untagging pointers returned from __uaccess_mask_ptr.

Changes in v1:
- Rebased onto 4.17-rc1.

Changes in RFC v2:
- Added "#ifndef untagged_addr..." fallback in linux/uaccess.h instead of
  defining it for each arch individually.
- Updated Documentation/arm64/tagged-pointers.txt.
- Dropped "mm, arm64: untag user addresses in memory syscalls".
- Rebased onto 3eb2ce82 (4.16-rc7).

Andrey Konovalov (11):
  arm64: add type casts to untagged_addr macro
  uaccess: add untagged_addr definition for other arches
  arm64: untag user addresses in access_ok and __uaccess_mask_ptr
  mm, arm64: untag user addresses in mm/gup.c
  lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
  arm64: untag user address in __do_user_fault
  fs, arm64: untag user address in copy_mount_options
  usb, arm64: untag user addresses in devio
  arm64: update Documentation/arm64/tagged-pointers.txt
  selftests, arm64: add a selftest for passing tagged pointers to kernel
  arm64: annotate user pointers casts detected by sparse

 Documentation/arm64/tagged-pointers.txt       |  5 +--
 arch/arm64/include/asm/compat.h               |  2 +-
 arch/arm64/include/asm/uaccess.h              | 16 ++++++----
 arch/arm64/kernel/perf_callchain.c            |  4 +--
 arch/arm64/kernel/signal.c                    | 16 +++++-----
 arch/arm64/kernel/signal32.c                  |  6 ++--
 arch/arm64/mm/fault.c                         |  4 +--
 block/compat_ioctl.c                          | 15 +++++----
 drivers/ata/libata-scsi.c                     |  2 +-
 drivers/block/loop.c                          |  2 +-
 drivers/gpio/gpiolib.c                        |  8 +++--
 drivers/input/evdev.c                         |  2 +-
 drivers/media/dvb-core/dvb_frontend.c         |  3 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |  9 +++---
 drivers/mmc/core/block.c                      |  6 ++--
 drivers/mtd/mtdchar.c                         |  2 +-
 drivers/net/tap.c                             |  2 +-
 drivers/net/tun.c                             |  2 +-
 drivers/spi/spidev.c                          |  6 ++--
 drivers/tty/tty_ioctl.c                       |  3 +-
 drivers/tty/vt/vt_ioctl.c                     |  5 +--
 drivers/usb/core/devio.c                      | 10 ++++--
 drivers/vfio/vfio.c                           |  6 ++--
 drivers/video/fbdev/core/fbmem.c              |  4 +--
 drivers/xen/gntdev.c                          |  6 ++--
 drivers/xen/privcmd.c                         |  4 +--
 fs/aio.c                                      |  2 +-
 fs/autofs/dev-ioctl.c                         |  3 +-
 fs/autofs/root.c                              |  2 +-
 fs/binfmt_elf.c                               | 10 +++---
 fs/btrfs/ioctl.c                              |  2 +-
 fs/compat_ioctl.c                             | 32 ++++++++++---------
 fs/ext2/ioctl.c                               |  2 +-
 fs/ext4/ioctl.c                               |  2 +-
 fs/fat/file.c                                 |  3 +-
 fs/fuse/file.c                                |  2 +-
 fs/namespace.c                                |  2 +-
 fs/readdir.c                                  |  4 +--
 fs/signalfd.c                                 | 10 +++---
 include/linux/mm.h                            |  2 +-
 include/linux/pagemap.h                       |  8 ++---
 include/linux/socket.h                        |  2 +-
 include/linux/uaccess.h                       |  4 +++
 ipc/shm.c                                     |  4 +--
 kernel/futex.c                                |  6 ++--
 kernel/futex_compat.c                         |  2 +-
 kernel/power/user.c                           |  2 +-
 kernel/signal.c                               |  2 +-
 lib/iov_iter.c                                | 16 +++++-----
 lib/strncpy_from_user.c                       |  4 ++-
 lib/strnlen_user.c                            |  6 ++--
 lib/test_kasan.c                              |  2 +-
 mm/gup.c                                      |  4 +++
 mm/memory.c                                   |  2 +-
 mm/migrate.c                                  |  4 +--
 mm/process_vm_access.c                        | 13 ++++----
 net/bluetooth/hidp/sock.c                     |  2 +-
 net/compat.c                                  | 12 ++++---
 sound/core/control_compat.c                   |  5 +--
 sound/core/pcm_native.c                       |  5 +--
 sound/core/timer_compat.c                     |  3 +-
 tools/testing/selftests/arm64/.gitignore      |  1 +
 tools/testing/selftests/arm64/Makefile        | 11 +++++++
 .../testing/selftests/arm64/run_tags_test.sh  | 12 +++++++
 tools/testing/selftests/arm64/tags_test.c     | 19 +++++++++++
 65 files changed, 232 insertions(+), 147 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/.gitignore
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
 create mode 100644 tools/testing/selftests/arm64/tags_test.c

-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

