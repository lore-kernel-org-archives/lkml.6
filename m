Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84752C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405C92084C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT69T4u5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405C92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeKNHLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:11:46 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39868 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNHLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 02:11:45 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so9256974edt.6;
        Tue, 13 Nov 2018 13:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=koQaqLMnVpvZZvf0SXII2VMBBkT3Y/YYUwWTok4rYSo=;
        b=kT69T4u5rCEKy+PPeD06628jN02XQwHimP93+enmOjKhp8+CsTI4FG2IU5e11fd+T4
         dFeWSblvsVq4E4HFX2oQZpBUHSMMNAOi2HDfjSy63cSo1/zYFoBng9xMdwcIcbISrfUE
         vtcBCJvJSzN28jFfAnMk76fbNvGKR1CtO+ex4fFOzhaFWmh9obeYGRDLyAYLzT++ifuV
         a8ERdtqwIHNaFjxGEI9g3JACuNh64+0doym1dV6xjSW1jorhgNWNVvyFc+NDUDdPEYjs
         3qr4ydUn/Ogtt6vNuK0IUeTEgonh6bE0mGa+Ivl1tdIMmxDNoVAxJGmjy61Jwmp2EYLK
         gQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=koQaqLMnVpvZZvf0SXII2VMBBkT3Y/YYUwWTok4rYSo=;
        b=E7S49Gv0jLuVMLbGvCONlrnYbmK1ZGknRy4rAOGsGLUfKuOivVoVMmD1QZjAExCvOJ
         lORsel4gQf22lfTWOAJgLkMmj9F5ViXjySGMijUOo16NQm94VCHTyT1ZqlyHt6ML/2b4
         QmOV2RZAUr9jfVdCa7CWwwGzk/7hQEOnQZVFOyPLEJaUYD9PwKDHhWcFI90XS/abWT5B
         XSVOJcYbTBjbKPy5V2ubhCmV6D8tzNXUgdALu/23TILKjxyTYaJKJNqg278p7zpew+Ol
         9LXQkdg1IEp48l1lyV7uD2fPj/BomGwVHIDUNyiI1gq3qcavGnvfjo/qX8hRttE1nKJh
         kgPA==
X-Gm-Message-State: AGRZ1gLb7wBKA5u3kQATz1XROhvoI11CBIA7aX/d9bK4DinFPXUdE8dT
        XN7ALWm5gYnDaWi5oq8ptdw=
X-Google-Smtp-Source: AJdET5fJ597uEcgN+QrI3nEu1QCrVbgEiOnROEIHObWvATdjv0XePKF0fN7arSZqh6gp7og6dQII0w==
X-Received: by 2002:a17:906:1001:: with SMTP id 1-v6mr13592601ejm.91.1542143506669;
        Tue, 13 Nov 2018 13:11:46 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id l6-v6sm6032951edl.60.2018.11.13.13.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 13:11:45 -0800 (PST)
Date:   Tue, 13 Nov 2018 22:11:44 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] mailbox: tegra-hsp: use devm_kstrdup_const()
Message-ID: <20181113211144.GC2724@ulmo>
References: <20181108164610.28361-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <20181108164610.28361-1-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 05:46:10PM +0100, Bartosz Golaszewski wrote:
> Use devm_kstrdup_const() in the tegra-hsp driver. This mostly serves as
> an example of how to use this new routine to shrink driver code.
>=20
> Also use devm_kzalloc() instead of regular kzalloc() to shrink the
> driver even more.
>=20
> Doorbell objects are only removed in the driver's remove callback so
> it's safe to convert all memory allocations to devres.
>=20
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/mailbox/tegra-hsp.c | 41 ++++++++-----------------------------
>  1 file changed, 9 insertions(+), 32 deletions(-)

This looks really nice. I'm currently working on a series of patches to
add shared mailboxes to the HSP driver. Part of that series adds struct
device *dev to struct tegra_hsp, which in turn would simplify this
patch a little.

Looking at some of the changes here it also seems like they would
conflict with my patches in some places. Would you mind if I pick this
patch up into my series and resolve the conflicts there?

Thierry

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvrPg0ACgkQ3SOs138+
s6HYSw/7B272unBtp25D5P+5OMk3akMT270t0lp7jgGUplWyhWbE1PzcbGAJc08Z
Ak66Vdv0Pd2Mp/3lm9fZ/SCnaYNszX9D9Yl+mOBEigjBq0gCU4hW2fTWUDXbGZrb
35uJLKaEuKogrL3RxLLmwiXDo28VDH4B/DwSd5UDQ6NCPBuKdksBT9KWsPgFAVCu
kQ0Ssp/28CokYkHJ6ExZdABXYcAD03xgl+db4Rqw/w0xKYXBYvqP0eXtFdEnZK4T
U8A5A88NPw56+iXttRRpYUR5qEzLmAthuvn0wfkMdiWOQC2+3N233Gcb8v2wr+Vh
/say5alqEZ1mttvdwh3dgVTOcDSotSyeY3DStDmfbpMlF4O/2ysnO/klQiCxskhJ
h2E6VP9t1JaZxcN5Xo9KjwDqsMn4YW4hKPdpDERorN6hyeZQftYhZnjiw0JZuidG
EftrmcvioUXZCgt6Qe31Xm7SvUJCO4DNoh5L7ZzYzu1XhRS30tnUZlpGomBTXR9M
GxspWw+K/4tWomDiByfpY9eGDiQFMHHChy9wVxU849Nm1guSeKmKqWUfwB2Ydnp8
sIyMyyIaOrRa5dKS77BRFXcxYBETrm2p6pG3ORJwW6m1a/nDymJck6hmjhTxbEvd
NNooITJlHhHjARGyIAPuvrv/8UaM/NqvRFXo8QRAGkvvHKhUIds=
=Ct1j
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
