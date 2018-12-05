Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEC6C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E592084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="gVRyw7+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E592084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbeLEPaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:30:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34186 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbeLEP37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:29:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so12036039wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 07:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=Ur086D7qzDoupcVAByhiQQIwNEmAWU9EL932ufFCXSc=;
        b=gVRyw7+2g5KFCamDnZaliagJzRR+8ZW/wry1HEYx8H2xI4jpnB0Me40TNKY7YHKe0S
         pxFTB6QNOUdWNxtXO/tD14kMjV3bHXMo+lOTwWRUlCddHu4yTNj6mqXvoSHLyuy5xChK
         Aa/VeTjhz4+jI0mENDqayDErCiOBtGguQViGy+qCrUnUqtL64Qo5nV1jF1Q7PaDO3nn0
         1GYg1uFzfOABmwsQ9TarYKtQtJ+lX8IdnRBrXt2lMtmlQzK+qxdgLYZHR7lcaAGGE9bf
         2Kk2k2iz8ej8EFJpbouIML+tRU+v/fQp8vv0ZrAGqAy9RIBpqHWExPi5zqRw57kxX280
         GISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=Ur086D7qzDoupcVAByhiQQIwNEmAWU9EL932ufFCXSc=;
        b=cZPDVCRHKgDdYAnBn/9OE6wDs/kjhrF3U6MfG952/cTl84TYu/zHueoMEOJYFgYft4
         bBS53hxksA2sUCSShCbXwuDZ4zqmVWpwMME1u4y3nM5vdafljNQd9aFaTTr8ovvpQ2E5
         xBP2l36QZFDzkDSgkDKWCpFGxwnAz87DtoTaDq7H1ABSZVdqWvu+OWbrwvyfHRXa6mBx
         DlbGezQoKt6CKh6MykWLrBTH/KVZUpktyKq1QVrOFdMTtxILp/oKesGJ/1GMPDLv3B1d
         5UsidTWJ5Kh0Gt3UYbKm86HjenHqFB8xdxJUfWCTvgK0ez8u+GVlyNTtQE5XO15th7DA
         rjUg==
X-Gm-Message-State: AA+aEWamJVokfctCbZ0oVpZYcfIZ1S92LGAcrhoKjWaOQTs6ypvCZRVu
        NI1TAlh/MKHUfFtKrFYfJkn6ow==
X-Google-Smtp-Source: AFSGD/UHtq4fk2Wl67rrTSZM/Q3hwcRK9hTJrXAQMEQQBKeuqJAU/I+aTPVjWv7XJam/i7TTO8Knpw==
X-Received: by 2002:a1c:2e0c:: with SMTP id u12mr16477992wmu.81.1544023797695;
        Wed, 05 Dec 2018 07:29:57 -0800 (PST)
Received: from [74.125.206.109] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id p74sm20297323wmd.29.2018.12.05.07.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 07:29:56 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH v2 2/6] microblaze: prefer memblock API returning virtual
 address
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Greentime Hu <green.hu@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mark Salter <msalter@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-3-git-send-email-rppt@linux.ibm.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <0a5e0aef-15fd-2d0c-765c-e7ba60219b00@monstr.eu>
Date:   Wed, 5 Dec 2018 16:29:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543852035-26634-3-git-send-email-rppt@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="p80uXp4MQpFTW9kBmtIO081Y5oGpJXXIR"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p80uXp4MQpFTW9kBmtIO081Y5oGpJXXIR
Content-Type: multipart/mixed; boundary="qysf5netJxUn4CkAZbDPuVrHjaMDiAo4f";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Mike Rapoport <rppt@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "David S. Miller" <davem@davemloft.net>, Guan Xuetao <gxt@pku.edu.cn>,
 Greentime Hu <green.hu@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mark Salter <msalter@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
 sparclinux@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>
Message-ID: <0a5e0aef-15fd-2d0c-765c-e7ba60219b00@monstr.eu>
Subject: Re: [PATCH v2 2/6] microblaze: prefer memblock API returning virtual
 address
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-3-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1543852035-26634-3-git-send-email-rppt@linux.ibm.com>

--qysf5netJxUn4CkAZbDPuVrHjaMDiAo4f
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03. 12. 18 16:47, Mike Rapoport wrote:
> Rather than use the memblock_alloc_base that returns a physical address=
 and
> then convert this address to the virtual one, use appropriate memblock
> function that returns a virtual address.
>=20
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/microblaze/mm/init.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> index b17fd8a..44f4b89 100644
> --- a/arch/microblaze/mm/init.c
> +++ b/arch/microblaze/mm/init.c
> @@ -363,8 +363,9 @@ void __init *early_get_page(void)
>  	 * Mem start + kernel_tlb -> here is limit
>  	 * because of mem mapping from head.S
>  	 */
> -	return __va(memblock_alloc_base(PAGE_SIZE, PAGE_SIZE,
> -				memory_start + kernel_tlb));
> +	return memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
> +				MEMBLOCK_LOW_LIMIT, memory_start + kernel_tlb,
> +				NUMA_NO_NODE);
>  }
> =20
>  #endif /* CONFIG_MMU */
>=20

I can't see any issue with functionality when this patch is applied.
If you want me to take this via my tree please let me know.
Otherwise:

Tested-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--qysf5netJxUn4CkAZbDPuVrHjaMDiAo4f--

--p80uXp4MQpFTW9kBmtIO081Y5oGpJXXIR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlwH7ugACgkQykllyylKDCF+oQCcD3h8FTgH3lqEuM6g3LYVVKdA
5FUAn2kZEag4xhKtRwOtFFVaEnckXAmY
=WdzP
-----END PGP SIGNATURE-----

--p80uXp4MQpFTW9kBmtIO081Y5oGpJXXIR--
