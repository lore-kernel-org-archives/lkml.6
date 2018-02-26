Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709765-1519676149-2-3639503063525964061
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
    t=1519676148; b=ue0yjET00MXBHFnFvVQ5VgjE+x61xPXwn8vtYkQxWOPGtCf
    o7iT+4aqwSw36v3a0WnvSI4BCpvr7rFUzF6kbNxK83E0beLI4VG0jttEcmmIvde3
    v81BGFq1U0sAQC4xgzQ8KAQwWmSkatL7Tyu/oqoRfbDroxxxEUu3UTeuAaZRwQPq
    2+dV0dd1jyncMFMsHA+HnfsSXNJ9C//mXQzL0lCYWN9KwAwt2tSXWKX9vWkTi86I
    Ktbjjq7jftz2siJpRxuQICzdORoEeNxJg2OwbLoPOkAp81sLTabInqj+2J4d3O/8
    QsYDgHVO4p9oGIk4Rf1W3yFp1C5bs/sMN5C4VqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519676148; bh=kkuFxiecR0i4R8Oavr2U5podYe
    wHpmHGyXvuDWwf1cs=; b=SGmse9x6Mn0MZy04gBkEedqBNWkMiDs+5rw+tXvs1a
    hNL/6iOMnBJsaFRo6q2PXNCaiVUvhGGJ7rAYIuw2JMJ5Ro1c3zmfzMQYyJQZQGlc
    RsGh3F3GMIXf/CCnG+d5BTQVK/GIq0M1On/7ucOhkKPCaxlXR6aV2mOCTJ/Ehf3h
    cnhjdCU0bRMp9UxLoNVn2ysvtKzdLLq2cJiv1UXowYEtXHB/8cgClAfBA7c8P++y
    KUU6xZ64xKTsVh4nr/G2p17Q0cn1N24Dqia/8oGQOfooUKl/1spgLWVeh6C3MUSo
    DvnDRh5jv+9YBGYhneey0KxdnXjwyKDd6An5U+1cfoqw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbeBZUPr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:15:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58192 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbeBZUPq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:15:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/13] 3.18.97-stable review
Date: Mon, 26 Feb 2018 21:15:28 +0100
Message-Id: <20180226201527.242286068@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.97-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.97-rc1
X-KernelTest-Deadline: 2018-02-28T20:15+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.97 release.
There are 13 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 28 20:15:12 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.97-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.97-rc1

Eric Biggers <ebiggers@google.com>
    ASN.1: fix out-of-bounds read when parsing indefinite length item

Jack Pham <jackp@codeaurora.org>
    usb: gadget: f_fs: Process all descriptors during bind

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: gadget: Set maxpacket size for ep0 IN

Michael Weiser <michael.weiser@gmx.de>
    arm64: Disable unhandled signal log messages by default

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

Johan Hovold <johan@kernel.org>
    PCI: keystone: Fix interrupt-controller-node lookup

Paolo Abeni <pabeni@redhat.com>
    netfilter: drop outermost socket lock in getsockopt()


-------------

Diffstat:

 Makefile                           |  4 +--
 arch/arm64/kernel/traps.c          |  2 +-
 arch/x86/oprofile/nmi_int.c        |  2 +-
 arch/xtensa/mm/init.c              | 70 ++++++++++++++++++++++++++++++++++----
 drivers/iio/imu/adis_trigger.c     |  7 ++--
 drivers/iio/industrialio-buffer.c  |  2 +-
 drivers/irqchip/irq-gic-v3.c       |  2 +-
 drivers/pci/host/pci-keystone.c    |  9 +++--
 drivers/scsi/ibmvscsi/ibmvfc.h     |  2 +-
 drivers/usb/dwc3/gadget.c          |  2 ++
 drivers/usb/gadget/function/f_fs.c |  6 ++--
 lib/asn1_decoder.c                 | 43 ++++++++++++-----------
 net/ipv4/ip_sockglue.c             |  7 +---
 net/ipv6/ipv6_sockglue.c           | 10 ++----
 net/mac80211/cfg.c                 |  2 +-
 15 files changed, 113 insertions(+), 57 deletions(-)
