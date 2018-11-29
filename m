Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8241C32789
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD9E20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilizQwCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD9E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbeK3ETX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:19:23 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36530 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730671AbeK3ETM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:19:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so2549269edb.3;
        Thu, 29 Nov 2018 09:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OSiwgcQEFe3mlSnWgZwNgudRqoNP5hL9085FEjWuX5g=;
        b=ilizQwCEESCGgwjYmDV2E9SwIYo2nFrqNNSw1KzklbZhrLKfCnqRTohWf+skFQkrJl
         tVbzKR8HvZbTtdVpXQAq+zG/LlY13p8nlhjl1IPpT/r3OauwrDFIj8RjvaTzRJ8G3tlA
         PVRNYSAdHf2bAvsgk58fTb9Yxt1wpi9IoNfdUI5FsYyKHrSaG1/dCsaPJVO+DI65w3bx
         Z8rP+gqXWqUrxdwkjiOhSL4Hq3W+y0IqC2Mn5Rr/i8GOFf5G+Xj8qzzZvzUHdzAKPsoY
         kv6vZpY3bFlRxRutticEJuZu6iGb1z4rd4PtF097GfhEeejOrFF8DBdrKAy5R/VVhvVw
         mO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OSiwgcQEFe3mlSnWgZwNgudRqoNP5hL9085FEjWuX5g=;
        b=RXTfnVxEZC/ckMeslnmRY9fzIh6Xk7ud9S3CtfNCAdaoxT5/mCbAoPk4c6pPkM8oey
         rSFVO6W5Z3r8DUMRbH6TyON5JBwekLhP5IW20W0dUW1E3q2sx0puLWf9RAH+HMr3SxZn
         lPboNPQTIJJcIcml7Hw5vEGpojEz5bItzSqU8jS7XE3Kv0DSB3DnUhYW6d5hczt6+oM9
         kk2aSak1z/G32Ab9ssi86o2t95fIM8eDIB5iBcvhLbgJy0dySMhqm97WlLdj8WuAxKwX
         BXq5n7Vrs4f8YCnCmbyZolTOnoTNwaa8/LGmYK0GoWywa6SYLPIaPc6rSvpfYnwTHQp1
         ds5Q==
X-Gm-Message-State: AA+aEWYe3615vXDLzTfNlGjVMgaWfbXe2vR6jSq8Krbnz0QYT5DQy2iQ
        WyAamPvv0dPFUUdCxXTsWOo=
X-Google-Smtp-Source: AFSGD/UWLlBzJhrs4c70A6vGbCDwKPHRuceNSEy/RH3AFIetkLFqQp8cBsedlT7QEHhCHePd2KTfHA==
X-Received: by 2002:a17:906:d41:: with SMTP id r1-v6mr2202292ejh.186.1543511586140;
        Thu, 29 Nov 2018 09:13:06 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id gy12-v6sm432493ejb.44.2018.11.29.09.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 09:13:05 -0800 (PST)
Date:   Thu, 29 Nov 2018 18:13:04 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, edubezval@gmail.com, srikars@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] thermal: tegra: parse sensor id before sensor
 register
Message-ID: <20181129171304.GB18128@ulmo>
References: <1543383877-20555-1-git-send-email-wni@nvidia.com>
 <1543383877-20555-4-git-send-email-wni@nvidia.com>
 <20181128102520.GC20723@ulmo>
 <9c373693-1d3c-cd02-4972-dde338651c0e@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <9c373693-1d3c-cd02-4972-dde338651c0e@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2018 at 01:55:02PM +0800, Wei Ni wrote:
> On 28/11/2018 6:25 PM, Thierry Reding wrote:
> > On Wed, Nov 28, 2018 at 01:44:37PM +0800, Wei Ni wrote:
[...]
> >> +	bool ret =3D false;
> >> +	struct of_phandle_args sensor_specs;
> >> +	struct device_node *np, *sensor_np;
> >> +
> >> +	np =3D of_find_node_by_name(NULL, "thermal-zones");
> >> +	if (!np)
> >> +		return ret;
> >> +
> >> +	sensor_np =3D of_get_next_child(np, NULL);
> >> +	for_each_available_child_of_node(np, sensor_np) {
> >=20
> > Aren't we leaking np here? I think we need of_node_put() after
> > of_get_next_child() to make sure the reference to the "thermal-zones"
> > node is properly released.
>=20
> No, we will not leak np here. Because the
> for_each_available_child_of_node will call
> of_get_next_available_child(), which will call of_node_put(prev) to
> decrease refcount of the prev node. So we just need to of_node_put the
> last node after break from this for block.

Okay, looks like I misinterpreted what you were doing there. I thought
that for_each_available_child_of_node() took the child as first argument
and the parent as second and therefore np would be overwritten by the
first assignment in the macro.

But looking at this more closely I think there's something else wrong
here. for_each_available_child_of_node() is defined as:

	for_each_available_child_of_node(parent, child)

so in the above, np will be the parent and sensor_np the child. Why do
you have to do

	sensor_np =3D of_get_next_child(np, NULL);

? That's already done as part of the loop in the macro, right? So does
that not mean we get two references and we leak the first one? Can the
above not simply been dropped?

Thierry

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwAHhwACgkQ3SOs138+
s6F6/xAAqMxIDiGgMuvXEKJ/kSKqxwnHpIZ2dq3URca40EkWCOEMHC6jBICE0yKN
V+Y8HEP5/aGh0Eo38UAdVbHmBZTIbMz6Caq46LKgtygfnyX2jLUSrqXI3O/OW9S1
HsrDcibccvgdnaMFTtZ+oaOOQNDfOSrW+DNOztyFZI55iUtnPI51yvhhLxkV5wDo
FEEONc7Jirfx1XBguWbMMJf4US2vk7Bch43yk8eosNAi/92iTxC01SMNrRi46xOp
bK7J+NlIB/x9mtef2g9TMz+6ohLa06u6LILf37hBdPAk7vNz18xQf8S4wZuIZWKO
ANtHAYNQ3weln/qM9dgMEjInk2/1945TNFCJvA/L07QEEUgiy92joic7vGF7iz9v
glmt68KtMNsgE2UHwTR7fnOJu7JqoDVPQJxetdR8ElLVKcHcr0QpM54J5jQ4Qo2y
BEFe1wTwfcVUI++9Kb2j5QWgxf+eZm9Q24334zAWAy8U4sFL/u+a/M6jwazuQHjl
t1y4Q5nBLVXjH67sOT7N1S6JarBimkwoZP/0XvKOdiIxkL1m6neO6mncCZpLNFv0
AJQBPk3bgz/oQ+PNbNW+akpnB36FCxvXIyUmwmN5TpCKSbFq/vEZDZnO0ys7liT3
sFYRn3GwN9VQMZaZgrp8y4UVesNCKom4066taF1sqb/8Bnx+Tic=
=3Rwa
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
