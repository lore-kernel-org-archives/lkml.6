Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785E3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAC420449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297760;
	bh=U818XwpjfyWWAPBSx/PCGLTaESDLe2rdVT3HHe8tm7c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jyqfKKZiQBFqSFmx8wc93oSA0USj3MZHQFyvkZKMgKWH+tu2vsUQoEAa4OqRMlDQr
	 nNgU3+vFjQrn6S3bdFVuZp3yxWaOLEH0+iRJ11P28VDMwuQwOwgjn8nWR6HRfvq1uP
	 LaDkxgabmjeSKu9sdc3dPhLRWnVG2PHSaZIILGU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbeLTJWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:22:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731374AbeLTJWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:22:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2E52177B;
        Thu, 20 Dec 2018 09:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297755;
        bh=U818XwpjfyWWAPBSx/PCGLTaESDLe2rdVT3HHe8tm7c=;
        h=From:To:Cc:Subject:Date:From;
        b=PSxc2GBnZWxiG4wIcoLWPQ0zlNJtunjqle6JCK6vhU+8ncHpOqtvYGoQZlvIOPK3C
         svHhlkYeNeLsmKlQYzPhlSqv0F4xWZzX5bxkm9BWkQEsl1qqb1sfk6Ujsrq2FOIGdD
         TGcHC7LzEHVpkxXorCE4pTKFWMuiHHlWNaYQs4l8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/40] 4.4.169-stable review
Date:   Thu, 20 Dec 2018 10:18:12 +0100
Message-Id: <20181220085826.212663515@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.169-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.169-rc1
X-KernelTest-Deadline: 2018-12-22T08:58+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.169 release.
There are 40 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Dec 22 08:58:16 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.169-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.169-rc1

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: isa/wavefront: prevent some out of bound writes

Trent Piepho <tpiepho@impinj.com>
    rtc: snvs: Add timeouts to avoid kernel lockups

Guy Shapiro <guy.shapiro@mobi-wize.com>
    rtc: snvs: add a missing write sync

Hans de Goede <hdegoede@redhat.com>
    i2c: scmi: Fix probe error on devices with an empty SMB0001 ACPI device node

Adamski, Krzysztof (Nokia - PL/Wroclaw) <krzysztof.adamski@nokia.com>
    i2c: axxia: properly handle master timeout

Steve French <stfrench@microsoft.com>
    cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure cifs)

Chris Cole <chris@sageembedded.com>
    ARM: 8814/1: mm: improve/fix ARM v7_dma_inv_range() unaligned address handling

Anderson Luiz Alves <alacn1@gmail.com>
    mv88e6060: disable hardware level MAC learning

Juha-Matti Tilli <juha-matti.tilli@iki.fi>
    libata: whitelist all SAMSUNG MZ7KM* solid-state disks

Tony Lindgren <tony@atomide.com>
    Input: omap-keypad - fix keyboard debounce configuration

Dan Carpenter <dan.carpenter@oracle.com>
    clk: mmp: Off by one in mmp_clk_add()

Yangtao Li <tiny.windzz@gmail.com>
    ide: pmac: add of_node_put()

Yangtao Li <tiny.windzz@gmail.com>
    drivers/tty: add missing of_node_put()

Yangtao Li <tiny.windzz@gmail.com>
    drivers/sbus/char: add of_node_put()

Yangtao Li <tiny.windzz@gmail.com>
    sbus: char: add of_node_put()

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Fix a potential race in xprt_connect()

Toni Peltonen <peltzi@peltzi.fi>
    bonding: fix 802.3ad state sent to partner when unbinding slave

Jose Abreu <joabreu@synopsys.com>
    ARC: io.h: Implement reads{x}()/writes{x}()

Sean Paul <seanpaul@chromium.org>
    drm/msm: Grab a vblank reference when waiting for commit_done

YiFei Zhu <zhuyifei1999@gmail.com>
    x86/earlyprintk/efi: Fix infinite loop on some screen widths

Cathy Avery <cavery@redhat.com>
    scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq during unload

Fred Herard <fred.herard@oracle.com>
    scsi: libiscsi: Fix NULL pointer dereference in iscsi_eh_session_reset

Alexey Khoroshilov <khoroshilov@ispras.ru>
    mac80211_hwsim: fix module init error paths for netlink

Ilan Peer <ilan.peer@intel.com>
    mac80211: Fix condition validating WMM IE

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: don't WARN on bad WMM parameters from buggy APs

Yunlei He <heyunlei@huawei.com>
    f2fs: fix a panic caused by NULL flush_cmd_control

Brian Norris <briannorris@chromium.org>
    Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"

Radu Rendec <radu.rendec@gmail.com>
    powerpc/msi: Fix NULL pointer access in teardown code

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix memory leak of instance function hash filters

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix memory leak in set_trigger_filter()

Aaro Koskinen <aaro.koskinen@iki.fi>
    MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310

Jeff Moyer <jmoyer@redhat.com>
    aio: fix spectre gadget in lookup_ioctx

Chen-Yu Tsai <wens@csie.org>
    pinctrl: sunxi: a83t: Fix IRQ offset typo for PH11

Guenter Roeck <linux@roeck-us.net>
    powerpc/boot: Fix random libfdt related build errors

Ingo Molnar <mingo@kernel.org>
    timer/debug: Change /proc/timer_list from 0444 to 0400

Davidlohr Bueso <dave@stgolabs.net>
    lib/interval_tree_test.c: allow users to limit scope of endpoint

Davidlohr Bueso <dave@stgolabs.net>
    lib/rbtree-test: lower default params

Davidlohr Bueso <dave@stgolabs.net>
    lib/rbtree_test.c: make input module parameters

Davidlohr Bueso <dave@stgolabs.net>
    lib/interval_tree_test.c: allow full tree search

Davidlohr Bueso <dave@stgolabs.net>
    lib/interval_tree_test.c: make test options module parameters


-------------

Diffstat:

 Makefile                                    |   4 +-
 arch/arc/include/asm/io.h                   |  72 +++++++++++++++++++
 arch/arm/mm/cache-v7.S                      |   8 ++-
 arch/powerpc/boot/Makefile                  |   3 +-
 arch/powerpc/kernel/msi.c                   |   7 +-
 arch/x86/platform/efi/early_printk.c        |   2 +-
 drivers/ata/libata-core.c                   |   1 +
 drivers/clk/mmp/clk.c                       |   2 +-
 drivers/gpu/drm/msm/msm_atomic.c            |   5 ++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   6 --
 drivers/i2c/busses/i2c-axxia.c              |  40 ++++++++---
 drivers/i2c/busses/i2c-scmi.c               |  10 ++-
 drivers/ide/pmac.c                          |   1 +
 drivers/input/keyboard/omap4-keypad.c       |  18 +++--
 drivers/mmc/host/omap.c                     |  11 ++-
 drivers/net/bonding/bond_3ad.c              |   3 +
 drivers/net/dsa/mv88e6060.c                 |  10 +--
 drivers/net/wireless/mac80211_hwsim.c       |  12 ++--
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c  |   2 +-
 drivers/rtc/rtc-snvs.c                      | 104 +++++++++++++++++++---------
 drivers/sbus/char/display7seg.c             |   1 +
 drivers/sbus/char/envctrl.c                 |   2 +
 drivers/scsi/libiscsi.c                     |   4 +-
 drivers/scsi/vmw_pvscsi.c                   |   4 +-
 drivers/tty/serial/suncore.c                |   1 +
 fs/aio.c                                    |   2 +
 fs/cifs/Kconfig                             |   2 +-
 fs/f2fs/segment.c                           |   5 +-
 kernel/time/timer_list.c                    |   2 +-
 kernel/trace/ftrace.c                       |   1 +
 kernel/trace/trace_events_trigger.c         |   6 +-
 lib/interval_tree_test.c                    |  93 ++++++++++++++++---------
 lib/rbtree_test.c                           |  55 +++++++++------
 net/mac80211/mlme.c                         |   3 +-
 net/sunrpc/xprt.c                           |  11 ++-
 sound/isa/wavefront/wavefront_synth.c       |   9 +++
 36 files changed, 376 insertions(+), 146 deletions(-)


