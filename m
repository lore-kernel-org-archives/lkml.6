Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F505C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6111921848
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZII5RgcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbfA1QAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:00:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53089 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730843AbfA1QAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:00:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so14560305wml.2;
        Mon, 28 Jan 2019 08:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I4uG06dG22XIYOZRNcXMuXWea70R1YziaVKqVrG4pJs=;
        b=ZII5RgcVh6j3e0igq+Yr9pVJ7Pbmpp07beofRINjaWQeAq2+saYbi7Lg78G0IR2zSs
         98H4u5teZDDYPKjrBImsv38X9BNXK8btfWwNKxbXnX9LPTn+Hs/W858FtJOHDNJerqdO
         gG8vj3kyUQskroqXWSfBC95I7PuXJoPUElHjdi9KTvcBInpswfy20pgBpiLRTPyC4JxO
         dEX6NKHNKxfHnfm9AHeLa/HIYeF19tI3fgXhmBcs6MbCNwOgKqyss105TNwDrhnI0UJf
         PaPTLbKMXug4mriKxZkoGf+bkeuRgwlzANPfBMLmwX3BbApT4qqnSBZ2yLvNfpmQaHzZ
         v0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I4uG06dG22XIYOZRNcXMuXWea70R1YziaVKqVrG4pJs=;
        b=RfespAzd4KAzdVxbo2cZ6j4bO3+RxEIh98bOmGa1Qxms9jy8i9E81zGkzc6cpC4VKM
         gvGCPSSUJAyvKkRUY6LKteJczCBoJFHcJLel3QIoxHm5+kXOvYsERI+/Y7o424jpaQkN
         c4HsFSzF247EpIwtKev+Ugyd2bxQy3ytOlqHa63xadtKv+Z/7XW/aQLY7QZx49E0u/Sb
         Zig3DMoDESsJg8Bvd/0LXne0TTM0wFi2jbhH11qhsp/74LtY2dVDDkDPyU2gdfOkjw/B
         89/OJUYQFTyddtN24xpgajQ8iS/ut/8F/53wGr15KvVNZiqagqH4Z6yKv2z8i/4FU3T+
         oKlw==
X-Gm-Message-State: AJcUukcelY3FhWBwEodtYyZl7J8rmwvkrTzm9VE8HrueKyCBrpX+462J
        Pa1hNjwq/lOB9D7vwab4MkY=
X-Google-Smtp-Source: ALg8bN4HnQgdHo6Dt6RibKuiaZXkXktjoOtMGMXFQlTydeMDLvzSqBR27uRohMR7lPB1jRVI6ChtdQ==
X-Received: by 2002:a1c:7719:: with SMTP id t25mr18797991wmi.7.1548691244871;
        Mon, 28 Jan 2019 08:00:44 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id k128sm104129573wmd.37.2019.01.28.08.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 08:00:44 -0800 (PST)
Date:   Mon, 28 Jan 2019 17:00:43 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Mark Van den Borre <mark@fosdem.org>,
        Gerry Demaret <gerry@fosdem.org>,
        Luc Verhaegen <libv@skynet.be>
Subject: Re: [PATCH v3 5/8] dt-bindings: Add bindings for the LeMaker
 BL035-RGB-002 LCD panel
Message-ID: <20190128160043.GE26200@ulmo>
References: <20181107181843.27628-1-contact@paulk.fr>
 <20181107181843.27628-6-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline
In-Reply-To: <20181107181843.27628-6-contact@paulk.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 07:18:40PM +0100, Paul Kocialkowski wrote:
> This adds the device-tree bindings for the LeMaker BL035-RGB-002 3.5"
> QVGA TFT LCD panel, compatible with simple-panel.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  .../bindings/display/panel/lemaker,bl035-rgb-002.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lemak=
er,bl035-rgb-002.txt

Applied to drm-misc-next, thanks.

Thierry

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPJysACgkQ3SOs138+
s6HoIQ/+O1YFHBC8AzyCahNnepV+kFaXjBypJm3egi893Jxt/qHngldQkRnnx9AM
GaZszuci46ensRLTwhia3HQ1lyYkD24v8zZ62uecemKtSWsL+uN0fvWIq4WYFzPO
UTfHX7yRfMUFyC4qEXAqVm6U/nVvHSu7trzcK0wzBgZ5NpseeQLcDAyuL9mPTmsW
bYlFR+ZfW9sz77JvUNY3Q0e5YjAeC5tMOSbro0SdXKh7JukDd1sCAVlOBflyuB7C
TYmrn7ONpXgBwT68vnpNJNBnBN3mMxwDa2dbOo0HnZ5q9YixIT7G8p6nAkW9eflT
b0ygrXtj2/4QZSdtM1eYuUCSyrkw7CHkP+98uWS4KDkEyH8EBw6LH1SgN2KAbY9J
k4BNAtInQqDg9ZVeemZ3V/B6C6iMNzimdSUeUIOo2D5jNtD50X4fVT5HgbUTgxN0
WRg7QiS34hlJeFdl0UI+LQwoObFc5T+edqpP3CEURh61MM+At9nXN9xzK34Z+mRe
6XSej5we30hzStX9/mi27soX8ZTiH5efWL+GnYqABJignAsZZlg4PYMUJx7jtZG0
KUE493VchKHKLZ8SWyGVL7FSUNPZ8lnA8EZf6ZI2xShMoYz/kg6XyNjNkuyBFXLM
06PAlYemA7UjQT/o8LTzYxGXpCYlekBVNtqQasPqDern8hg9IC8=
=jyXv
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--
