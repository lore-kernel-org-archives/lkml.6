Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeDIL7H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:59:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51317 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeDIL7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:59:05 -0400
X-Google-Smtp-Source: AIpwx49h2PgIyF6u/5GPeScf49QDAXS1e9aoViV7DVLT35P1aPf56by1WStai47Z9mx9C9yFPPqNaw==
Date: Mon, 9 Apr 2018 13:59:01 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Patrice CHOTARD <patrice.chotard@st.com>, Tejun Heo <tj@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org"
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] ata: ahci-platform: add reset control support
Message-ID: <20180409115901.GB29946@ulmo>
References: <6ce60a0b-0409-016a-d29c-91b8b9e2ad07@redhat.com>
 <cd3bc161-9a38-1e58-b66f-3ef81e3ed220@redhat.com>
 <20180406134838.2ADC.4A936039@socionext.com>
 <22a2bcd7-eff5-c20f-e056-f5946e579d5e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <22a2bcd7-eff5-c20f-e056-f5946e579d5e@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 06, 2018 at 10:29:37AM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 06-04-18 06:48, Kunihiko Hayashi wrote:
> > Hi Hans,
> >=20
> > On Thu, 5 Apr 2018 16:08:24 +0200
> > Hans de Goede <hdegoede@redhat.com> wrote:
> >=20
> > > Hi,
> > >=20
> > > On 05-04-18 16:00, Hans de Goede wrote:
> > > > Hi,
> > > > > On 05-04-18 15:54, Thierry Reding wrote:
> > > > > On Thu, Apr 05, 2018 at 03:27:03PM +0200, Hans de Goede wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > On 05-04-18 15:17, Patrice CHOTARD wrote:
> > > > > > > Hi Thierry
> > > > > > >=20
> > > > > > > On 04/05/2018 11:54 AM, Thierry Reding wrote:
> > > > > > > > On Fri, Mar 23, 2018 at 10:30:53AM +0900, Kunihiko Hayashi =
wrote:
> > > > > > > > > Add support to get and control a list of resets for the d=
evice
> > > > > > > > > as optional and shared. These resets must be kept de-asse=
rted until
> > > > > > > > > the device is enabled.
> > > > > > > > >=20
> > > > > > > > > This is specified as shared because some SoCs like UniPhi=
er series
> > > > > > > > > have common reset controls with all ahci controller insta=
nces.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socione=
xt.com>
> > > > > > > > > ---
> > > > > > > > > ??? .../devicetree/bindings/ata/ahci-platform.txt????? |?=
 1 +
> > > > > > > > > ??? drivers/ata/ahci.h???????????????????????????????? |?=
 1 +
> > > > > > > > > ??? drivers/ata/libahci_platform.c???????????????????? | =
24 +++++++++++++++++++---
> > > > > > > > > ??? 3 files changed, 23 insertions(+), 3 deletions(-)
> > > > > > > >=20
> > > > > > > > This causes a regression on Tegra because we explicitly req=
uest the
> > > > > > > > resets after the call to ahci_platform_get_resources().
> > > > > > >=20
> > > > > > > I confirm, we got exactly the same behavior on STi platform.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > ?? From a quick look, ahci_mtk and ahci_st are in the same =
boat, adding the
> > > > > > > > corresponding maintainers to Cc.
> > > > > > > >=20
> > > > > > > > Patrice, Matthias: does SATA still work for you after this =
patch? This
> > > > > > > > has been in linux-next since next-20180327.
> > > > > > >=20
> > > > > > > SATA is still working after this patch, but a kernel warning =
is
> > > > > > > triggered due to the fact that resets are both requested by
> > > > > > > libahci_platform and by ahci_st driver.
> > > > > >=20
> > > > > > So in your case you might be able to remove the reset handling
> > > > > > from the ahci_st driver and rely on the new libahci_platform
> > > > > > handling instead? If that works that seems like a win to me.
> > > > > >=20
> > > > > > As said elsewhere in this thread I think it makes sense to keep=
 (or re-add
> > > > > > after a revert) the libahci_platform reset code, but make it co=
nditional
> > > > > > on a flag passed to ahci_platform_get_resources(). This way we =
get
> > > > > > the shared code for most cases and platforms which need special=
 handling
> > > > > > can opt-out.
> > > > >=20
> > > > > Agreed, although I prefer such helpers to be opt-in, rather than
> > > > > opt-out. In my experience that tends make the helpers more resili=
ent to
> > > > > this kind of regression. It also simplifies things because instea=
d of
> > > > > drivers saying "I want all the helpers except this one and that o=
ne",
> > > > > they can simply say "I want these helpers and that one". In the f=
ormer
> > > > > case whenever you add some new (opt-out) feature, you have to upd=
ate all
> > > > > drivers and add the exception. In the latter you only need to ext=
end the
> > > > > drivers that want to make use of the new helper.
> > >=20
> > > Erm, the idea never was to make this opt-out but rather opt in, so
> > > we add a flags parameter to ahci_platform_get_resources() and all
> > > current users pass in 0 for that to keep the current behavior.
> > >=20
> > > And only the generic drivers/ata/ahci_platform.c driver will pass
> > > in a the new AHCI_PLATFORM_GET_RESETS flag, which makes
> > > ahci_platform_get_resources() (and the other functions) also deal
> > > with resets.
> > >=20
> > > > > With that in mind, rather than adding a flag to the
> > > > > ahci_platform_get_resources() function, it might be more flexible=
 to
> > > > > split the helpers into finer-grained functions. That way drivers =
can
> > > > > pick whatever functionality they want from the helpers.
> > > > > Good point, so lets:
> > > > > 1) Revert the patch for now
> > > > 2) Have a new version of the patch which adds a ahci_platform_get_r=
esets() helper
> > > > 3) Modify the generic drivers/ata/ahci_platform.c driver to call th=
e new
> > > >   ?? ahci_platform_get_resets() between its ahci_platform_get_resou=
rces()
> > > >   ?? and ahci_platform_enable_resources() calls.
> > > >   ?? I think that ahci_platform_enable_resources() should still aut=
omatically
> > > >   ?? do the right thing wrt resets if ahci_platform_get_resets() wa=
s called
> > > >   ?? (otherwise the resets array will be empty and should be skippe=
d)
> > > > > This should make the generic driver usable for the UniPhier SoCs =
and
> > > > maybe some other drivers like the ahci_st driver can also switch to=
 the
> > > > new ahci_platform_get_resets() functionality to reduce their code a=
 bit.
> > >=20
> > > So thinking slightly longer about this, with the opt-in variant
> > > (which is what I intended all along) I do think that a flags parameter
> > > is better, because the whole idea behind lib_ahci_platform is to avoid
> > > having to do err =3D get_resource_a(), if (err) bail, err =3D get_res=
ource_b()
> > > if (err) bail, etc. in all the ahci (platform) drivers. And having fi=
ne
> > > grained helpers re-introduces that.
> >=20
> > In case of adding a flag instead of get_resource_a(),
> > for example, we add the flag for use of resets,
> >=20
> > -struct ahci_host_priv *ahci_platform_get_resources(struct platform_dev=
ice *pdev)
> > +struct ahci_host_priv *ahci_platform_get_resources(struct platform_dev=
ice *pdev,
> > +                                                  bool use_reset)
> >=20
> > and for now all the drivers using this function need to add the argumen=
t as false
> > to the caller.
> >=20
> > -       hpriv =3D ahci_platform_get_resources(pdev);
> > +       hpriv =3D ahci_platform_get_resources(pdev, false);
> >=20
> > Surely this can avoid adding functions such get_resource_a(). If we app=
ly another
> > feature later, we add its flag as one of the arguments instead. Is it r=
ight?
>=20
> Yes, that is right, but instead of adding a "bool use_reset" please add
> an "unsigned int flags" parameter instead and a:
>=20
> #define AHCI_PLATFORM_GET_RESETS	0x01
>=20
> And update all callers of ahci_platform_get_resources to pass 0 for flags
> except for drivers/ata/ahci_platform.c. This way we only need to modify
> all callers once, and if we want to add another optional resource in
> the future we can add a:
>=20
> #define AHCI_PLATFORM_GET_FOO		0x02
>=20
> Without needing to change all callers again.

On a side-note, I also think the symbolic flags make the code easier to
read. Having something like:

	ahci_platform_get_resources(pdev, true, false, true);

becomes really difficult to understand.

Thierry

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrLVYUACgkQ3SOs138+
s6FP2w/+KCuJYABKiICvvM5N0vvY/FJ8IJWWRwZU751gHnPsHBNrCfeAY5EbjC4B
urZ8LitKJxWuiLt8SCQ78TtZuTnr15cVgN2LPE7jUPocCXU81TS2hKgl1Wn3RFa0
ksnGurmR2OL/kntGv4EAYjSIHNmlRHlWRA3Wdf1sH/NeP+NEVYKnlaD4DZWKvY8l
7UIw9lrp2Ekk0zvhoFgP518KVTSmqNAA2bnhSG03ARIEbb5DNSwXELQXge6Q7Brw
07MbDkuN8RcMOhP+E08QgU983xE+WuJHjOwiAsiVWLVMfcNdzwwvKiTmsK31EG6C
9wn8J4SLHjHZ7hLY3FOk0wagJwcE5/liF/0BiP/W+baIkwrLsb49j9c4mxOnnbec
ey4bHf3ccefxcUxHmElUgGkix1iZN61YiWoNV1j/V2hSAuSbuDz6XwFJra0IivYm
s7s8SY/8VConJO1ubeFiHT6yCpwVs3qDzL1lhDTHgFErvzaNzWKZ7qJl/lyRwlYQ
eXNvI0NmTk4VmesGD4sfIdl5BYRVlqwrKZYNGAYBz5KrDMLC1BdlHtOfBFpilm+o
Iki44cF93IdHmP7At8vCREKcYTo08nK1hpwm7U0DCKXKpGa1CS19QJjE2+vJN+Oz
8nk7U6XCy+LONVSm0YyZmv3Hqbl8R7UksCMXCpzUFfEYChclZ2M=
=9v0W
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
