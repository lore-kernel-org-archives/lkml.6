Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C8BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7BD2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDDxXQjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbfAKRRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:17:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34214 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbfAKRRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:17:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id j10so6583113pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HWuijyoxogeqOmnjxsgUR6E1Sj73yqh3WJbZNy4mPLU=;
        b=DDDxXQjQYHbDHOs/p+zC4+zNSsxyk0C/gs7x9AYZdsW72PaGC3N2h8HIq1rQvg86V/
         YAK2CMfpfoU6OOoeHWzUAWjpeSGN4RbMkFX1XdYY8ml/JcDrykiWEBpdwF26z0zCMtPw
         srX5IUafH0tCdwH76P3PUNO8czt/s6jQoVAwKM5XHMKcHshfDAdRBv4vF0UIBZ9p/RER
         DW7jtNVpFcc9219VccnGosUR8ha2781MoiHtHocQgHsBVaN98Tr4nE3RzOtPZx2koBN5
         N2KIXfd4AjUor493y9TaUL/PV7mLMTtn5ByD8uIpZF/Jq2uKpKQbHIP/UfSH+S0uaCWt
         2Xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=HWuijyoxogeqOmnjxsgUR6E1Sj73yqh3WJbZNy4mPLU=;
        b=V70cEV3u/bUdmJDX+kmOZE3hOepH25Y9F2cO3t8UXkUM17eTAh8SvLfjwBEYAuUdwk
         VqN1/1zSiMKrhRkuYJbYZZa3DkTNX1h0x9tU5N2aswQAjcyTblzhD1vMijl4l6IGmY5+
         MNhWh8uqnYoiBxnv96MBB/EA7eqQj0fVlV5Nq75O07/JTfttZ6OUro6sHNxzW4IB2lx3
         ZJGGe3wZIKi7SuQ3hAGqX+X8Dw+81ER++V925V0nQU/8hKXJzOYNm06zWp+Ug22VK709
         BL7UiNCMyIOd9jydezUcg3yHz8yi9g1p3qEIC0HBqPPBRXvbOlSJpT6dQYBhUawRwJzf
         05FA==
X-Gm-Message-State: AJcUukeQgtsVjARibW0H0qnjx6fQ00FFSqzU7BEhoCnpJJEcqGLH2KSx
        S7On2bplY8FSFaXVfJWShEU=
X-Google-Smtp-Source: ALg8bN6cYaqeGvN8+V/2tskQ0kgNt8sA2kXnw1yXZu2f/hCjWy2c/4OF4UnmA7xy2QBVgqxZwUh6Ag==
X-Received: by 2002:a62:db41:: with SMTP id f62mr15632100pfg.123.1547227067209;
        Fri, 11 Jan 2019 09:17:47 -0800 (PST)
Received: from gmail.com ([2605:e000:1117:c227:3b53:d0fe:bff:4913])
        by smtp.gmail.com with ESMTPSA id 125sm102513849pfg.39.2019.01.11.09.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 09:17:45 -0800 (PST)
Date:   Fri, 11 Jan 2019 07:17:43 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, esploit@protonmail.ch,
        jejb@linux.ibm.com, dgilbert@interlog.com,
        martin.petersen@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH] rbtree: fix the red root
Message-ID: <20190111171743.qx44dlsdaowdt3no@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        esploit@protonmail.ch, jejb@linux.ibm.com, dgilbert@interlog.com,
        martin.petersen@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <YrcPMrGmYbPe_xgNEV6Q0jqc5XuPYmL2AFSyeNmg1gW531bgZnBGfEUK5_ktqDBaNW37b-NP2VXvlliM7_PsBRhSfB649MaW1Ne7zT9lHc=@protonmail.ch>
 <20190111165145.23628-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yqofroxyylfvf7td"
Content-Disposition: inline
In-Reply-To: <20190111165145.23628-1-cai@lca.pw>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yqofroxyylfvf7td
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 11:51:45AM -0500, Qian Cai wrote:
> A GFP was reported,
>=20
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
>         kasan_die_handler.cold.22+0x11/0x31
>         notifier_call_chain+0x17b/0x390
>         atomic_notifier_call_chain+0xa7/0x1b0
>         notify_die+0x1be/0x2e0
>         do_general_protection+0x13e/0x330
>         general_protection+0x1e/0x30
>         rb_insert_color+0x189/0x1480
>         create_object+0x785/0xca0
>         kmemleak_alloc+0x2f/0x50
>         kmem_cache_alloc+0x1b9/0x3c0
>         getname_flags+0xdb/0x5d0
>         getname+0x1e/0x20
>         do_sys_open+0x3a1/0x7d0
>         __x64_sys_open+0x7e/0xc0
>         do_syscall_64+0x1b3/0x820
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>=20
> It turned out,
>=20
> gparent =3D rb_red_parent(parent);
> tmp =3D gparent->rb_right; <-- GFP triggered here.
>=20
> Apparently, "gparent" is NULL which indicates "parent" is rbtree's root
> which is red. Otherwise, it will be treated properly a few lines above.

Good catch, acked. After thinking through the logic a bit your solution
seems like the simplest fix.

Now, I didn't do _extensive_ testing but a quick compile and bootup of
the patch with CONFIG_KASAN_INLINE enabled has yet to throw any GFPs,
so take that as you will.

Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>
Tested-by: Joey Pabalinas <joeypabalinas@gmail.com>

> /*
>  * If there is a black parent, we are done.
>  * Otherwise, take some corrective action as,
>  * per 4), we don't want a red root or two
>  * consecutive red nodes.
>  */
> if(rb_is_black(parent))
> 	break;
>=20
> Hence, it violates the rule #1 and need a fix up.
>=20
> Reported-by: Esme <esploit@protonmail.ch>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  lib/rbtree.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/lib/rbtree.c b/lib/rbtree.c
> index d3ff682fd4b8..acc969ad8de9 100644
> --- a/lib/rbtree.c
> +++ b/lib/rbtree.c
> @@ -127,6 +127,13 @@ __rb_insert(struct rb_node *node, struct rb_root *ro=
ot,
>  			break;
> =20
>  		gparent =3D rb_red_parent(parent);
> +		if (unlikely(!gparent)) {
> +			/*
> +			 * The root is red so correct it.
> +			 */
> +			rb_set_parent_color(parent, NULL, RB_BLACK);
> +			break;
> +		}
> =20
>  		tmp =3D gparent->rb_right;
>  		if (parent !=3D tmp) {	/* parent =3D=3D gparent->rb_left */
> --=20
> 2.17.2 (Apple Git-113)
>=20

--=20
Cheers,
Joey Pabalinas

--yqofroxyylfvf7td
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlw4z7YACgkQ2rGdfm9D
tVLJsg//aTGUdBk9D/pGQFJUcdzB6+sD0sDmwqc6caJkhQZ7ID6W3OWeKbXkFewd
hHCG8V5nYgrXBdYZEEEvJeYQqYba2JNXXFr/TL6qYMCV+vVH+LTOTj2fX21QzEfj
cjpMLFuGSL8riCWPd6IQOD3Fp089AW/Fbe5vkKmqWtuLCKj8JGgd6FfIZ9Wu/cGS
JLfke1PAtphpvTcxZkE2CsYXBBmQYTT17kdleEXEaKi132HRCmR+wLWtKq42HKFy
GjQrv7e00EabrViZ5YpRcstcFBC1S4kgOv/jItsM7fgm/zuL4xIIPPFUtzwPBjdr
MwpbFmXIioQccvps32Ichu/0dTap6+gpLpgUWfVJweWW3G/N8Hl5EAk/pgig0/JE
UlJPTJ0wHNoBRbdADkvyX2DrKNlm9K4/0TbiZct0yFzyUXTY2XSygWLj9U/mMdeG
x7DwBOZcp3Ln+iqaSE5dPlcn0XGgeFJnbyLKe6TT1O49FnbDZLCqBsbHbRKp8s89
iJoOK2zpG/z5GYEyifIRJju9DGxYJ6ihKAuVy9UqwmNI/wMlW9mkGaaJULOVL/Ql
Y8xl5VCs4By94IfgAA05vlL/BwiCB2DSMq08+k3Xy6r7JxfTl+D5+rAY3g0v1b82
lKBHQDTcCJMzgJX8rpef2K8YSzKoKeT105aTgiJghyEH+WVFUOA=
=XjO3
-----END PGP SIGNATURE-----

--yqofroxyylfvf7td--
