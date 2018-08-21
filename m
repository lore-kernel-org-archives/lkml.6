Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220D9C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04C521774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04C521774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeHUJlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:41:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54736 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeHUJlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:41:31 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 764BC516;
        Tue, 21 Aug 2018 06:22:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.18 00/35] 4.18.4-stable review
Date:   Tue, 21 Aug 2018 08:20:26 +0200
Message-Id: <20180821055019.954904905@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.4-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.18.4-rc1
X-KernelTest-Deadline: 2018-08-23T05:50+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.18.4 release.
There are 35 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Aug 23 05:50:07 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.4-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.18.4-rc1

Hangbin Liu <liuhangbin@gmail.com>
    cls_matchall: fix tcf_unbind_filter missing

Jisheng Zhang <Jisheng.Zhang@synaptics.com>
    net: mvneta: fix mvneta_config_rss on armada 3700

Andrew Lunn <andrew@lunn.ch>
    net: ethernet: mvneta: Fix napi structure mixup on armada 3700

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    ip_vti: fix a null pointer deferrence when create vti fallback tunnel

Jian-Hong Pan <jian-hong@endlessm.com>
    r8169: don't use MSI-X on RTL8106e

Takashi Iwai <tiwai@suse.de>
    hv/netvsc: Fix NULL dereference at single queue mode fallback

Jeremy Cline <jcline@redhat.com>
    net: sock_diag: Fix spectre v1 gadget in __sock_diag_cmd()

Kees Cook <keescook@chromium.org>
    isdn: Disable IIOCDBGVAR

Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    Bluetooth: avoid killing an already killed socket

Xiubo Li <xiubli@redhat.com>
    Revert "uio: use request_threaded_irq instead"

Johan Hovold <johan@kernel.org>
    misc: sram: fix resource leaks in probe error path

Hailong Liu <liu.hailong6@zte.com.cn>
    uio: fix wrong return value from uio_mmap()

Srinath Mannam <srinath.mannam@broadcom.com>
    serial: 8250_dw: Add ACPI support for uart on Broadcom SoC

Chen Hu <hu1.chen@intel.com>
    serial: 8250_dw: always set baud rate in dw8250_set_termios

Aaron Sierra <asierra@xes-inc.com>
    serial: 8250_exar: Read INT0 from slave device, too

Mark <dmarkh@cfl.rr.com>
    tty: serial: 8250: Revert NXP SC16C2552 workaround

Willy Tarreau <w@1wt.eu>
    ACPI / PM: save NVS memory for ASUS 1025C laptop

Aleksander Morgado <aleksander@aleksander.es>
    USB: option: add support for DW5821e

Movie Song <MovieSong@aten-itlab.cn>
    USB: serial: pl2303: add a new device id for ATEN

John Ogness <john.ogness@linutronix.de>
    USB: serial: sierra: fix potential deadlock at close

Mika Båtsman <mika.batsman@gmail.com>
    media: gl861: fix probe of dvb_usb_gl861

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix poll() error return

Takashi Iwai <tiwai@suse.de>
    ALSA: vxpocket: Fix invalid endian conversions

Takashi Iwai <tiwai@suse.de>
    ALSA: memalloc: Don't exceed over the requested size

Hans de Goede <hdegoede@redhat.com>
    ALSA: hda: Correct Asrock B85M-ITX power_save blacklist entry

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: dice: fix wrong copy to rx parameters for Alesis iO26

Takashi Iwai <tiwai@suse.de>
    ALSA: cs5535audio: Fix invalid endian conversion

Takashi Iwai <tiwai@suse.de>
    ALSA: virmidi: Fix too long output trigger loop

Takashi Iwai <tiwai@suse.de>
    ALSA: vx222: Fix invalid endian conversions

Park Ju Hyung <qkrwngud825@gmail.com>
    ALSA: hda - Turn CX8200 into D3 as well upon reboot

Park Ju Hyung <qkrwngud825@gmail.com>
    ALSA: hda - Sleep for 10ms after entering D3 on Conexant codecs

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: don't use MSI-X on RTL8168g

Hangbin Liu <liuhangbin@gmail.com>
    net_sched: Fix missing res info when create new tc_index filter

Hangbin Liu <liuhangbin@gmail.com>
    net_sched: fix NULL pointer dereference when delete tcindex filter

Wei Wang <weiwan@google.com>
    l2tp: use sk_dst_check() to avoid race on sk->sk_dst_cache


-------------

Diffstat:

 Makefile                                |  4 +--
 drivers/acpi/sleep.c                    |  8 +++++
 drivers/isdn/i4l/isdn_common.c          |  8 +----
 drivers/media/usb/dvb-usb-v2/gl861.c    | 21 +++++++------
 drivers/misc/sram.c                     |  9 +++++-
 drivers/net/ethernet/marvell/mvneta.c   | 53 ++++++++++++++++++++-------------
 drivers/net/ethernet/realtek/r8169.c    | 12 ++++++--
 drivers/net/hyperv/rndis_filter.c       |  2 +-
 drivers/tty/serial/8250/8250_dw.c       |  3 +-
 drivers/tty/serial/8250/8250_exar.c     |  6 +++-
 drivers/tty/serial/8250/8250_port.c     |  3 +-
 drivers/uio/uio.c                       | 10 ++-----
 drivers/usb/serial/option.c             |  4 +++
 drivers/usb/serial/pl2303.c             |  2 ++
 drivers/usb/serial/pl2303.h             |  1 +
 drivers/usb/serial/sierra.c             |  4 +--
 net/bluetooth/sco.c                     |  3 +-
 net/core/sock_diag.c                    |  2 ++
 net/ipv4/ip_vti.c                       |  3 +-
 net/l2tp/l2tp_core.c                    |  2 +-
 net/sched/cls_matchall.c                |  2 ++
 net/sched/cls_tcindex.c                 |  8 ++---
 net/socket.c                            |  3 +-
 sound/core/memalloc.c                   |  8 ++---
 sound/core/seq/oss/seq_oss.c            |  2 +-
 sound/core/seq/seq_clientmgr.c          |  2 +-
 sound/core/seq/seq_virmidi.c            | 10 +++++++
 sound/firewire/dice/dice-alesis.c       |  2 +-
 sound/pci/cs5535audio/cs5535audio.h     |  6 ++--
 sound/pci/cs5535audio/cs5535audio_pcm.c |  4 +--
 sound/pci/hda/hda_intel.c               |  2 +-
 sound/pci/hda/patch_conexant.c          |  4 ++-
 sound/pci/vx222/vx222_ops.c             |  8 ++---
 sound/pcmcia/vx/vxp_ops.c               | 10 +++----
 34 files changed, 138 insertions(+), 93 deletions(-)


