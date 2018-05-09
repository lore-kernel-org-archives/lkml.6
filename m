Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755434AbeEIE4c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:56:32 -0400
Received: from ozlabs.org ([203.11.71.1]:41201 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751922AbeEIE4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:56:30 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 9 May 2018 14:56:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQt?= =?UTF-8?B?SsO4cmdlbnNlbg==?=
        <toke@toke.dk>
Subject: linux-next: build warning after merge of the mac80211-next tree
Message-ID: <20180509145624.643d2e56@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hlS.Gq/id/tlEVDlzOM.jCP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hlS.Gq/id/tlEVDlzOM.jCP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

After merging the mac80211-next tree, today's linux-next build (arm_multi
v7_defconfig) produced this warning:

drivers/net/wireless/marvell/mwifiex/uap_event.c: In function 'mwifiex_proc=
ess_uap_event':
drivers/net/wireless/marvell/mwifiex/uap_event.c:333:1: warning: the frame =
size of 1680 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
 }
 ^
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'b=
rcmf_notify_connect_status_ap':
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:5530:1: warning=
: the frame size of 1680 bytes is larger than 1024 bytes [-Wframe-larger-th=
an=3D]
 }
 ^

Maybe introduced by commit

  52539ca89f36 ("cfg80211: Expose TXQ stats and parameters to userspace")

--=20
Cheers,
Stephen Rothwell

--Sig_/hlS.Gq/id/tlEVDlzOM.jCP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlryf3gACgkQAVBC80lX
0GxqrggAjA5GohA+vLw21E0YcEVw05I8gpMaX+pWFevpGEZEWOFjNkNvf8k7rqmK
HVlx97/uiM6k9WdVE9cRWccqEviCc6lkMMkPxDLCT21wSR12Yl3SacpsQmrFzAnG
5ON1Fzzj4X0LTB4GvWxVZrHQZY776AYSz5rSTA4sPoIFZaj6g1AhUWcm/o7ci0Xg
by5UcfF09/B9uE8C4Ud+V/IthEZqO0X4qqgupbCdT9m+MrYVn8AA73qSiTe5TALf
zJ+QxAJR/Yp39PJ9ThS3xdoerZflM8ny1tuYf25Lm/pFxwZ34c7jdanJ8DqrhkCr
YUgHBdwXg3T+4uzu2y0V6V2cZ3XD7Q==
=UjYP
-----END PGP SIGNATURE-----

--Sig_/hlS.Gq/id/tlEVDlzOM.jCP--
