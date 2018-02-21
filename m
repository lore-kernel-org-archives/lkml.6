Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224usyLGYtyPY6pR6oFwhP0qytCFQLKRlhDk5HjYFXQjCRSBQF0TcXpLIw1oKTiXER3AiDVL
ARC-Seal: i=1; a=rsa-sha256; t=1519217118; cv=none;
        d=google.com; s=arc-20160816;
        b=xiXOLCE0hvx4dbubdbmQb+fs/Fc1ofVm2HkadR2ZS9yDdoyredAnRbpFnh1kfeduEg
         3D1B3RwKDfyD5/57K8+sbl8+lDbW/PYsoTdSWwScqCzq7xUgGtdi5PLbE5H4W7NJw8Eu
         tl7c7LnFVuZ3vHayqOpEhQg/14L0wo5vNjTgkU28y3SSkmQRqOuLD9Nov9FCfUe8IUOy
         bBmbVYzPk1+dA5Sjv1kCBcnuObMZUgOMNMxk75WTM4x7qVSRgej4Ajrw5EnC+gDrgoin
         rcM3xbBWROFTEqHVVBC8pLT+KhPUIsrfh65hYIppgALf12RzR0/NwWreCGxOsYRHJpRf
         XSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r15GkEx7mNDOyJhkzbyPRH2BUipJOnMTEeWjA8SIfyw=;
        b=OFBozKvaCI1Nzql62zERtLUgnnU6aw53IhXqFq2h9zgAInWQ9uxMcreL/zF7+lofr6
         RpZ9y54J5PZiUEU6BC2rsruCWN7LhZnLeoSaOl9h50P71jyLEG7Iy50HGGYPRe07QdyB
         hkzNKEX6p0MJAiA3KLD1r+rtcpYVdRn9UsT4UT1sl7WwLbgaLU28lj5A6ncGZBBitVk4
         zEtbvvF43l1htssYT4QKcmFkFPTpWTUe41Agze86a4DMJXQcEcMKNavtI6fv41N8QJGc
         IDENHVovqu7roWwcZx58QFH5IZoHSMqVLxXPPOG2Y1U3DTkXj5RuUTsmQSdQetxAxHtP
         DxEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuahkh@osg.samsung.com,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.4 00/33] 4.4.117-stable review
Date: Wed, 21 Feb 2018 13:44:43 +0100
Message-Id: <20180221124409.564661689@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.117-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.117-rc1
X-KernelTest-Deadline: 2018-02-23T12:44+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014609837749485?=
X-GMAIL-MSGID: =?utf-8?q?1593014609837749485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.117 release.
There are 33 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Feb 23 12:43:54 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.117-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.117-rc1

Arnd Bergmann <arnd@arndb.de>
    media: r820t: fix r820t_write_reg for KASAN

Arnd Bergmann <arnd@arndb.de>
    ARM: dts: s5pv210: add interrupt-parent for ohci

Arnd Bergmann <arnd@arndb.de>
    ARM: pxa/tosa-bt: add MODULE_LICENSE tag

Linus Torvalds <torvalds@linux-foundation.org>
    vfs: don't do RCU lookup of empty pathnames

Arnd Bergmann <arnd@arndb.de>
    x86: fix build warnign with 32-bit PAE

NeilBrown <neilb@suse.com>
    dm: correctly handle chained bios in dec_pending()

Mikulas Patocka <mpatocka@redhat.com>
    mvpp2: fix multicast address filter

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix racy pool initializations

Lassi Ylikojola <lassi.ylikojola@gmail.com>
    ALSA: usb-audio: add implicit fb quirk for Behringer UFX1204

Jan-Marek Glogowski <glogow@fbihome.de>
    ALSA: hda/realtek: PCI quirk for Fujitsu U7x7

Kirill Marinushkin <k.marinushkin@gmail.com>
    ALSA: usb-audio: Fix UAC2 get_ctl request with a RANGE attribute

Hui Wang <hui.wang@canonical.com>
    ALSA: hda - Fix headset mic detection problem for two Dell machines

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix unexpected -EEXIST when creating new inode

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix crash due to not cleaning up tree log block's dirty bits

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix deadlock in run_delalloc_nocow

Larry Finger <Larry.Finger@lwfinger.net>
    rtlwifi: rtl8821ae: Fix connection lost problem correctly

Nicolas Pitre <nicolas.pitre@linaro.org>
    console/dummy: leave .con_font_get set to NULL

Johan Hovold <johan@kernel.org>
    video: fbdev: atmel_lcdfb: fix display-timings lookup

Arnd Bergmann <arnd@arndb.de>
    mm: hide a #warning for COMPILE_TEST

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    ext4: correct documentation for grpid mount option

Zhouyi Zhou <zhouzhouyi@gmail.com>
    ext4: save error to disk in __ext4_grp_locked_error()

Stewart Smith <stewart@linux.vnet.ibm.com>
    rtc-opal: Fix handling of firmware error codes, prevent busy loops

Julia Lawall <Julia.Lawall@lip6.fr>
    drm/radeon: adjust tested variable

Gustavo A. R. Silva <garsilva@embeddedor.com>
    x86/cpu: Change type of x86_cache_size variable to unsigned int

David Woodhouse <dwmw@amazon.co.uk>
    KVM/x86: Reduce retpoline performance impact in slot_handle_level_range(), by always inlining iterator helper methods

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix regression by incorrect ioctl_mutex usages

Viresh Kumar <viresh.kumar@linaro.org>
    arm: spear13xx: Fix spics gpio controller's warning

Viresh Kumar <viresh.kumar@linaro.org>
    arm: spear13xx: Fix dmas cells

Viresh Kumar <viresh.kumar@linaro.org>
    arm: spear600: Add missing interrupt-parent of rtc

Patrice Chotard <patrice.chotard@st.com>
    ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property

Eugene Syromiatnikov <esyr@redhat.com>
    s390: fix handling of -1 in set{,fs}[gu]id16 syscalls

Bjorn Andersson <bjorn.andersson@linaro.org>
    PM / devfreq: Propagate error from devfreq_add_device()

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/mlx4: Fix incorrectly releasing steerable UD QPs when have only ETH ports


-------------

Diffstat:

 Documentation/devicetree/bindings/dma/snps-dma.txt |  2 +-
 Documentation/filesystems/ext4.txt                 |  2 +-
 Makefile                                           |  4 ++--
 arch/arm/boot/dts/s5pv210.dtsi                     |  1 +
 arch/arm/boot/dts/spear1310-evb.dts                |  2 +-
 arch/arm/boot/dts/spear1340.dtsi                   |  4 ++--
 arch/arm/boot/dts/spear13xx.dtsi                   |  6 ++---
 arch/arm/boot/dts/spear600.dtsi                    |  1 +
 arch/arm/boot/dts/stih407.dtsi                     |  3 ++-
 arch/arm/boot/dts/stih410.dtsi                     |  3 ++-
 arch/arm/mach-pxa/tosa-bt.c                        |  4 ++++
 arch/s390/kernel/compat_linux.c                    |  8 +++----
 arch/x86/include/asm/processor.h                   |  2 +-
 arch/x86/kernel/cpu/common.c                       |  2 +-
 arch/x86/kernel/cpu/microcode/intel.c              |  2 +-
 arch/x86/kernel/cpu/proc.c                         |  4 ++--
 arch/x86/kvm/mmu.c                                 | 10 ++++----
 drivers/devfreq/devfreq.c                          |  2 +-
 drivers/gpu/drm/radeon/radeon_uvd.c                |  2 +-
 drivers/infiniband/hw/mlx4/main.c                  | 13 ++++------
 drivers/md/dm.c                                    |  3 ++-
 drivers/media/tuners/r820t.c                       | 13 ++++++----
 drivers/net/ethernet/marvell/mvpp2.c               | 11 ++++++---
 drivers/net/ethernet/mellanox/mlx4/qp.c            |  3 +++
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |  5 ++--
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |  1 +
 drivers/rtc/rtc-opal.c                             | 12 ++++++++--
 drivers/video/console/dummycon.c                   |  1 -
 drivers/video/fbdev/atmel_lcdfb.c                  |  8 ++++++-
 fs/btrfs/inode.c                                   |  5 +++-
 fs/btrfs/tree-log.c                                | 27 +++++++++++++++++++++
 fs/ext4/super.c                                    |  1 +
 fs/namei.c                                         |  3 +++
 include/linux/kaiser.h                             |  2 +-
 mm/memory.c                                        |  2 +-
 sound/core/seq/seq_clientmgr.c                     | 23 ++++++++++--------
 sound/pci/hda/patch_realtek.c                      | 28 ++++++++++++++++++++++
 sound/usb/mixer.c                                  | 18 ++++++++------
 sound/usb/pcm.c                                    |  9 +++++++
 39 files changed, 181 insertions(+), 71 deletions(-)
