Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037D1C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D75820989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8qs6ovP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D75820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbeLFFWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:22:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44124 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeLFFWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:22:08 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so20482594lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 21:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o2xtOj5sbgfjcko8IPwJpvleas5w67T/uAA9CynYGrU=;
        b=M8qs6ovPHuQU2P2c9BEz+8F4dW3qDZKe13boCcAgSxLhuHeZHFcCXR37HFkMl1+GWn
         8GtIvsARtPa9Cqq9BV8GdyU9MlbqxLYeRjZ8oRCNlgJILjXmudPF6TpbYhVWkIS8I+if
         MDN5BVF1OEfcecvHY3PYxvqZ0xekXgMA4jvEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o2xtOj5sbgfjcko8IPwJpvleas5w67T/uAA9CynYGrU=;
        b=opGGwYOJjKf2P6y8RHrvwgNDBEL7F8q4YFera6DcZL2D2tILmQa4TPko2wgdJHq5OK
         LnnwDHCQcE8SY401G02V+8IFZMYGY86rxhZCkI492ATRyyH/WewUEhnefcQ29neOFRks
         kUq7/lft1UJdhdEe2cpAeWZxGokFlJ0LnBPXWmCrNkl23Elh51gP8FsjGIXy1HjgSRLC
         BppZPmepkVEyt9KEd3v334hG/MmEzE3AmJRdPOGk0M9wkcCDmLPWJ+ZtIgo/SBNXLazb
         3QnB8I0OvSt6LshlQwu9ZFv+DCBh2WkmoJRfnEhAvot+1SkO9mc5wIB6PI52XFbbXv9p
         AlYw==
X-Gm-Message-State: AA+aEWYYHMmBVaHNiNg6AKh0VE8F9WjHWXalOgi0Csz6px9hIjvwAd6N
        yb+OPUinl4vvHkAIL0OrIvnjICa6e85SE/QPe6cMHg==
X-Google-Smtp-Source: AFSGD/WjgMJ/QIkzyIwdYkX16TV4GQMqyFeqzbMgc9RFPNftO2NUF9aU15tlEWo0SMCMkPzRihiyjcng2LQmgULfIPs=
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr6175694ljb.52.1544073724928;
 Wed, 05 Dec 2018 21:22:04 -0800 (PST)
MIME-Version: 1.0
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
 <a41e3aad0147b25c4c22189dd7af0d68c5587b92.1542362262.git.baolin.wang@linaro.org>
 <20181204215219.GA14502@bogus> <CAMz4ku+5ELZ9sXz+1RzkgHnOFz_XfObwCdyixhvPN+Q0aovgUQ@mail.gmail.com>
 <20181205203455.cbochpqw5zwnn3uu@earth.universe>
In-Reply-To: <20181205203455.cbochpqw5zwnn3uu@earth.universe>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 6 Dec 2018 13:21:53 +0800
Message-ID: <CAMz4kuLTPumBBRxaF2XAs4RLAQFD7bjyX+9Z=564kvdpPZ=+Ow@mail.gmail.com>
Subject: Re: [PATCH 5/6] power: supply: charger-manager: Remove deprecated
 extcon APIs
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Thu, 6 Dec 2018 at 04:34, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Wed, Dec 05, 2018 at 10:57:12AM +0800, Baolin Wang wrote:
> > Hi Rob=EF=BC=8C
> > On Wed, 5 Dec 2018 at 05:52, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Nov 16, 2018 at 07:01:12PM +0800, Baolin Wang wrote:
> > > > The struct extcon_specific_cable_nb and related APIs are deprecated=
 now,
> > > > so we should use new method to get one extcon device and register e=
xtcon
> > > > notifier.
> > > >
> > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > > ---
> > > >  .../bindings/power/supply/charger-manager.txt      |    6 +--
> > >
> > > Bindings should be a separate patch.
> >
> > Sure.
> >
> > >
> > > >  drivers/power/supply/charger-manager.c             |   51 ++++++++=
------------
> > > >  include/linux/power/charger-manager.h              |    2 +-
> > > >  3 files changed, 23 insertions(+), 36 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/power/supply/charger=
-manager.txt b/Documentation/devicetree/bindings/power/supply/charger-manag=
er.txt
> > > > index ec4fe9d..315b0cb 100644
> > > > --- a/Documentation/devicetree/bindings/power/supply/charger-manage=
r.txt
> > > > +++ b/Documentation/devicetree/bindings/power/supply/charger-manage=
r.txt
> > > > @@ -11,7 +11,7 @@ Required properties :
> > > >       - cm-regulator-name : name of charger regulator
> > > >       - subnode <cable> :
> > > >               - cm-cable-name : name of charger cable
> > > > -             - cm-cable-extcon : name of extcon dev
> > > > +             - extcon : phandles to external connector devices
> > >
> > > Somewhat less terrible, but not really. I consider extcon binding its=
elf
> > > deprecated. I suspect 'charger-manager' as a whole probably needs to =
be
> > > reworked. This also is not a backwards compatible change.
>
> Right, charger-manager is a big hack. The DT node does not represent
> any hardware. The feature should be integrated into the power-supply
> core and work without any special DT bindings. I don't have the time
> to work on this, though.

Now we are trying to use charger manager to monitor our charging and
battery. So what you mean here is you want to remove the charger
manager driver and implement them in power_supply_core.c file, right?
If this is the future plan for charger manager, then we will stop to
optimize the charger manger driver.

I can help to implement or test the charger manager thing in power
supply core, so I am curious what's your thoughts if we try to
implement it in power supply core, could you explicit on? Thanks.

>
> > We are do some optimization for 'charger-manager', like this patch
> > did, we are trying to remove the deprecated extcon API.
> > And now no one use the incorrect 'cm-cable-extcon' property on
> > mainline, so no need worry backwards compatibility.
>
> As far as I can see there is no charger-manager user in mainline at
> all.
>
> -- Sebastian
>
> > > >  (optional)   - cm-cable-min : minimum current of cable
> > > >  (optional)   - cm-cable-max : maximum current of cable
> > > >
> > > > @@ -66,13 +66,13 @@ Example :
> > > >                       cm-regulator-name =3D "chg-reg";
> > > >                       cable@0 {
> > > >                               cm-cable-name =3D "USB";
> > > > -                             cm-cable-extcon =3D "extcon-dev.0";
> > > > +                             extcon =3D <&extcon_usb>;
> > > >                               cm-cable-min =3D <475000>;
> > > >                               cm-cable-max =3D <500000>;
> > > >                       };
> > > >                       cable@1 {
> > > >                               cm-cable-name =3D "TA";
> > > > -                             cm-cable-extcon =3D "extcon-dev.0";
> > > > +                             extcon =3D <&extcon_usb>;
> > > >                               cm-cable-min =3D <650000>;
> > > >                               cm-cable-max =3D <675000>;
> > > >                       };
> > > > diff --git a/drivers/power/supply/charger-manager.c b/drivers/power=
/supply/charger-manager.c
> > > > index dc0c9a6..4f28c03 100644
> > > > --- a/drivers/power/supply/charger-manager.c
> > > > +++ b/drivers/power/supply/charger-manager.c
> > > > @@ -1207,12 +1207,11 @@ static int charger_extcon_init(struct charg=
er_manager *cm,
> > > >        */
> > > >       INIT_WORK(&cable->wq, charger_extcon_work);
> > > >       cable->nb.notifier_call =3D charger_extcon_notifier;
> > > > -     ret =3D extcon_register_interest(&cable->extcon_dev,
> > > > -                     cable->extcon_name, cable->name, &cable->nb);
> > > > -     if (ret < 0) {
> > > > -             pr_info("Cannot register extcon_dev for %s(cable: %s)=
\n",
> > > > -                     cable->extcon_name, cable->name);
> > > > -     }
> > > > +     ret =3D devm_extcon_register_notifier(cm->dev, cable->extcon_=
dev,
> > > > +                                         EXTCON_USB, &cable->nb);
> > > > +     if (ret < 0)
> > > > +             dev_err(cm->dev, "Cannot register extcon_dev for (cab=
le: %s)\n",
> > > > +                     cable->name);
> > > >
> > > >       return ret;
> > > >  }
> > > > @@ -1589,15 +1588,25 @@ static struct charger_desc *of_cm_parse_des=
c(struct device *dev)
> > > >                               for_each_child_of_node(child, _child)=
 {
> > > >                                       of_property_read_string(_chil=
d,
> > > >                                       "cm-cable-name", &cables->nam=
e);
> > > > -                                     of_property_read_string(_chil=
d,
> > > > -                                     "cm-cable-extcon",
> > > > -                                     &cables->extcon_name);
> > > >                                       of_property_read_u32(_child,
> > > >                                       "cm-cable-min",
> > > >                                       &cables->min_uA);
> > > >                                       of_property_read_u32(_child,
> > > >                                       "cm-cable-max",
> > > >                                       &cables->max_uA);
> > > > +
> > > > +                                     if (of_property_read_bool(_ch=
ild, "extcon")) {
> > > > +                                             struct device_node *n=
p;
> > > > +
> > > > +                                             np =3D of_parse_phand=
le(_child, "extcon", 0);
> > > > +                                             if (!np)
> > > > +                                                     return ERR_PT=
R(-ENODEV);
> > > > +
> > > > +                                             cables->extcon_dev =
=3D extcon_find_edev_by_node(np);
> > > > +                                             of_node_put(np);
> > > > +                                             if (IS_ERR(cables->ex=
tcon_dev))
> > > > +                                                     return ERR_PT=
R(PTR_ERR(cables->extcon_dev));
> > > > +                                     }
> > > >                                       cables++;
> > > >                               }
> > > >                       }
> > > > @@ -1625,7 +1634,6 @@ static int charger_manager_probe(struct platf=
orm_device *pdev)
> > > >       struct charger_desc *desc =3D cm_get_drv_data(pdev);
> > > >       struct charger_manager *cm;
> > > >       int ret, i =3D 0;
> > > > -     int j =3D 0;
> > > >       union power_supply_propval val;
> > > >       struct power_supply *fuel_gauge;
> > > >       struct power_supply_config psy_cfg =3D {};
> > > > @@ -1823,19 +1831,8 @@ static int charger_manager_probe(struct plat=
form_device *pdev)
> > > >                               &charger->attr_g);
> > > >       }
> > > >  err_reg_extcon:
> > > > -     for (i =3D 0; i < desc->num_charger_regulators; i++) {
> > > > -             struct charger_regulator *charger;
> > > > -
> > > > -             charger =3D &desc->charger_regulators[i];
> > > > -             for (j =3D 0; j < charger->num_cables; j++) {
> > > > -                     struct charger_cable *cable =3D &charger->cab=
les[j];
> > > > -                     /* Remove notifier block if only edev exists =
*/
> > > > -                     if (cable->extcon_dev.edev)
> > > > -                             extcon_unregister_interest(&cable->ex=
tcon_dev);
> > > > -             }
> > > > -
> > > > +     for (i =3D 0; i < desc->num_charger_regulators; i++)
> > > >               regulator_put(desc->charger_regulators[i].consumer);
> > > > -     }
> > > >
> > > >       power_supply_unregister(cm->charger_psy);
> > > >
> > > > @@ -1847,7 +1844,6 @@ static int charger_manager_remove(struct plat=
form_device *pdev)
> > > >       struct charger_manager *cm =3D platform_get_drvdata(pdev);
> > > >       struct charger_desc *desc =3D cm->desc;
> > > >       int i =3D 0;
> > > > -     int j =3D 0;
> > > >
> > > >       /* Remove from the list */
> > > >       mutex_lock(&cm_list_mtx);
> > > > @@ -1857,15 +1853,6 @@ static int charger_manager_remove(struct pla=
tform_device *pdev)
> > > >       cancel_work_sync(&setup_polling);
> > > >       cancel_delayed_work_sync(&cm_monitor_work);
> > > >
> > > > -     for (i =3D 0 ; i < desc->num_charger_regulators ; i++) {
> > > > -             struct charger_regulator *charger
> > > > -                             =3D &desc->charger_regulators[i];
> > > > -             for (j =3D 0 ; j < charger->num_cables ; j++) {
> > > > -                     struct charger_cable *cable =3D &charger->cab=
les[j];
> > > > -                     extcon_unregister_interest(&cable->extcon_dev=
);
> > > > -             }
> > > > -     }
> > > > -
> > > >       for (i =3D 0 ; i < desc->num_charger_regulators ; i++)
> > > >               regulator_put(desc->charger_regulators[i].consumer);
> > > >
> > > > diff --git a/include/linux/power/charger-manager.h b/include/linux/=
power/charger-manager.h
> > > > index c4fa907..e4d0269 100644
> > > > --- a/include/linux/power/charger-manager.h
> > > > +++ b/include/linux/power/charger-manager.h
> > > > @@ -66,7 +66,7 @@ struct charger_cable {
> > > >       const char *name;
> > > >
> > > >       /* The charger-manager use Extcon framework */
> > > > -     struct extcon_specific_cable_nb extcon_dev;
> > > > +     struct extcon_dev *extcon_dev;
> > > >       struct work_struct wq;
> > > >       struct notifier_block nb;
> > > >
> > > > --
> > > > 1.7.9.5
> > > >
> >
> >
> >
> > --
> > Baolin Wang
> > Best Regards



--=20
Baolin Wang
Best Regards
