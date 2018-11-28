Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A58C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9992208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1VDsncN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9992208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeK2KNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:13:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36581 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeK2KNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:13:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so3426plo.3;
        Wed, 28 Nov 2018 15:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uuv9KxIakgeB9blIaIbFKOJLyyLLr5/4cAdRxGVU2XY=;
        b=U1VDsncNFalpTwqTmPRioqyKlnvsEc+BOUHqxM3bHDHFkKBkOOSXdYEUz0gOGBI6G4
         mkAH7AvUJTK+LVD0T3Lyx20NoeTbPz0PaFIpTbhdSapEyKjIt+c7TCDNRbkgNWZY2BNq
         VDUEGbvXtMcqfo2EjHkyFe7wOwZL1BOi9uNmMOjl7qSNQeUOdi4NOcqJUe2Bi/VEYDbm
         n9UN78ryfe9p7mJUyG/aX/pwF6aa6Qw9PKSz7fdFbf5lt3S90xbLX9Rv7lPrpzdnzMHM
         c1Ja4tizdhE6rfSClddWFi1WQTq+OaoTc4D5WqJZzzSrybUCc4ZgUmGbwok/PSEq4kFR
         IJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Uuv9KxIakgeB9blIaIbFKOJLyyLLr5/4cAdRxGVU2XY=;
        b=NDiIWEitRlGSA2JKuF3fegkDhKC6O3+XDVlgXT9PtAYFeW2aYdhRhAX+KCKzkuxsZW
         8aXQX5mYQhkZeO2S0MvxJmPOdDnDp+4MsmrJHHuE3JQl4jYIUOtLhZDPVzNhaCFqrHrQ
         yXvJqjXEsvsv4lC1RFWug02vVeNEqlt8W2+qENRS18c1cOEaN9GBK3WakJM47Kyrb+Bm
         DHMkfjfJ68KJzhjDjTvTSUv0sViyo70lnIveQgWS9Sg32czPcpx5kxDQOVsTOAwQu5mb
         vFkmBLHwniwfGPzpmqFIbDNudSj2WHzl0L9HhupnWYKwjzxky+oAoAJzQ6BdsbxZLmDa
         pOMg==
X-Gm-Message-State: AA+aEWbbLGQkPZmSjsmG/Qbf61o0dHE+Vf/8ctV3cA/FXL1L3aZ7Q92l
        cTErP6e1svd6YDlBxHelDSA=
X-Google-Smtp-Source: AFSGD/UulYiOw7pe7cKqfKMF7Vd5zfhcIkMhY1//8x5wxJRYb2QaW3q7SgqxzUHdVWhJH8MOBiXn4Q==
X-Received: by 2002:a17:902:b282:: with SMTP id u2mr39340421plr.89.1543446595388;
        Wed, 28 Nov 2018 15:09:55 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id x3sm4073pgt.45.2018.11.28.15.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 15:09:54 -0800 (PST)
Date:   Wed, 28 Nov 2018 13:09:51 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH 26/29] x86/fpu: Inline copy_user_to_fpregs_zeroing()
Message-ID: <20181128230951.prvhc44x4lnpbimw@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
 <20181128222035.2996-27-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y56k3mt3i4q3tnwx"
Content-Disposition: inline
In-Reply-To: <20181128222035.2996-27-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y56k3mt3i4q3tnwx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 11:20:32PM +0100, Sebastian Andrzej Siewior wrote:
> Start refactoring __fpu__restore_sig() by inlining
> copy_user_to_fpregs_zeroing().
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>

--=20
Cheers,
Joey Pabalinas

--y56k3mt3i4q3tnwx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv/ID4ACgkQ2rGdfm9D
tVLeOA//efh50K2dw5YoK/jk0pjWwe2EgSWV6X5sz5KUZGuyMy4ZyCguUALhQ7JE
cdysVyQLFPJty7p3uujNJKcN6fMuc/Pw2cEsLO31RdmmRY8EQ90ol/pQSMYMEO5s
b2yjqSyplBBSYgxwb3TAvRdIxNnkJ1JRAcva0F2VRWmKC6wZByid/rNUk8+UnH09
hjiwfcZYZ6DsBQ7YlYuFqfIBCFwfewZBV9EWOPvhF7FTcHeyVbin4xOjF7qSXaMS
hXkFj3Y8+0Qp8VzHPcsQS8FvE9laofpjNIFkaARErF9lPitCq3LmCNXYW1ONNQ3C
vOlzW+ovGWEKQnHEw9ZXKZunLhqckhbqLb6KspW3m2L02Z67JNynzyhBpt64y5JJ
7t1VvNcJJEeiaysDVfo/8MdY30hfOo+tVXp8n6VHdElxq4ChfRmdUufxmomboMYL
qAWPrjMLMpRNQ3GvePIWvg1uW4KJ5hBxmuNiddvNXLFKFgYZWdMTuChsBzZFjdXh
VW/o5jfG8djSoPp0/73RVu+DHmyc2ZNIBhZl9s2AAyJLwSzu/pUgbqGUcq+A7C6o
kgOxk4sPda9H7O9RhOLSYcvZATnJfASv+9VV7SPoztsxcnK9JRWPKCKaxfHpmUe1
j7UIyp+Wrzsftx7/tBkl5LzEWtZJNte4y8RCDCzt2puGIGgo6PA=
=W5U2
-----END PGP SIGNATURE-----

--y56k3mt3i4q3tnwx--
