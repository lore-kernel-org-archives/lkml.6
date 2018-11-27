Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEEAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0255420989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dshhf+7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0255420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeK1BQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:16:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45425 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeK1BQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:16:11 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so19096920edb.12;
        Tue, 27 Nov 2018 06:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vawwjEbKvLRQ8IlPNh/d8+AU9eLeFH4W9t3PVcQ9rns=;
        b=Dshhf+7s1E3G8fs3NJlx1F4utAavVoI7fvO8K14g/tHunjPn0SVRgWpTAG273XyM9t
         RZVvldevB49tTbWXSwjlnMl+WfEtiFQU5KDl3uDg9WbAm4J7tJrlrd5qCQrOcL2NhxOg
         yNTY8LxquKrNDm+TepgYPykMRpRJtqxYO8A8Gg9AtbLsFJCy3r3F2/Wl2vxyds3gjgxT
         wUV00lkitkYIKxHOTtnMv08Oe3S9jMYHwpQpg4Kf1WykwqfBX2DL3F0hBmJ4QbW4/LDX
         bx9BuLLimzca136k0S5uv87+noMPDBDrA3wCgmHynSckqjhYuieZvpdsEQtH9DIm/2oH
         y31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vawwjEbKvLRQ8IlPNh/d8+AU9eLeFH4W9t3PVcQ9rns=;
        b=B9Of0R+r0GhlhG9DgdJ/kyYyctU+L9m+aM5BOr8FRLC6nx2AjxIMkeM1bb69ih1Y21
         9rSacB33T9QIH9F9Qxv6YATcGMYEQzn/yYrq6BejO8r77Vwd2jWMYHB4pc0gks8FW0I7
         iaCjISOrj6Jah50fAnW5Be/3CsTlbQ0uY0I6+10RmEAKLJzGrAUmn23Rn6X+clK6Mk5r
         9/7X7BsD07ndIdkf4CnYdQAqidtdUAVLNwAc/0+t+6zgSKEHicdoxOfuY+yQ3ggRRr6O
         AGhsOr4emHw6f6nN1uIv1w6REv7xp3WgA7kyC1QVEC7i/DfX3R7obcwemjcoyyBuQ7su
         uuQg==
X-Gm-Message-State: AGRZ1gK9Fkdwyqe6uUdtOfMd7haw5j7SIU6NXA8PzgZY/78ZDRFEzDQP
        LzmBFCICD/kfrrPq8YZKILo=
X-Google-Smtp-Source: AJdET5fYMIs1Jyi4A3eEbhhizzYQt254c2icOYvj+VznLGlmrW9CoUkvUHW2mLmLr3FlmThT4Om8Jw==
X-Received: by 2002:a17:906:14d8:: with SMTP id y24-v6mr23923048ejc.216.1543328286042;
        Tue, 27 Nov 2018 06:18:06 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id e53sm1023500ede.90.2018.11.27.06.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 06:18:05 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:18:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 7/9] iommu: tegra-gart: make it explicitly non-modular
Message-ID: <20181127141803.GA10560@ulmo>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
 <1543271498-28966-8-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <1543271498-28966-8-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 05:31:36PM -0500, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
>=20
> drivers/iommu/Kconfig:config TEGRA_IOMMU_GART
> drivers/iommu/Kconfig:  bool "Tegra GART IOMMU Support"
>=20
> ...meaning that it currently is not being built as a module by anyone.
>=20
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>=20
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
>=20
> Since module_init was not in use by this code, the init ordering
> remains unchanged with this commit.
>=20
> We replace module.h with moduleparam.h since the file does actually
> declare some module_param() and the easiest way to keep back
> compatibility with existing use cases is to leave it as-is for now.
>=20
> The init function was missing an __init annotation, so it was added.
>=20
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
>=20
> Cc: Hiroshi Doyu <hdoyu@nvidia.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/iommu/tegra-gart.c | 37 +++++++------------------------------
>  1 file changed, 7 insertions(+), 30 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv9UhcACgkQ3SOs138+
s6GgbBAAi/Mxc51OVKQqQum9GKCX2Bb6gfyB7EOoy5OfWgk1dXPUKhy6EhLZIaxk
2lpqJVfEikiOd5RdozVEspvrOqCKAGUuXNev7VEIy0daSNIM/VUJ6fSFCJRZEV+w
cFbj7Z/q44r+Gx9/F7vBl2miQhn9dvFhhJZjsT62uePD79C1r9o4OJch2kQAGB6O
aomSkBgzYz+iig3bD42H1JJERz1JrnKkbCXw3bKvRU4YG74hkM0NlWgUWxxCCsM/
59awkEkdId0jWuF7Cn7Iwfvs34p42vVhK5unMAIhO9YEZ3IWgNIhrkKnkWAIdhlU
VqbgJaKmdGqMjIZsGxWPwFnoNuHSV3LDxt0mCkhr6ZMIFuimJMy317vf0ETrhMSW
C4HUVScW6t/H/FXegQ8XfuRm6qZGnwmgT8MH0Oi2RW51iOA3eADP7HqCdUQ11uN6
K2LFAAbncjTJHdzUhECU9x1vWgzrXhUsufhj9Bc8DwwKN2+6zB+dsvJ7qA5SKUEU
PaOGRAz2M0+C6D65xiBsy0GpG3iH3SgMAXJ/bKC37UUV8AHH7z7DmoJUNYVOszCD
1Ai4TBSOmHgFUzszni4NOrcV/buCNOqLz2qspAHT64YK0ewgJDKuforGo7TV1q2G
epfhNiFXDV5CYbNa+lZH/gwz2KO646KyrPKidGtOj0PPhk/FA7U=
=9Dwj
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
