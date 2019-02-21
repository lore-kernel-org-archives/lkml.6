Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A158C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA8C2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="f6Fkw0Go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfBUU1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:27:01 -0500
Received: from ozlabs.org ([203.11.71.1]:39925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfBUU1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:27:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4455by5vYQz9s2R;
        Fri, 22 Feb 2019 07:26:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550780819;
        bh=k3UJ4mgwDZw5DMq/ce6nehIxwBl84NC1aJqDccquDfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f6Fkw0GoLTopVpgo0dVBg0EuY7pC38AncgYBICmrkj12cHAjE3Ls+1CZ06dHlFRbV
         MuxgGEn9b14MqkqZckHQTqTwtHFIiPpFhkC8oe5D6t6/KmSEc1MxDw4t+ihSqYhZxd
         OdsVV3uKvx7ZCJlWPl78t+U8wVLvNa5om22Jr/x6jtrw/Dre2A1yHXjiOuwEMv3rZ7
         +m1VprGoCUPxru/m+z7ifROzrUryhJHz09JkRtCjDJ3+2JIeq0HZ6Hnm4C7x4mTEB/
         oovVjIK5TF1JQdCDhv/YzcOiqshMHdhtFGjHwmGQ8im+3oK6QK3njYBvkQmwwUG5Kz
         Yr+4UfeIetURQ==
Date:   Fri, 22 Feb 2019 07:26:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jann Horn <jannh@google.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH 5/6] lib: Fix function documentation for
 strncpy_from_user
Message-ID: <20190222072652.2441e8a2@canb.auug.org.au>
In-Reply-To: <CAGXu5j+Mf2D5LgkEmps7VVBhmNGt=49y4caP1y1E0OBURJEeXQ@mail.gmail.com>
References: <20190218232308.11241-1-tobin@kernel.org>
        <20190218232308.11241-6-tobin@kernel.org>
        <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com>
        <CAGXu5jKeS3bkTSXEw2nsjrWoqhbkDZD4C=PdYTHMtM0GNk6tSg@mail.gmail.com>
        <20190221052435.GF11758@eros.localdomain>
        <CAGXu5j+Mf2D5LgkEmps7VVBhmNGt=49y4caP1y1E0OBURJEeXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/16HKosc1eB4/OdJ8zARR2vg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/16HKosc1eB4/OdJ8zARR2vg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Wed, 20 Feb 2019 22:02:32 -0800 Kees Cook <keescook@chromium.org> wrote:
>
> What I can't quite figure out yet is how to find a way for sfr to flag
> newly added users of strcpy, strncpy, and strlcpy. We might need to
> bring back __deprecated, but hide it behind a W=3Dlinux-next flag or
> something crazy. Stephen, in your builds you're already injecting
> -Wimplicit-fallthrough: do you do W=3D1 or anything like that? If not, I
> think we need some W=3D setting for your linux-next builds that generate
> the maintainer-nag warnings...

I just have a set of compiler flags that my build scripts explicitly
enable by setting KCFLAGS.

--=20
Cheers,
Stephen Rothwell

--Sig_/16HKosc1eB4/OdJ8zARR2vg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxvCYwACgkQAVBC80lX
0Gy1iAgAipXsrzM+7B/eQNkmcSgakfzIso73aGvuVcrZUvqIJCwDQTO9URAJ5YL2
1kp/2Q4mkvXyRyun2CpFs6xry0kgo0FmVqOCjTxZE49JlZYPSiWnjaI5VLfdAy2h
L6G9jf2FKSapWuacbEJUqxne7UIMEe7OMJBsCoAKcXAo3snwbPRNhO8fGAhVzFMd
6hKFPWMymq6qEPrigr9J5yB1Q0lTGbz8tsh65AE0ENMswGHcJYFgN/nEb05eHx2h
G3rQhy2wX5WItnRhhXsueYwEE2oSRBFC8AfL+5N8zPW/RX+8fo91kg6rOZZpU0mX
/Lxm95vnAbmfahlPbpsaZACDSIVCUA==
=QQ0T
-----END PGP SIGNATURE-----

--Sig_/16HKosc1eB4/OdJ8zARR2vg--
