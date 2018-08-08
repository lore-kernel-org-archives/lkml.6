Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE40C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0261A21737
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="upblgrDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0261A21737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeHHNYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:24:14 -0400
Received: from ozlabs.org ([203.11.71.1]:60241 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeHHNYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:24:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41lpSL6wzWz9ryt;
        Wed,  8 Aug 2018 21:04:50 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533726299;
        bh=DVpGWns8ge1wpKonwTWgPpPLFmArBnFJvOSVZKlYixY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=upblgrDMab/8oLt+axdv8zXii18uCxhhueYVyCqzJGGrd3tpMv90rjtogkQLNMWUt
         U8c7NsWxIBPPidavnwC7+VhuxVxoWvrjw/zvIMcNgH87+7gbMMH+ruLm00YRnKZ84V
         54RAOvfFz1qk9VL38xCGqqls+oKfG9zIbLYD83aAtwBTibKGoJVbe24TKX8009WEjC
         vTBQkZUMv0mEKvzhsHcAbS/MFNbX8q7MkGoXg9/OHBAY8phvT+ECSbAtoAS6r4Ftev
         14oX/wgmCCD+RRL5ix3GuTWNYQXudpOEsPFMPK5U/R/LxYthNB+/TfcC82xmQ/PBKE
         cgMoTJQIhTkvg==
Date:   Wed, 8 Aug 2018 21:04:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, vdavydov.dev@gmail.com,
        mhocko@suse.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 01/10] rcu: Make CONFIG_SRCU unconditionally enabled
Message-ID: <20180808210450.02108372@canb.auug.org.au>
In-Reply-To: <9ac119a7-4142-3a5a-6c4b-6f35ad026cb0@virtuozzo.com>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
        <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
        <20180808110827.65631461@canb.auug.org.au>
        <9ac119a7-4142-3a5a-6c4b-6f35ad026cb0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NS9RdzWSmlMIFWUxGHf7hWB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NS9RdzWSmlMIFWUxGHf7hWB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kirill,

On Wed, 8 Aug 2018 12:59:40 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 08.08.2018 04:08, Stephen Rothwell wrote:
> >=20
> > So what sort of overheads (in terms of code size and performance) are
> > we adding by having SRCU enabled where it used not to be? =20
>=20
> SRCU is unconditionally enabled for x86, so I had to use another arch (sp=
arc64)
> to check the size difference. The config, I used to compile, is attached,=
 SRCU
> was enabled via:
>=20
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 2d58c26bff9a..6e9116e356d4 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -15,6 +15,7 @@ config SPARC
>  	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
>  	select ARCH_MIGHT_HAVE_PC_SERIO
>  	select OF
> +	select SRCU
>  	select OF_PROMTREE
>  	select HAVE_IDE
>  	select HAVE_OPROFILE
>=20
> $ size image.srcu.disabled=20
>    text	   data	    bss	    dec	    hex	filename
> 5117546	8030506	1968104	15116156	 e6a77c	image.srcu.disabled
>=20
> $ size image.srcu.enabled
>    text	   data	    bss	    dec	    hex	filename
> 5126175	8064346	1968104	15158625	 e74d61	image.srcu.enabled
>=20
> The difference is: 15158625-15116156 =3D 42469 ~41Kb

Thanks for that.

> I have not ideas about performance overhead measurements. If you have ide=
as,
> where they may occur, please say. At the first sight, there should not be
> a problem, since SRCU is enabled in x86 by default.

I have no idea, just asking questions that might be relevant for
platforms where SRCU is normally disabled.

--=20
Cheers,
Stephen Rothwell

--Sig_/NS9RdzWSmlMIFWUxGHf7hWB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltqzlIACgkQAVBC80lX
0Gxx3Qf7B8JdGdmyDUbzpSrVrCvYft5KUeWIit4wjayC3zqPfE6opmESJwxrGov6
ZfEobR/VNTg8r3HLAXSFgrGo0WUOdEyJwHYd1gfZZVdAevP/LzJMZ6TA8mNVQch8
/XUUGD1B4YL/sR6CNlzCPQnetJhqYxbrDDCbDM9Ek1E+ZnII4Un4or5bY4It4R66
5UaTWGuBK9T5005AkjoNXgb48F0AXA9jkprtxCD44n4hkuzr+1egFLyoonb/ZEoT
s73eJN8haDVsK5gZ4CUiKQBwuNZisllJ4+L6tGvEx6pKIVtQqJYrgVLJ5Sbaz6gG
qOOuGqBP07jhK/XSWTsL11dWLEe0bg==
=YY9L
-----END PGP SIGNATURE-----

--Sig_/NS9RdzWSmlMIFWUxGHf7hWB--
