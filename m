Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754180AbeBGS5c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753856AbeBGS5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:57:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EC621738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jlayton@kernel.org
Message-ID: <1518029843.3601.8.camel@kernel.org>
Subject: [GIT PULL] inode->i_version related cleanup patch for v4.16
From: Jeff Layton <jlayton@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: GoffredoBaroncelli <kreijack@libero.it>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Date: Wed, 07 Feb 2018 13:57:23 -0500
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+z2xv7lCc19FhC0Rus8y"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+z2xv7lCc19FhC0Rus8y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following changes since commit 255442c93843f52b6891b21d0b485bf2c97f93c3=
:

  Merge tag 'docs-4.16' of git://git.lwn.net/linux (2018-01-31 19:25:25 -08=
00)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/iver=
sion-v4.16-2

for you to fetch changes up to c472c07bfed9c87d7e0b2c052d7e77fedd7109a9:

  iversion: Rename make inode_cmp_iversion{+raw} to inode_eq_iversion{+raw}=
 (2018-02-01 08:15:25 -0500)

----------------------------------------------------------------
Hi Linus,

Goffredo went ahead and sent a patch to rename this function, and
reverse its sense, as we discussed last week.

The patch is very straightforward and I figure it's probably best to go
ahead and merge this to get the API as settled as possible.

Thanks!
Jeff
----------------------------------------------------------------
Goffredo Baroncelli (1):
      iversion: Rename make inode_cmp_iversion{+raw} to inode_eq_iversion{+=
raw}

 fs/affs/dir.c                     |  2 +-
 fs/exofs/dir.c                    |  2 +-
 fs/ext2/dir.c                     |  2 +-
 fs/ext4/dir.c                     |  4 ++--
 fs/ext4/inline.c                  |  2 +-
 fs/fat/namei_vfat.c               |  2 +-
 fs/nfs/inode.c                    |  6 +++---
 fs/ocfs2/dir.c                    |  4 ++--
 fs/ufs/dir.c                      |  2 +-
 include/linux/iversion.h          | 22 +++++++++++-----------
 security/integrity/ima/ima_main.c |  2 +-
 11 files changed, 25 insertions(+), 25 deletions(-)
--=20
Jeff Layton <jlayton@kernel.org>
--=-+z2xv7lCc19FhC0Rus8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAlp7TBMTHGpsYXl0b25A
a2VybmVsLm9yZwAKCRAADmhBGVaCFYuxEACSpcuH3OMNBGwhG72WdIawkiLn/Psl
6iYigHAvwBpqJCPCkqhDsjvVFt6kmNaM/ItzzzUQEyq1T3HKUEZnw6bL7vOScO3Y
ueIGZFNy+GHMyB3klRn7qETiYrsEFtOdObBGPKRvyvPOC/vkGAlgDydIIsjoxLU6
XCUZNIyhTMckY6K4aSxTaj4ZTiMd2Ud3y0xlF9n8UT0NmDMXDNGhWT6gDO6QvyAR
rtSmqdkhyUdWiIC03H/lRbNQM09e1oo0539zFjlSJ8h3yontntlzPXFQLVBVQ8uL
c8VOE1x9ikJu1A1zFaHqSeuwdiwfamw+/cwDJlh0O1SEFdQ0iraP4BqXjjIIu5fE
EbPX75WdBNNaA+xx39Qw4HwzDLIzRIvUj3zNwL6yTNrbQ17oIH46j/TXERUc/hB1
qW3SkNgKRo+ymozDZcqbrH9wh6mnr4AfHQdGBEpsN8no2DkVdEhhbm+2ZVnI9Lwz
oJnC9mjhTXrQabaj7NqpyuZSAupcAFtq5mAm6fnkoXsh4vCOFi5SOM0Dn+I78h9k
//k4u5cDnEmCBFdTTaMI4b7puYs79slBIp8585DUCxWVqp1OrYBGY1QmHeJdTbB9
PsMYh/76L3ib91Ca274Oq0xdo7hCgwSFYtkuy5rQIcSy/mLLj/OEWwCGu5uuYx7+
AqMFdaASgYZrPw==
=2tnH
-----END PGP SIGNATURE-----

--=-+z2xv7lCc19FhC0Rus8y--
