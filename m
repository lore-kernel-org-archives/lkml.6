Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFF7C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355D7208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="RhLG1oK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355D7208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeFUG4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:56:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42128 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeFUG4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:56:21 -0400
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so1892943wrk.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 23:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=qTg/8ATEP6+0DM1qAGzns1E8BdIEEtcJZp32EkqQlZs=;
        b=RhLG1oK41gjCmvTf4aL4s1nivCOIeeUclhMJdOE0mEQAx/K+TvtZmhiUhSHNXyR9tv
         CsqXtpK9YGFdcSht+7ziEhMO2VrqSb37tVDqR751ENEOKRdDm57VHH7yof0ncxjDSCH2
         7lWa5VRfgdJ6pXidRzdzYqSJRlruV5LACcIy20XGOItPome3WjkJnmQWxY10JVOM332m
         COfwfkxYncuk9RXWGa9DJXg/v5yqbvTyRS++PD5zJ20F97PjbfAdHN18JN3EoaR+vMhx
         hePLrWSGTQgbD6TKXLA0W1GYtm5LMWjKwHgKRaCTeLbiDD3uxYzoggI3PjZvt2IRtt9T
         KjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=qTg/8ATEP6+0DM1qAGzns1E8BdIEEtcJZp32EkqQlZs=;
        b=rtMR0QEPRo9srf4Z5oms2cMUgPCZkWUBzh9BwyzoLLlc8U8VpFGA7LHRjhZHKuIDzY
         x44wtmblc2KwOqBjlIXaaw2Cl8n8Bgvdc2ntajOkeTzB3PL0pmBDCIaA5uIf2kWuh5xp
         jPB2804LEMFqQUyDX0zu9HCWYgwds74fp48CJu30Simn0gV6TdXerIq5+K0TSetAsNEL
         0WhzkK+Y+fYDL5kLY5QI+i1ixUJS6ZCniL1JITUqJEJMhpS4J13Im024f2sWJ76sbS0Y
         j7KCoPAfMkn5eWN71qTeCzBrdSBdQ8F2W6xLrI0LIETp2DnaDmiCGeWQE2w4PzOoKPBR
         KtSw==
X-Gm-Message-State: APt69E0CF2dIboOppK6R6QMpnvDBBlwa83Ecm7lyeKRPHPElphKPqR7d
        uQ5NES+Rge5FC0zIDwHXdTYv+g==
X-Google-Smtp-Source: ADUXVKKik6Ujb+cbi+SlTmBY1Lwexi5W3hHYBZO9THNH3JCPm5Xq0EQ/EaFvblw+2CdQhn8PZolnVw==
X-Received: by 2002:adf:889c:: with SMTP id f28-v6mr4894555wrf.250.1529564180001;
        Wed, 20 Jun 2018 23:56:20 -0700 (PDT)
Received: from [64.233.166.109] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id b186-v6sm5050188wmh.4.2018.06.20.23.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 23:56:19 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] microblaze: Add new syscalls io_pgetevents and rseq
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        u-boot@lists.denx.de, Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <b08f5d64603a7aca3f9dd0a9fb57c6d7bc3b433e.1528957563.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <9f59a1b3-0719-3a20-be54-8da330e1c93b@monstr.eu>
Date:   Thu, 21 Jun 2018 08:56:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b08f5d64603a7aca3f9dd0a9fb57c6d7bc3b433e.1528957563.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mkEJMaDCHLbGPZrwnr3MeDj5W021076rK"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mkEJMaDCHLbGPZrwnr3MeDj5W021076rK
Content-Type: multipart/mixed; boundary="W7e8K261iKNQsIS9J7G9ZN59PjFC9m0X0";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>, u-boot@lists.denx.de,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <9f59a1b3-0719-3a20-be54-8da330e1c93b@monstr.eu>
Subject: Re: [PATCH] microblaze: Add new syscalls io_pgetevents and rseq
References: <b08f5d64603a7aca3f9dd0a9fb57c6d7bc3b433e.1528957563.git.michal.simek@xilinx.com>
In-Reply-To: <b08f5d64603a7aca3f9dd0a9fb57c6d7bc3b433e.1528957563.git.michal.simek@xilinx.com>

--W7e8K261iKNQsIS9J7G9ZN59PjFC9m0X0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.6.2018 08:26, Michal Simek wrote:
> Wire up new syscalls io_pgetevents and rseq.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
>  arch/microblaze/include/asm/unistd.h      | 2 +-
>  arch/microblaze/include/uapi/asm/unistd.h | 2 ++
>  arch/microblaze/kernel/syscall_table.S    | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/inc=
lude/asm/unistd.h
> index 9774e1d9507b..a62d09420a47 100644
> --- a/arch/microblaze/include/asm/unistd.h
> +++ b/arch/microblaze/include/asm/unistd.h
> @@ -38,6 +38,6 @@
> =20
>  #endif /* __ASSEMBLY__ */
> =20
> -#define __NR_syscalls         399
> +#define __NR_syscalls         401
> =20
>  #endif /* _ASM_MICROBLAZE_UNISTD_H */
> diff --git a/arch/microblaze/include/uapi/asm/unistd.h b/arch/microblaz=
e/include/uapi/asm/unistd.h
> index eb156f914793..7a9f16a76413 100644
> --- a/arch/microblaze/include/uapi/asm/unistd.h
> +++ b/arch/microblaze/include/uapi/asm/unistd.h
> @@ -415,5 +415,7 @@
>  #define __NR_pkey_alloc		396
>  #define __NR_pkey_free		397
>  #define __NR_statx		398
> +#define __NR_io_pgetevents	399
> +#define __NR_rseq		400
> =20
>  #endif /* _UAPI_ASM_MICROBLAZE_UNISTD_H */
> diff --git a/arch/microblaze/kernel/syscall_table.S b/arch/microblaze/k=
ernel/syscall_table.S
> index 56bcf313121f..6ab650593792 100644
> --- a/arch/microblaze/kernel/syscall_table.S
> +++ b/arch/microblaze/kernel/syscall_table.S
> @@ -400,3 +400,5 @@ ENTRY(sys_call_table)
>  	.long sys_pkey_alloc
>  	.long sys_pkey_free
>  	.long sys_statx
> +	.long sys_io_pgetevents
> +	.long sys_rseq
>=20

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--W7e8K261iKNQsIS9J7G9ZN59PjFC9m0X0--

--mkEJMaDCHLbGPZrwnr3MeDj5W021076rK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlsrTAwACgkQykllyylKDCH80gCfX0zqGAat+iqPrTaPGTHVE+8g
9i4AnRby530iP8iyHr5Dm6AW4QCQ7IB3
=RpiC
-----END PGP SIGNATURE-----

--mkEJMaDCHLbGPZrwnr3MeDj5W021076rK--
