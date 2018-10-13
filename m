Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12305C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B078E20835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzxQa6LM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B078E20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJMQeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 12:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbeJMQeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 12:34:20 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D07BF20835;
        Sat, 13 Oct 2018 08:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539421079;
        bh=p93HvmMufoPNMS2mhWKZrHdOi0II9PebHmzh9Q0GCn4=;
        h=Date:From:To:Cc:Subject:From;
        b=gzxQa6LMnY6FIBCG5FaRBbjQE0fsrnUgkvsFW/w+RXgiWBt5O9Sgb80SKoJeFIk1N
         AwozgfZ6ZjRAfd8RfkScUHb1kYsBcL1kU6wrIbmcSAiWtRiPjyhmzw95zpWRVbcR1Y
         ieCjzRKpYeKvk02bwb1bi5fP/k8s7J31VwfYC0hY=
Date:   Sat, 13 Oct 2018 10:57:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.161
Message-ID: <20181013085757.GA24894@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.161 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                        |    2=20
 arch/arc/kernel/process.c                       |   20 +
 arch/powerpc/kernel/fadump.c                    |   23 -
 arch/x86/entry/vdso/vclock_gettime.c            |   26 -
 drivers/base/power/main.c                       |    5=20
 drivers/infiniband/core/ucma.c                  |    2=20
 drivers/md/dm-cache-target.c                    |    9=20
 drivers/net/wireless/ath/ath10k/trace.h         |   12=20
 drivers/net/wireless/ath/ath10k/wmi-tlv.c       |    8=20
 drivers/net/wireless/ath/ath10k/wmi.c           |    2=20
 drivers/of/unittest.c                           |   28 +
 drivers/pci/pci.c                               |   27 +
 drivers/usb/host/xhci-pci.c                     |    2=20
 drivers/usb/serial/usb-serial-simple.c          |    3=20
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |    5=20
 fs/ext4/xattr.c                                 |    6=20
 fs/ubifs/super.c                                |    3=20
 include/linux/netfilter_bridge/ebtables.h       |    5=20
 include/linux/skbuff.h                          |    8=20
 include/linux/tcp.h                             |    7=20
 include/net/sock.h                              |    7=20
 include/net/tcp.h                               |    2=20
 kernel/cgroup.c                                 |    6=20
 mm/vmstat.c                                     |    3=20
 net/bridge/netfilter/ebt_arpreply.c             |    3=20
 net/core/skbuff.c                               |   19 +
 net/ipv4/tcp.c                                  |    4=20
 net/ipv4/tcp_input.c                            |  417 ++++++++++++++-----=
-----
 net/ipv4/tcp_ipv4.c                             |    3=20
 net/ipv4/tcp_minisocks.c                        |    1=20
 net/ipv6/tcp_ipv6.c                             |    1=20
 net/mac80211/cfg.c                              |    2=20
 32 files changed, 438 insertions(+), 233 deletions(-)

Andy Lutomirski (2):
      x86/vdso: Fix asm constraints on vDSO syscall fallbacks
      x86/vdso: Fix vDSO syscall fallback asm constraint regression

Carl Huang (1):
      ath10k: fix use-after-free in ath10k_wmi_cmd_send_nowait

Cong Wang (1):
      ucma: fix a use-after-free in ucma_resolve_ip()

Daniel Drake (1):
      PCI: Reprogram bridge prefetch registers on resume

Eric Dumazet (5):
      tcp: increment sk_drops for dropped rx packets
      tcp: fix a stale ooo_last_skb after a replace
      tcp: free batches of packets in tcp_prune_ofo_queue()
      tcp: call tcp_drop() from tcp_data_queue_ofo()
      tcp: add tcp_ooo_try_coalesce() helper

Felix Fietkau (1):
      mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys

Gao Feng (1):
      ebtables: arpreply: Add the standard target sanity check

Greg Kroah-Hartman (1):
      Linux 4.4.161

Guenter Roeck (1):
      of: unittest: Disable interrupt node tests for old world MAC systems

Jann Horn (1):
      mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly

Johan Hovold (1):
      USB: serial: simple: add Motorola Tetra MTP6550 id

Mathias Nyman (1):
      xhci: Add missing CAS workaround for Intel Sunrise Point xHCI

Michal Suchanek (1):
      powerpc/fadump: Return error when fadump registration fails

Mike Snitzer (1):
      dm cache: fix resize crash if user doesn't reload cache table

Prateek Sood (1):
      cgroup: Fix deadlock in cpu hotplug path

Rafael J. Wysocki (1):
      PM / core: Clear the direct_complete flag on errors

Richard Weinberger (1):
      ubifs: Check for name being NULL while mounting

Theodore Ts'o (1):
      ext4: always verify the magic number in xattr blocks

Tomi Valkeinen (1):
      fbdev/omapfb: fix omapfb_memory_read infoleak

Vineet Gupta (1):
      ARC: clone syscall to setp r25 as thread pointer

Yaogong Wang (1):
      tcp: use an RB tree for ooo receive queue

Zhi Chen (1):
      ath10k: fix scan crash due to incorrect length calculation


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvBs5QACgkQONu9yGCS
aT5cmA//QlQEcM4VFwzfANvZn5BubuxsfBLmkCSf9jPbgwgACszk3FlzKqEfXtgs
0lJYT+GAI1c7tAEgd0uxi9P3ak0xb6ZtNzOhkz1T09zxZvwTUjgGXPFWDM3S2kl1
thHhesm/mdtgF1N3rCDFqkouIstwyFax298zoETwsnomk9rtisQniuTJGN4/D7Q5
iZinY/CS6Lde7ucVyjSMEfMDry6yFLXYA0By4fvvvLGVs2Ocotwc6GunzT/KvSxc
544EA1UmB1fXksF9CKmaqr0BST65v9QDwJBL7vNrLFpVg3mNpuFetgNOxNsveKHa
C9pqhq+QBDGw1vaKORK+CZE1IAbYr16WzThTm/j8JCUNTzyZjdvNIjZuz2Vs39gj
u/GsJm3SCfyjDn++R1wLhqOG/nl+1c8lt8sEEhMQerw2nN8Xxa73A86EqlKL0ZUG
G9yAr6aIoR+oXTaxu/OEK7hkPFhDKH/zDHV+FsaHRtcQ9cJc/nlkY5XeHkx61aZg
J4uGXaGvVukBnZ9tt9JRhxT7FtlfmHKDppba1OWLxxB441Oiq4akKusZaUAHubdd
Vhiuzx7rUVWMAIdc2iF9QsquYklL6XSjDfpP1a0UFSPo4Yyw/5auNytXqMWsiDx9
ceYGiEY0ur6xJW/LeZqzgI5DfI0Lb9L+O6mo5Nuf9qCZSsouTGo=
=3LND
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
