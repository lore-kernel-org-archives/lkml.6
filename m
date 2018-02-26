Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3726165-1519676290-2-16616181054009778228
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519676289; b=j3P3wHN8O/vQrSSR9Rcsz8z6cPC0xPmNFWrZG9uLthBvrkf
    j5EXR9TmxGdxhg9Ka5kuJiiKDq7+KmPzIsyMK5IHTGmU8BgA0/vREFJyMtNkK4VR
    9BHbCXovG1vJqsAZrVKcYeHgotQcGGRjBJE2S7V0AM14PP8CImfo5ijWvQsim4KM
    PGKNnnRWW9mqTSROP6d+8lXfr44FYktU0gpnigJ/iOnuRixuflDoKkdRmu24kJPa
    44Ygt3S1GnWFojEqCh/iTKCvqvT3vVg6kgJ9e7yzC3IxokE5HaGI1hnqiowCIbxN
    gOP1/wyQYiGQ6QZeVtLmEQBaDvAmyjPxhZULXYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519676289; bh=bZGpj7qsZe0MQHPx3DkckLKMQK
    buzmDja7YoEn1RFH8=; b=rd9NAF6378G1M9PrpwYf4WxgOVlt5yDuShYr5nOVnZ
    kpWFWOWgkNNkjJinJfL/OBs6xLHgVuXUcPh0xI4VoN4yI8aXsGasnmQW5olWc5u6
    btkvvz7q4BWmvFOe10iJL3vjZ7TnkprqZssInvHBRHbRibLYiY3nGGqw7C2lzJt0
    s0hcHzUzh3BDotUjVy5J1dhCQ7x6F+wJh46CxWAkPTRC26QsMeIkNyMo4cQEo4Uo
    YlZqQsSxpXksIVmEBMFaPlXGgvIC6sp7lkJtJKerlLD1emXkPACzIscjimeDQkSD
    nFNmEDXBw5e1pui5IUP+bt6J8bZTOVPYETt5GsYTcfJQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbeBZURy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:17:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59944 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBZURk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:17:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/22] 4.4.119-stable review
Date: Mon, 26 Feb 2018 21:16:00 +0100
Message-Id: <20180226201558.681421374@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.119-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.119-rc1
X-KernelTest-Deadline: 2018-02-28T20:15+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.119 release.
There are 22 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 28 20:15:48 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.119-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.119-rc1

Eric Biggers <ebiggers@google.com>
    binder: add missing binder_unlock()

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: Avoid leaking PM domain on driver unbind (v2)

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: renesas_usbhs: missed the "running" flag in usb_dmac with rx path

Jack Pham <jackp@codeaurora.org>
    usb: gadget: f_fs: Process all descriptors during bind

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

Shanker Donthineni <shankerd@codeaurora.org>
    irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()

Arnd Bergmann <arnd@arndb.de>
    x86/oprofile: Fix bogus GCC-8 warning in nmi_setup()

Lars-Peter Clausen <lars@metafoo.de>
    iio: adis_lib: Initialize trigger before requesting interrupt

Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>
    iio: buffer: check if a buffer has been set up when poll is called

Arnd Bergmann <arnd@arndb.de>
    cfg80211: fix cfg80211_beacon_dup

Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
    scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix high memory/reserved memory collision

Paolo Abeni <pabeni@redhat.com>
    ip_tunnel: fix preempt warning in ip tunnel creation/updating

Paolo Abeni <pabeni@redhat.com>
    ip_tunnel: replace dst_cache with generic implementation

Johan Hovold <johan@kernel.org>
    PCI: keystone: Fix interrupt-controller-node lookup

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Fix RFI flush dependency on HARDLOCKUP_DETECTOR

Paolo Abeni <pabeni@redhat.com>
    netfilter: drop outermost socket lock in getsockopt()


-------------

Diffstat:

 Makefile                                   |  4 +-
 arch/arm64/kernel/traps.c                  |  2 +-
 arch/powerpc/kernel/setup_64.c             |  2 +-
 arch/x86/oprofile/nmi_int.c                |  2 +-
 arch/xtensa/mm/init.c                      | 70 ++++++++++++++++++++++++---
 drivers/android/binder.c                   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 -
 drivers/gpu/drm/drm_edid.c                 |  3 ++
 drivers/hid/hid-core.c                     |  3 ++
 drivers/hid/hid-ids.h                      |  3 ++
 drivers/iio/imu/adis_trigger.c             |  7 +--
 drivers/iio/industrialio-buffer.c          |  2 +-
 drivers/irqchip/irq-gic-v3.c               |  2 +-
 drivers/pci/host/pci-keystone.c            |  9 +++-
 drivers/scsi/ibmvscsi/ibmvfc.h             |  2 +-
 drivers/usb/core/quirks.c                  |  3 ++
 drivers/usb/dwc3/gadget.c                  |  2 +
 drivers/usb/gadget/function/f_fs.c         |  6 +--
 drivers/usb/host/ohci-q.c                  | 17 ++++---
 drivers/usb/misc/ldusb.c                   |  6 +++
 drivers/usb/renesas_usbhs/fifo.c           |  5 ++
 include/net/ip_tunnels.h                   |  9 +---
 net/ipv4/Kconfig                           |  1 +
 net/ipv4/ip_sockglue.c                     |  7 +--
 net/ipv4/ip_tunnel.c                       | 78 +++++-------------------------
 net/ipv6/ipv6_sockglue.c                   | 10 +---
 net/ipv6/sit.c                             | 17 ++++---
 net/mac80211/cfg.c                         |  2 +-
 28 files changed, 151 insertions(+), 129 deletions(-)
