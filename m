Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F50EC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4E220878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ1RpHOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4E220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeG1Omg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 10:42:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43925 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeG1Omg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 10:42:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id f135-v6so5304628lfg.10;
        Sat, 28 Jul 2018 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5By4YMJIrDo99ma0g09YxE5GtQnXbQmClUzrMOAmc3I=;
        b=CJ1RpHOdbEwJ3E4OOY0qaZ5ZVRR/qwiNYFlFApNqBz9UUMBhpeLwwydPkXtzc05jm1
         lUqZAHzYtNgQ9PcYw3TviSTKhfNlnCidCOWeXI+NiiqiynuK+TgqHnYHqlzciTmvSe1h
         0PAMR17RlaO2i2irskpsO2FyciIbAyCPp85/0ZQ73h+DhkxKxYUZkIrJFoukSLcNRGCC
         j/T+9oOejAAF2hLc8PGWUSNA1ZUgIubx5Z9N2U0amMDNtMfqgIL860Jgy2ZNVmbx/Gc3
         Jslt3TL/4vIuQMZVXM9gozBxea/zqNBMPJoljer0k2ua7w8fOqPK5S0iJXh0+HY7/lN9
         Et/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5By4YMJIrDo99ma0g09YxE5GtQnXbQmClUzrMOAmc3I=;
        b=U2PmJZlLAX2zfr1fxcE28+z2qtHvKKPvUF6ng01BfiIMMcqu5PVkvZqOGAYm2HsyP1
         9qKscm00eGdwhnzqvEPmwoRtCJiNN77h5xQknyi08E92DZqOTavDHPSOMH278T52tq1m
         OXx4wHoV0jdohO2x9TmEJqEVVvcjMWjpMGubDHmzYc246ECHlqOm45Edbl077K8JY3FC
         VcvKIriIsiahlebE/rHtjE4wPzBroHJgSdYDs+Guk0whFKc3wgfihFq2RCImgeayFZiw
         7ttnL2K0sSiEOcaZyonomHBHbAUsK7CY0qR4lXeQWIQpLzr5Yo6pw1nzc2IVxz8v85mz
         +aNA==
X-Gm-Message-State: AOUpUlHQV/6Ps+LF64m+TaDKjoVCtmV9trLZmODrc9ptUUtiHBOLCcJF
        32CRhzHgKN/K4aAkRJfxz5E=
X-Google-Smtp-Source: AAOMgpfq4umtoloyYPEzzKRaFK0oJpcipP0LDiF4PJkWZqhnLG9xl11jo6bhUiFKyrJO6Q2e15Gf9g==
X-Received: by 2002:a19:a2d5:: with SMTP id l204-v6mr6727393lfe.65.1532783764348;
        Sat, 28 Jul 2018 06:16:04 -0700 (PDT)
Received: from acerlaptop.localnet (user-94-254-173-71.play-internet.pl. [94.254.173.71])
        by smtp.gmail.com with ESMTPSA id j26-v6sm1128576ljc.54.2018.07.28.06.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 06:16:03 -0700 (PDT)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Nick Dyer <nick@shmanahar.org>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: atmel_mxt_ts: Add support for  optional regulators.
Date:   Sat, 28 Jul 2018 15:16:02 +0200
Message-ID: <2009318.0y2T04Zz3n@acerlaptop>
User-Agent: KMail/5.1.3 (Linux/4.15.0-29-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20180719205403.GA29273@hairyalien>
References: <1531851386-17840-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <2353752.vfvcsHJLR6@acerlaptop> <20180719205403.GA29273@hairyalien>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 19, 2018 9:54:04 PM CEST Nick Dyer wrote:
> On Wed, Jul 18, 2018 at 06:21:30PM +0200, Pawe=C5=82 Chmiel wrote:
> > On Tuesday, July 17, 2018 10:00:05 PM CEST Nick Dyer wrote:
> > > On Tue, Jul 17, 2018 at 08:16:25PM +0200, Pawe=C5=82 Chmiel wrote:
> > > > This patch adds optional regulators, which can be used to power
> > > > up touchscreen. After enabling regulators, we need to wait 150msec.
> > > > This value is taken from official driver.
> > > >=20
> > > > It was tested on Samsung Galaxy i9000 (based on Samsung S5PV210 SOC=
).
> > > >=20
> > > > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > > > ---
> > > > Changes from v1:
> > > >   - Enable regulators only if reset_gpio is present.
> > > >   - Switch from devm_regulator_get_optional to devm_regulator_get
> > > > ---
> > > >  drivers/input/touchscreen/atmel_mxt_ts.c | 46 ++++++++++++++++++++=
++++++++++--
> > > >  1 file changed, 44 insertions(+), 2 deletions(-)
> > >=20
> > > Hi Pawel-
> > >=20
> > > I see you've borrowed some of the logic from the patch I wrote a while
> > > back (see https://github.com/ndyer/linux/commit/8e9687e41ed062 )
> > Actually, i was looking at https://github.com/atmel-maxtouch/linux/blob=
/maxtouch-v3.14/drivers/input/touchscreen/atmel_mxt_ts.c (and didn't saw Yo=
ur patch till now).
> > Are You going to submit it? (it has more functionalities - for example
> > suspend mode read from device tree).
>=20
> Getting that work upstream has stalled for a couple of years because I
> changed jobs. I have actually started recently to dust it off again, it
> was later on in my queue but if you have the time to work on it that is
> great.
>=20
> > > The correct behaviour according to Atmel should be:
> > >=20
> > > * Make RESET zero
> > > * Bring up regulators
> > > * Wait for a period to settle (150 msec)
> > > * Release RESET
> > > * Wait for 100 msec whilst device gets through bootloader
> > > * Wait for CHG line assert before reading info block
> > >=20
> > > I can't see the first and last steps in your patch at present.
> > About first step - reset_gpio is readed by using
> > devm_gpiod_get_optional with GPIOD_OUT_LOW flag, so i think (but might
> > be wrong)  that we don't need to set this gpio value again to 0 before
> > enabling regulators,
>=20
> I see what you mean - that is fair enough.
>=20
> > since currently only place where reset_gpio is used is in driver probe
> > (in Your patch it is used in other cases/places - for example in
> > mxt_start/stop, when we enable regulators).
> > About missing wait after releasing reset, shouldn't this be separate
> > patch (since currently driver is not doing it)? I can prepare it and
> > send with other in next version.
>=20
> According to the maxtouch documentation, it isn't ready for comms until
> the firmware asserts the CHG line. I've seen a bunch of devices that get
> by without an explicit wait because the board file does the power on,
> and by the time the driver gets to probe it's a few hundred ms later
> anyway, so it doesn't matter. But if we put it all in the driver, it
> will attempt to read the info block straight after the 100 msec delay
> without waiting for CHG, and I suspect we'll end up with occasional
> probe failures. It'll depend on the maxtouch device, though: they have a
> range of different power on timings.
>=20
> Which platform are you doing this for? Is it a Chromebook?
No, it's Samsung Galaxy S (i9000) phone with S5PV210 Samsung Soc.
I'm preparing v3 version with separate patch adding this wait/delay.
>=20
> > Thanks for feedback
> > >=20
> > > The only downside with this approach is that there are a lot of
> > > delays during driver probe, but I believe the asynchronous probe stuff
> > > that's landed since I wrote the original patch should address that.
> > >=20
> > > cheers
> > >=20
> > > Nick
> > >=20
> > > >  	}
> > > > @@ -3116,6 +3154,10 @@ static int mxt_remove(struct i2c_client *cli=
ent)
> > > >  	struct mxt_data *data =3D i2c_get_clientdata(client);
> > > > =20
> > > >  	disable_irq(data->irq);
> > > > +	if (data->reset_gpio) {
> > > > +		regulator_disable(data->avdd_reg);
> > > > +		regulator_disable(data->vdd_reg);
> > > > +	}
> > > >  	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
> > > >  	mxt_free_input_device(data);
> > > >  	mxt_free_object_table(data);
> > >=20
> >=20
> >=20
>=20


