Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224mD+u1x/FJHnSj2TVjpbSgKAWZG0c2o6OZvBoHyZD0GGfoNR4ucYKl+PpWndsQXrHzdD8p
ARC-Seal: i=1; a=rsa-sha256; t=1519676461; cv=none;
        d=google.com; s=arc-20160816;
        b=07CdQgc4ivU2uZY9BtpdvIY7pOvMSiYCfUG+qhako5eA4/b2zSpD4itpP0t4n7FVPD
         7vwNQzye3nzTeQ9oZAEUNFTLngN0TSmS73jNJ7cTTJX9ShwADnNxh4ZbO8NrgNcfS2va
         PVIDwRG0SQc2i9FDEV5LBubrmlpc0JnxJq6Pr+fNydtcRejhnhA6g8SgkvdK8Roscq7q
         7I2HQWfTkXp1IoRvLMcvLFjEQxu0cBESy8OS4cYYo0sqYlrV6ZvAXoriIykVUi1Rfem4
         a+6v5q2AsF7+S1f3fgl91Lldj2Sh0KxY2UjCi9LjF2RPmC8yKo8EOX9TQK9A6gzjQnXU
         Sk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TnH4SxQJUBl1vYxlmBzk+BFVMI/cNzozBaT+1yf3PMo=;
        b=JoYHONHwvMoQZBuwFFjqjOVlsLh/6gRDs/ZnfykCVHAMVDfjmq2ifjKufdKDgqqEVa
         xngv8lwYsFkg8ddHQIyOJRthqrAhn5BKOoVojLI3Y52xaP5ITRNl47mnkQ5Htwo49eWw
         a49gz+vEiXCD0bfZsLTNf+tMdOb5wVV1b21qo8FrzrTTHS2Q3yjWjdNRw2If/lUndSdb
         4Kut3Vg5BLUjP/s9u+/Ha3II46cXNENNvRQcrFxhFujvwl2313sxGkJoIr1oh5VhUfoY
         jCDwcYLsBT+so26bGOcUrmPOByyCOR43whDzeJmHE82wjRs+bGwwTFk6Xz9LgxsxLVk8
         r8Rw==
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
Subject: [PATCH 4.9 00/39] 4.9.85-stable review
Date: Mon, 26 Feb 2018 21:20:21 +0100
Message-Id: <20180226201643.660109883@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.85-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.85-rc1
X-KernelTest-Deadline: 2018-02-28T20:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496265865352156?=
X-GMAIL-MSGID: =?utf-8?q?1593496265865352156?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.85 release.
There are 39 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 28 20:16:31 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.85-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.85-rc1

Dan Williams <dan.j.williams@intel.com>
    x86/entry/64: Clear extra registers beyond syscall arguments, to reduce speculation attack surface

Dan Williams <dan.j.williams@intel.com>
    mm: fail get_vaddr_frames() for filesystem-dax mappings

Jan H. Schönherr <jschoenh@amazon.de>
    mm: Fix devm_memremap_pages() collision handling

Dan Williams <dan.j.williams@intel.com>
    libnvdimm, dax: fix 1GB-aligned namespaces vs physical misalignment

Dan Williams <dan.j.williams@intel.com>
    IB/core: disable memory registration of filesystem-dax vmas

Dan Williams <dan.j.williams@intel.com>
    v4l2: disable filesystem-dax mapping support

Dan Williams <dan.j.williams@intel.com>
    mm: introduce get_user_pages_longterm

Dan Williams <dan.j.williams@intel.com>
    device-dax: implement ->split() to catch invalid munmap attempts

Dan Williams <dan.j.williams@intel.com>
    libnvdimm: fix integer overflow static analysis warning

Jan Kara <jack@suse.cz>
    fs/dax.c: fix inefficiency in dax_writeback_mapping_range()

Ross Zwisler <ross.zwisler@linux.intel.com>
    mm: avoid spurious 'bad pmd' warning messages

Eric Biggers <ebiggers@google.com>
    X.509: fix NULL dereference when restricting key with unsupported_sig

Eric Biggers <ebiggers@google.com>
    binder: add missing binder_unlock()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    drm/amdgpu: add new device to use atpx quirk

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: Avoid leaking PM domain on driver unbind (v2)

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: add atpx quirk handling (v2)

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: Add dpm quirk for Jet PRO (v2)

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: renesas_usbhs: missed the "running" flag in usb_dmac with rx path

Jack Pham <jackp@codeaurora.org>
    usb: gadget: f_fs: Process all descriptors during bind

Bin Liu <b-liu@ti.com>
    Revert "usb: musb: host: don't start next rx urb if current one failed"

Karsten Koop <kkoop@ld-didactic.de>
    usb: ldusb: add PIDs for new CASSY devices supported by this driver

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: gadget: Set maxpacket size for ep0 IN

Kai-Heng Feng <kai.heng.feng@canonical.com>
    drm/edid: Add 6 bpc quirk for CPT panel in Asus UX303LA

Jack Stocker <jackstocker.93@gmail.com>
    Add delay-init quirk for Corsair K70 RGB keyboards

Michael Weiser <michael.weiser@gmx.de>
    arm64: Disable unhandled signal log messages by default

AMAN DEEP <aman.deep@samsung.com>
    usb: ohci: Proper handling of ed_rm_list to handle race condition between usb_kill_urb() and finish_unlinks()

Shigeru Yoshida <shigeru.yoshida@windriver.com>
    ohci-hcd: Fix race condition caused by ohci_urb_enqueue() and io_watchdog_func()

Casey Leedom <leedom@chelsio.com>
    PCI/cxgb4: Extend T3 PCI quirk to T4+ devices

Shanker Donthineni <shankerd@codeaurora.org>
    irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()

Arnd Bergmann <arnd@arndb.de>
    x86/oprofile: Fix bogus GCC-8 warning in nmi_setup()

Lars-Peter Clausen <lars@metafoo.de>
    iio: adis_lib: Initialize trigger before requesting interrupt

Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>
    iio: buffer: check if a buffer has been set up when poll is called

Leon Romanovsky <leonro@mellanox.com>
    RDMA/uverbs: Protect from command mask overflow

Eric Biggers <ebiggers@google.com>
    PKCS#7: fix certificate chain verification

Eric Biggers <ebiggers@google.com>
    X.509: fix BUG_ON() when hash algorithm is unsupported

Arnd Bergmann <arnd@arndb.de>
    cfg80211: fix cfg80211_beacon_dup

Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
    scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix high memory/reserved memory collision

Paolo Abeni <pabeni@redhat.com>
    netfilter: drop outermost socket lock in getsockopt()


-------------

Diffstat:

 Makefile                                         |  4 +-
 arch/arm64/kernel/traps.c                        |  2 +-
 arch/x86/entry/entry_64.S                        | 13 +++++
 arch/x86/oprofile/nmi_int.c                      |  2 +-
 arch/xtensa/mm/init.c                            | 70 +++++++++++++++++++++---
 crypto/asymmetric_keys/pkcs7_verify.c            |  2 +-
 crypto/asymmetric_keys/public_key.c              |  4 +-
 crypto/asymmetric_keys/restrict.c                |  7 ++-
 drivers/android/binder.c                         |  4 +-
 drivers/dax/dax.c                                | 12 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 58 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  2 -
 drivers/gpu/drm/amd/amdgpu/si_dpm.c              |  5 ++
 drivers/gpu/drm/drm_edid.c                       |  3 +
 drivers/hid/hid-core.c                           |  3 +
 drivers/hid/hid-ids.h                            |  3 +
 drivers/iio/imu/adis_trigger.c                   |  7 ++-
 drivers/iio/industrialio-buffer.c                |  2 +-
 drivers/infiniband/core/umem.c                   |  2 +-
 drivers/infiniband/core/uverbs_main.c            | 27 ++++++---
 drivers/irqchip/irq-gic-v3.c                     |  2 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c        |  5 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c       | 10 ----
 drivers/nvdimm/bus.c                             | 11 ++--
 drivers/nvdimm/pfn_devs.c                        | 15 ++++-
 drivers/pci/quirks.c                             | 39 +++++++------
 drivers/scsi/ibmvscsi/ibmvfc.h                   |  2 +-
 drivers/usb/core/quirks.c                        |  3 +
 drivers/usb/dwc3/gadget.c                        |  2 +
 drivers/usb/gadget/function/f_fs.c               |  6 +-
 drivers/usb/host/ohci-hcd.c                      | 10 +++-
 drivers/usb/host/ohci-hub.c                      |  4 +-
 drivers/usb/host/ohci-q.c                        | 17 +++---
 drivers/usb/misc/ldusb.c                         |  6 ++
 drivers/usb/musb/musb_host.c                     |  8 +--
 drivers/usb/renesas_usbhs/fifo.c                 |  5 ++
 fs/dax.c                                         |  1 +
 include/linux/dax.h                              |  5 --
 include/linux/fs.h                               | 20 +++++++
 include/linux/kernel.h                           |  1 +
 include/linux/mm.h                               | 13 +++++
 kernel/memremap.c                                | 13 +++--
 mm/frame_vector.c                                | 12 ++++
 mm/gup.c                                         | 64 ++++++++++++++++++++++
 mm/memory.c                                      | 40 ++++++++++----
 net/ipv4/ip_sockglue.c                           |  7 +--
 net/ipv6/ipv6_sockglue.c                         | 10 +---
 net/mac80211/cfg.c                               |  2 +-
 48 files changed, 433 insertions(+), 132 deletions(-)
