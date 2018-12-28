Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7798AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A9A2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999497;
	bh=gaB98eZXb2xaef167tDfuTzI7fplUNZNzQk2GkemVOs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nq+WAypLuG4HNUITFuP4FFN65Z6mUWib16bAEpGqWtkStSe4KiUhI8J+UQ7pIEvQV
	 ibwNg2QtdBfk+uUvmdmD10xUgLNWeTzm8MFG89LWoNfU10lidLKEImKuoo7kDw++Le
	 UnrJDpwtYGTQmuHQIe1dcDWgq/kqinS9olAb8jP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733139AbeL1MSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:18:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733112AbeL1MSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:18:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E553820675;
        Fri, 28 Dec 2018 12:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999490;
        bh=gaB98eZXb2xaef167tDfuTzI7fplUNZNzQk2GkemVOs=;
        h=From:To:Cc:Subject:Date:From;
        b=N2CaXkZobZtG/AUm3/jDoM3rGmYxKZRymHuwIYVxaaOQPyHUyKYuUSoxrovSj5Pqs
         4lbF638nZ/aQaXrUC6WVvIT3aPPD/23g9Tzj+6IO+DSHGFKOM4XRsdMion3tNVpFpw
         5iNN3qkSOs49+P80Xl5t6IhkuWGvvuu0jmc0wAQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/22] 4.9.148-stable review
Date:   Fri, 28 Dec 2018 12:52:37 +0100
Message-Id: <20181228113126.144310132@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.148-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.148-rc1
X-KernelTest-Deadline: 2018-12-30T11:31+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.148 release.
There are 22 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Dec 30 11:31:00 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.148-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.148-rc1

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/ioctl: Fix Spectre v1 vulnerabilities

Ivan Delalande <colona@arista.com>
    proc/sysctl: don't return ENOMEM on lookup when a table is unregistering

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
    panic: avoid deadlocks in re-entrant console drivers

Richard Weinberger <richard@nod.at>
    ubifs: Handle re-linking of inodes correctly while recovery

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    x86/fpu: Disable bottom halves while loading FPU registers

Colin Ian King <colin.king@canonical.com>
    x86/mtrr: Don't copy uninitialized gentry fields back to userspace

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened channels

Christophe Leroy <christophe.leroy@c-s.fr>
    gpio: max7301: fix driver for use with CONFIG_VMAP_STACK

Russell King <rmk+kernel@armlinux.org.uk>
    mmc: omap_hsmmc: fix DMA API warning

Ulf Hansson <ulf.hansson@linaro.org>
    mmc: core: Use a minimum 1600ms timeout when enabling CACHE ctrl

Ulf Hansson <ulf.hansson@linaro.org>
    mmc: core: Allow BKOPS and CACHE ctrl even if no HPI support

Ulf Hansson <ulf.hansson@linaro.org>
    mmc: core: Reset HPI enabled state during re-init and in case of errors

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add Telit LN940 series

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add Fibocom NL668 series

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add Simcom SIM7500/SIM7600 (MBIM mode)

Tore Anderson <tore@fud.no>
    USB: serial: option: add HP lt4132

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add GosunCn ZTE WeLink ME3630

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Don't prevent USB2 bus suspend in state check intended for USB3 only

Hui Peng <benquike@gmail.com>
    USB: hso: Fix OOB memory access in hso_probe/hso_get_config_data

Bart Van Assche <bart.vanassche@wdc.com>
    ib_srpt: Fix a use-after-free in __srpt_close_all_ch()

Mikulas Patocka <mpatocka@redhat.com>
    block: fix infinite loop if the device loses discard capability

Jens Axboe <axboe@kernel.dk>
    block: break discard submissions into the user defined size


-------------

Diffstat:

 Makefile                              |  4 ++--
 arch/x86/kernel/cpu/mtrr/if.c         |  2 ++
 arch/x86/kernel/fpu/signal.c          |  4 ++--
 block/blk-lib.c                       | 22 ++++++++++++++++++---
 drivers/gpio/gpio-max7301.c           | 12 +++---------
 drivers/gpu/drm/drm_ioctl.c           | 10 ++++++++--
 drivers/hv/vmbus_drv.c                | 20 +++++++++++++++++++
 drivers/infiniband/ulp/srpt/ib_srpt.c |  4 ++--
 drivers/mmc/core/mmc.c                | 24 ++++++++++++++---------
 drivers/mmc/host/omap_hsmmc.c         | 12 +++++++++++-
 drivers/net/usb/hso.c                 | 18 +++++++++++++++--
 drivers/usb/host/xhci-hub.c           |  3 ++-
 drivers/usb/serial/option.c           | 16 ++++++++++++++-
 fs/proc/proc_sysctl.c                 | 13 ++++++------
 fs/ubifs/replay.c                     | 37 +++++++++++++++++++++++++++++++++++
 kernel/panic.c                        |  6 +++++-
 16 files changed, 165 insertions(+), 42 deletions(-)


