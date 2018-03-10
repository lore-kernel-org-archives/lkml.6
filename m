Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1720711-1520641128-2-5777636589269093944
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520641127; b=g+GaZSTTVEsmF3Q4RNNisEhoFyHoMXneCxPA9r+EGeMvA1v
    gM+stZJ1gD6AOvuUXrFJ6WyGU09QVxaTq3oXbYcsV9IreKFQ9SpZguwEMUMaFzV2
    qMSbNlrUZyok3sBPsogz7aqxRvpfXuNMD8ZV5c89ZCMVbLMKDfK0G1ykrbCSj+79
    K3px4+8WneHwVaom5hnI1FSQ52PqBuFyRyHDkekYKanowzvbn1lPVMz1NPOXZMHp
    DTg7n8ZZ3tQThHWL8i8+QwHks9eijldM5WbTtbKKOtLYxKc/YtIRzhXby30XTTaR
    zQisKJIm3gkw2Xtj0iWb1pOa/YCJXhayJmI7sJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520641127; bh=vor/q8B1g30aqmB5rljKXlJq6c
    /uylUy0MbcnpmRp8Y=; b=OfFLiVvFKLHF90xFsGPNchw8R8dY3KsKNhGnsC6Cfg
    vsQsrZ4B4sJGdu8zMoCcVIXmBdqBrnAYt/2JjPOplmD9YENRpQIVQsZwl5A1SeQa
    gAqOWRxyCef77NM1vkY77NiAS7JXK0G3YgwTOITHY6oGCV8K2aOLb23sDBLoj59K
    Z6t6Ya/hJk+taHS+vgMq97LXiVR5nVTB72676xfghxqWveu9elATqscWdAbL5dNw
    IoX99wP171LThgbUOZ7frORL1H3cwwQJFnKzN6f3zh34/MdAPr1gjVUhpFEM/2Ak
    S2VHqoy7dVL6z9xD+CPrHAsmJf2CoI5lN9mrtaewhfAg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeCJASn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:18:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeCJASn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:18:43 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/21] 3.18.99-stable review
Date: Fri,  9 Mar 2018 16:18:22 -0800
Message-Id: <20180310001801.045114869@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.99-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.99-rc1
X-KernelTest-Deadline: 2018-03-12T00:18+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.99 release.
There are 21 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon Mar 12 00:17:44 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.99-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.99-rc1

Mike Snitzer <snitzer@redhat.com>
    dm io: fix duplicate bio completion due to missing ref count

Stefano Brivio <sbrivio@redhat.com>
    fib_semantics: Don't match route with mismatching tclassid

Sabrina Dubroca <sd@queasysnail.net>
    net: ipv4: don't allow setting net.ipv4.route.min_pmtu below 68

Alexey Kodanev <alexey.kodanev@oracle.com>
    sctp: verify size of a new chunk in _sctp_make_chunk()

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix IPA command submission race

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix SETIP command handling

Alexey Kodanev <alexey.kodanev@oracle.com>
    sctp: fix dst refcnt leak in sctp_v6_get_dst()

Alexey Kodanev <alexey.kodanev@oracle.com>
    udplite: fix partial checksum initialization

Guillaume Nault <g.nault@alphalink.fr>
    ppp: prevent unregistered channels from connecting to PPP units

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    netlink: ensure to loop over all netns in genlmsg_multicast_allns()

Jakub Kicinski <jakub.kicinski@netronome.com>
    net: fix race on decreasing number of TX queues

Arnd Bergmann <arnd@arndb.de>
    ipv6 sit: work around bogus gcc-8 -Wrestrict warning

Denis Du <dudenis2000@yahoo.ca>
    hdlc_ppp: carrier detect ok, don't turn off negotiation

Xin Long <lucien.xin@gmail.com>
    bridge: check brport attr show in brport_show

Nathan Sullivan <nathan.sullivan@ni.com>
    leds: do not overflow sysfs buffer in led_trigger_show

Lucas Stach <l.stach@pengutronix.de>
    net: fec: introduce fec_ptp_stop and use in probe fail path

Ulf Magnusson <ulfalizer@gmail.com>
    ARM: mvebu: Fix broken PL310_ERRATA_753970 selects

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()

Erik Veijola <erik.veijola@gmail.com>
    ALSA: usb-audio: Add a quirck for B&W PX headphones

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm_i2c_infineon: fix potential buffer overruns caused by bit glitches on the bus


-------------

Diffstat:

 Makefile                                  |  4 +--
 arch/arm/mach-mvebu/Kconfig               |  4 +--
 drivers/char/tpm/tpm_i2c_infineon.c       |  5 ++--
 drivers/char/tpm/tpm_i2c_nuvoton.c        |  8 ++++--
 drivers/cpufreq/s3c24xx-cpufreq.c         |  8 +++++-
 drivers/leds/led-triggers.c               | 12 ++++----
 drivers/md/dm-io.c                        |  1 +
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c |  5 ++--
 drivers/net/ethernet/freescale/fec_ptp.c  | 10 +++++++
 drivers/net/ppp/ppp_generic.c             |  9 ++++++
 drivers/net/wan/hdlc_ppp.c                |  5 +++-
 drivers/s390/net/qeth_core.h              |  5 ++++
 drivers/s390/net/qeth_core_main.c         | 33 ++++++++++++----------
 include/net/udplite.h                     |  1 +
 net/bridge/br_sysfs_if.c                  |  3 ++
 net/core/dev.c                            | 11 ++++++--
 net/ipv4/fib_semantics.c                  |  5 ++++
 net/ipv4/route.c                          |  7 +++--
 net/ipv4/udp.c                            |  5 ++++
 net/ipv6/ip6_checksum.c                   |  5 ++++
 net/ipv6/sit.c                            |  2 +-
 net/netlink/genetlink.c                   | 12 ++++++--
 net/sctp/ipv6.c                           | 10 +++++--
 net/sctp/sm_make_chunk.c                  |  8 ++++--
 sound/usb/quirks-table.h                  | 47 +++++++++++++++++++++++++++++++
 26 files changed, 181 insertions(+), 45 deletions(-)
