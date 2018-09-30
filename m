Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9274C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637962075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637962075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeJACVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:21:20 -0400
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:36260 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeJACVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:21:19 -0400
Received: from smtp7.infomaniak.ch (smtp7.infomaniak.ch [83.166.132.30])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id w8UJjUD7008494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Sep 2018 21:45:30 +0200
Received: from ns3096276.ip-94-23-54.eu (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp7.infomaniak.ch (8.14.5/8.14.5) with ESMTP id w8UJjQ4I081451
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
        Sun, 30 Sep 2018 21:45:26 +0200
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
To:     Aleksa Sarai <cyphar@cyphar.com>, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20180929103453.12025-1-cyphar@cyphar.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Openpgp: preference=signencrypt
Autocrypt: addr=mic@digikod.net; prefer-encrypt=mutual; keydata=
 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
 fzQh4n77RjVFnCHFbtPhnyvGdQQ=
Message-ID: <39d64180-73d5-6f27-e455-956143a5b5d3@digikod.net>
Date:   Sun, 30 Sep 2018 21:45:18 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20180929103453.12025-1-cyphar@cyphar.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Feym2fnev053dmFcOhqlbxZLmNqxSKfIy"
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Feym2fnev053dmFcOhqlbxZLmNqxSKfIy
Content-Type: multipart/mixed; boundary="sMs1JIs6X9nEq3L8PGLQai3GHiZyPZxOB";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: Aleksa Sarai <cyphar@cyphar.com>, Jeff Layton <jlayton@kernel.org>,
 "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <christian@brauner.io>,
 Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dev@opencontainers.org, containers@lists.linux-foundation.org,
 linux-security-module <linux-security-module@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>
Message-ID: <39d64180-73d5-6f27-e455-956143a5b5d3@digikod.net>
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
References: <20180929103453.12025-1-cyphar@cyphar.com>
In-Reply-To: <20180929103453.12025-1-cyphar@cyphar.com>

--sMs1JIs6X9nEq3L8PGLQai3GHiZyPZxOB
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

As a side note, I'm still working on Landlock which can achieve the same
goal but in a more flexible and dynamic way: https://landlock.io

Regards,
 Micka=EBl

On 9/29/18 12:34, Aleksa Sarai wrote:
> The need for some sort of control over VFS's path resolution (to avoid
> malicious paths resulting in inadvertent breakouts) has been a very
> long-standing desire of many userspace applications. This patchset is a=

> revival of Al Viro's old AT_NO_JUMPS[1] patchset with a few additions.
>=20
> The most obvious change is that AT_NO_JUMPS has been split as dicussed
> in the original thread, along with a further split of AT_NO_PROCLINKS
> which means that each individual property of AT_NO_JUMPS is now a
> separate flag:
>=20
>   * Path-based escapes from the starting-point using "/" or ".." are
>     blocked by AT_BENEATH.
>   * Mountpoint crossings are blocked by AT_XDEV.
>   * /proc/$pid/fd/$fd resolution is blocked by AT_NO_PROCLINKS (more
> 	correctly it actually blocks any user of nd_jump_link() because it
> 	allows out-of-VFS path resolution manipulation).
>=20
> AT_NO_JUMPS is now effectively (AT_BENEATH|AT_XDEV|AT_NO_PROCLINKS). At=

> Linus' suggestion in the original thread, I've also implemented
> AT_NO_SYMLINKS which just denies _all_ symlink resolution (including
> "proclink" resolution).
>=20
> An additional improvement was made to AT_XDEV. The original AT_NO_JUMPS=

> path didn't consider "/tmp/.." as a mountpoint crossing -- this patch
> blocks this as well (feel free to ask me to remove it if you feel this
> is not sane).
>=20
> Currently I've only enabled these for openat(2) and the stat(2) family.=

> I would hope we could enable it for basically every *at(2) syscall --
> but many of them appear to not have a @flags argument and thus we'll
> need to add several new syscalls to do this. I'm more than happy to sen=
d
> those patches, but I'd prefer to know that this preliminary work is
> acceptable before doing a bunch of copy-paste to add new sets of *at(2)=

> syscalls.
>=20
> One additional feature I've implemented is AT_THIS_ROOT (I imagine this=

> is probably going to be more contentious than the refresh of
> AT_NO_JUMPS, so I've included it in a separate patch). The patch itself=

> describes my reasoning, but the shortened version of the premise is tha=
t
> continer runtimes need to have a way to resolve paths within a
> potentially malicious rootfs. Container runtimes currently do this in
> userspace[2] which has implicit race conditions that are not resolvable=

> in userspace (or use fork+exec+chroot and SCM_RIGHTS passing which is
> inefficient). AT_THIS_ROOT allows for per-call chroot-like semantics fo=
r
> path resolution, which would be invaluable for us -- and the
> implementation is basically identical to AT_BENEATH (except that we
> don't return errors when someone actually hits the root).
>=20
> I've added some selftests for this, but it's not clear to me whether
> they should live here or in xfstests (as far as I can tell there are no=

> other VFS tests in selftests, while there are some tests that look like=

> generic VFS tests in xfstests). If you'd prefer them to be included in
> xfstests, let me know.
>=20
> [1]: https://lore.kernel.org/patchwork/patch/784221/
> [2]: https://github.com/cyphar/filepath-securejoin
>=20
> Aleksa Sarai (3):
>   namei: implement O_BENEATH-style AT_* flags
>   namei: implement AT_THIS_ROOT chroot-like path resolution
>   selftests: vfs: add AT_* path resolution tests
>=20
>  fs/fcntl.c                                    |   2 +-
>  fs/namei.c                                    | 158 ++++++++++++------=

>  fs/open.c                                     |  10 ++
>  fs/stat.c                                     |  15 +-
>  include/linux/fcntl.h                         |   3 +-
>  include/linux/namei.h                         |   8 +
>  include/uapi/asm-generic/fcntl.h              |  20 +++
>  include/uapi/linux/fcntl.h                    |  10 ++
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/vfs/.gitignore        |   1 +
>  tools/testing/selftests/vfs/Makefile          |  13 ++
>  tools/testing/selftests/vfs/at_flags.h        |  40 +++++
>  tools/testing/selftests/vfs/common.sh         |  37 ++++
>  .../selftests/vfs/tests/0001_at_beneath.sh    |  72 ++++++++
>  .../selftests/vfs/tests/0002_at_xdev.sh       |  54 ++++++
>  .../vfs/tests/0003_at_no_proclinks.sh         |  50 ++++++
>  .../vfs/tests/0004_at_no_symlinks.sh          |  49 ++++++
>  .../selftests/vfs/tests/0005_at_this_root.sh  |  66 ++++++++
>  tools/testing/selftests/vfs/vfs_helper.c      | 154 +++++++++++++++++
>  19 files changed, 707 insertions(+), 56 deletions(-)
>  create mode 100644 tools/testing/selftests/vfs/.gitignore
>  create mode 100644 tools/testing/selftests/vfs/Makefile
>  create mode 100644 tools/testing/selftests/vfs/at_flags.h
>  create mode 100644 tools/testing/selftests/vfs/common.sh
>  create mode 100755 tools/testing/selftests/vfs/tests/0001_at_beneath.s=
h
>  create mode 100755 tools/testing/selftests/vfs/tests/0002_at_xdev.sh
>  create mode 100755 tools/testing/selftests/vfs/tests/0003_at_no_procli=
nks.sh
>  create mode 100755 tools/testing/selftests/vfs/tests/0004_at_no_symlin=
ks.sh
>  create mode 100755 tools/testing/selftests/vfs/tests/0005_at_this_root=
=2Esh
>  create mode 100644 tools/testing/selftests/vfs/vfs_helper.c
>=20


--sMs1JIs6X9nEq3L8PGLQai3GHiZyPZxOB--

--Feym2fnev053dmFcOhqlbxZLmNqxSKfIy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAluxJ84ACgkQIt7+33O9
apXeyAf+OnSwPdBayV1fdgXBpMfKOUYkvGnIu/wwMcrCZsARqrmToAlomImix6JX
nRiOPtjUGFSFeL8RgAAsaJH32m4jvMVMl2nI7Yz2ai+17ia36BeF2JvtGVzgO2Wk
TQFmEHUTb81mtZY6pj8M5hAuHMnYHbQVHXdy2raxRe+st8FmJwTFCF02tGGpgzDT
Q9EhyKlyMI+wwO6QLsBjGqfgfDv7qsCpHcAgENR0UVavKjxhN6ecNECgiYIwATCV
6Wl8IsgsgruG42uQrGt+ph9yZBAkHVtRfFwl/k2y2Z2N0NCzoRLDLdx0/iXHNtV5
Vo+/RbgySyTjkO8kl1y+i6qwdmyEkg==
=/s0t
-----END PGP SIGNATURE-----

--Feym2fnev053dmFcOhqlbxZLmNqxSKfIy--
