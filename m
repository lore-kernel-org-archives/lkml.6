Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F88AC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1870B20856
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNjaOxTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfBBO1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 09:27:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46254 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfBBO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 09:27:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so8166776ljh.13;
        Sat, 02 Feb 2019 06:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+KhDxtcEgadOyIqKjazQnY6KU1iRYsZF9T3iqlT8Pc=;
        b=eNjaOxTsIExrH8AtdNRHxJZpXA7tIpXgB8dQzblm46auYhwrvWgntc2Se9QgAa9x/x
         zO4VIS5co82QXgz9vXI7X0GGO2G8yiQJs8UTDs2hGSoi79JvqS37eUpd9BuW1SWP8RKC
         ll9njjVLTqwoqNTlah2eY8ooTAShlQ5clF+YAsAuLFoa1YW6xLwXJUA/N/CedUjtUXEX
         H6fGWk6suY7dMVh7ADF7wv2WsNgCflr6PoneinqRBT63vkSkgHjbeMl/8DzVJW/IksvO
         3YgcKQcytcDEigFj+8UaoZLeBfFlsLrPQcmBAORiimfsPHIlvOK02+mvG5JVr3SImy/R
         BaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+KhDxtcEgadOyIqKjazQnY6KU1iRYsZF9T3iqlT8Pc=;
        b=kBpMB4NJzYkFsrhaRkOrVssFjk6DfZ423C2CXK73o6wsrawT7yjrMi/R26MkT5n/LQ
         ZToef2Ko9gjo4qBxTJndWGIAIyIBzN9xRL2dFLMBZKjFrN5mcl25PrlUcwLTMKh9MUEC
         5vjFhZEV739+JbM+SZvvYuIFLGjDd/XT6ZnEMRzYbIbB0yxTJ7tgHMlkeQYAJwJziWf+
         /Jtg6z40i5sUMYtifHVN7K4pA8+McLa0/IsZP/wvrwdbgFssU0zHnmgoco5HJs6hNQvk
         YGf6iigIixGO3DIaGuC6XXg+6krW78O1t0SDwiE0Fv5p7VxESI0naqgHZi78FlBzNg5O
         60FQ==
X-Gm-Message-State: AJcUukeYFhhFLVj0UMEoihX/NaK22ucgrdnUKLbNOGTDLkZcYUV9Euoj
        8McDaNm6s0vEWjRPjy84bRM=
X-Google-Smtp-Source: ALg8bN4J/U6zo/nVGf4JKsOlXI5HuSNzQlSgQRmZ6vBpi0DtxQM7uCioG1Po/qXiOwD3B/E1KbpPpA==
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr33381023ljt.107.1549117628943;
        Sat, 02 Feb 2019 06:27:08 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:6cb2:9e25:2436:6eda])
        by smtp.gmail.com with ESMTPSA id 11-v6sm1788291ljv.1.2019.02.02.06.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 06:27:07 -0800 (PST)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com
Subject: Re: [PATCH v2 2/2] drm/panel: Add driver for Samsung S6E63M0 panel
Date:   Sat, 02 Feb 2019 15:27:06 +0100
Message-ID: <2172951.fb1UFt6Zc6@acerlaptop>
In-Reply-To: <20190201213607.GA27951@ravnborg.org>
References: <20190201172852.4944-1-pawel.mikolaj.chmiel@gmail.com> <20190201172852.4944-2-pawel.mikolaj.chmiel@gmail.com> <20190201213607.GA27951@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On pi=C4=85tek, 1 lutego 2019 22:36:07 CET Sam Ravnborg wrote:
> Hi Pawe=C5=82
>=20
> Looks good, thanks for addressing all the review feedback.
>=20
> On Fri, Feb 01, 2019 at 06:28:52PM +0100, Pawe=C5=82 Chmiel wrote:
> > This patch adds Samsung S6E63M0 AMOLED LCD panel driver, connected over
> > spi. It's based on already removed, non dt s6e63m0 driver and
> > panel-samsung-ld9040. It can be found for example in some of Samsung
> > Aries based phones.
> >=20
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> If you consider (do not change unless you think it better) the
> following nits than you can add my:
>=20
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>=20
> 	Sam
>=20
> > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kcon=
fig
> > index 3f3537719beb..be05ed5218eb 100644
> > --- a/drivers/gpu/drm/panel/Kconfig
> > +++ b/drivers/gpu/drm/panel/Kconfig
> > @@ -158,6 +158,13 @@ config DRM_PANEL_SAMSUNG_S6E63J0X03
> >  	depends on BACKLIGHT_CLASS_DEVICE
> >  	select VIDEOMODE_HELPERS
> > =20
> > +config DRM_PANEL_SAMSUNG_S6E63M0
> > +	tristate "Samsung S6E63M0 RGB/SPI panel"
> > +	depends on OF
> > +	depends on SPI
> > +	depends on BACKLIGHT_CLASS_DEVICE
> > +	select VIDEOMODE_HELPERS
> With the use of display_mode the above "select VIDEOMODE_HELPERS"
> is likely no longer required. Please check.
Confirmed that it's not needed now.
>=20
> A help text would be nice.
Simple help text added.
>=20
> > +
> >  config DRM_PANEL_SAMSUNG_S6E8AA0
> >  	tristate "Samsung S6E8AA0 DSI video mode panel"
> >  	depends on OF
>=20
>=20
> > +#include <video/of_videomode.h>
> > +#include <video/videomode.h>
> Please check if these two files are required.
Removed.
>=20
> > +struct s6e63m0 {
> > +	struct device *dev;
> > +	struct drm_panel panel;
> > +	struct backlight_device *bl_dev;
> > +
> > +	struct regulator_bulk_data supplies[2];
> > +	struct gpio_desc *reset_gpio;
> > +	struct videomode vm;
> vm is no longer used - delete it.
Removed.
>=20
> > +
> > +	bool prepared;
> > +	bool enabled;
> > +
> > +	/*
> > +	 * This field is tested by functions directly accessing bus before
> > +	 * transfer, transfer is skipped if it is set. In case of transfer
> > +	 * failure or unexpected response the field is set to error value.
> > +	 * Such construct allows to eliminate many checks in higher level
> > +	 * functions.
> > +	 */
> > +	int error;
> > +};
> > +
>=20
> > +static int s6e63m0_get_modes(struct drm_panel *panel)
> > +{
> > +	struct drm_connector *connector =3D panel->connector;
> > +	struct drm_display_mode *mode;
> > +
> > +	mode =3D drm_mode_duplicate(panel->drm, &default_mode);
> > +	if (!mode) {
> > +		DRM_ERROR("failed to add mode %ux%ux@%u\n",
> > +			  default_mode.hdisplay, default_mode.vdisplay,
> > +			  default_mode.vrefresh);
> I recall I have seen a generic way to print the above,
> but I have failed to find it.
> Maybe it is just my memory that fools me.
>=20
> The above is fine.
>=20
> > +
> > +	s6e63m0_backlight_register(ctx);
>=20
> Is it correct that we continue even if we fail to register backlight?
=46ixed, now errors are handled and it's called before adding drm panel,=20
so we won't do this if there will be any error during backlight setup.
>=20
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +
> > +static const struct of_device_id s6e63m0_of_match[] =3D {
> > +	{ .compatible =3D "samsung,s6e63m0" },
> > +	{ }
>=20
> Add /* sentinel */ comment?
Added
>=20
> > +};
>=20
>=20
I'll be sending v3 version with all issues fixed. It would be nice to have =
this tested on Samsung Goni.
Thanks for all comments



