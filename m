Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2268JPTMne+BQzTlFEb1ydZ4LE+T0NOLZAMqwWP1b25MP/XQZmn7JCJoTRB8O+3V8Ji0Y06G
ARC-Seal: i=1; a=rsa-sha256; t=1519676855; cv=none;
        d=google.com; s=arc-20160816;
        b=o6DrNEgvRs3lxvIg8WT0nbVh1soQC80A1mpJZE5qImX/U97L9BMnHZgbUNBeXPAwxK
         bCMquUaGrfnTjqSUZ3lT09wYYX88+Mv4tVnCKfj8E35Dc/afcjp31xAR8Y/I23T0XX/i
         8gBsVpFbTMCoRa6BcQjT4mdi1t9VK24Ni9YTrVJXRLrPp5nNKPYeKCEtQrQ/uC4QlSI2
         0EYlKA3oiYdbkx5mWh+8IUiR+TzZ3IwURDtw6EyBGP7xpkwAntE3XYz0HSe47vvsz1uM
         MTvQjD52y0AD8DoZFMb3qt+CU7MrbHLymG4D8LobnsEajYOvxsVODyB0eXD9YbcfGfEZ
         WI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pnfFWzbO5JNpDhzeKhy4g0VkOv3WHqLC27HPGUkIJdM=;
        b=It5VRI9Qh9qwFAGIeAcP9VA5D6jPPQbFc1U33x5URgKkKExjp7QHNVR2xtqrQL7fZr
         a+R0QZa6UF32c5qQgrtga4gTqWsxjqF0aXLsZfS7gXF4pbXdg7NoRtzjNYu4nPfRrD3v
         8iybgFN0zQ9UE/RVMKMdecG3JEpcsrrN84faBNyVKXOglaW08KxneFSiMjKuVEs9NTe6
         OsDNNpZKhj6H14USxJpPtbfUq2+LNBhWj7xROZnhRVXnOh3P0UFRoXNq/EI70Xxdrao9
         Gd0mlJXnhclVi2qMaK9vvOW40yZHkRCc/KwlRtckTog+T0ZfTSPhkNWK+5E8Ung5uXC+
         QRtw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.15 00/64] 4.15.7-stable review
Date: Mon, 26 Feb 2018 21:21:37 +0100
Message-Id: <20180226202153.453363333@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.15.7-rc1
X-KernelTest-Deadline: 2018-02-28T20:21+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496679131822580?=
X-GMAIL-MSGID: =?utf-8?q?1593496679131822580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.15.7 release.
There are 64 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 28 20:21:30 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.7-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.15.7-rc1

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/breadcrumbs: Ignore unsubmitted signalers

Will Deacon <will.deacon@arm.com>
    arm64: __show_regs: Only resolve kernel symbols when running at EL1

Kai-Heng Feng <kai.heng.feng@canonical.com>
    drm/amdgpu: add new device to use atpx quirk

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: Avoid leaking PM domain on driver unbind (v2)

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: add atpx quirk handling (v2)

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: only check mmBIF_IOV_FUNC_IDENTIFIER on tonga/fiji

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: Add dpm quirk for Jet PRO (v2)

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix VA hole handling on Vega10 v3

Huang Rui <ray.huang@amd.com>
    drm/amdgpu: disable MMHUB power gating on raven

Chris Wilson <chris@chris-wilson.co.uk>
    drm: Handle unexpected holes in color-eviction

Leo (Sunpeng) Li <sunpeng.li@amd.com>
    drm/atomic: Fix memleak on ERESTARTSYS during non-blocking commits

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/cirrus: Load lut in crtc_commit

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: renesas_usbhs: missed the "running" flag in usb_dmac with rx path

Jack Pham <jackp@codeaurora.org>
    usb: gadget: f_fs: Use config_ep_by_speed()

Jack Pham <jackp@codeaurora.org>
    usb: gadget: f_fs: Process all descriptors during bind

Bin Liu <b-liu@ti.com>
    Revert "usb: musb: host: don't start next rx urb if current one failed"

Karsten Koop <kkoop@ld-didactic.de>
    usb: ldusb: add PIDs for new CASSY devices supported by this driver

Fabio Estevam <fabio.estevam@nxp.com>
    usb: phy: mxs: Fix NULL pointer dereference on i.MX23/28

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: ep0: Reset TRB counter for ep0 IN

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: gadget: Set maxpacket size for ep0 IN

Peter Chen <hzpeterchen@gmail.com>
    usb: host: ehci: use correct device pointer for dma ops

Kai-Heng Feng <kai.heng.feng@canonical.com>
    drm/edid: Add 6 bpc quirk for CPT panel in Asus UX303LA

Jack Stocker <jackstocker.93@gmail.com>
    Add delay-init quirk for Corsair K70 RGB keyboards

Will Deacon <will.deacon@arm.com>
    arm64: cpufeature: Fix CTR_EL0 field definitions

Michael Weiser <michael.weiser@gmx.de>
    arm64: Disable unhandled signal log messages by default

Michael Weiser <michael.weiser@gmx.de>
    arm64: Remove unimplemented syscall log message

AMAN DEEP <aman.deep@samsung.com>
    usb: ohci: Proper handling of ed_rm_list to handle race condition between usb_kill_urb() and finish_unlinks()

Shigeru Yoshida <shigeru.yoshida@windriver.com>
    ohci-hcd: Fix race condition caused by ohci_urb_enqueue() and io_watchdog_func()

Mika Westerberg <mika.westerberg@linux.intel.com>
    net: thunderbolt: Run disconnect flow asynchronously when logout is received

Mika Westerberg <mika.westerberg@linux.intel.com>
    net: thunderbolt: Tear down connection properly on suspend

Casey Leedom <leedom@chelsio.com>
    PCI/cxgb4: Extend T3 PCI quirk to T4+ devices

Matt Redfearn <matt.redfearn@mips.com>
    irqchip/mips-gic: Avoid spuriously handling masked interrupts

Shanker Donthineni <shankerd@codeaurora.org>
    irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()

Hauke Mehrtens <hauke@hauke-m.de>
    uapi/if_ether.h: move __UAPI_DEF_ETHHDR libc define

Juergen Gross <jgross@suse.com>
    mm: don't defer struct page initialization for Xen pv guests

Huang Ying <huang.ying.caritas@gmail.com>
    mm, swap, frontswap: fix THP swap if frontswap enabled

Arnd Bergmann <arnd@arndb.de>
    x86/oprofile: Fix bogus GCC-8 warning in nmi_setup()

Thomas Gleixner <tglx@linutronix.de>
    x86/apic/vector: Handle vector release on CPU unplug correctly

Arnd Bergmann <arnd@arndb.de>
    Kbuild: always define endianess in kconfig.h

Lars-Peter Clausen <lars@metafoo.de>
    iio: adis_lib: Initialize trigger before requesting interrupt

Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>
    iio: buffer: check if a buffer has been set up when poll is called

Andreas Klinger <ak@it-klinger.de>
    iio: srf08: fix link error "devm_iio_triggered_buffer_setup" undefined

Fabrice Gasnier <fabrice.gasnier@st.com>
    iio: adc: stm32: fix stm32h7_adc_enable error handling

Leon Romanovsky <leonro@mellanox.com>
    RDMA/uverbs: Sanitize user entered port numbers prior to access it

Leon Romanovsky <leonro@mellanox.com>
    RDMA/uverbs: Fix circular locking dependency

Leon Romanovsky <leonro@mellanox.com>
    RDMA/uverbs: Fix bad unlock balance in ib_uverbs_close_xrcd

Leon Romanovsky <leonro@mellanox.com>
    RDMA/uverbs: Protect from command mask overflow

Leon Romanovsky <leonro@mellanox.com>
    RDMA/uverbs: Protect from races between lookup and destroy of uobjects

Thomas Gleixner <tglx@linutronix.de>
    genirq/matrix: Handle CPU offlining proper

Hans de Goede <hdegoede@redhat.com>
    extcon: int3496: process id-pin first so that we start with the right status

Eric Biggers <ebiggers@google.com>
    PKCS#7: fix certificate blacklisting

Eric Biggers <ebiggers@google.com>
    PKCS#7: fix certificate chain verification

Eric Biggers <ebiggers@google.com>
    X.509: fix NULL dereference when restricting key with unsupported_sig

Eric Biggers <ebiggers@google.com>
    X.509: fix BUG_ON() when hash algorithm is unsupported

Eric Anholt <eric@anholt.net>
    i2c: bcm2835: Set up the rising/falling edge delays

Ben Gardner <gardner.ben@gmail.com>
    i2c: designware: must wait for enable

Arnd Bergmann <arnd@arndb.de>
    cfg80211: fix cfg80211_beacon_dup

James Hogan <jhogan@kernel.org>
    MIPS: Drop spurious __unused in struct compat_flock

Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
    scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix high memory/reserved memory collision

Kees Cook <keescook@chromium.org>
    MIPS: boot: Define __ASSEMBLY__ for its.S build

Kees Cook <keescook@chromium.org>
    kconfig.h: Include compiler types to avoid missed struct attributes

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64: mm: don't write garbage into TTBR1_EL1 register

Paolo Abeni <pabeni@redhat.com>
    netfilter: drop outermost socket lock in getsockopt()


-------------

Diffstat:

 Makefile                                         |  4 +-
 arch/arm64/kernel/cpufeature.c                   |  6 +-
 arch/arm64/kernel/process.c                      | 11 +++-
 arch/arm64/kernel/traps.c                        | 10 +---
 arch/arm64/mm/proc.S                             |  2 +-
 arch/mips/boot/Makefile                          |  1 +
 arch/mips/include/asm/compat.h                   |  1 -
 arch/x86/kernel/apic/vector.c                    | 25 ++++++++-
 arch/x86/oprofile/nmi_int.c                      |  2 +-
 arch/xtensa/mm/init.c                            | 70 +++++++++++++++++++++---
 crypto/asymmetric_keys/pkcs7_verify.c            | 12 ++--
 crypto/asymmetric_keys/public_key.c              |  4 +-
 crypto/asymmetric_keys/restrict.c                | 21 ++++---
 drivers/extcon/extcon-intel-int3496.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 58 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           | 10 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 11 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c          |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 13 +++++
 drivers/gpu/drm/amd/amdgpu/si_dpm.c              |  5 ++
 drivers/gpu/drm/amd/amdgpu/soc15.c               |  4 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                  | 21 ++++---
 drivers/gpu/drm/cirrus/cirrus_mode.c             | 40 ++++++++------
 drivers/gpu/drm/drm_atomic_helper.c              | 15 +++++
 drivers/gpu/drm/drm_edid.c                       |  3 +
 drivers/gpu/drm/drm_mm.c                         | 21 ++++++-
 drivers/gpu/drm/i915/intel_breadcrumbs.c         | 29 ++++------
 drivers/hid/hid-core.c                           |  3 +
 drivers/hid/hid-ids.h                            |  3 +
 drivers/i2c/busses/i2c-bcm2835.c                 | 21 ++++++-
 drivers/i2c/busses/i2c-designware-master.c       |  2 +-
 drivers/iio/adc/stm32-adc.c                      |  7 ++-
 drivers/iio/imu/adis_trigger.c                   |  7 ++-
 drivers/iio/industrialio-buffer.c                |  2 +-
 drivers/iio/proximity/Kconfig                    |  2 +
 drivers/infiniband/core/rdma_core.c              | 10 +++-
 drivers/infiniband/core/uverbs_cmd.c             | 16 ++++--
 drivers/infiniband/core/uverbs_main.c            | 27 ++++++---
 drivers/irqchip/irq-gic-v3.c                     |  2 +-
 drivers/irqchip/irq-mips-gic.c                   |  2 -
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c       | 10 ----
 drivers/net/thunderbolt.c                        | 19 +++++--
 drivers/pci/quirks.c                             | 39 +++++++------
 drivers/scsi/ibmvscsi/ibmvfc.h                   |  2 +-
 drivers/usb/core/quirks.c                        |  3 +
 drivers/usb/dwc3/ep0.c                           |  7 ++-
 drivers/usb/dwc3/gadget.c                        |  2 +
 drivers/usb/gadget/function/f_fs.c               | 44 +++------------
 drivers/usb/host/ehci-hub.c                      |  4 +-
 drivers/usb/host/ohci-hcd.c                      | 10 +++-
 drivers/usb/host/ohci-hub.c                      |  4 +-
 drivers/usb/host/ohci-q.c                        | 17 +++---
 drivers/usb/misc/ldusb.c                         |  6 ++
 drivers/usb/musb/musb_host.c                     |  8 +--
 drivers/usb/phy/phy-mxs-usb.c                    |  3 +
 drivers/usb/renesas_usbhs/fifo.c                 |  5 ++
 drivers/xen/tmem.c                               |  4 ++
 include/drm/drm_atomic.h                         |  9 +++
 include/linux/kconfig.h                          |  9 +++
 include/uapi/linux/if_ether.h                    |  6 +-
 include/uapi/linux/libc-compat.h                 |  6 --
 kernel/irq/matrix.c                              | 23 +++++---
 mm/page_alloc.c                                  |  4 ++
 mm/zswap.c                                       |  6 ++
 net/ipv4/ip_sockglue.c                           |  7 +--
 net/ipv6/ipv6_sockglue.c                         | 10 +---
 net/mac80211/cfg.c                               |  2 +-
 68 files changed, 530 insertions(+), 251 deletions(-)
