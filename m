Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoMwQXFpwYClWTX8p2rWhJTmofkrR+2zYg2cnN8sYWI/+UoCiiArIpsuAbqDKOVt5M6pZWr
ARC-Seal: i=1; a=rsa-sha256; t=1525767400; cv=none;
        d=google.com; s=arc-20160816;
        b=z8+RWG8hw9i1/hMUw7juGfOstnFRTgARZChzuU45GGOivi+5m2/0TJtEerPjWRHOUL
         4D2m8Ndq3pAysKkNTLGFSq6vOu4JtrkoeIbYR3YFzEkpChqNEnc7BUwGlgQuIkTCqTh0
         3cUVghNmoXpwtcqAPg+aJAVUEWN2b3saVgGS86lcLHGRHTBaWmcro7dFdzXGNTyi1PXc
         VGtdhI8bZm9G7+lBt/96UQ0Yf0n3wdyedwt5g77EuWuES7+uzPwJLiVCdwDT1BXjKrEx
         jHcqiY/5Hlz5TWc0QDrqGR53Aoly7oLzo/LuF/LAI9TajVtaGUcYZwHfSJqJ+5h38miv
         +ydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Sy6X7s8sr+hXZfqFEh4gOqoSvSXfatJFtDzxFGP+54k=;
        b=gNBjsM6WPDv0T794yUGG3CEkExr4BWP5xozm9cjxMN7c1dVOm7bntjJ6RGMqt9AMFh
         i5iZhoCHQ4dWdI33PtxYyVL1qsscfO+4NNP8UlFEISvK+pyvO+rvciyPPnuR/Zm2R4E0
         pnXm1EhZaTf6gs0hhxDjQEpEnGnPIVKDT2g7uh26zMbqkwniOduclYFT82k2gq7t5HOk
         6mEH81g5acKhOT6LBet8fUdzwDk0AjqkshcpOHtOoHX6DrH7y9DjXtfjFwIy8ujbiQV3
         hkLuhreN77wYFba/kEWqG9486aVn2FqPwy6zXQW3hNqRsroMShcKLXll/nN4tMFs7hWm
         1vvw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NI6HGwOE;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NI6HGwOE;
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
Subject: [PATCH 4.9 00/32] 4.9.99-stable review
Date: Tue,  8 May 2018 10:10:40 +0200
Message-Id: <20180508074008.800421598@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.99-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.99-rc1
X-KernelTest-Deadline: 2018-05-10T07:40+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599883077500588538?=
X-GMAIL-MSGID: =?utf-8?q?1599883077500588538?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.99 release.
There are 32 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu May 10 07:39:44 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.99-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.99-rc1

Heiko Carstens <heiko.carstens@de.ibm.com>
    s390/facilites: use stfle_fac_list array size for MAX_FACILITY_BIT

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

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    USB: serial: visor: handle potential invalid device configuration

Ben Hutchings <ben.hutchings@codethink.co.uk>
    test_firmware: fix setting old custom fw path back on exit, second try

Sean Paul <seanpaul@chromium.org>
    drm/bridge: vga-dac: Fix edid memory leak

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix a buffer object leak

Sebastian Sanchez <sebastian.sanchez@intel.com>
    IB/hfi1: Fix NULL pointer dereference when invalid num_vls is used

Danit Goldberg <danitg@mellanox.com>
    IB/mlx5: Use unlimited rate when static rate is not supported

SZ Lin (林上智) <sz.lin@moxa.com>
    NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Protect from shift operand overflow

Roland Dreier <roland@purestorage.com>
    RDMA/ucma: Allow resolving address w/o specifying source address

Raju Rangoju <rajur@chelsio.com>
    RDMA/cxgb4: release hw resources on device removal

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: prevent creating negative-sized file via INSERT_RANGE

Vittorio Gambaletta (VittGam) <linuxbugs@vittgam.net>
    Input: atmel_mxt_ts - add touchpad button mapping for Samsung Chromebook Pro

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: leds - fix out of bound access

Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    tracepoint: Do not warn on ENOMEM

Takashi Iwai <tiwai@suse.de>
    ALSA: aloop: Add missing cable lock to ctl API callbacks

Robert Rosengren <robert.rosengren@axis.com>
    ALSA: aloop: Mark paused device as inactive

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Check PCM state at xfern compat ioctl

Kristian Evensen <kristian.evensen@gmail.com>
    USB: serial: option: Add support for Quectel EP06

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: imx: ensure UCR3 and UFCR are setup correctly

LEROY Christophe <christophe.leroy@c-s.fr>
    crypto: talitos - fix IPsec cipher in length

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: KVM: Add PSCI version selection API

Teng Qin <qinteng@fb.com>
    bpf: map_get_next_key to return first key on NULL

Tejun Heo <tj@kernel.org>
    percpu: include linux/sched.h for cond_resched()

Tan Xiaojun <tanxiaojun@huawei.com>
    perf/core: Fix the perf_cpu_time_max_percent check


-------------

Diffstat:

 Documentation/virtual/kvm/api.txt                 |   9 +-
 Documentation/virtual/kvm/arm/psci.txt            |  30 ++
 Makefile                                          |   4 +-
 arch/arm/include/asm/kvm_host.h                   |   3 +
 arch/arm/include/uapi/asm/kvm.h                   |   6 +
 arch/arm/kvm/guest.c                              |  13 +
 arch/arm/kvm/psci.c                               |  60 +++
 arch/arm64/include/asm/kvm_host.h                 |   3 +
 arch/arm64/include/uapi/asm/kvm.h                 |   6 +
 arch/arm64/kvm/guest.c                            |  14 +-
 arch/s390/include/asm/facility.h                  |   2 +-
 drivers/crypto/talitos.c                          |  41 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c             |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c               |   1 +
 drivers/infiniband/core/ucma.c                    |   2 +-
 drivers/infiniband/hw/cxgb4/device.c              |   9 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h            |   4 +
 drivers/infiniband/hw/cxgb4/resource.c            |  26 +-
 drivers/infiniband/hw/hfi1/init.c                 |   2 +
 drivers/infiniband/hw/hfi1/pcie.c                 |   3 -
 drivers/infiniband/hw/mlx5/qp.c                   |  22 +-
 drivers/input/input-leds.c                        |   8 +-
 drivers/input/touchscreen/atmel_mxt_ts.c          |   9 +
 drivers/net/usb/qmi_wwan.c                        |   1 +
 drivers/platform/x86/asus-wireless.c              |   4 +-
 drivers/tty/serial/imx.c                          |  14 +-
 drivers/usb/core/config.c                         |   4 +-
 drivers/usb/musb/musb_gadget.c                    |   3 +-
 drivers/usb/musb/musb_host.c                      |   4 +-
 drivers/usb/serial/option.c                       | 448 ++++++++--------------
 drivers/usb/serial/visor.c                        |  69 ++--
 fs/xfs/xfs_file.c                                 |  14 +-
 include/kvm/arm_psci.h                            |  16 +-
 kernel/bpf/arraymap.c                             |   2 +-
 kernel/bpf/hashtab.c                              |   9 +-
 kernel/bpf/syscall.c                              |  20 +-
 kernel/events/core.c                              |   2 +-
 kernel/tracepoint.c                               |   4 +-
 mm/percpu.c                                       |   1 +
 sound/core/pcm_compat.c                           |   2 +
 sound/core/seq/seq_virmidi.c                      |   4 +-
 sound/drivers/aloop.c                             |  29 +-
 tools/testing/selftests/firmware/fw_filesystem.sh |   6 +-
 43 files changed, 530 insertions(+), 407 deletions(-)
