Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98F4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C60F21773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297657;
	bh=0BxjJHlHfndjfs6uGRWU/coBmWLFFUrc35y8dGSmz2k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LEIBrBIdVL5I1wuSQ+Rtqk7lAWH72/jiu+V7vAKC22MsL31gk3VO4i2FLttcf1Nh2
	 JjFLTTdEeupZxhFwIs3KPOKEHEmnyHn2nUiImb5BbTtYi7atLxgHlYYYC/VUYKGFtJ
	 dIE+qFo5szV+2r7pjjAEra4dRY/0ePK1Xwrhn5oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbeLTJU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:20:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730883AbeLTJUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:20:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4013B2177E;
        Thu, 20 Dec 2018 09:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297652;
        bh=0BxjJHlHfndjfs6uGRWU/coBmWLFFUrc35y8dGSmz2k=;
        h=From:To:Cc:Subject:Date:From;
        b=krk0Ng47i3+qVTP4Oa2Ep/wBmQsVQ87Vk8rJAZ2hjbtyxiiFrqGvFrtt+q9INlCKp
         YxBj2jvfKlUcze+vAMLCs9TyHCUluUGXgESg89ka7cMVsEUKXbyNQbQqzBCdoVdi4b
         aGCh22nagvQ5nfCFqOFJ3x7XzVgK+WrzO9g2X96g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/31] 3.18.131-stable review
Date:   Thu, 20 Dec 2018 10:18:12 +0100
Message-Id: <20181220085742.601260254@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.131-rc1
X-KernelTest-Deadline: 2018-12-22T08:57+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.131 release.
There are 31 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Dec 22 08:57:30 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.131-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.131-rc1

Lior David <qca_liord@qca.qualcomm.com>
    wil6210: missing length check in wmi_set_ie

Kees Cook <keescook@chromium.org>
    swiotlb: clean up reporting

Jens Axboe <axboe@kernel.dk>
    sr: pass down correctly sized SCSI sense buffer

Thomas Gleixner <tglx@linutronix.de>
    posix-timers: Sanitize overrun handling

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: pcm: remove SNDRV_PCM_IOCTL1_INFO internal command

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: isa/wavefront: prevent some out of bound writes

Hans de Goede <hdegoede@redhat.com>
    i2c: scmi: Fix probe error on devices with an empty SMB0001 ACPI device node

Steve French <stfrench@microsoft.com>
    cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure cifs)

Chris Cole <chris@sageembedded.com>
    ARM: 8814/1: mm: improve/fix ARM v7_dma_inv_range() unaligned address handling

Juha-Matti Tilli <juha-matti.tilli@iki.fi>
    libata: whitelist all SAMSUNG MZ7KM* solid-state disks

Tony Lindgren <tony@atomide.com>
    Input: omap-keypad - fix keyboard debounce configuration

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

YiFei Zhu <zhuyifei1999@gmail.com>
    x86/earlyprintk/efi: Fix infinite loop on some screen widths

Cathy Avery <cavery@redhat.com>
    scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq during unload

Fred Herard <fred.herard@oracle.com>
    scsi: libiscsi: Fix NULL pointer dereference in iscsi_eh_session_reset

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    powerpc: Look for "stdout-path" when setting up legacy consoles

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix memory leak of instance function hash filters

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix memory leak in set_trigger_filter()

Aaro Koskinen <aaro.koskinen@iki.fi>
    MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310

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

 Makefile                               |  4 +-
 arch/arm/mm/cache-v7.S                 |  8 +--
 arch/powerpc/boot/Makefile             |  3 +-
 arch/powerpc/kernel/legacy_serial.c    |  6 ++-
 arch/x86/platform/efi/early_printk.c   |  2 +-
 drivers/ata/libata-core.c              |  1 +
 drivers/i2c/busses/i2c-scmi.c          | 10 ++--
 drivers/ide/pmac.c                     |  1 +
 drivers/input/keyboard/omap4-keypad.c  | 18 +++++--
 drivers/mmc/host/omap.c                | 11 +++-
 drivers/net/bonding/bond_3ad.c         |  3 ++
 drivers/net/wireless/ath/wil6210/wmi.c |  7 ++-
 drivers/sbus/char/display7seg.c        |  1 +
 drivers/sbus/char/envctrl.c            |  2 +
 drivers/scsi/libiscsi.c                |  4 +-
 drivers/scsi/sr_ioctl.c                | 21 +++-----
 drivers/scsi/vmw_pvscsi.c              |  4 +-
 drivers/tty/serial/suncore.c           |  1 +
 fs/cifs/Kconfig                        |  2 +-
 include/linux/posix-timers.h           |  4 +-
 include/sound/pcm.h                    |  2 +-
 kernel/time/posix-cpu-timers.c         |  2 +-
 kernel/time/posix-timers.c             | 29 +++++++----
 kernel/time/timer_list.c               |  2 +-
 kernel/trace/ftrace.c                  |  1 +
 kernel/trace/trace_events_trigger.c    |  6 ++-
 lib/interval_tree_test.c               | 93 ++++++++++++++++++++++------------
 lib/rbtree_test.c                      | 55 ++++++++++++--------
 lib/swiotlb.c                          | 18 +++----
 net/sunrpc/xprt.c                      | 11 +++-
 sound/core/pcm_lib.c                   |  2 -
 sound/core/pcm_native.c                |  6 +--
 sound/isa/wavefront/wavefront_synth.c  |  9 ++++
 33 files changed, 224 insertions(+), 125 deletions(-)


