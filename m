Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEC6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B512086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HijZaiu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B512086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeJPSvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:51:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43954 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeJPSvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:51:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so24963599wrt.10;
        Tue, 16 Oct 2018 04:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fnGCS83Z0SZAGsiz42xG0H+2VU7WB1tZuj9DdgTIoQQ=;
        b=HijZaiu5sP3vZtlCbpQZqyDsGFpqIRHQgyMltErHDYKNDutFb6azEo8VWcnZxd2HPx
         x3idSsHg0FEecmvOeEtF+ayf1448eR/5B4WThHpMoY2b51hdjAqJhfR7CnPBk4MYl8KX
         lQmCEkKamsvEETtB/xtK07w1qfQpxsS3idFMb32Yph9yC1kPRbPu7PXEbraYL232zBkb
         2Vj61TBwHnC5+A1SqriQa/PP4xuZ/lKezYqu4HdgqDAcHpoBhHQGawH2pgc1tE5veLoY
         DAF3XE+qtpJsX0RMLiCJrWEwiZM+IzIG6eqv+NEoHydy3uXzjvkQSk/f5y3CMOATWM3U
         yfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fnGCS83Z0SZAGsiz42xG0H+2VU7WB1tZuj9DdgTIoQQ=;
        b=NPx0cBO4g5NagfbQUX/WI1xQ88zIIuA2ET4UuhOvHxgCsODzlSNiJtv4JEblCFvfZM
         gRGEC7jYPQLOm4FuyE6oVJFmMkOT9QvA/tuaYMVNFUCV3hvudp8UM+xphj/RUnsgKxBX
         WaAx6gj8y8aGJ5bpc5TeCuZ89MWZ1gXEccLxiTo5ypzrJaNtuHbfzv/5JOPJIo59S9dg
         N8YFfq7ZOz/WECwJlne2T3eSXOcj5cmRRslyO47ox7vjs+ZmJRcQ7uqlOAHJYtukbdNJ
         mTyvbWQhzaKNGYwGttro4+KeBv9A9vt+jhQ5GC2v9ukSrMIkojL7UGwn6sB+IcFd59Hz
         oEEg==
X-Gm-Message-State: ABuFfogLde/Mx/MfeBICpULfbbo7FIf7iNw3oBhr7DDEzhmfJfF9CBCw
        QyJZfGQz3WswXYmS7eegmK8=
X-Google-Smtp-Source: ACcGV60XPHlPvtT49HYyLOubtJz18+BHFeC1YnHOQgMbaW99bDWRvBFlBT3htyhCBzTfO1CtCq3UIg==
X-Received: by 2002:a5d:4208:: with SMTP id n8-v6mr17033485wrq.260.1539687704113;
        Tue, 16 Oct 2018 04:01:44 -0700 (PDT)
Received: from localhost (pD9E5106D.dip0.t-ipconnect.de. [217.229.16.109])
        by smtp.gmail.com with ESMTPSA id 126-v6sm11977018wme.48.2018.10.16.04.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 04:01:43 -0700 (PDT)
Date:   Tue, 16 Oct 2018 13:01:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Atish Patra <atish.patra@wdc.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Wesley Terpstra <wesley@sifive.com>, palmer@sifive.com,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, hch@infradead.org
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Message-ID: <20181016110142.GC8852@ulmo>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010134926.GD21134@ulmo>
 <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline
In-Reply-To: <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 03:57:35PM -0700, Atish Patra wrote:
> On 10/10/18 6:49 AM, Thierry Reding wrote:
> > On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
> > > From: "Wesley W. Terpstra" <wesley@sifive.com>
> > >=20
> > > DT documentation for PWM controller added with updated compatible
> > > string.
> > >=20
> > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > [Atish: Compatible string update]
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >   .../devicetree/bindings/pwm/pwm-sifive.txt         | 32 +++++++++++=
+++++++++++
> > >   1 file changed, 32 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive=
=2Etxt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/D=
ocumentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > new file mode 100644
> > > index 00000000..532b10fc
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > @@ -0,0 +1,32 @@
> > > +SiFive PWM controller
> > > +
> > > +Unlike most other PWM controllers, the SiFive PWM controller current=
ly only
> > > +supports one period for all channels in the PWM. This is set globall=
y in DTS.
> > > +The period also has significant restrictions on the values it can ac=
hieve,
> > > +which the driver rounds to the nearest achievable frequency.
> >=20
> > What restrictions are these? If "nearest achievable" is too far off the
> > target period it might be preferable to error out.
> >=20
>=20
> @Wes: Any comments?
>=20
> > > +Required properties:
> > > +- compatible: should be one of
> > > +	"sifive,fu540-c000-pwm0","sifive,pwm0".
> >=20
> > What's the '0' in here? A version number?
> >=20
>=20
> I think yes. Since fu540 is the first Linux capable RISC-V core, SiFive G=
uys
> decided mark it as version 0.
>=20
> @Wesly: Please correct me if I am wrong.

It seems fairly superfluous to me to have a version number in additon to
the fu540-c000, which already seems to be the core plus some sort of
part number. Do you really expect there to be any changes in the SoC
that would require a different compatible string at this point? If the
SoC has taped out, how will you ever get a different version of the PWM
IP in it?

I would expect any improvements or changes to the PWM IP to show up in a
different SoC generation, at which point it would be something like
"sifive,fu640-c000" maybe, or perhaps "sifive,fu540-d000", or whatever
the numbering is.

> > > +	PWM controller is HiFive Unleashed specific chip which warrants a
> > > +	specific compatible string. The second string is kept for backward
> > > +	compatibility until a firmware update with latest compatible string.
> > > +- reg: physical base address and length of the controller's registers
> > > +- clocks: The frequency the controller runs at
> > > +- #pwm-cells: Should be 2.
> > > +  The first cell is the PWM channel number
> > > +  The second cell is the PWM polarity
> > > +- sifive,approx-period: the driver will get as close to this period =
as it can
> >=20
> > Given the above comment, maybe "sifive,period"?
> >=20
>=20
> ok.
> In Unleashed board, the DT is loaded by FSBL (first stage boot loader).
> Thus, changing device tree entries requires a FSBL update. If we update t=
his
> string, we need to update the driver to parse both properties so that
> existing devices with older firmware continue to work.
>=20
> This is probably ok as we anyways do that for compatible strings. Just
> wanted to update that here for the record.

I'm going to defer to Rob on this. He's said in the past that he doesn't
care about existing bindings that haven't been vetted through upstream,
even if that means that bootloaders may have to be updated. I know he's
been fairly strict on this in the past, but let's see if there is room
for exceptions.

Thierry

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvFxRMACgkQ3SOs138+
s6GhURAAmC6vuSADDLFab6WEqwRLFGoo9to8KJZ7D+7hu7qf/bAwo8RXJ30UXWyE
72UmII/bY4sTDaBAPU0e4LhN7fwp4TaOWqV03FN2zalTxPeeVF7zEE7elulhsZNp
9UuSTvIAXvHK8FmE3mFoGXduSaDAfpDmx2CzLZrHtJ14JSK2xpRr6z7K2OX2XdWP
YsPglyv40v1e/x8p/GlsiO8fo8+AtOFyyCvIq/IcI+o3ynQZXwyYsGOdSrtPYHTj
51ZDLXJK4dAxLijoJ/MPpZGq50BNbtSlgsylEkHV/7iLhGqskQkjXlUlM1zPBTeX
VWHK+/akjOzlEhase3MaBA4wNgZZ0JPXWn+pUWIK4CjL9A6sTbxWEiVGBK9Heo5O
3ghb8BcJolWVgS0Z9xnamcs1SXODhqwQzZhVNNSW2xQTsdEW0+OKcwWuNANOOzrr
a7yZQYL55G+C3cBL74Kc4n82gjlIsl+q85OD0XMyhpoVRPd2SvLFqy7nHXVRl50K
PGEJNwLIFYgKzFcHUQI7uO+wBAo9Lx92QPBVtUJCrbBwJxcgkCXwwWMQqLyR5WbL
Uaw2K5rb6ICdIxzlsd4C97alXe/7xCU0tSLiUmieno02appctkBQEoceKqeVAbOZ
A2+T8lVGEmPg3ugVzeSyvJxDXo679KUNQAGHz7GgTg3yJmDhraI=
=UizH
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
