Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC634ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 16:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDC9214C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 16:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="MbxiJeqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDC9214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeIVWIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 18:08:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33397 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbeIVWIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 18:08:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id n11-v6so4419735wro.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mcGbBgXQJT0O7Kc84hZsmJG+iBq1Y2VtsMhhu9LzD7g=;
        b=MbxiJeqqyWVXS69oKibqLYu9cI3pdclStk3QqTlqK2eUrqyp0uZ82meFHv/GFR8hPE
         f59ZolbuKtpseCigXM/3EhyRkfZK2aG4b2I4SDQ3tCMx2Xn8uxfdgKtpIolLJJOZ0vHL
         2zypKMhxp9hYhKE8XaNI6Dau/Y4FTnqYVQ9ujtpnPk8Y/JgamBTTcOmEhSCG+YI4UdK7
         FeEcq2S4uqKgshJ6AG/izqz4n/bq2A6rwsKGKN27m2a4Y0buoP10MbuK74jmB5jNE7wz
         4/Fyim8lKTCDSSsd7CVp4mzj2qFvbGtPRAcwkT0qFNAzGQjMkL8qsUTB43v4lNv+deh1
         2frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mcGbBgXQJT0O7Kc84hZsmJG+iBq1Y2VtsMhhu9LzD7g=;
        b=YGB+B2ACEPh86IFrIIXIzOE4zRlZPkrwKz1DPszGUnLofIHBca55pBYcwqBa/7VOnZ
         U1K2eHSkVTGFXVPlcEwbag1p0kA/rPySj87jVRLQCear7FX0DlPEQzw1swZZHC/ENsum
         8VP6ygysSnuorYWPpoX1fUTQA5yD2QmpcKWr6sHstlmS2ofLZn7S0P3AZm+2cd3SbTJw
         z5/XPeEB0qK19tImWFu9hmRmSJA3TpN7adJ2E4b6u+hVlH+vHUQjwqi0iI1efLefjcGO
         ZVFo4T+7Vq43Fzyxi1Yfue/oasVA/8+l02p+hv+QY35jXMjo1MVr4HgSQvoZXEE6mn5X
         /AVw==
X-Gm-Message-State: ABuFfojguMZcZBdK/At+re10XYf/6vQXXDc0QKoJhOnkZudafoQSoubu
        ssQ1nv68PWr8ykqpZhyMWnZE7Q==
X-Google-Smtp-Source: ACcGV60KJH9bSze6tH3NH03yxf23xeI91XIb4UicdeUqwb8zKtKPnY4jV8RweK5bskohJMVJRUWldA==
X-Received: by 2002:a5d:6911:: with SMTP id t17-v6mr2527166wru.170.1537632848903;
        Sat, 22 Sep 2018 09:14:08 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:6c3f:d1be:cb5f:3e61])
        by smtp.gmail.com with ESMTPSA id q3-v6sm7294366wma.45.2018.09.22.09.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 09:14:08 -0700 (PDT)
Date:   Sat, 22 Sep 2018 18:14:07 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] fsmount: do not use legacy MS_ flags
Message-ID: <20180922161406.6beo2ob6ki2otrjx@brauner.io>
References: <20180922132106.wfa6xaxwbu276qka@brauner.io>
 <20180921155455.flkf5vdrm3vgn6do@brauner.io>
 <20180920151214.15484-6-mszeredi@redhat.com>
 <20180920151214.15484-1-mszeredi@redhat.com>
 <17157.1537542475@warthog.procyon.org.uk>
 <20311.1537548756@warthog.procyon.org.uk>
 <8221.1537631312@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ggw43pqr6lmhvudm"
Content-Disposition: inline
In-Reply-To: <8221.1537631312@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ggw43pqr6lmhvudm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 22, 2018 at 04:48:32PM +0100, David Howells wrote:
> Christian Brauner <christian@brauner.io> wrote:
>=20
> > mount_setattr(int dfd, const char *path, unsigned int atflags,
> >               unsigned int attr_cmd,
> > 	      unsigned int attr_values,
> > 	      unsigned int attr_mask);
>=20
> Whilst you can have up to six arguments on a syscall, I seem to remember =
that
> 6-arg syscalls require special handlers on some systems due to register c=
ount.

Sure, but if we wanted to we might just get the syscall down to five
arguments even with my suggestion. Of course, I'm not sure what the
reasons for all of the other arguments to this function are since it's
not yet implemented. Seems that attr_values and attr_mask could be
compacted to a single attr_mask maybe? :)

Christian

--ggw43pqr6lmhvudm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE7btrcuORLb1XUhEwjrBW1T7ssS0FAlumak4ACgkQjrBW1T7s
sS1DWA//cxvoc44u465NnCKqN2tw1U6zh7y9CgMb7ZMgX5wwcV1wa4ROQD44Uxf3
9j8MlrVSflsEe203BqueDytZbvPjfzSk94wGzudoHlDIIU2JhD7nT9oahw9jYkht
GAXHpm9sx46vvtIycG9bgXRsbRiKpexcC7clzzjAkohsS+b2tq7w8ywNme4FeNqt
c1bXgNHtxzuECCTU6f6uZJIwIvO/B1sgpAHpTAkkTLXH/AO5reSalp+O1PxkfvhT
3vb8pn1mt3cKE5XbmfniFaSEkowqGBgyeFFKDUE/tR+bEr9ko9MlANYFNLaa6Nq/
CaN/PzPGbkhVKLGf5pJlBUqKL6Am2NADm7bPG/p2KAJTHL+rQLBZVJuWWUnWbk5Z
5vbiTywkQMfnDtjAYmS7wfWIK/q93XVraVte0zMIw44Le3wMK2iHMj63qer1uzrx
2GvfpQJY3VHWDcCFriclYFgHrxJNl+jPXKHj+W7pbLx7157UJHMlkO691u6Qmnp/
954rx9YDDIRf+3SlgtvOzSKhGiEtNUWKCZKDOZovISFx+BhqKTsH5bsbG821MzGC
IFf1r/eDDZkDDW9mJlhjoZ9VtO+MD25O1UkgAp23vb2u/ubtkUqVR8CtsStBlxYK
O2wqyXotKw2pKRHnrSZIE/WfPIoN+gE58Z/kQRnrY5wgoBdK5Ic=
=dDqw
-----END PGP SIGNATURE-----

--ggw43pqr6lmhvudm--
