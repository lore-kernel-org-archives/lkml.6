Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AG47ELuQRcACx8DFWmsPDqazXCjKqEJlaSQBve66Lyw22S6T6QqWV+2UeAPDp6QtIDjL0yPd5P9m
ARC-Seal: i=1; a=rsa-sha256; t=1521075250; cv=none;
        d=google.com; s=arc-20160816;
        b=Ls8V7jpzxuIt8KwOvg528OUn8rMgWnBGvSGP1u0mhCUpjCRk+kfWzv2ga/sE6RTz9m
         58aVmDTy2eNsZ4/vu+6ZysHzvGhn1iT4uEzMN6GWS2KyP1etm9VlRzKhP467ZSSHSC7l
         AP4ARvyywM4QFHN6QiBzYTyBq6HyCAB9Y4NrJWl2eUP2k+CCTKnbuRmA46Kko7XVA11A
         xh/dukrHLPOJ4On566orYM4XAggKCeKixhja1xtqQen9Wusgkmkt7jbnCA+1463oUVnc
         0daECihaVhf/BYZedG97YAieCzMcCL2olaN5gI3C48VPz1Y7sPJ3krCiI7TVa7M48oVg
         qF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:arc-authentication-results;
        bh=O2ghVScbhcf9DCVM+dnTTxF7snT7aOBX1+vchN90Smw=;
        b=0jLmScOSBZGD5b+KVvSo3ZH6jCKKPsH85rTAYqU+1AawbXyxAgupjcTwp4o+fEi8ge
         WKZEllYeyIFi3AE0cbBVpQ27pTNGOeaABmGtcg7NkPQZvwIMlHWA4GPJlYvn/EKcV/o9
         WWulo5pFbVzZPf7D+HX6bvozBuGN3os0bhUGeMVKLwZKHaTYKR2dhL59JLpQA2m3Q9N3
         cwbKZMKNielW0FVIv2bTLR+JD8RH2Ev/5q0y/fFfc4R9rcp9hsbjkzD2IIXMx7RQ/qMX
         c1DVlsqkqISHCel8vve+s+FvGL209yZT5Lx7KH8NJHr4OiBzxcLPrQu8dcseVlUzVVqO
         9lfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathieu Malaterre <malat@debian.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Mark the variable earlycon_acpi_spcr_enable maybe_unused
In-Reply-To: <20180310180645.7014-1-malat@debian.org>
References: <20180310180645.7014-1-malat@debian.org>
Date: Thu, 15 Mar 2018 11:54:06 +1100
Message-ID: <87lgeuf9ap.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594575013229600361?=
X-GMAIL-MSGID: =?utf-8?q?1594963001098064452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Mathieu Malaterre <malat@debian.org> writes:
> Subject: Re: [PATCH] powerpc: Mark the variable earlycon_acpi_spcr_enable=
 maybe_unused

You're fixing an error on powerpc, but the patch is to the serial code,
so the subject should probably be more like:

  serial: core: Mark the variable earlycon_acpi_spcr_enable maybe_unused

cheers

> Re-use the object-like macro EARLYCON_USED_OR_UNUSED to mark
> `earlycon_acpi_spcr_enable` as maybe_unused.
>
> Fix the following warning (treated as error in W=3D1)
>
>   CC      arch/powerpc/kernel/setup-common.o
> In file included from ./include/linux/serial_8250.h:14:0,
>                  from arch/powerpc/kernel/setup-common.c:33:
> ./include/linux/serial_core.h:382:19: error: =E2=80=98earlycon_acpi_spcr_=
enable=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>  static const bool earlycon_acpi_spcr_enable;
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  include/linux/serial_core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index b32df49a3bd5..1d356105f25a 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -379,7 +379,7 @@ extern int of_setup_earlycon(const struct earlycon_id=
 *match,
>  extern bool earlycon_acpi_spcr_enable __initdata;
>  int setup_earlycon(char *buf);
>  #else
> -static const bool earlycon_acpi_spcr_enable;
> +static const bool earlycon_acpi_spcr_enable EARLYCON_USED_OR_UNUSED;
>  static inline int setup_earlycon(char *buf) { return 0; }
>  #endif
>=20=20
> --=20
> 2.11.0
