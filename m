Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545D1C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB49214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB49214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbeIRNQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:16:51 -0400
Received: from smtp-sh.infomaniak.ch ([128.65.195.4]:41265 "EHLO
        smtp-sh.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeIRNQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:16:50 -0400
Received: from smtp5.infomaniak.ch (smtp5.infomaniak.ch [83.166.132.18])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id w8I7ixbn025290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 09:45:00 +0200
Received: from ns3096276.ip-94-23-54.eu (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp5.infomaniak.ch (8.14.5/8.14.5) with ESMTP id w8I7irqu030412
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
        Tue, 18 Sep 2018 09:44:55 +0200
Subject: Re: [PATCH v2 00/10] LSM: Module stacking in support of S.A.R.A and
 Landlock
To:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <alpine.LRH.2.21.1809130727310.19741@namei.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Openpgp: preference=signencrypt
Autocrypt: addr=mic@digikod.net; prefer-encrypt=mutual; keydata=
 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
 fzQh4n77RjVFnCHFbtPhnyvGdQQ=
Message-ID: <d2ad1caf-4e81-f33d-f764-6f90f9d101c4@digikod.net>
Date:   Tue, 18 Sep 2018 09:44:47 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1809130727310.19741@namei.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6t2AHDVawcfDyXz43It5ZPOAYstQl28sP"
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6t2AHDVawcfDyXz43It5ZPOAYstQl28sP
Content-Type: multipart/mixed; boundary="wlIgseE8uGy21t8rLeoSLitsACGY9OGDi";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: James Morris <jmorris@namei.org>, Casey Schaufler
 <casey@schaufler-ca.com>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
Message-ID: <d2ad1caf-4e81-f33d-f764-6f90f9d101c4@digikod.net>
Subject: Re: [PATCH v2 00/10] LSM: Module stacking in support of S.A.R.A and
 Landlock
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <alpine.LRH.2.21.1809130727310.19741@namei.org>
In-Reply-To: <alpine.LRH.2.21.1809130727310.19741@namei.org>

--wlIgseE8uGy21t8rLeoSLitsACGY9OGDi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 9/12/18 23:29, James Morris wrote:
> Adding the SARA and LandLock authors for review & comment.
>=20
> Salvatore & Micka=C3=ABl: does this patchset meet your needs for mergin=
g to=20
> mainline?

It almost does! For now, I need the task_struct, cred, inode and file
security blobs. Only the task_struct one is missing.

FYI, the capitalization of Landlock is not consistent in all commit
messages. :)

Thanks,
 Micka=C3=ABl

>=20
>=20
>=20
> On Tue, 11 Sep 2018, Casey Schaufler wrote:
>=20
>> LSM: Module stacking in support of S.A.R.A and Landlock
>>
>> v2: Reduce the patchset to what is required to support
>>     the proposed S.A.R.A. and LandLock security modules
>>
>> The S.A.R.A. security module is intended to be used
>> in conjunction with other security modules. It requires
>> state to be maintained for the credential, which
>> in turn requires a mechanism for sharing the credential
>> security blob. The module also requires mechanism for
>> user space manipulation of the credential information,
>> hence an additional subdirectory in /proc/.../attr.
>>
>> The LandLock security module provides user configurable
>> policy in the secmark mechanism. It requires data in
>> the credential, file and inode security blobs. For this
>> to be used along side the existing "major" security
>> modules mechanism for sharing these blobs is provided.
>>
>> A side effect of providing sharing of the crendential
>> security blob is that the TOMOYO module can be used at
>> the same time as the other "major" modules.
>>
>> The mechanism for configuring which security modules are
>> enabled has to change when stacking in enabled. Any
>> module that uses just the security blobs that are shared
>> can be selected. Additionally, one other "major" module
>> can be selected.
>>
>> The security module stacking issues around networking and
>> IPC are not addressed here as they are beyond what is
>> required for TOMOYO, S.A.R.A and LandLock.
>>
>> git://github.com/cschaufler/lsm-stacking.git#stacking-4.19-rc2-saraloc=
k
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  Documentation/admin-guide/LSM/index.rst |  23 ++-
>>  fs/proc/base.c                          |  64 ++++++-
>>  fs/proc/internal.h                      |   1 +
>>  include/linux/lsm_hooks.h               |  20 ++-
>>  include/linux/security.h                |  15 +-
>>  kernel/cred.c                           |  13 --
>>  security/Kconfig                        |  92 ++++++++++
>>  security/apparmor/domain.c              |   2 +-
>>  security/apparmor/include/cred.h        |  24 ++-
>>  security/apparmor/include/file.h        |   9 +-
>>  security/apparmor/include/lib.h         |   4 +
>>  security/apparmor/lsm.c                 |  53 ++++--
>>  security/apparmor/task.c                |   6 +-
>>  security/security.c                     | 293 +++++++++++++++++++++++=
+++++++--
>>  security/selinux/hooks.c                | 215 ++++++++---------------=

>>  security/selinux/include/objsec.h       |  37 +++-
>>  security/selinux/selinuxfs.c            |   5 +-
>>  security/selinux/xfrm.c                 |   4 +-
>>  security/smack/smack.h                  |  42 ++++-
>>  security/smack/smack_access.c           |   4 +-
>>  security/smack/smack_lsm.c              | 283 +++++++++++------------=
-------
>>  security/smack/smackfs.c                |  18 +-
>>  security/tomoyo/common.h                |  31 +++-
>>  security/tomoyo/domain.c                |   4 +-
>>  security/tomoyo/securityfs_if.c         |  15 +-
>>  security/tomoyo/tomoyo.c                |  57 +++++--
>>  26 files changed, 899 insertions(+), 435 deletions(-)
>>
>=20


--wlIgseE8uGy21t8rLeoSLitsACGY9OGDi--

--6t2AHDVawcfDyXz43It5ZPOAYstQl28sP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAlugrO8ACgkQIt7+33O9
apUf5Af+JJNP6M6qsRzVbsUmXo2eiDaxhGn8mU5ndWw/x6DMHAOtG4D6ug7P59lb
uXx9yG2T5+6haVYEtifoPEiVadVCOoC/y3Po93WUIbQSJhOvb9RYb1ILRR13TYrw
q2MUMA39HiDhva4tkyxAJYBBOum9MFiRYjZudqJIneMnhDE2v7W5SoUlUiO75kYL
yhnoDB0WbkdnNjbdAek8JtRbTqYWKH81+pXMXwNwBc3IP2/stVAW3AAz0P4YAjSE
/Jj5EkrVAEy6A+sQOQm2kHmET0mFI2py5kSKMqYHZ8eWVG7FsSo3e9jqxyE+LRQl
oy7gkpId6zo9HtFD6Ktuwry9YZf8Ag==
=ILf6
-----END PGP SIGNATURE-----

--6t2AHDVawcfDyXz43It5ZPOAYstQl28sP--
