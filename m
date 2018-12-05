Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D73DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042A620989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042A620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeLEUfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:35:01 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50988 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeLEUfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:35:01 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5F095275703
Received: by earth.universe (Postfix, from userid 1000)
        id 7F1F23C08D6; Wed,  5 Dec 2018 21:34:55 +0100 (CET)
Date:   Wed, 5 Dec 2018 21:34:55 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 5/6] power: supply: charger-manager: Remove deprecated
 extcon APIs
Message-ID: <20181205203455.cbochpqw5zwnn3uu@earth.universe>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
 <a41e3aad0147b25c4c22189dd7af0d68c5587b92.1542362262.git.baolin.wang@linaro.org>
 <20181204215219.GA14502@bogus>
 <CAMz4ku+5ELZ9sXz+1RzkgHnOFz_XfObwCdyixhvPN+Q0aovgUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u6lwr7onrt42sm2v"
Content-Disposition: inline
In-Reply-To: <CAMz4ku+5ELZ9sXz+1RzkgHnOFz_XfObwCdyixhvPN+Q0aovgUQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u6lwr7onrt42sm2v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 05, 2018 at 10:57:12AM +0800, Baolin Wang wrote:
> Hi Rob=EF=BC=8C
> On Wed, 5 Dec 2018 at 05:52, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Nov 16, 2018 at 07:01:12PM +0800, Baolin Wang wrote:
> > > The struct extcon_specific_cable_nb and related APIs are deprecated n=
ow,
> > > so we should use new method to get one extcon device and register ext=
con
> > > notifier.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  .../bindings/power/supply/charger-manager.txt      |    6 +--
> >
> > Bindings should be a separate patch.
>=20
> Sure.
>=20
> >
> > >  drivers/power/supply/charger-manager.c             |   51 ++++++++--=
----------
> > >  include/linux/power/charger-manager.h              |    2 +-
> > >  3 files changed, 23 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/power/supply/charger-m=
anager.txt b/Documentation/devicetree/bindings/power/supply/charger-manager=
=2Etxt
> > > index ec4fe9d..315b0cb 100644
> > > --- a/Documentation/devicetree/bindings/power/supply/charger-manager.=
txt
> > > +++ b/Documentation/devicetree/bindings/power/supply/charger-manager.=
txt
> > > @@ -11,7 +11,7 @@ Required properties :
> > >       - cm-regulator-name : name of charger regulator
> > >       - subnode <cable> :
> > >               - cm-cable-name : name of charger cable
> > > -             - cm-cable-extcon : name of extcon dev
> > > +             - extcon : phandles to external connector devices
> >
> > Somewhat less terrible, but not really. I consider extcon binding itself
> > deprecated. I suspect 'charger-manager' as a whole probably needs to be
> > reworked. This also is not a backwards compatible change.

Right, charger-manager is a big hack. The DT node does not represent
any hardware. The feature should be integrated into the power-supply
core and work without any special DT bindings. I don't have the time
to work on this, though.

> We are do some optimization for 'charger-manager', like this patch
> did, we are trying to remove the deprecated extcon API.
> And now no one use the incorrect 'cm-cable-extcon' property on
> mainline, so no need worry backwards compatibility.

As far as I can see there is no charger-manager user in mainline at
all.

-- Sebastian

> > >  (optional)   - cm-cable-min : minimum current of cable
> > >  (optional)   - cm-cable-max : maximum current of cable
> > >
> > > @@ -66,13 +66,13 @@ Example :
> > >                       cm-regulator-name =3D "chg-reg";
> > >                       cable@0 {
> > >                               cm-cable-name =3D "USB";
> > > -                             cm-cable-extcon =3D "extcon-dev.0";
> > > +                             extcon =3D <&extcon_usb>;
> > >                               cm-cable-min =3D <475000>;
> > >                               cm-cable-max =3D <500000>;
> > >                       };
> > >                       cable@1 {
> > >                               cm-cable-name =3D "TA";
> > > -                             cm-cable-extcon =3D "extcon-dev.0";
> > > +                             extcon =3D <&extcon_usb>;
> > >                               cm-cable-min =3D <650000>;
> > >                               cm-cable-max =3D <675000>;
> > >                       };
> > > diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/s=
upply/charger-manager.c
> > > index dc0c9a6..4f28c03 100644
> > > --- a/drivers/power/supply/charger-manager.c
> > > +++ b/drivers/power/supply/charger-manager.c
> > > @@ -1207,12 +1207,11 @@ static int charger_extcon_init(struct charger=
_manager *cm,
> > >        */
> > >       INIT_WORK(&cable->wq, charger_extcon_work);
> > >       cable->nb.notifier_call =3D charger_extcon_notifier;
> > > -     ret =3D extcon_register_interest(&cable->extcon_dev,
> > > -                     cable->extcon_name, cable->name, &cable->nb);
> > > -     if (ret < 0) {
> > > -             pr_info("Cannot register extcon_dev for %s(cable: %s)\n=
",
> > > -                     cable->extcon_name, cable->name);
> > > -     }
> > > +     ret =3D devm_extcon_register_notifier(cm->dev, cable->extcon_de=
v,
> > > +                                         EXTCON_USB, &cable->nb);
> > > +     if (ret < 0)
> > > +             dev_err(cm->dev, "Cannot register extcon_dev for (cable=
: %s)\n",
> > > +                     cable->name);
> > >
> > >       return ret;
> > >  }
> > > @@ -1589,15 +1588,25 @@ static struct charger_desc *of_cm_parse_desc(=
struct device *dev)
> > >                               for_each_child_of_node(child, _child) {
> > >                                       of_property_read_string(_child,
> > >                                       "cm-cable-name", &cables->name);
> > > -                                     of_property_read_string(_child,
> > > -                                     "cm-cable-extcon",
> > > -                                     &cables->extcon_name);
> > >                                       of_property_read_u32(_child,
> > >                                       "cm-cable-min",
> > >                                       &cables->min_uA);
> > >                                       of_property_read_u32(_child,
> > >                                       "cm-cable-max",
> > >                                       &cables->max_uA);
> > > +
> > > +                                     if (of_property_read_bool(_chil=
d, "extcon")) {
> > > +                                             struct device_node *np;
> > > +
> > > +                                             np =3D of_parse_phandle=
(_child, "extcon", 0);
> > > +                                             if (!np)
> > > +                                                     return ERR_PTR(=
-ENODEV);
> > > +
> > > +                                             cables->extcon_dev =3D =
extcon_find_edev_by_node(np);
> > > +                                             of_node_put(np);
> > > +                                             if (IS_ERR(cables->extc=
on_dev))
> > > +                                                     return ERR_PTR(=
PTR_ERR(cables->extcon_dev));
> > > +                                     }
> > >                                       cables++;
> > >                               }
> > >                       }
> > > @@ -1625,7 +1634,6 @@ static int charger_manager_probe(struct platfor=
m_device *pdev)
> > >       struct charger_desc *desc =3D cm_get_drv_data(pdev);
> > >       struct charger_manager *cm;
> > >       int ret, i =3D 0;
> > > -     int j =3D 0;
> > >       union power_supply_propval val;
> > >       struct power_supply *fuel_gauge;
> > >       struct power_supply_config psy_cfg =3D {};
> > > @@ -1823,19 +1831,8 @@ static int charger_manager_probe(struct platfo=
rm_device *pdev)
> > >                               &charger->attr_g);
> > >       }
> > >  err_reg_extcon:
> > > -     for (i =3D 0; i < desc->num_charger_regulators; i++) {
> > > -             struct charger_regulator *charger;
> > > -
> > > -             charger =3D &desc->charger_regulators[i];
> > > -             for (j =3D 0; j < charger->num_cables; j++) {
> > > -                     struct charger_cable *cable =3D &charger->cable=
s[j];
> > > -                     /* Remove notifier block if only edev exists */
> > > -                     if (cable->extcon_dev.edev)
> > > -                             extcon_unregister_interest(&cable->extc=
on_dev);
> > > -             }
> > > -
> > > +     for (i =3D 0; i < desc->num_charger_regulators; i++)
> > >               regulator_put(desc->charger_regulators[i].consumer);
> > > -     }
> > >
> > >       power_supply_unregister(cm->charger_psy);
> > >
> > > @@ -1847,7 +1844,6 @@ static int charger_manager_remove(struct platfo=
rm_device *pdev)
> > >       struct charger_manager *cm =3D platform_get_drvdata(pdev);
> > >       struct charger_desc *desc =3D cm->desc;
> > >       int i =3D 0;
> > > -     int j =3D 0;
> > >
> > >       /* Remove from the list */
> > >       mutex_lock(&cm_list_mtx);
> > > @@ -1857,15 +1853,6 @@ static int charger_manager_remove(struct platf=
orm_device *pdev)
> > >       cancel_work_sync(&setup_polling);
> > >       cancel_delayed_work_sync(&cm_monitor_work);
> > >
> > > -     for (i =3D 0 ; i < desc->num_charger_regulators ; i++) {
> > > -             struct charger_regulator *charger
> > > -                             =3D &desc->charger_regulators[i];
> > > -             for (j =3D 0 ; j < charger->num_cables ; j++) {
> > > -                     struct charger_cable *cable =3D &charger->cable=
s[j];
> > > -                     extcon_unregister_interest(&cable->extcon_dev);
> > > -             }
> > > -     }
> > > -
> > >       for (i =3D 0 ; i < desc->num_charger_regulators ; i++)
> > >               regulator_put(desc->charger_regulators[i].consumer);
> > >
> > > diff --git a/include/linux/power/charger-manager.h b/include/linux/po=
wer/charger-manager.h
> > > index c4fa907..e4d0269 100644
> > > --- a/include/linux/power/charger-manager.h
> > > +++ b/include/linux/power/charger-manager.h
> > > @@ -66,7 +66,7 @@ struct charger_cable {
> > >       const char *name;
> > >
> > >       /* The charger-manager use Extcon framework */
> > > -     struct extcon_specific_cable_nb extcon_dev;
> > > +     struct extcon_dev *extcon_dev;
> > >       struct work_struct wq;
> > >       struct notifier_block nb;
> > >
> > > --
> > > 1.7.9.5
> > >
>=20
>=20
>=20
> --=20
> Baolin Wang
> Best Regards

--u6lwr7onrt42sm2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwINmwACgkQ2O7X88g7
+pqKEw//aqzaoXIwxQhrkPkWe/LcgJLbB92xsWJeFzdLrCwpC/hyqS+prgtE6Q9g
gz8t+4Mx+eODTO3BrY/85pFa4OH7icFW+zt7kgYH8wDuzl6+4ZnbDNXVwFKFc72r
f7Kju/5BfZjXY7Q7R/X8Bi23dze+W1Agz6SI5/62OKyoBeQ4wONXSat7zT2C34+w
cZypMvxyNhX4vzedumTfms0J3WpYzPP5QS8/67KZwEwZGv5bu2iiglavl1tPM8nX
1BM7vqTCnMHOpofAbZpTHdscJct0dqzComXPd6B4vt6qEWRbf1WgGdNBi3GUvsqQ
jj6EI3lnML1pkJQoYwOr/rEU+kCo5i88ughz9JLwy9I+Ja1YfG5sat0vCB1R3k0r
LVvq+ihb/3gdBv5pEerH5h1oFGqgNVud15m9Tef6aw4a2HDfkn4donOdp8eml4np
YtCgJxsXdKf7w7shnBJUsmfeTMFmz86ymP7xLtMH7kv4Y7oivpC3WY26e4PXs95s
8Ws7sB7JgV7IEmn42zxaQD8wNF+/tYsYIjNlBI/qQ0VXtkCd6LwSKZoe52TMbF0n
4CxSVGOaZWr/cQHuwTjP+yjpHBeggt75LksJp8XMgZEGot39T8Sv4OBnYghvq3zQ
aD78K1L/82kpXCjBmuzJ+7JoUuJqqDDMp0RBF3v09377SAr4dfE=
=5wHn
-----END PGP SIGNATURE-----

--u6lwr7onrt42sm2v--
