Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvWOeQTsNozZh1K9AjceupIS91+ufRPfXrqUACI71BjYIY50sSCL+dxN8ZEdODHceCExS+k
ARC-Seal: i=1; a=rsa-sha256; t=1521800272; cv=none;
        d=google.com; s=arc-20160816;
        b=AqHkQG68yuvMtlAWa49zu+9TtNsw9D+HhDpH6vB9XPFTF68usjDbTN5TUQW+pwm0tV
         Y565c4BHec587g7D7mJE3wrpl/ar8kegA47ErZgudZjIfU8YG419x/IfG1Knj/No+02m
         QoPx50PoEpkZgACtie4Z93hMoeZ5pYXvlkB3coVz0T8oHXcNCc5imKOy71aMf8GZFind
         9/SBuDXIagd63YnQiKH9q8cv4+VXb2ATv7YOuL+l8Eo2dFtvDVRo1lwXBrJlEpdAuLQ9
         EiO6TOz7KjG2FuG+KwZinjb2Ddm9/vcBNdLZEJS6tHoI6ohHkZLtIn78YptRGr8/ousH
         +XDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=FhENn/cIRJkoW0E6QtoVBAgXmvJ9IIPjhraO7f2vy7U=;
        b=z4K6myrtj/DcNEUh4lgwMx2ENEgpwVM6Qi1M9A1hXgV4OAOwQPLkiOpKDmPMDG0RmC
         tNfoTG8FV3DfdR4ePOG6RN3rReHxakIYbnZyYcDPafy834upvdLDnhpjS+gq1/M6Enlj
         JSvLrzFCw/axHWSXqUWZSOJ7nTM5KRgy7KX0qRgzbF+GHju9sPhGJSoCbGqiNMi+GCMr
         ycJtzU7OjGi5yMWIoULvOcWq/OvtLXSHyyqi6fTgGD2qV/d/r0/u0QG5eh56+/iHQfI+
         B1y+PPebhQ5KxIPqzTHlWI0+BFOfxTxhBWCp+RgUMsKXazvAspSzHepauqzglqZ0biim
         KDWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 3.18 00/47] 3.18.102-stable review
Date: Fri, 23 Mar 2018 10:54:51 +0100
Message-Id: <20180323094248.117679641@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.102-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.102-rc1
X-KernelTest-Deadline: 2018-03-25T09:42+00:00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595723242372704468?=
X-GMAIL-MSGID: =?utf-8?q?1595723242372704468?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.102 release.
There are 47 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 25 09:42:36 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.102-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.102-rc1

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Fix access to non-initialized CM_ID object

Sergej Sawazki <sergej@taudac.com>
    clk: si5351: Rename internal plls to avoid name collisions

Florian Fainelli <f.fainelli@gmail.com>
    pinctrl: Really force states during suspend/resume

Peter Ujfalusi <peter.ujfalusi@ti.com>
    drm/omap: DMM: Check for DMM readiness after successful transaction commit

Bjorn Helgaas <bhelgaas@google.com>
    vgacon: Set VGA struct resource types

Parav Pandit <parav@mellanox.com>
    RDMA/cma: Use correct size when writing netlink stats

Erez Shitrit <erezsh@mellanox.com>
    IB/ipoib: Avoid memory leak if the SA returns a different DGID

Daniel Drake <drake@endlessm.com>
    mmc: avoid removing non-removable hosts during suspend

Ron Economos <w6rz@comcast.net>
    media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    media: bt8xx: Fix err 'bt878_probe()'

Prakash Kamliya <pkamliya@codeaurora.org>
    drm/msm: fix leak in failed get_pages

Dan Carpenter <dan.carpenter@oracle.com>
    cifs: small underflow in cnvrtDosUnixTm()

Alexey Khoroshilov <khoroshilov@ispras.ru>
    sm501fb: don't return zero on failure path in sm501fb_start()

Maksim Salau <maksim.salau@gmail.com>
    video: fbdev: udlfb: Fix buffer on stack

Sergei Trofimovich <slyfox@gentoo.org>
    ia64: fix module loading for gcc-5.4

Shaohua Li <shli@fb.com>
    md/raid10: skip spare disk as 'first' disk

Michael Trimarchi <michael@amarulasolutions.com>
    power: supply: pda_power: move from timer to delayed_work

Scott Wood <swood@redhat.com>
    bnx2x: Align RX buffers

Robert Lippert <roblip@gmail.com>
    ipmi/watchdog: fix wdog hang on panic waiting for ipmi response

Kishon Vijay Abraham I <kishon@ti.com>
    ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP

Keerthy <j-keerthy@ti.com>
    mfd: palmas: Reset the POWERHOLD mux during power off

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: don't parse encrypted management frames in ieee80211_frame_acked

Filipe Manana <fdmanana@suse.com>
    Btrfs: send, fix file hole not being preserved due to inline extent

Pan Bian <bianpan2016@163.com>
    rndis_wlan: add return value validation

Finn Thain <fthain@telegraphics.com.au>
    scsi: mac_esp: Replace bogus memory barrier with spinlock

Pan Bian <bianpan2016@163.com>
    qlcnic: fix unchecked return value

Pan Bian <bianpan2016@163.com>
    wan: pc300too: abort path on failure

Dan Carpenter <dan.carpenter@oracle.com>
    mmc: host: omap_hsmmc: checking for NULL instead of IS_ERR()

James Smart <jsmart2021@gmail.com>
    Fix driver usage of 128B WQEs when WQ_CREATE is V1.

Dan Carpenter <dan.carpenter@oracle.com>
    HSI: ssi_protocol: double free in ssip_pn_xmit()

Feras Daoud <ferasda@mellanox.com>
    IB/ipoib: Update broadcast object if PKey value was changed in index 0

Mikhail Paulyshka <me@mixaill.tk>
    ALSA: hda - Fix headset microphone detection for ASUS N551 and N751

Bernd Faust <berndfaust@gmail.com>
    e1000e: fix timing for 82579 Gigabit Ethernet controller

Eric Dumazet <edumazet@google.com>
    tcp: remove poll() flakes with FastOpen

Alexey Kardashevskiy <aik@ozlabs.ru>
    KVM: PPC: Book3S PR: Exit KVM on failed mapping

David Gibson <david@gibson.dropbear.id.au>
    scsi: virtio_scsi: Always try to read VPD pages

Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
    ath: Fix updating radar flags for coutry code India

Marek Vasut <marex@denx.de>
    spi: dw: Disable clock after unregistering the host

Jasmin J <jasmin@anw.at>
    media/dvb-core: Race condition when writing to CAM

David Ahern <dsa@cumulusnetworks.com>
    net: ipv6: send unsolicited NA on admin up

Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
    i2c: i2c-scmi: add a MS HID

Hans de Goede <hdegoede@redhat.com>
    genirq: Use irqd_get_trigger_type to compare the trigger type for shared IRQs

Thomas Gleixner <tglx@linutronix.de>
    cpufreq/sh: Replace racy task affinity logic

Thomas Gleixner <tglx@linutronix.de>
    ACPI/processor: Replace racy task affinity logic

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: ar1021_i2c - fix too long name in driver's device table

Hans de Goede <hdegoede@redhat.com>
    x86: i8259: export legacy_pic symbol

Santeri Toivonen <santeri.toivonen@vatsul.com>
    platform/x86: asus-nb-wmi: Add wapf4 quirk for the X302UA


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/alpha/kernel/console.c                        |  1 +
 arch/arm/mach-omap2/clockdomains7xx_data.c         |  2 +-
 arch/ia64/kernel/module.c                          |  4 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c              |  5 +-
 arch/powerpc/kvm/book3s_pr.c                       |  6 ++-
 arch/x86/kernel/i8259.c                            |  1 +
 drivers/acpi/processor_driver.c                    |  7 ++-
 drivers/acpi/processor_throttling.c                | 62 +++++++++++++---------
 drivers/char/ipmi/ipmi_watchdog.c                  |  8 +--
 drivers/clk/clk-si5351.c                           |  2 +-
 drivers/cpufreq/sh-cpufreq.c                       | 45 +++++++++-------
 drivers/gpu/drm/msm/msm_gem.c                      | 14 +++--
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |  5 ++
 drivers/hsi/clients/ssi_protocol.c                 |  5 +-
 drivers/i2c/busses/i2c-scmi.c                      |  4 ++
 drivers/infiniband/core/cma.c                      |  5 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            | 13 +++++
 drivers/infiniband/ulp/ipoib/ipoib_main.c          | 16 ++++++
 drivers/input/touchscreen/ar1021_i2c.c             |  2 +-
 drivers/md/raid10.c                                |  1 +
 drivers/media/dvb-core/dvb_ca_en50221.c            | 23 ++++++++
 drivers/media/dvb-frontends/si2168.c               |  3 ++
 drivers/media/pci/bt8xx/bt878.c                    |  3 +-
 drivers/mfd/palmas.c                               | 14 +++++
 drivers/mmc/core/core.c                            |  8 +++
 drivers/mmc/host/omap_hsmmc.c                      |  4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c         |  6 +++
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |  2 +
 drivers/net/wan/pc300too.c                         |  1 +
 drivers/net/wireless/ath/regd.c                    | 19 ++++---
 drivers/net/wireless/rndis_wlan.c                  |  4 ++
 drivers/pinctrl/core.c                             | 24 ++++++---
 drivers/platform/x86/asus-nb-wmi.c                 |  9 ++++
 drivers/power/pda_power.c                          | 49 +++++++++--------
 drivers/scsi/lpfc/lpfc_sli.c                       |  3 ++
 drivers/scsi/mac_esp.c                             | 33 ++++++++----
 drivers/scsi/virtio_scsi.c                         | 24 +++++++++
 drivers/spi/spi-dw-mmio.c                          |  2 +-
 drivers/video/console/vgacon.c                     | 34 +++++++++---
 drivers/video/fbdev/sm501fb.c                      |  1 +
 drivers/video/fbdev/udlfb.c                        | 14 ++++-
 fs/btrfs/send.c                                    | 23 +++++++-
 fs/cifs/netmisc.c                                  |  6 +--
 kernel/irq/manage.c                                |  4 +-
 net/ipv4/tcp_input.c                               | 16 +++---
 net/ipv6/ndisc.c                                   |  2 +
 net/mac80211/status.c                              |  1 +
 sound/pci/hda/patch_realtek.c                      | 12 ++++-
 50 files changed, 416 insertions(+), 141 deletions(-)
