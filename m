Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F64C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCE920673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCE920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbeK3Brr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:47:47 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:55903 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbeK3Brq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:47:46 -0500
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0D9B0200002;
        Thu, 29 Nov 2018 14:42:07 +0000 (UTC)
Date:   Thu, 29 Nov 2018 15:42:06 +0100
From:   jacopo mondi <jacopo@jmondi.org>
To:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        shawnguo@kernel.org, s.hauer@pengutronix.de, fabio.estevam@nxp.com
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Regression: v4.20-rc4: "SMSC LAN8710/LAN8720: Master/Slave
 resolution failed"
Message-ID: <20181129144206.GK9807@w540>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0qVF/w3MHQqLSynd"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0qVF/w3MHQqLSynd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,
   netdev people,
   i.MX6 people,

   I'm running an i.MX6Q system, and since v4.20-rc1 the ethernet PHY
fails to properly startup, preventing me from mounting my NFS rootfs
(the interfaces gets configured after some minutes, but it's too late
for NFS).

The complete boot log:

[    3.000186] SMSC LAN8710/LAN8720 2188000.ethernet-1:00: attached PHY driver [SMSC LAN8710/LAN8720] (mii_bus:phy_addr=2188000.ethernet-1:00, irq=POLL)
[    3.015616] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    4.090582] SMSC LAN8710/LAN8720 2188000.ethernet-1:00: Master/Slave resolution failed, maybe conflicting manual settings?
[   13.038779] Waiting up to 110 more seconds for network.
[   23.058776] Waiting up to 100 more seconds for network.
[   33.078782] Waiting up to 90 more seconds for network.
[   43.098780] Waiting up to 80 more seconds for network.
[   53.118780] Waiting up to 70 more seconds for network.
[   63.138733] Waiting up to 60 more seconds for network.
[   73.158781] Waiting up to 50 more seconds for network.
[   83.178779] Waiting up to 40 more seconds for network.
[   93.198778] Waiting up to 30 more seconds for network.
[  103.218780] Waiting up to 20 more seconds for network.
[  113.238779] Waiting up to 10 more seconds for network.
[  123.048862] IP-Config: Guessing netmask 255.255.255.0
[  123.053967] IP-Config: Complete:
[  123.057247]      device=eth0, hwaddr=9c:53:cd:02:fb:34, ipaddr=192.168.1.100, mask=255.255.255.0, gw=255.255.255.255
[  123.067927]      host=192.168.1.100, domain=, nis-domain=(none)
[  123.074027]      bootserver=255.255.255.255, rootserver=192.168.1.64, rootpath=
[  123.082826] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[  123.096250] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[  123.103753] ALSA device list:
[  123.106824]   No soundcards found.
[  123.111007] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[  123.119879] cfg80211: failed to load regulatory.db

The board I'm using went in in v4.20-rc1:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=37c045d25e90038682b845de0a1db43c8301694d
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09ad741b7ecee8f7fa80bfa21eb0716394aff418

But with the above patches applied on v4.19 (on which I initially wrote them)
it still works with no issues.

Not a network expert and I might have missed some adjustments required
to have the PHY work properly on v4.20 (I see the issue on both v4.20-rc1
and v4.20-rc4 as well).

Before diving into a painful bisect, I'm here reporting the issue.

Thanks
   j


--0qVF/w3MHQqLSynd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJb//q+AAoJEHI0Bo8WoVY8HRkP/RCh+2GE8PizHB0ztDirLfTY
sS3pm6USbtTzYFF49sdXM17Ufgycn5DxuXr6SD2nv5utUUrKmECRVc6nSO/UFeGn
/B7pDJh/WJM0Db8NhUIPxoATmc7elUR/OeCOfgB0cUPIxB5cj8evGxUaNY1Xco3R
COBrWaAObtjUQLZWUErUKh2/komCUcm5UYwTWMRLycGQjzlORwS7KHezQBWTIKy7
6ctjW76PL0B1eO7kipNiM1qlLs8wh0HAYWIqTY4XyT/VV/FBtss94Wql4TXGZKYP
IQ+osFmvbslI+3NN6zLWagz/MQw06w09kO0M+G5c4Hs+Ht7qorLdSBR9sjVHTtUS
15lMdNQddHLfIbeS8Vl0g6YFlcOCFa8ng0/17I50/SxdEwdLz0x50QtX8gpmKR1G
qAwwKm0UuJ1KqtASX7p+2vV2Vv5EcRM2clQaz7Z2STqfSE2gB/FC7AzZX7mjZdnY
bl2fxcn/k59B/g1JBJDg9Ydk8sPMpppeRLB3xDWqDYA4v1fGmnume9bX/XgQ6x+H
x2Qb1mHMuZzW/GYb1ntQbo2EogB61bUxMnwx2NlAx59FB4uj48td6PRG5LdPz4pq
LtsGqqhtZJINezuUwXCscax97LhD7nWhFOenADA/CmgqsWEqbaw1Vmyxt/1g0cfv
z7flDRDqYp7sw13NJ490
=4hsW
-----END PGP SIGNATURE-----

--0qVF/w3MHQqLSynd--
