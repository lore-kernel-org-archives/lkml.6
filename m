Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B148ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2052920854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="ZJMSSnfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2052920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeKERhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:37:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34016 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKERhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:37:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id f1-v6so5761317wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 00:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=UiPzZDAEiD9tnSrkXJws+OQ5xX8Q+NV/LJI2c2kHI8U=;
        b=ZJMSSnfDC1dCkbveoP/swOc12TumH6jwgcQoqcqnPpl6aFY9OOBHGtsc1A3zjQ0zZa
         eWs36Wu8hvvub71HdK5vWB26wRA6Bxos9QUgn7rv5Zt5yV86DUjVTpNrurILontDdO5w
         aGoYCeY3AtJoM5Cv0HUF/A6fvGN3b5kW2qXsHOSmm+z52g9i26upc2Lk5h2PzCzrOWgN
         HmzAj95dPwF9T8xHGf0pWjKkaUhK/v71LleYS9ngicb09WOr1NGtW4SN10767NKa3y0C
         og+nCJCzza+sLx4M1FNn1gAAxk/WmBIg62bLC8nAnnxSU/hpFiUTURR3/5YNNUaRq8tJ
         9riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=UiPzZDAEiD9tnSrkXJws+OQ5xX8Q+NV/LJI2c2kHI8U=;
        b=pCmgyaaHuffbxXb1wXS9BWtJjSXR+R7YIG7w13ss8I9OYCzWYw6+ZYdPq+Ilg5u0Jp
         hBJRh10+BkUQhR0kdSbJ/YWMOOls5gfjDv2LRBf9RF4JKhwvoy8KT/YRlX1nDaopv6Zb
         8cuGYkrXKG6cJMNBfJCuaVt6Mra6hue7yS2JaAk1/DDPWEuEl6nt4SIT4ZvNDWSuKqgs
         keAthlayNEx3m9j920QDcGVzWPt9OtTeyX0pJ/9k7NlxdQAyQpSvz+OFkczVNLlh+xcP
         DEP7RuHA4g969g27oAuwa7MbdUL1xk+VEfgbDJ3Hlc0zoYyv30OUkoDDuplW9Nx5+p18
         k15g==
X-Gm-Message-State: AGRZ1gKTco5u43X92wp8RInmnJAR9TbUPsaLNQHGu7xIx3XPnGqNCHCA
        jfeg6MGP98+qYyupBs6JibwEKg==
X-Google-Smtp-Source: AJdET5cLjp/lC37624dKqWwaA8pTZ2jAnDwtH8yYdg3XvPbHAff5W3TnptyW7nWO9aTzUCB28oDAXQ==
X-Received: by 2002:a1c:4407:: with SMTP id r7-v6mr5380983wma.16.1541405942478;
        Mon, 05 Nov 2018 00:19:02 -0800 (PST)
Received: from [173.194.76.108] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id 191-v6sm31833545wmk.30.2018.11.05.00.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 00:19:01 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH v3 0/3] microblaze: system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
References: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <7af87565-19cc-df96-fe57-b0a8fe81d9cd@monstr.eu>
Date:   Mon, 5 Nov 2018 09:18:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TExgSfnQJEzmZukQQiCAHptMStTVOKVWI"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TExgSfnQJEzmZukQQiCAHptMStTVOKVWI
Content-Type: multipart/mixed; boundary="FlZnou0W2AEzHYm6OH75kAsiEjeopixzY";
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
Message-ID: <7af87565-19cc-df96-fe57-b0a8fe81d9cd@monstr.eu>
Subject: Re: [PATCH v3 0/3] microblaze: system call table generation support
References: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>

--FlZnou0W2AEzHYm6OH75kAsiEjeopixzY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 26. 10. 18 7:09, Firoz Khan wrote:
> The purpose of this patch series is, we can easily add/modify/delete
> system call table support by changing entry in syscall.tbl file=20
> instead of manually changing many files. The other goal is to unify=20
> the system call table generation support implementation across all=20
> the architectures.=20
>=20
> The system call tables are in different format in all architecture.=20
> It will be difficult to manually add, modify or delete the system=20
> calls in the respective files manually. To make it easy by keeping
> a script and which'll generate uapi header file and syscall table=20
> file.
>=20
> syscall.tbl contains the list of available system calls along with=20
> system call number and corresponding entry point. Add a new system=20
> call in this architecture will be possible by adding new entry in=20
> the syscall.tbl file.
>=20
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>=20
> ARM, s390 and x86 architecuture does exist the similar support. I=20
> leverage their implementation to come up with a generic solution.
>=20
> I have done the same support for work for alpha, ia64, m68k, mips,=20
> parisc, powerpc, sh, sparc, and xtensa. Below mentioned git repos-
> itory contains more details.
> Git repo:- https://github.com/frzkhn/system_call_table_generator/
>=20
> Finally, this is the ground work to solve the Y2038 issue. We need=20
> to add two dozen of system calls to solve Y2038 issue. So this patch
> series will help to add new system calls easily by adding new entry=20
> in the syscall.tbl.
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

where is the changelog?

Thanks,
Michal



--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--FlZnou0W2AEzHYm6OH75kAsiEjeopixzY--

--TExgSfnQJEzmZukQQiCAHptMStTVOKVWI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlvf/O4ACgkQykllyylKDCE0YwCfRKsTNOjT3vrYIlR9FC6hikXr
GMMAoJWWZZ/hbLe6fIMo8AlIlotzfpZN
=Ii+7
-----END PGP SIGNATURE-----

--TExgSfnQJEzmZukQQiCAHptMStTVOKVWI--
