Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D27C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050A220883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="dmSAU6a7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050A220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389505AbeKPSmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:42:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34367 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeKPSmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:42:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so23936120wre.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 00:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=eYJ5ASopu/myAhVLEw+Bxqbner8R1z9kNbAU9dIvz+s=;
        b=dmSAU6a73gA0bA+NSyX2NxHDRjMkjOv4+qH7Dzmgs1odS/fDHWH3sJ5z6Oehev96Sc
         +9x4uj+8Je5Odc04tYvwn0fkjti86eWQlu0v8ZrGOiCPp2loJ8fLD/HLS4NW3v4MNjiS
         slBSVijEA37faupfmjE6b/TwNK7j7AZNQkla2hgGawJZGCoCIYL9WtmPPiWdZRHp/XZG
         acfBXMIvOhCrJoxedasT9myAcatL95pgUB1Euule/cRi1tmRsZB2xmSqudIJnm1cagK3
         48d04ScihpHvKOndD0vCIeSRnjm8aeu1mDC6jr/XOzn1eTRzSQZhHis+R89IZDH+Mqlu
         a4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=eYJ5ASopu/myAhVLEw+Bxqbner8R1z9kNbAU9dIvz+s=;
        b=tPWrqaMGmWHoZVFubTyH6LTGbueDBqEItxRvjWG4oo//p3KF2Pmn51oNTn83XPhGZ/
         qMCN5hYFw9LSj/aBbM2c/pgZb9vEmbDMhQl8pzvI+QlT1sB1JbyVZxCsLuThycrhhPNB
         o5PzhbJH8c6DXsJXH+dkhRIZi4ZJQ2OJsnuQ2ozUM1y0t9waSG95rY8zCX+c04L6v7Q9
         yo2Du93ModY5BM90iCNYG5VpYUPvjLUCrGXDqU9/T4fcV7jh4mVflRte/kt5mbUwD/Ox
         mqpOpypkOoO19LVFx27k+H+M9HP+Lqdiu85Z8BT3bxZJ+T1AQdHxt1GGvUAYzi1b7qts
         epFw==
X-Gm-Message-State: AA+aEWboJHkyEZDuJZXbBhCbqfh+xLsWD+J8ku15moiVoqELWVRgCqCr
        LlqEh55/1PzDaK/PVkCS44BwDQ==
X-Google-Smtp-Source: AFSGD/VsmUNobabOlWJjH+n8d0P1xQUYdJhPQ2DcpoIf7yyngpgMosA/MRGTbVb4jehD5IrtfxHuPA==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr6528648wrs.272.1542357074307;
        Fri, 16 Nov 2018 00:31:14 -0800 (PST)
Received: from [64.233.167.108] ([149.199.62.129])
        by smtp.gmail.com with ESMTPSA id z17sm5229569wrv.2.2018.11.16.00.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 00:31:13 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH v4 0/3] microblaze: system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
References: <1542089074-20027-1-git-send-email-firoz.khan@linaro.org>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <632c1d3f-26cf-7e65-4e7a-cc882ef168c4@monstr.eu>
Date:   Fri, 16 Nov 2018 09:31:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542089074-20027-1-git-send-email-firoz.khan@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="W0OFtpJrjHn1JGCgnYWWSnZBTKoztM5XW"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W0OFtpJrjHn1JGCgnYWWSnZBTKoztM5XW
Content-Type: multipart/mixed; boundary="Pla37rODYW6n9t799SvllDnYNa0LfYfpM";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Firoz Khan <firoz.khan@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
 marcin.juszkiewicz@linaro.org
Message-ID: <632c1d3f-26cf-7e65-4e7a-cc882ef168c4@monstr.eu>
Subject: Re: [PATCH v4 0/3] microblaze: system call table generation support
References: <1542089074-20027-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542089074-20027-1-git-send-email-firoz.khan@linaro.org>

--Pla37rODYW6n9t799SvllDnYNa0LfYfpM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13. 11. 18 7:04, Firoz Khan wrote:
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the
> system call table generation support implementation
> across all the architectures.
>=20
> The system call tables are in different format in
> all architecture. It will be difficult to manually
> add, modify or delete the system calls in the resp-
> ective files manually. To make it easy by keeping a
> script and which'll generate uapi header file and
> syscall table file.
>=20
> syscall.tbl contains the list of available system
> calls along with system call number and correspond-
> ing entry point. Add a new system call in this arch-
> itecture will be possible by adding new entry in the
> syscall.tbl file.
>=20
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>=20
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to
> come up with a generic solution.
>=20
> I have done the same support for work for alpha, ia64,
> m68k, mips, parisc, powerpc, sh, sparc and xtensa.
> Below mentioned git repository contains more details
> about the workflow.
>=20
> https://github.com/frzkhn/system_call_table_generator/
>=20
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to
> solve Y2038 issue. So this patch series will help to
> add new system calls easily by adding new entry in
> the syscall.tbl.
>=20
> changes since v3:
>  - changed from generic-y to generated-y in Kbuild.
>=20
> changes since v2:
>  - optimized/updated the syscall table generation
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall_*.tbl.
>=20
> changes since v1:
>  - enclosed __NR_sycalls macro with __KERNEL__.
>  - added missing new line.

next time please also keep this changelog in every patch.

>=20
> Firoz Khan (3):
>   microblaze: move __NR_syscalls macro from asm/unistd.h
>   microblaze: add system call table generation support
>   microblaze: generate uapi header and system call table files
>=20
>  arch/microblaze/Makefile                      |   3 +
>  arch/microblaze/include/asm/Kbuild            |   1 +
>  arch/microblaze/include/asm/unistd.h          |   2 -
>  arch/microblaze/include/uapi/asm/Kbuild       |   1 +
>  arch/microblaze/include/uapi/asm/unistd.h     | 407 +-----------------=
-------
>  arch/microblaze/kernel/syscall_table.S        | 406 +-----------------=
-------
>  arch/microblaze/kernel/syscalls/Makefile      |  38 +++
>  arch/microblaze/kernel/syscalls/syscall.tbl   | 410 ++++++++++++++++++=
++++++++
>  arch/microblaze/kernel/syscalls/syscallhdr.sh |  36 +++
>  arch/microblaze/kernel/syscalls/syscalltbl.sh |  32 ++
>  10 files changed, 526 insertions(+), 810 deletions(-)
>  create mode 100644 arch/microblaze/kernel/syscalls/Makefile
>  create mode 100644 arch/microblaze/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh
>=20

Looks good now. I have queue it to next. And also asked our team to
retest everything.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--Pla37rODYW6n9t799SvllDnYNa0LfYfpM--

--W0OFtpJrjHn1JGCgnYWWSnZBTKoztM5XW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlvugEkACgkQykllyylKDCGuLACeLdJgfLbAgvM64yYaH5bB+U3u
4xcAnjD3dwMDCj1P1rF3YGv1ipQsJrSO
=0wDO
-----END PGP SIGNATURE-----

--W0OFtpJrjHn1JGCgnYWWSnZBTKoztM5XW--
