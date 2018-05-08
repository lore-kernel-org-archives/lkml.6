Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrpf9+Z7hAzJuA4lqjQEnRyTMYjSq9ieYX59EqSpkeae6iUCRjimhzPW0oIQH69t1cMCzLI
ARC-Seal: i=1; a=rsa-sha256; t=1525767279; cv=none;
        d=google.com; s=arc-20160816;
        b=VnZyquqbIMy1CQxl3mc4xL6AWy3J2TFwwcek71gOz5O4RW62lBWlgGdP01v/vm6NxW
         TjwBVpe/cioa0vnOmkHRVUgPBJA6QObRzdXk+g5uwb8FnpoAOUGoObgtV12LJ09pLhZu
         NJ2PlQp63gPxMbXHw+2UWQQuXhY/Zcm0sT81zCreizsRWvkuDiq1w6foCU/ky4kF87RS
         zVOV4bXj6tr3lPK6e9y3PNBGnLmp6xPcxtRFu19sCr9+lvVULrdkv1cn/0+lgmnQ8fVO
         ZHiK9OEjgb6UzkGABp28KrYF73lhkGnx89LcX+iW6non1hGQl1aOHFO1lWE0UtBK8afm
         7AvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=buv0UvZQhH2dypF4aiqRV4MaPM7x67K2GZWtV2szQdQ=;
        b=zVmAQ7Nw5gND0g8zg4exz4+OE9AKooi4uooi7je0t2QQRCPuKWCD6/WhNpuzG148bq
         MtOtrQ8tHNMAsEYekRMpSsbHzbgI77SUdqzyENCFEl0Jk3yJBKqX8PKogrWHRNV1zGoe
         J00Z+dv91jlWmbT7YYYVa/e09wVDwZVLqh2hJh3UTffHza4n+TfYALPCe6c44AMatFCg
         XwdVUDJPpzGgsHOGOcoN88JnRMH/MKErU7urvUm7lOGSpARED8ztrB6degAUnNYff1EJ
         FlqFoFGNr6epVr/Khge4I/r/KJ4Lc1GutkRS1MDu/3HeTqMcVLPDFHBlg3GBEcOfon3O
         5MjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=L3Qz2+fX;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=L3Qz2+fX;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.14 00/43] 4.14.40-stable review
Date: Tue,  8 May 2018 10:10:19 +0200
Message-Id: <20180508074003.984433784@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.40-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.40-rc1
X-KernelTest-Deadline: 2018-05-10T07:40+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882950858871392?=
X-GMAIL-MSGID: =?utf-8?q?1599882950858871392?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.40 release.
There are 43 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu May 10 07:39:32 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.40-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.40-rc1

Song Liu <songliubraving@fb.com>
    tracing: Fix bad use of igrab in trace_uprobe.c

Agustin Vega-Frias <agustinv@codeaurora.org>
    irqchip/qcom: Fix check for spurious interrupts

João Paulo Rechi Vita <jprvita@gmail.com>
    platform/x86: asus-wireless: Fix NULL pointer dereference

Bin Liu <b-liu@ti.com>
    usb: musb: trace: fix NULL pointer dereference in musb_g_tx()

Bin Liu <b-liu@ti.com>
    usb: musb: host: fix potential NULL pointer dereference

SZ Lin (林上智) <sz.lin@moxa.com>
    USB: serial: option: adding support for ublox R410M

Johan Hovold <johan@kernel.org>
    USB: serial: option: reimplement interface masking

Alan Stern <stern@rowland.harvard.edu>
    USB: Accept bulk endpoints with 1024-byte maxpacket

Mayank Rana <mrana@codeaurora.org>
    usb: dwc3: gadget: Fix list_del corruption in dwc3_ep_dequeue

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    USB: serial: visor: handle potential invalid device configuration

Matthew Wilcox <willy@infradead.org>
    errseq: Always report a writeback error once

Ben Hutchings <ben.hutchings@codethink.co.uk>
    test_firmware: fix setting old custom fw path back on exit, second try

Sean Paul <seanpaul@chromium.org>
    drm/bridge: vga-dac: Fix edid memory leak

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix a buffer object leak

Bharat Potnuri <bharat@chelsio.com>
    iw_cxgb4: Atomically flush per QP HW CQEs

Sebastian Sanchez <sebastian.sanchez@intel.com>
    IB/hfi1: Fix NULL pointer dereference when invalid num_vls is used

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/hfi1: Fix loss of BECN with AHG

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/hfi1: Fix handling of FECN marked multicast packet

Danit Goldberg <danitg@mellanox.com>
    IB/mlx5: Use unlimited rate when static rate is not supported

SZ Lin (林上智) <sz.lin@moxa.com>
    NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Protect from shift operand overflow

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Fix multiple NULL-ptr deref errors in rereg_mr flow

Roland Dreier <roland@purestorage.com>
    RDMA/ucma: Allow resolving address w/o specifying source address

Raju Rangoju <rajur@chelsio.com>
    RDMA/cxgb4: release hw resources on device removal

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: prevent creating negative-sized file via INSERT_RANGE

Ping-Ke Shih <pkshih@realtek.com>
    rtlwifi: cleanup 8723be ant_sel definition

Ping-Ke Shih <pkshih@realtek.com>
    rtlwifi: btcoex: Add power_on_setting routine

Vittorio Gambaletta (VittGam) <linuxbugs@vittgam.net>
    Input: atmel_mxt_ts - add touchpad button mapping for Samsung Chromebook Pro

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: leds - fix out of bound access

Bryant G Ly <bryantly@linux.vnet.ibm.com>
    scsi: target: Fix fortify_panic kernel exception

Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    tracepoint: Do not warn on ENOMEM

Takashi Iwai <tiwai@suse.de>
    ALSA: aloop: Add missing cable lock to ctl API callbacks

Robert Rosengren <robert.rosengren@axis.com>
    ALSA: aloop: Mark paused device as inactive

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: dice: fix kernel NULL pointer dereference due to invalid calculation for array index

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Check PCM state at xfern compat ioctl

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Fix incorrect usage of IS_REACHABLE()

Kristian Evensen <kristian.evensen@gmail.com>
    USB: serial: option: Add support for Quectel EP06

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    ACPI / button: make module loadable when booted in non-ACPI mode

LEROY Christophe <christophe.leroy@c-s.fr>
    crypto: talitos - fix IPsec cipher in length

Tejun Heo <tj@kernel.org>
    percpu: include linux/sched.h for cond_resched()

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    net: don't call update_pmtu unconditionally

Xin Long <lucien.xin@gmail.com>
    geneve: update skb dst pmtu on tx path


-------------

Diffstat:

 Makefile                                           |   4 +-
 drivers/acpi/button.c                              |  24 +-
 drivers/crypto/talitos.c                           |  41 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c              |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   1 +
 drivers/infiniband/core/ucma.c                     |   2 +-
 drivers/infiniband/hw/cxgb4/cq.c                   |  11 +-
 drivers/infiniband/hw/cxgb4/device.c               |   9 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h             |   6 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |   4 +-
 drivers/infiniband/hw/cxgb4/resource.c             |  26 +-
 drivers/infiniband/hw/hfi1/driver.c                |  19 +-
 drivers/infiniband/hw/hfi1/hfi.h                   |   8 +-
 drivers/infiniband/hw/hfi1/init.c                  |   2 +
 drivers/infiniband/hw/hfi1/pcie.c                  |   3 -
 drivers/infiniband/hw/hfi1/ruc.c                   |  50 ++-
 drivers/infiniband/hw/hfi1/ud.c                    |   4 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  32 +-
 drivers/infiniband/hw/mlx5/qp.c                    |  22 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |   3 +-
 drivers/input/input-leds.c                         |   8 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |   9 +
 drivers/irqchip/qcom-irq-combiner.c                |   4 +-
 drivers/net/geneve.c                               |  14 +
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/vxlan.c                                |   6 +-
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c       |  15 -
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.h       |   1 +
 .../wireless/realtek/rtlwifi/btcoexist/rtl_btc.c   |   6 +
 .../wireless/realtek/rtlwifi/btcoexist/rtl_btc.h   |   1 +
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |  11 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   6 +
 drivers/platform/x86/asus-wireless.c               |   4 +-
 drivers/target/target_core_iblock.c                |   8 +-
 drivers/usb/core/config.c                          |   4 +-
 drivers/usb/dwc3/gadget.c                          |   2 +-
 drivers/usb/musb/musb_gadget.c                     |   3 +-
 drivers/usb/musb/musb_host.c                       |   4 +-
 drivers/usb/serial/option.c                        | 448 ++++++++-------------
 drivers/usb/serial/visor.c                         |  69 ++--
 fs/xfs/xfs_file.c                                  |  14 +-
 include/net/dst.h                                  |   8 +
 kernel/trace/trace_uprobe.c                        |  24 +-
 kernel/tracepoint.c                                |   4 +-
 lib/errseq.c                                       |  25 +-
 mm/percpu.c                                        |   1 +
 net/ipv4/ip_tunnel.c                               |   3 +-
 net/ipv4/ip_vti.c                                  |   2 +-
 net/ipv6/ip6_tunnel.c                              |   5 +-
 net/ipv6/ip6_vti.c                                 |   2 +-
 net/ipv6/sit.c                                     |   4 +-
 sound/core/pcm_compat.c                            |   2 +
 sound/core/seq/seq_virmidi.c                       |   4 +-
 sound/drivers/aloop.c                              |  29 +-
 sound/firewire/amdtp-stream.c                      |   5 +-
 sound/pci/hda/patch_realtek.c                      |   2 +-
 tools/testing/selftests/firmware/fw_filesystem.sh  |   6 +-
 57 files changed, 547 insertions(+), 492 deletions(-)
