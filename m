Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A057EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF6A20883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNXVeCAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF6A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933372AbeGJK6Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:58:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52935 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932909AbeGJK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:58:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id w16-v6so24074275wmc.2;
        Tue, 10 Jul 2018 03:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oIAe7uaZphhpiTrcOd4pbUTbs2AP5vp9mp1uT099n3E=;
        b=eNXVeCAQdKlwpIDRtDWZwEVf25kH7JaEjj5wlLTX90Q6M2QzyTmzVkW0rF2pCmiDIO
         BSrahohVCZkXY7YtonMkj2dPoxnfeeQK4z7/VctEfO4WN26u4QlYD1IyI+2KGxeAt4oD
         auGjodh6qGZGyM/mcPvlU+tm2tWAdncu6VIu37R49IFgV/4by+R0iSktkrw1nr9J1zE5
         1VZiK3VTF5lCrW6kBIuT72szU0B74e3+o65Ki9dwfpOXTIn1O8/hDjHUZVIsV7can/1h
         hlkXkaeW5B+TGX3/NJZhjYIe8PZJs9PcSGAyPH9oDfJNiWwghix5mGcPLERktXy0USSV
         CPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oIAe7uaZphhpiTrcOd4pbUTbs2AP5vp9mp1uT099n3E=;
        b=jEKu/JiFb2qbZR9GPAbzW5IyEB/wA8CcdrX3cEA5wzeow0NGC64wUViUzUIlwkChwi
         ISjE6W+EEWtl1XJrVPBnxOxKAJTqT8pM6LMsRJdT+3ThPELxk2tiSNOtIsp0HJj0FcKo
         4Dsyxqhtvt2G4LSaQtxNXfSRp4MWcziO2Zfj7/KZODN0eWayfdrn0uVuq8hr+BZgqQkn
         EZ96SKG5c9NBuDoc6+kBzVjwsV9UbSkneAUhos7wRgKMU8wwEXyLkxdkYK2sTbcNG4cc
         eNQN070DPq9w+awEkig5GKIJwK19dFcCx4clqTovCeEHfsUcidrN8kuApQnkbI0LdLOm
         Z7Cw==
X-Gm-Message-State: APt69E2gWBZtZs3EkF38HwfpTaI7hw9Qs3A866vfD5iwlZMv7bHczAOb
        ZTo+6xL15B0Q8qfUcWOIbSA=
X-Google-Smtp-Source: AAOMgpeSvZfX/ebw76kBlORb3Z+b1AzDtk4br77V0kGC0+HSTqs7mceSu9Sr0dSg9E2LICwPMFbtWA==
X-Received: by 2002:a1c:8dd1:: with SMTP id p200-v6mr11572785wmd.145.1531220293813;
        Tue, 10 Jul 2018 03:58:13 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id e13-v6sm36259605wrd.9.2018.07.10.03.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 03:58:12 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:58:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        briannorris@chromium.org, hl@rock-chips.com,
        emil.l.velikov@gmail.com
Subject: Re: [PATCH v5 3/4] dt-bindings: Add Innolux P097PFG panel bindings
Message-ID: <20180710105812.GM1504@ulmo>
References: <20180702102721.3546-1-heiko@sntech.de>
 <20180702102721.3546-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yklP1rR72f9kjNtc"
Content-Disposition: inline
In-Reply-To: <20180702102721.3546-4-heiko@sntech.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yklP1rR72f9kjNtc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 12:27:20PM +0200, Heiko Stuebner wrote:
> From: huang lin <hl@rock-chips.com>
>=20
> The Innolux P097PFG panel is 9.7" panel with 1536X2048
> resolution, it reuse P079ZCA panel driver, so improve
> p079ZCA dt-binding to support P097PFG.
>=20
> Changes in v2:
> - None
> Changes in v3:
> - None
> Changes in v4:
> - None
> Changes in v5:
> - use separate file for binding
> - keep power supplies as required
>=20
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../display/panel/innolux,p097pfg.txt         | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/innol=
ux,p097pfg.txt

Applied, thanks.

Thierry

--yklP1rR72f9kjNtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltEkUMACgkQ3SOs138+
s6GnaA/+IbOAdh4Ukf/wjiUROgmRLBJRTU90II48NoI+3zWI8QHxd/K7P+ePjOee
REiJ5elHYuQzefyIHPvJs/ScpNOs10HiY4xN3B7YsUpljQucuut0G4/WVSL/eOLL
iqnbsgXjkzAeHhE/ss3cFB09VeYNpl8JxJTzsf8DuD/xbcbqcMei1XOOg7lWLuZp
1nPve0nOfyf6bzlD8FJBYxbp2KD17cH6qwFyutEA2HvPmc2LxiLLd9EcPgvvtn8M
RjjmFytwGO5vf2fqp6rXWjz4Lha0afHjcbWcWjZhHH14iohA2Ec63tR+P3K+JBvH
wsgRhpsuqppEsB7Y0zekqN4++3MRgcj/YqUqvV4+UJlpwq/0kyd6bMG0AqE9K1X3
C+HzXc8mfb6fN5bCD+qkAR15vHy7wPuKyj34iyQ8zAd6GFMfQ4/CaB3hGuqRjhbh
TlENvRoOzYdmAbE3tiB+Vm+QZ1rBNpwjlhvHcUSloBx5RugTCJA8znwyWcFfUh98
rLYEN9cd5di/jH8riMf1UEsCqLdFfEIzL/WCnyMM31MBHAMWLZWnGcuzUVW2R7b6
doWhrVGfDh4UZlHxu9mAKBt0labIBFjL81nOA+dGSiXFwgKBRUJjBApnmmNTDNfN
1VvqB5dQvYUm0IeKp15VbiWOYcdyAZ8XH7Zuc285tujg6X2RySw=
=NN3k
-----END PGP SIGNATURE-----

--yklP1rR72f9kjNtc--
