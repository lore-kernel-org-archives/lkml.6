Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F549C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D612184B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MekOj1rK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfAZVXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 16:23:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38777 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfAZVXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 16:23:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so11142701lja.5;
        Sat, 26 Jan 2019 13:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KyOShsW5KoT/4WxkL8Iuq5S2HOReSUbUKj8k/2WpdC4=;
        b=MekOj1rKqpQTb8ds2U2m6rdprrr4wbnGnEpH3OkKt4WKnpItBRPgYFZZb/XX5f4LEP
         8WhbLm0oHRn3jHPa7OEbxKmhjjERVzafHtJocHevnZu97NMYM/G4gTpswHaByeLHwKXp
         Kt569iunuzKtXdLyZH7g5p0RO02no1qWqVVOS2xvxV+P41bwSgdo2Sg/3yCCX4bH9/NS
         Y4jdUObcH4rEiV33gLmfInajKd3hF3lk/rQ3CI6L3ZtExNqCRmotAe/st6/2N3YKaeOW
         3wY/N7TLwJ3xHwvDZ7u3HYWDvRWi4QeMN5BRe922U6CK6hzNWOLe8KbE+0zvJaC1xPa9
         GpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KyOShsW5KoT/4WxkL8Iuq5S2HOReSUbUKj8k/2WpdC4=;
        b=I8bpH2bCgJVb1HNFuu0EyijOZ1K69sfab7EiPVgkWY0KQrT6WoSz3uyHa7RbJAz0Ro
         0Snes4v8R9bQcjjOGN9ikoHiLRyFE4wQvHzQPItQqTpMQ2zWUJhK/uq4XNtgbMhjcQ5d
         0kEKXud9ThPBmeG+27ZKQFUQOKrkYwjvvCIpSqWv03j6lUenGzOzRdzOR1Qnd46V4OsA
         curW0HDgKKhrTL0T/5oOpypyjO6vHY85ux/yJWX3FvpOx7l1Lt/eC9ibo9Rz5X+72C04
         hJcV1QWXwqFKTnOn4uzLo9ucvTruBQMa3xC1FV5lXS7UiRlbNH3g7eccZIu1JEuOMN33
         OoJQ==
X-Gm-Message-State: AJcUukfH1CHDhrzhm1TGzYArqsnAteIzC/4AZi+qHvwckMW/bKJ22H9D
        sTWXcO8G2Jow5gkBJ8DBem8=
X-Google-Smtp-Source: ALg8bN65HMWzHBsCN/EhXgB455VpigQ5VAIDnn/nDBO/gez282Cg/77NOB6catAjKzECVqB9NpZwyw==
X-Received: by 2002:a2e:5418:: with SMTP id i24-v6mr12773758ljb.51.1548537790091;
        Sat, 26 Jan 2019 13:23:10 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:1443:c0d9:3512:5f9a])
        by smtp.gmail.com with ESMTPSA id f29sm2178402lfa.46.2019.01.26.13.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 13:23:09 -0800 (PST)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        Jonathan Bakker <xc-racer2@live.ca>,
        linux-kernel@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com
Subject: Re: [PATCH 1/2] drm: panel: Add Samsung s6e63m0 panel documentation
Date:   Sat, 26 Jan 2019 22:23:07 +0100
Message-ID: <1914204.IzKZliLL3I@acerlaptop>
In-Reply-To: <20190126205501.GA31182@ravnborg.org>
References: <20190125164645.19208-1-pawel.mikolaj.chmiel@gmail.com> <20190126205501.GA31182@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sobota, 26 stycznia 2019 21:55:01 CET Sam Ravnborg wrote:
Hi
> Hi Pawel.
>=20
> Thanks for the patch, some comments follows.
> Please judge what comments you chose to follow, see this as suggestions.
>=20
> According to Documentation/devicetree/bindings/submitting-patches.rst:
>=20
> 	The preferred subject prefix for binding patches is:
> 	"dt-bindings: <binding dir>: ..."
>=20
> It would be a good idea to follow this practice in next revision.
I don't know how I forgot about this (will be fixed in next version).
>=20
> On Fri, Jan 25, 2019 at 05:46:44PM +0100, Pawe=C5=82 Chmiel wrote:
> > From: Jonathan Bakker <xc-racer2@live.ca>
> >=20
> > This commit adds documentation for Samsung s6e63m0 AMOLED LCD panel
> > driver.
> >=20
> > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  .../display/panel/samsung,s6e63m0.txt         | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/sam=
sung,s6e63m0.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6=
e63m0.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0=
=2Etxt
> > new file mode 100644
> > index 000000000000..4979200e2dd2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.t=
xt
> > @@ -0,0 +1,60 @@
> > +Samsung s6e63m0 AMOLED LCD panel
> > +
> > +Required properties:
> > +  - compatible: "samsung,s6e63m0"
> > +  - reset-gpio: GPIO spec for reset pin
> The preferred name is reset-gpios (added 's')
Right, will be fixed.
>=20
> > +  - vdd3-supply: VDD regulator
> > +  - vci-supply: VCI regulator
> > +  - display-timings: timings for the connected panel as described by [=
1]
> Today, as is my best understanding, it is encouraged to specify the timing
> in the actual driver and not in DT,
Ok, will hardcode them in driver. Currently those timings (which i had adde=
d to my device dts) were taken from original kernel sources.
Need to check if there are other devices (not only using mainline kernel) u=
sing this panel and what timings are they using (hope they're the same).
>=20
> The example include a spi-max-frequency which is not mentioned?
spi-max-frequency shouldn't be here and will be removed.
>=20
> > +
> > +Optional properties:
> > +  - reset-delay: Delay in ms after adjusting reset-gpio, default 120ms
> > +  - power-on-delay: Delay in ms after powering on, default 25ms
> > +  - power-off-delay: Delay in ms before powering off, default 200ms
> > +  - panel-width-mm: physical panel width in mm
> > +  - panel-height-mm: physical panel height in mm
> Likewise these delays are also properties that today are included in the =
driver.
>=20
Need to check delays also (like timings).
> I cannot explain the background for this, this is just how things are don=
e.
>=20
> > +
> > +The device node can contain one 'port' child node with one child
> > +'endpoint' node, according to the bindings defined in [2]. This
> > +node should describe panel's video bus.
> > +
> > +[1]: Documentation/devicetree/bindings/display/panel/display-timing.txt
> > +[2]: Documentation/devicetree/bindings/media/video-interfaces.txt
> > +
> > +Example:
> > +
> > +		s6e63m0: display@0 {
> > +			compatible =3D "samsung,s6e63m0";
> > +			reg =3D <0>;
> > +			reset-gpio =3D <&mp05 5 1>;
> > +			vdd3-supply =3D <&ldo12_reg>;
> > +			vci-supply =3D <&ldo11_reg>;
> > +			spi-max-frequency =3D <1000000>;
> > +
> > +			power-on-delay =3D <0>;
> > +			power-off-delay =3D <0>;
> > +			reset-delay =3D <10>;
> > +			panel-width-mm =3D <53>;
> > +			panel-height-mm =3D <89>;
> > +
> > +			display-timings {
> > +				timing-0 {
> > +					/* 480x800@60Hz */
> > +					clock-frequency =3D <25628040>;
> > +					hactive =3D <480>;
> > +					vactive =3D <800>;
> > +					hfront-porch =3D <16>;
> > +					hback-porch =3D <16>;
> > +					hsync-len =3D <2>;
> > +					vfront-porch =3D <28>;
> > +					vback-porch =3D <1>;
> > +					vsync-len =3D <2>;
> > +				};
> > +			};
> > +
> > +			port {
> > +				lcd_ep: endpoint {
> > +					remote-endpoint =3D <&fimd_ep>;
> > +				};
> > +			};
> > +		};
>=20
> 	Sam
>=20
Thanks for review



