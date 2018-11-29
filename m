Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87853C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B287208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChTHdJN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B287208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbeK3BUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:20:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbeK3BUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:20:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4609C205C9;
        Thu, 29 Nov 2018 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500889;
        bh=P5ev/Zt3fVB1ws59yUA03ZaG4+vgyBg/2gaquH5uKCk=;
        h=From:To:Cc:Subject:Date:From;
        b=ChTHdJN6yLAHpMoGSOB7eowqvcGnsXO1WmmfOEO794ZQzzbgKvJmJ7X3zwPzK+Nqo
         YNmeKQRGIqzXgrD8yTSWQlhvsFOtsQYHJOivah7Up1HHD4BSEdD6Tmi9TOc/i8cWlb
         ITx1nGU8rshLeRJsBjw1XV8XUjzo4v+HZTsjK5VE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/83] 3.18.128-stable review
Date:   Thu, 29 Nov 2018 15:11:18 +0100
Message-Id: <20181129140138.002176596@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.128-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.128-rc1
X-KernelTest-Deadline: 2018-12-01T14:01+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.128 release.
There are 83 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Dec  1 14:01:23 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.128-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.128-rc1

Thomas Zimmermann <tzimmermann@suse.de>
    drm/ast: Remove existing framebuffers before loading driver

WANG Cong <xiyou.wangcong@gmail.com>
    af_unix: move unix_mknod() out of bindlock

Greg Kroah-Hartman <greg@kroah.com>
    tty: wipe buffer if not echoing data

Linus Torvalds <torvalds@linux-foundation.org>
    tty: wipe buffer.

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    scsi: qla2xxx: do not queue commands when unloading

Subhash Jadavani <subhashj@codeaurora.org>
    scsi: ufs: fix race between clock gating and devfreq scaling work

Venkat Gopalakrishnan <venkatg@codeaurora.org>
    scsi: ufshcd: Fix race between clk scaling and ungate work

Yaniv Gardi <ygardi@codeaurora.org>
    scsi: ufs: fix bugs related to null pointer access and array size

Johannes Thumshirn <jthumshirn@suse.de>
    cw1200: Don't leak memory if krealloc failes

Ramses Ramírez <ramzeto@gmail.com>
    Input: xpad - add support for Xbox1 PDP Camo series gamepad

Enno Boland <gottox@voidlinux.eu>
    Input: xpad - fix GPD Win 2 controller name

Ethan Lee <flibitijibibo@gmail.com>
    Input: xpad - add GPD Win 2 Controller USB IDs

Marcus Folkesson <marcus.folkesson@gmail.com>
    Input: xpad - avoid using __set_bit() for capabilities

Leo Sperling <leosperling97@gmail.com>
    Input: xpad - fix some coding style issues

Francis Therien <frtherien@gmail.com>
    Input: xpad - add PDP device id 0x02a4

Mark Furneaux <mark@furneaux.ca>
    Input: xpad - add support for PDP Xbox One controllers

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - validate USB endpoint type during probe

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - fix PowerA init quirk for some gamepad models

Arvind Yadav <arvind.yadav.cs@gmail.com>
    Input: xpad - constify usb_device_id

Benjamin Valentin <benpicco@googlemail.com>
    Input: xpad - sync supported devices with XBCD

Benjamin Valentin <benpicco@googlemail.com>
    Input: xpad - sync supported devices with 360Controller

Benjamin Valentin <benpicco@googlemail.com>
    Input: xpad - add USB IDs for Mad Catz Brawlstick and Razer Sabertooth

Benjamin Valentin <benpicco@googlemail.com>
    Input: xpad - sync supported devices with xboxdrv

Benjamin Valentin <benpicco@googlemail.com>
    Input: xpad - sort supported devices by USB ID

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - support some quirky Xbox One pads

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - restore LED state after device resume

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - fix stuck mode button on Xbox One S pad

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - don't depend on endpoint order

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - simplify error condition in init_output

Daniel Tobias <dan.g.tob@gmail.com>
    Input: xpad - move reporting xbox one home button to common function

Daniel Tobias <dan.g.tob@gmail.com>
    Input: xpad - correctly sort vendor id's

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - use correct product id for x360w controllers

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - fix Xbox One rumble stopping after 2.5 secs

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - add product ID for Xbox One S pad

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - power off wireless 360 controllers on suspend

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - fix oops when attaching an unknown Xbox One gamepad

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - fix rumble on Xbox One controllers with 2015 firmware

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - xbox one elite controller support

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - add more third-party controllers

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - prevent spurious input from wired Xbox 360 controllers

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - move pending clear to the correct location

Silvan Jegen <s.jegen@gmail.com>
    Input: xpad - add Mad Catz FightStick TE 2 VID/PID

Arnd Bergmann <arnd@arndb.de>
    Input: xpad - remove unused function

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - correct xbox one pad device name

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: xpad - use LED API when identifying wireless controllers

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - workaround dead irq_out after suspend/ resume

Pierre-Loup A. Griffais <githubpublic@plagman.net>
    Input: xpad - update Xbox One Force Feedback Support

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - correctly handle concurrent LED and FF requests

Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
    Input: xpad - handle "present" and "gone" correctly

Clement Calmels <clement.calmels@free.fr>
    Input: xpad - remove spurious events of wireless xpad 360 controller

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - fix clash of presence handling with LED setting

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - query wireless controller state at init

Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
    Input: xpad - move the input device creation to a new function

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - x360w: report dpad as buttons and axes

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - factor out URB submission in xpad_play_effect

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - remove needless bulk out URB used for LED setup

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - use ida() for finding the pad_nr

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - clarify LED enumeration

Dario Scarpa <dario.scarpa@duskzone.it>
    Input: xpad - fix Razer Atrox Arcade Stick button mapping

Erik Lundgren <eriklundgren93@gmail.com>
    Input: xpad - add Covert Forces edition of the Xbox One controller

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - re-send LED command on present event

Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
    Input: xpad - set the LEDs properly on XBox Wireless controllers

Ming-ting Yao Wei <mwei@lxde.org>
    Input: xpad - add rumble support for Xbox One controller

Aniroop Mathur <aniroop.mathur@gmail.com>
    Input: initialize device counter variables with -1

Greg Hackmann <ghackmann@android.com>
    arm64: remove no-op -p linker flag

Yufen Yu <yuyufen@huawei.com>
    tmpfs: make lseek(SEEK_DATA/SEK_HOLE) return ENXIO with a negative offset

Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
    powerpc/numa: Suppress "VPHN is not supported" messages

Prarit Bhargava <prarit@redhat.com>
    kdb: Use strscpy with destination buffer size

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Fix a bogus get/put in generic_key_to_expire()

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: make lookup_processor_type() non-__init

Anson Huang <anson.huang@nxp.com>
    cpufreq: imx6q: add return value check for voltage scale

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: __can_get_echo_skb(): Don't crash the kernel if can_priv::echo_skb is accessed out of bounds

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: __can_get_echo_skb(): replace struct can_frame by canfd_frame to access frame length

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: can_get_echo_skb(): factor out non sending code to __can_get_echo_skb()

Y.C. Chen <yc_chen@aspeedtech.com>
    drm/ast: change resolution may cause screen blurred

Y.C. Chen <yc_chen@aspeedtech.com>
    drm/ast: fixed cursor may disappear sometimes

Eric Dumazet <edumazet@google.com>
    llc: do not use sk_eat_skb()

Andrew Price <anprice@redhat.com>
    gfs2: Don't leave s_fs_info pointing to freed memory in init_sbd

Xin Long <lucien.xin@gmail.com>
    sctp: clear the transport of some out_chunk_list chunks in sctp_assoc_rm_peer

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    bfs: add sanity check at bfs_fill_super()

Dominique Martinet <dominique.martinet@cea.fr>
    v9fs_dir_readdir: fix double-free on p9stat_read error

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    usb: core: Fix hub port connection events lost


-------------

Diffstat:

 Makefile                          |    4 +-
 arch/arm/kernel/head-common.S     |    6 +-
 arch/arm64/Makefile               |    2 +-
 arch/powerpc/mm/numa.c            |    2 +-
 drivers/cpufreq/imx6q-cpufreq.c   |    7 +-
 drivers/gpu/drm/ast/ast_drv.c     |   21 +
 drivers/gpu/drm/ast/ast_mode.c    |    3 +-
 drivers/input/gameport/gameport.c |    4 +-
 drivers/input/joystick/xpad.c     | 1422 +++++++++++++++++++++++++++----------
 drivers/input/misc/ims-pcu.c      |    4 +-
 drivers/input/serio/serio.c       |    4 +-
 drivers/input/serio/serio_raw.c   |    4 +-
 drivers/net/can/dev.c             |   48 +-
 drivers/net/wireless/cw1200/wsm.c |   16 +-
 drivers/scsi/qla2xxx/qla_os.c     |    5 +
 drivers/scsi/ufs/ufs.h            |    3 +-
 drivers/scsi/ufs/ufshcd.c         |   72 +-
 drivers/tty/n_tty.c               |   19 +-
 drivers/tty/tty_buffer.c          |    2 +
 drivers/usb/core/hub.c            |    4 +-
 fs/9p/vfs_dir.c                   |   11 -
 fs/bfs/inode.c                    |    9 +-
 fs/gfs2/ops_fstype.c              |    2 +-
 include/linux/can/dev.h           |    1 +
 kernel/debug/kdb/kdb_io.c         |   15 +-
 kernel/debug/kdb/kdb_private.h    |    2 +-
 kernel/debug/kdb/kdb_support.c    |   10 +-
 mm/shmem.c                        |    4 +-
 net/llc/af_llc.c                  |   11 +-
 net/sctp/associola.c              |   10 +-
 net/sunrpc/auth_generic.c         |    8 +-
 net/unix/af_unix.c                |   27 +-
 32 files changed, 1293 insertions(+), 469 deletions(-)


