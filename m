Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32873C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0382081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Pat9DP0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0382081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbeLJWCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:02:23 -0500
Received: from ozlabs.org ([203.11.71.1]:51729 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbeLJWCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:02:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43DH9l4kCDz9sB5;
        Tue, 11 Dec 2018 09:02:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544479340;
        bh=HKtHmeKNg7O8eyPBPZvaBkpFkghGUFWs838EdVRa+Ys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pat9DP0y/VeEtGMgriUGcejQojQsc7LYpxEkt2tD9qoINPQCim/AZpZsEGKTRCHS0
         i1+THlOUdt7dWZENfSSXwIWpjsgsRhaVGX9gtfXNoObjb1dhOpyX8CxC6Rd3lxlYaR
         kTyCaUnNgmTpTkV0jVJWGi+2tdUvHlLCkkdcYIaCLQnv1EWylYZyoHpESCq2GDDXiO
         7SR855KYVTgI9SoI/0t01jPn+LS0Xt2fzunoR4as8NnsS492qalOwczgLIza+cMgAc
         1mqH99fPUmn0ZWjrOg3/ryKs6pp61JDLYDif0L5rhrW9Piq1cDe2jc8weaCzK9vJFV
         7XcRbnK1JeQcQ==
Date:   Tue, 11 Dec 2018 09:02:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Oscar Salvador <osalvador@suse.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stefan Agner <stefan@agner.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: mm: remove unused variable
Message-ID: <20181211090219.52ef9144@canb.auug.org.au>
In-Reply-To: <20181210205309.2794444-1-arnd@arndb.de>
References: <20181210205309.2794444-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/awIiuti6fPXSpOfYGgukl7U"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/awIiuti6fPXSpOfYGgukl7U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Mon, 10 Dec 2018 21:53:02 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>
> A recent change dropped the only user of the variable, which should
> now be removed as well to avoid this warning:
>=20
> arch/x86/mm/init_32.c: In function 'arch_remove_memory':
> arch/x86/mm/init_32.c:867:15: error: unused variable 'zone' [-Werror=3Dun=
used-variable]
>=20
> Fixes: dd99d07f818b ("mm, memory_hotplug: move zone/pages handling to off=
line stage")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/mm/init_32.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> index 0b8c7b0033d2..c75c26497c4f 100644
> --- a/arch/x86/mm/init_32.c
> +++ b/arch/x86/mm/init_32.c
> @@ -864,7 +864,6 @@ int arch_remove_memory(int nid, u64 start, u64 size, =
struct vmem_altmap *altmap)
>  {
>  	unsigned long start_pfn =3D start >> PAGE_SHIFT;
>  	unsigned long nr_pages =3D size >> PAGE_SHIFT;
> -	struct zone *zone;
> =20
>  	return remove_sections(nid, start_pfn, nr_pages, altmap);
>  }

I have added that to the akpm-current tree for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/awIiuti6fPXSpOfYGgukl7U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwO4msACgkQAVBC80lX
0Gzm9wf/dSfwUsoyQFbNXkl4+eROm0GkEFHV99iqMaev43pS7jw1t3OMTPB7kXHf
BG5Hc+FsR0TAOM6ODUKK2C7a1a8MePnvoDxiB3xnanNRNdhLBdJnTqgTeRwNBj+D
ihQXzh3IC7sQaSAfYWE7beD8SPngMG0QwwvcR95wz2gG+FFo3exm2I5S5DaQ7WrO
ZySJz/5xpzx+Epw+u7CMu+KhngGt58PmZb5ehfuAApMlJvT7+V03aA761bykZF3B
/N3y8FJkFVukC9t8FTV7sKKCkiQQKLplY1Rx4tWmHN4TEcTCGLA7g8Pum/jT9KKK
b5Da4YJKD3CYypMH1t3uRvLrLQrfBw==
=D6fF
-----END PGP SIGNATURE-----

--Sig_/awIiuti6fPXSpOfYGgukl7U--
