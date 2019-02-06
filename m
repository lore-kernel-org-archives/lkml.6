Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95E4C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C67D20818
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7VGxFoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfBFMlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:41:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38010 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfBFMlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:41:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so7379887wrw.5;
        Wed, 06 Feb 2019 04:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tis5SAcrLw0sVnBACth58RVphDEDrVdV+7xU8ZHdREg=;
        b=g7VGxFoZh70yxpHWhuFlu5bNfmisB9CFRcCXckmywRVmxLe1iJnd8af5dInPjTIdTS
         lyKy3J7fCpIyjZAt4ONhVPs2FMRjptaBj+pmZE6q003fv9sWukJQAodtAnygANv8Q2O0
         vKuAbYwR8V0MkkAULmNWIG7DmV+DTH6ulTWuZhdNbhSBHnjCjKZexf+aBJ/HiqGP/T4s
         KDcgaBuz1nVEM49e8kP/KoE/bMOt2fOKHlpIcxDAHG+nCAy1MzgH7QcU/Fnk+5sM9RDP
         ywFjJq13b+8EvBqV+KObk07tsorOvXtoTQM5+8pp1ppw1S/SAMEpsLz1j9SM5rHgYTbl
         rQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tis5SAcrLw0sVnBACth58RVphDEDrVdV+7xU8ZHdREg=;
        b=pDHqQ1/YNidZjRHjEL53yvGNwtWueOZIcPQed7jK721J/dc3CuVAcnKri2YUEh8iOF
         PAEUQPpL4ID3EYYpTuEwIFPsPOPpsnk9cw7uUC/5ocD91DZ88X+JXi4wpccLT8TGsbUq
         oal+v0K0+8I1yo9w68U6fyZrWBnczDQEh9fPN5up/zBLFaFvwvsPR+omnwwOTkXFTVsh
         XtgYCz72HSDhgdgWymhR3XIKM4iQLoTz8ajVI5s+wVBoKhJTIBeyNY+F/cclwMus8QVs
         KP07O4bm89LNKp4wOPmvjxyOZEqWTOeSTE39GjOwobv/zMtFOdoSfN0y8QN/DyGiANcL
         yPIA==
X-Gm-Message-State: AHQUAubff3JFu5hCPHXeGGVE3x3TVZyj6z0FGxtwc0QbXbmBaeFzN8aj
        NpCxZKECAdjyLGFHOTTmRWQ=
X-Google-Smtp-Source: AHgI3Ibwj8kdKRUo8QAgRdIUcEgTemw7KxE3Q+5xKOsLuCBn1qnLB4YrBHNwAdhndeu9/ErvbEuUYQ==
X-Received: by 2002:adf:fd50:: with SMTP id h16mr8396338wrs.231.1549456857554;
        Wed, 06 Feb 2019 04:40:57 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id f8sm7471981wrv.41.2019.02.06.04.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 04:40:56 -0800 (PST)
Date:   Wed, 6 Feb 2019 13:40:55 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Yash Shah <yash.shah@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v5 1/2] pwm: sifive: Add DT documentation for SiFive PWM
 Controller
Message-ID: <20190206124055.GF21676@ulmo>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-2-git-send-email-yash.shah@sifive.com>
 <20190130081411.5rva7cpwoy2l5qjd@pengutronix.de>
 <CAJ2_jOHiJ3X5VYZMCNk2bpvUdDOsrqHJna3HPvtdNQpJB9fxjg@mail.gmail.com>
 <20190206110730.ogqxncrnblyazgjw@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline
In-Reply-To: <20190206110730.ogqxncrnblyazgjw@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 12:07:30PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Feb 06, 2019 at 04:18:47PM +0530, Yash Shah wrote:
> > On Wed, Jan 30, 2019 at 1:44 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Tue, Jan 29, 2019 at 05:13:18PM +0530, Yash Shah wrote:
> > > > DT documentation for PWM controller added.
> > > >
> > > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > > [Atish: Compatible string update]
> > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > > ---
> > > >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ++++++++++=
++++++++++++
> > > >  1 file changed, 33 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifiv=
e.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b=
/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > > new file mode 100644
> > > > index 0000000..8dcb40d
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > > @@ -0,0 +1,33 @@
> > > > +SiFive PWM controller
> > > > +
> > > > +Unlike most other PWM controllers, the SiFive PWM controller curre=
ntly only
> > > > +supports one period for all channels in the PWM. This is set globa=
lly in DTS.
> > >
> > > You can simply drop this if the first user can set this using the usu=
al
> > > interface. Don't you like this suggestion that I already made a few
> > > times now?
> > >
> > > Did you consider to make the driver support only a single output with=
 a
> > > more flexible period setting?
> >=20
> > We cannot consider supporting only single output since we have boards t=
hat
> > use the additional PWM channels to control individual LED brightness
> > of a tri-color LED.
> > If we go down to one channel, then we can't control the brightness of
> > the individual LEDs.
> > It will break the use case.
>=20
> OK.
>=20
> > I am considering the below approach, let me know if it's fine by you.
> >=20
> > - Drop the global period property and allow the only first user to chan=
ge period
> > using the usual interface.
> > - A note in the binding that all PWMs need to run at the same
> > period. If the driver already refuses to apply incompatible periods,
> > the users are going to notice that they've got the DT wrong.
> > - In driver code, count the users using the .request and .free callback=
s.
> > Based on this, allow changes to period iff the user count is one.
>=20
> Not sure you need to point this limitation in the binding doc. Other
> than that this is fine.

I think it's useful to point this out in the binding documentation since
it's something that device tree writers will want to know.

Thierry

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxa1dcACgkQ3SOs138+
s6FwnxAAnOiWlI5IXor27eIlWOEiHliIvBCTzMGSSDQ44AM/j+38k8KSzvq+n1qW
s207o9cjcOdJ3RCDh3fc26RLUVDJktckltr3KErgeaWuHZOktAlCznk6dlr8KNgo
eNTM31TqOtDKo5w6bWLvJ1hL+VUgqOCQDvHmyKzPIN8mfde3E+qegEq67QLicCzx
f9TPgGt6rBW5T7dGYgFmXcScanUrsJJsNSZchz3Jr8rhwQH6yzngWiaKVQJAZFfi
/elDBQecb/RGrFWae136qGSkcc1iXs613WCotxx9VwS1LeboMOXNSbsZOaBNK4JK
4948roLoBNZePVPaUfDFZjc6JiVOZO7cjJWystXdniw2DjYjjT8jeAX6Ib2uSOcw
/nZg7dd7t5XATDLe6X8WHvcgmrBZJ9pzEtFfcZfYy9yS3qD6f1fGxn3x+s9lbbzp
MA89TJdvZw1frVRbYq4dn5fMwqSm8Xkk/0f+aP8JyYYPgbDDnHl3vxja1wop6X2P
XjomhsxSXcUZ8ingcWpVZdrFQXKzg7iZKxRLI0UUl/6mwfflq7vOZ1DsuRYkBLvw
sXel5NH8sm2LHdnGl2ygss++aOhS5ycN9jwMHhxA+PqUz+geiXNWMD36ufKuq32O
IZZoeldKTLKTKcuouWqYIuc9unhQRvbNQTATCoLe4FRJw3bmBWE=
=l1j6
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--
