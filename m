Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1229C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9412147D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qod0kAKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9412147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeKZVq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:46:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbeKZVq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:46:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B112A21104;
        Mon, 26 Nov 2018 10:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229564;
        bh=1SUbayii6JctmIVHJVlKP/mhO1QF7A6/RxKWoAW5+Qs=;
        h=From:To:Cc:Subject:Date:From;
        b=qod0kAKQ3Ql+fTv+VkTTFqVipVNQZbCtooDJwL1dHDM1aTkgEXtlNEz+UZ80hwq25
         0cXvp96q3y+8+PaQ1NpsTzE/ZRi/5BVGgn5e76TUFDCKO3jHvN4S9ex12FWN3dj2Sx
         kHABBT6UbAOeT4C4U0QvE+HJ1JxoGYqf4o4V2IC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/24] 3.18.127-stable review
Date:   Mon, 26 Nov 2018 11:50:54 +0100
Message-Id: <20181126105029.790599475@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.127-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.127-rc1
X-KernelTest-Deadline: 2018-11-28T10:50+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.127 release.
There are 24 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Nov 28 10:50:13 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.127-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.127-rc1

Eric Biggers <ebiggers@google.com>
    HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges

Al Viro <viro@zeniv.linux.org.uk>
    new helper: uaccess_kernel()

Hans de Goede <hdegoede@redhat.com>
    ACPI / platform: Add SMB0001 HID to forbidden_id_list

Mattias Jacobsson <2pi@mok.nu>
    USB: misc: appledisplay: add 20" Apple Cinema Display

Nathan Chancellor <natechancellor@gmail.com>
    misc: atmel-ssc: Fix section annotation on atmel_ssc_get_driver_data

Emmanuel Pescosta <emmanuelpescosta099@gmail.com>
    usb: quirks: Add delay-init quirk for Corsair K70 LUX RGB

Kai-Heng Feng <kai.heng.feng@canonical.com>
    USB: quirks: Add no-lpm quirk for Raydium touchscreens

Maarten Jacobs <maarten256@outlook.com>
    usb: cdc-acm: add entry for Hiro (Conexant) modem

Dan Carpenter <dan.carpenter@oracle.com>
    uio: Fix an Oops on load

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: v4l: event: Add subscription to list before calling "add" operation

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV"

YueHaibing <yuehaibing@huawei.com>
    SUNRPC: drop pointless static qualifier in xdr_get_next_encode_buffer()

Sasha Levin <sashal@kernel.org>
    Revert "Revert "drm/i915: Fix mutex->owner inspection race under DEBUG_MUTEXES""

Minchan Kim <minchan@kernel.org>
    zram: close udev startup race condition as default groups

Vignesh R <vigneshr@ti.com>
    i2c: omap: Enable for ARCH_K3

Jeremy Linton <jeremy.linton@arm.com>
    lib/raid6: Fix arm64 test build

Vasily Gorbik <gor@linux.ibm.com>
    s390/vdso: add missing FORCE to build targets

Marek Szyprowski <m.szyprowski@samsung.com>
    clk: samsung: exynos5420: Enable PERIS clocks for suspend

Chengguang Xu <cgxu519@gmx.com>
    fs/exofs: fix potential memory leak in mount option parsing

Richard Weinberger <richard@nod.at>
    um: Give start_idle_thread() a return code

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    hfsplus: prevent btree data loss on root split

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    hfs: prevent btree data loss on root split

Jann Horn <jannh@google.com>
    reiserfs: propagate errors from fill_with_dentries() properly

Eric Dumazet <edumazet@google.com>
    net-gro: reset skb->pkt_type in napi_reuse_skb()


-------------

Diffstat:

 Makefile                             |  4 ++--
 arch/s390/kernel/vdso32/Makefile     |  6 ++---
 arch/s390/kernel/vdso64/Makefile     |  6 ++---
 arch/um/os-Linux/skas/process.c      |  5 +++++
 drivers/acpi/acpi_platform.c         |  1 +
 drivers/block/zram/zram_drv.c        | 18 +++++----------
 drivers/bluetooth/Kconfig            |  1 -
 drivers/clk/samsung/clk-exynos5420.c |  1 +
 drivers/gpu/drm/i915/i915_gem.c      |  2 +-
 drivers/hid/uhid.c                   | 13 +++++++++++
 drivers/i2c/busses/Kconfig           |  2 +-
 drivers/media/v4l2-core/v4l2-event.c | 43 ++++++++++++++++++++----------------
 drivers/misc/atmel-ssc.c             |  2 +-
 drivers/uio/uio.c                    |  7 ++++--
 drivers/usb/class/cdc-acm.c          |  3 +++
 drivers/usb/core/quirks.c            |  8 +++++++
 drivers/usb/misc/appledisplay.c      |  1 +
 fs/exofs/super.c                     |  5 ++++-
 fs/hfs/brec.c                        |  4 ++++
 fs/hfsplus/brec.c                    |  4 ++++
 fs/reiserfs/xattr.c                  |  7 ++++++
 include/linux/uaccess.h              |  3 +++
 lib/raid6/test/Makefile              |  4 ++--
 net/core/dev.c                       |  4 ++++
 net/sunrpc/xdr.c                     |  2 +-
 25 files changed, 107 insertions(+), 49 deletions(-)


