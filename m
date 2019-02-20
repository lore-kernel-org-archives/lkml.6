Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B90C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3605820880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toO/u5Fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfBTVYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:24:25 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45851 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBTVYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:24:25 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so42665971ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 13:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CX0Ej+C25hnPLucJgZDuVp4EYcT9632ZU7KSmYgM990=;
        b=toO/u5FxNwFqKBIoCiFcRFJ+6g7uh94mVACddWd4U6EaivSUV4hdNscKcXRzY/D1tJ
         9sZ/1VJMvWuxDkHkajR36ACZmtpDhUAivYGABCC5CPVNb8oDUcBptRv/hbxuQdMlgqor
         dO9KwkHTdf9CniMk5AUd9cDCGB7OLvyaLeEbtT3CLu6F0SueOdqFp3wVhgVtzn6/U52S
         lr8syqQJ7rCNebItSeW/ictyFPrZ20Umnh3YRbVQFXFW7vsBaHvJLIEQvKNR9UlZjkmT
         DOTlfKXr4OKIoFZa+oOO8pqZFKN43tlqlUytWWkqkgViyRsSaxnhDY8EnuYCmFPv1rJz
         Hv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CX0Ej+C25hnPLucJgZDuVp4EYcT9632ZU7KSmYgM990=;
        b=eM8sdy1JbWB3ijkrDF6SlPjQ52RGiWt+SBTGzQLLn6KyWhHgU437DTGoO9acUntyKr
         l2KMJAzLRzFdB8wTxXFQxQoT4R/xMC+U3x1WcYLDIrV15aUtRqGV1cvJZIs31lIjB/G5
         dRYtfDobMmfXMkt+I6DxMl+aXXzu4p7a+TaS/e/HXAw7KgrkHQ5ST5yZ2LVJQP5SQYpx
         bYHrRzwLQDJQ4hlz520RaOCypTY1aJI1qE9KSivjT4SZlMAN/MIFuE0UDqd2MmXFTTBF
         T/B2zRYp/kDGV5tuxlxgm1Ys73PqcDMCafuNV4TNspxoxRD2CqA/CP+/OPRWlGfATSaH
         HiBg==
X-Gm-Message-State: AHQUAuaMthNtacdsJQTYmY5yH/03u9NiCgpYhb5Ok22/LLIlz5fyltx3
        iCHfAOxBsrhD08QreLGjXAnlZWqs9w9dzpHIzng=
X-Google-Smtp-Source: AHgI3Ib7fvmTpDY4ZrK7UCuksFJ5ZPqtQvFGZ+RWxjMD1vio22OQNbmYqWHPkupgNWmgpSP/Ldl86ZT/B3TTD5ttKKs=
X-Received: by 2002:aca:75cf:: with SMTP id q198mr7390669oic.125.1550697863672;
 Wed, 20 Feb 2019 13:24:23 -0800 (PST)
MIME-Version: 1.0
References: <20190219212441.19391-1-jekhor@gmail.com> <20190219212441.19391-3-jekhor@gmail.com>
 <19f27109-434d-3e5e-c895-fdec0324572f@redhat.com>
In-Reply-To: <19f27109-434d-3e5e-c895-fdec0324572f@redhat.com>
From:   Yauhen Kharuzhy <jekhor@gmail.com>
Date:   Thu, 21 Feb 2019 00:24:11 +0300
Message-ID: <CAKWEGV7rOzvyK5GHQc65XvtGd3Pe7Czccro=sjpoH0DbQ+h+Rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] extcon intel-cht-wc: Enable external charger
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 20 =D1=84=D0=B5=D0=B2=D1=80. 2019 =D0=B3. =D0=B2 18:53, Hans =
de Goede <hdegoede@redhat.com>:
>
> Hi,
>
> On 2/19/19 10:24 PM, Yauhen Kharuzhy wrote:
> > In some configuration external charger "#charge enable" signal is
> > connected to PMIC. Enable it at device probing to allow charging.
> >
> > Save CHGRCTRL0 and CHGDISCTR registers at driver probing and restore
> > them at driver unbind to re-enable hardware charging control if it was
> > enabled before.
> >
> > Tested at Lenovo Yoga Book (YB1-X91L).
> >
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > ---
> >   drivers/extcon/extcon-intel-cht-wc.c | 91 +++++++++++++++++++++++++++=
-
> >   1 file changed, 90 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extc=
on-intel-cht-wc.c
> > index 4f6ba249bc30..ac009929d244 100644
> > --- a/drivers/extcon/extcon-intel-cht-wc.c
> > +++ b/drivers/extcon/extcon-intel-cht-wc.c
> > @@ -57,6 +57,16 @@
> >   #define CHT_WC_USBSRC_TYPE_OTHER    8
> >   #define CHT_WC_USBSRC_TYPE_DCP_EXTPHY       9
> >
> > +#define CHT_WC_CHGDISCTRL            0x5e2f
> > +#define CHT_WC_CHGDISCTRL_OUTPUT     BIT(0)
> > +/* 0 - open drain, 1 - regular output */
> > +#define CHT_WC_CHGDISCTRL_DRV_OD_DIS BIT(4)
> > +#define CHT_WC_CHGDISCTRL_MODE_HW    BIT(6)
> > +
> > +#define CHT_WC_CHGDISCTRL_CCSM_DIS   0x11
> > +#define CHT_WC_CHGDISCTRL_CCSM_EN    0x00
> > +#define CHT_WC_CHGDISCTRL_CCSM_MASK  0x51
> > +
>
> You no longer need the last 3 defines and IMHO keeping them
> will only confuse the reader of the code, please drop these 3.

My mistake, thanks.

> > +static int cht_wc_save_initial_state(struct cht_wc_extcon_data *ext)
> > +{
> > +     int ret;
> > +
> > +     /*
> > +      * Save the external charger control output state for restoring i=
t at
> > +      * driver unbinding
> > +      */
> > +     ret =3D regmap_read(ext->regmap, CHT_WC_CHGDISCTRL,
> > +                       &ext->chgdisctrl_saved);
> > +     if (ret) {
> > +             dev_err(ext->dev, "Error reading CHGDISCTRL: %d\n",
> > +                     ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D regmap_read(ext->regmap, CHT_WC_CHGRCTRL0,
> > +                       &ext->chgrctrl0_saved);
> > +     if (ret) {
> > +             dev_err(ext->dev, "Error reading CHGRCTRL0: %d\n",
> > +                     ret);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int cht_wc_restore_initial_state(struct cht_wc_extcon_data *ext=
)
> > +{
> > +     int ret;
> > +
> > +     ret =3D regmap_write(ext->regmap, CHT_WC_CHGDISCTRL,
> > +                        ext->chgdisctrl_saved);
> > +     if (ret)
> > +             dev_err(ext->dev, "Error restoring of CHGDISCTRL reg: %d\=
n",
> > +                     ret);
> > +
> > +     ret =3D regmap_write(ext->regmap, CHT_WC_CHGRCTRL0,
> > +                        ext->chgrctrl0_saved);
> > +     if (ret)
> > +             dev_err(ext->dev, "Error restoring of CHGRCTRL0 reg: %d\n=
",
> > +                     ret);
> > +
> > +     return ret;
> > +}
> > +
> >   static int cht_wc_extcon_probe(struct platform_device *pdev)
> >   {
> >       struct intel_soc_pmic *pmic =3D dev_get_drvdata(pdev->dev.parent)=
;
> > @@ -347,6 +429,8 @@ static int cht_wc_extcon_probe(struct platform_devi=
ce *pdev)
> >       if (IS_ERR(ext->edev))
> >               return PTR_ERR(ext->edev);
> >
> > +     cht_wc_save_initial_state(ext);
> > +
> >       /*
> >        * When a host-cable is detected the BIOS enables an external 5v =
boost
> >        * converter to power connected devices there are 2 problems with=
 this:
> > @@ -365,7 +449,10 @@ static int cht_wc_extcon_probe(struct platform_dev=
ice *pdev)
> >       /* Enable sw control */
> >       ret =3D cht_wc_extcon_sw_control(ext, true);
> >       if (ret)
> > -             return ret;
> > +             goto disable_sw_control;
> > +
> > +     /* Disable charging by external battery charger */
> > +     cht_wc_extcon_enable_charging(ext, false);
> >
> >       /* Register extcon device */
> >       ret =3D devm_extcon_dev_register(ext->dev, ext->edev);
> > @@ -400,6 +487,7 @@ static int cht_wc_extcon_probe(struct platform_devi=
ce *pdev)
> >
> >   disable_sw_control:
> >       cht_wc_extcon_sw_control(ext, false);
> > +     cht_wc_restore_initial_state(ext);
>
> The restore_initial_state will clober al changes made by the
> cht_wc_extcon_sw_control call, so we do not need both. Thinking a bit
> more about this I think it might be best to drop the state save/restore
> code and just enable hw-control on exit unconditionally. We cannot be
> sure that te initial state is sane, so just switching to hw-control on
> exit seem best and requires less code.  Andy, what is your take on this?

On the other hand we don't know if HW mode is suitable for given
hardware configuration.

We can suppose that if existing code with unconditionally switching to
HW mode didn't cause
any issues before than we can safely leave this for future discussions
and add CHGDISCTRL restoring only.

--=20
Yauhen Kharuzhy
