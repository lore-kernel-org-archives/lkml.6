Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqxpXhrh8azB7MZRUN6jZ+fu12XQ+HtkjdJCtUKwqRMsIakS7gK32tyJn8ZPSuRlZl0Ln0l
ARC-Seal: i=1; a=rsa-sha256; t=1525767139; cv=none;
        d=google.com; s=arc-20160816;
        b=v4G/fQEOuKG8bbgRrWYxIhZmCubmV+j0amEw66GVu6YurY2EItK7xQkto811prxrRv
         oCIRHt2tbjSELSy5JOCGmoocAzDKvarhIZk2ILtyMYzKc91/OC+47daoDjQpac0tv15F
         xcADQbunYMhpAQ6H8b+eJorTOfFfoYrEossX079PSOHHaLNjMgsUocjDxB3pCNVyG+Za
         rv5P6ApUmQehujRn/68qGOn4ydt+183czqIp3Au6zLRfHchwzcUckkFo763GyGHi48p4
         ljrwEia3N93hqtI57MJ9gskNHie0x9NFmyQbGoNVAjCEfQdzx9PPtWY6APXKJRlFBJD9
         VuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=abUSOtTarE/ODmh64XqYLyBL50Td72ILTjG/TUq5vrA=;
        b=qRH1iXOkI3rMPfBFtw/x0WRbLqZInavjSLWl9WFb1QsvAoMzcSTOmbDj3QIfsSJ3f9
         D4XUvC858xcZ9ox5bcfegh69Slmcno7Nm0hpB74yq4iBKCx0JbCUJGquZzq5DiyX66ct
         1WnXCmbvKLqNU0cDKglwuBHQIVwdZYfLXtOCG2fGPYkzrTLs8W3Uy+gpVTwZ/8o6bH9h
         k45eOjKb7EX1WJEajKAm2EG2FaFj3YdrK7lO9DCsN8tIWEJ3bMFTnzx69JVs8HfX7UDa
         GLY5KAVHAFUns1985oGWGWe1TaAi5DoD1l+jXaopm+mH+Wlyr735cbl9b0U/JL103Np8
         OOxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bQdVf7JK;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bQdVf7JK;
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
Subject: [PATCH 4.16 00/52] 4.16.8-stable review
Date: Tue,  8 May 2018 10:09:58 +0200
Message-Id: <20180508073928.058320984@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.8-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.16.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.16.8-rc1
X-KernelTest-Deadline: 2018-05-10T07:39+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882803803541095?=
X-GMAIL-MSGID: =?utf-8?q?1599882803803541095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.16.8 release.
There are 52 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu May 10 07:38:51 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.8-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.16.8-rc1

Song Liu <songliubraving@fb.com>
    tracing: Fix bad use of igrab in trace_uprobe.c

Peter Zijlstra <peterz@infradead.org>
    clocksource: Consistent de-rate when marking unstable

Peter Zijlstra <peterz@infradead.org>
    clocksource: Initialize cs->wd_list

Peter Zijlstra <peterz@infradead.org>
    clocksource: Allow clocksource_mark_unstable() on unregistered clocksources

Agustin Vega-Frias <agustinv@codeaurora.org>
    irqchip/qcom: Fix check for spurious interrupts

Peter Zijlstra <peterz@infradead.org>
    x86/tsc: Fix mark_tsc_unstable()

Peter Zijlstra <peterz@infradead.org>
    x86/tsc: Always unregister clocksource_tsc_early

Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
    KVM: x86: remove APIC Timer periodic/oneshot spikes

Mario Limonciello <mario.limonciello@dell.com>
    platform/x86: Kconfig: Fix dell-laptop dependency chain.

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

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix use-after-free in xhci_free_virt_device

Ben Hutchings <ben.hutchings@codethink.co.uk>
    test_firmware: fix setting old custom fw path back on exit, second try

Sean Paul <seanpaul@chromium.org>
    drm/bridge: vga-dac: Fix edid memory leak

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix a buffer object leak

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/vc4: Make sure vc4_bo_{inc,dec}_usecnt() calls are balanced

ethanwu <ethanwu@synology.com>
    btrfs: Take trans lock before access running trans in check_delayed_ref

Bharat Potnuri <bharat@chelsio.com>
    iw_cxgb4: Atomically flush per QP HW CQEs

Sebastian Sanchez <sebastian.sanchez@intel.com>
    IB/hfi1: Fix NULL pointer dereference when invalid num_vls is used

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/hfi1: Fix loss of BECN with AHG

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/hfi1: Fix handling of FECN marked multicast packet

Randy Dunlap <rdunlap@infradead.org>
    infiniband: mlx5: fix build errors when INFINIBAND_USER_ACCESS=m

Danit Goldberg <danitg@mellanox.com>
    IB/mlx5: Use unlimited rate when static rate is not supported

SZ Lin (林上智) <sz.lin@moxa.com>
    NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Protect from shift operand overflow

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx4: Add missed RSS hash inner header flag

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Fix multiple NULL-ptr deref errors in rereg_mr flow

Roland Dreier <roland@purestorage.com>
    RDMA/ucma: Allow resolving address w/o specifying source address

Raju Rangoju <rajur@chelsio.com>
    RDMA/cxgb4: release hw resources on device removal

Jiri Slaby <jslaby@suse.cz>
    tools: power/acpi, revert to LD = gcc

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: prevent creating negative-sized file via INSERT_RANGE

Ping-Ke Shih <pkshih@realtek.com>
    rtlwifi: cleanup 8723be ant_sel definition

Michel Dänzer <michel.daenzer@amd.com>
    swiotlb: fix inversed DMA_ATTR_NO_WARN test

Vittorio Gambaletta (VittGam) <linuxbugs@vittgam.net>
    Input: atmel_mxt_ts - add touchpad button mapping for Samsung Chromebook Pro

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: leds - fix out of bound access

Bryant G Ly <bryantly@linux.vnet.ibm.com>
    scsi: target: Fix fortify_panic kernel exception

Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    tracepoint: Do not warn on ENOMEM

Matthew Wilcox <willy@infradead.org>
    errseq: Always report a writeback error once

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

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: Add work around for Arm Cortex-A55 Erratum 1024718

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    ACPI / button: make module loadable when booted in non-ACPI mode


-------------

Diffstat:

 Documentation/arm64/silicon-errata.txt             |   1 +
 Makefile                                           |   4 +-
 arch/arm64/Kconfig                                 |  14 +
 arch/arm64/include/asm/assembler.h                 |  40 ++
 arch/arm64/include/asm/cputype.h                   |   2 +
 arch/arm64/mm/proc.S                               |   5 +
 arch/x86/kernel/tsc.c                              |  22 +-
 arch/x86/kvm/lapic.c                               |  37 +-
 drivers/acpi/button.c                              |  24 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c              |   4 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     |  46 ++-
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
 drivers/infiniband/hw/mlx4/qp.c                    |   3 +-
 drivers/infiniband/hw/mlx5/Kconfig                 |   1 +
 drivers/infiniband/hw/mlx5/mr.c                    |  32 +-
 drivers/infiniband/hw/mlx5/qp.c                    |  22 +-
 drivers/input/input-leds.c                         |   8 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |   9 +
 drivers/irqchip/qcom-irq-combiner.c                |   4 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c       |  15 -
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |  11 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   5 +
 drivers/platform/x86/Kconfig                       |   2 +-
 drivers/platform/x86/asus-wireless.c               |   4 +-
 drivers/target/target_core_iblock.c                |   8 +-
 drivers/usb/core/config.c                          |   4 +-
 drivers/usb/dwc3/gadget.c                          |   2 +-
 drivers/usb/host/xhci.c                            |   1 +
 drivers/usb/musb/musb_gadget.c                     |   3 +-
 drivers/usb/musb/musb_host.c                       |   4 +-
 drivers/usb/serial/option.c                        | 451 +++++++--------------
 drivers/usb/serial/visor.c                         |  69 ++--
 fs/btrfs/extent-tree.c                             |   7 +
 fs/xfs/xfs_file.c                                  |  14 +-
 kernel/time/clocksource.c                          |  57 ++-
 kernel/trace/trace_uprobe.c                        |  24 +-
 kernel/tracepoint.c                                |   4 +-
 lib/errseq.c                                       |  23 +-
 lib/swiotlb.c                                      |   2 +-
 sound/core/pcm_compat.c                            |   2 +
 sound/core/seq/seq_virmidi.c                       |   4 +-
 sound/drivers/aloop.c                              |  29 +-
 sound/firewire/amdtp-stream.c                      |   5 +-
 sound/pci/hda/patch_realtek.c                      |   2 +-
 tools/power/acpi/Makefile.config                   |   1 +
 tools/testing/selftests/firmware/fw_filesystem.sh  |   6 +-
 59 files changed, 674 insertions(+), 509 deletions(-)
