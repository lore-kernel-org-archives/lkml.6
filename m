Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D741CFF05E2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769E620893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769E620893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeG2NvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:51:03 -0400
Received: from bues.ch ([80.190.117.144]:42624 "EHLO bues.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbeG2NvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:51:03 -0400
X-Greylist: delayed 2209 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Jul 2018 09:51:03 EDT
Received: by bues.ch with esmtpsa (Exim 4.89)
        (envelope-from <m@bues.ch>)
        id 1fjk6u-0000Lt-CE; Sun, 29 Jul 2018 13:43:40 +0200
Date:   Sun, 29 Jul 2018 13:42:02 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [TRIVIAL RFC PATCH] Kconfigs - reduce use of "depends on
 EXPERT"
Message-ID: <20180729134202.5ab56762@wiggum>
In-Reply-To: <27780ceb2056b871d746803a2ac23464396f3026.camel@perches.com>
References: <27780ceb2056b871d746803a2ac23464396f3026.camel@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/zF+NOvxa9zL7F4P8tC0wFvf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zF+NOvxa9zL7F4P8tC0wFvf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Jul 2018 15:13:00 -0700
Joe Perches <joe@perches.com> wrote:

>  config SSB_SILENT
> -	bool "No SSB kernel messages"
> -	depends on SSB && EXPERT
> +	bool "No SSB kernel messages" if EXPERT
> +	depends on SSB
>  	help
>  	  This option turns off all Sonics Silicon Backplane printks.
>  	  Note that you won't be able to identify problems, once


What about removing this option entirely?
We would just have to remove it from Kconfig and from its only use in
drivers/ssb/ssb_private.h
I don't think anybody uses (or should use) this option anyway.
That would reduce the EXPERT dependencies by one, which is a good
thing. :)

--=20
Michael

--Sig_/zF+NOvxa9zL7F4P8tC0wFvf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAltdqAoACgkQ9TK+HZCN
iw4Ktw//R+OJKZ2oixZtTGzCwin21bIigZ+8SeqCv3UwNZELVGrvuQnQTWmF9i9T
1kKqo82CZnHL9udgdJqFPp+zvQWDrohX45C0j+ROzBpsyNACaGU3wy7cxayv+0Bn
uTvuRdN4LiBzkaOV1HLu6HN6RYDujuGreIe0v+ks/ugNiRPxg1QopUGISu0N98kw
e4ypm/A3RnU+Ho4T2P3tZFAhc9PVXAUmaIT43rmxZtKxJ0Q0eCjBJmtugr0ffxYg
fg6iG11O/zREjA0Ha9BBaOhVGTj9qg+e2X2w/hdslhfMl1Fft3//JsKRqZPlNfV7
FI6IUx8NqwR0Cmu2b4wVtjyqNkz/1zOh2mbdkWGRQ92IpFDjaLIONo1Xd9ad/L15
VaEckI9AlR7/Jzzz/ZHozXobS/VivBYJi35t0VseWV4kU1x4vvtlAyH7ofnlru6F
Uk5EP3iS7qIPN3fP++ecJ8zPIJEoulxTRTj3PMW9r8io9xXWhR0cywMD8urk64XE
zLB83QiP2ptqGncUYtTdKC1+0rEhmaZgDcLb7Uud+kUCcKLrs73PQWZFyMcURo63
LGArOw9KENQuxhro8f7H0EUUkp44SCOlTtxEebiFka7sB2V67aGPDk9+iNEXyDny
rwPgn393I6XpWKEe83nWlR5z2aK740mzSR0E0AKF64LJW4EnWnU=
=fPeg
-----END PGP SIGNATURE-----

--Sig_/zF+NOvxa9zL7F4P8tC0wFvf--
