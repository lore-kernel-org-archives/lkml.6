Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AD9C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9F82082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Mfk0dZEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9F82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeLJQMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:12:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:47026 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbeLJQMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:12:51 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so10859480otm.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuoUbHVId+o3TXIuU0XZsMaDLUZPwXd+63MtyP5nl+c=;
        b=Mfk0dZEkqx3BMVqMjDgaWD7shFMbfopUvDhD1kZp4BGlJ4oblqaAxSGP2BIHOwctVW
         OP2Rx92mSuBpsjhLXJtg94+VEdoUPhotj09fFFJ0w3LP0EAr2W+XeW3jv3qRGxEyZ8r8
         VPLJ3Xvaknf6JuupWU5hJV3q00NsV1k9IuWG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuoUbHVId+o3TXIuU0XZsMaDLUZPwXd+63MtyP5nl+c=;
        b=Wyd4za3LpoW+ChNJ+I+DoGv1tYlfVAR91gobJPSJnPRIyMTUUMLcDJ/3VFGjvbs5Z/
         rVTlU0hv/2pRg9PO7hBIu7Uzc7h4Fci5D+YDIRA+uz5+v1MFGV9LSszQvJPc4GNMjWHE
         ijjIUBOvfX9vPffkyGBQAG8xvEoumwZOOrz+Lv4YDY4bS0ubOXNgHKTJfvGEx+G2aTtH
         3MGPRbRC4A5ZZ+k3LydGTLvYL84RJ7o1IU8tfq5aK4WKfDjWAu5CjSZafHcpGTn9+OYw
         T1tcXoujCh82SVCN55l7DsHcH3hdWHAbIwxNhyvPaeJELisF2mM8N+jeJKTGfEp6rPAQ
         Dsrw==
X-Gm-Message-State: AA+aEWbM9Vz3yRpn9sST2IrvnHYrucZRhVTqVq7PaIIE0rO/mD0Q6LyD
        iTWgEx3i8xsGNeF1XHlig/AQcLTtAoy3Qba0cUELqwQvEFmWYw==
X-Google-Smtp-Source: AFSGD/WwkmxlWvJIbhB1K/JynkQfAnLv8L2s6VUMTxMFufto5o1G9mDH6V5HyVx2NuR3Tw17uI5zXCSAqDS7OLKzlB0=
X-Received: by 2002:a9d:4b17:: with SMTP id q23mr9192259otf.121.1544458370931;
 Mon, 10 Dec 2018 08:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20181116163916.29621-1-jagan@amarulasolutions.com> <20181116163916.29621-12-jagan@amarulasolutions.com>
In-Reply-To: <20181116163916.29621-12-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 10 Dec 2018 21:42:38 +0530
Message-ID: <CAMty3ZBNJ07v7jWq9s8KyvitGaJ5e_igPoP=9X9wN=PAyfOU0A@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry and David,

On Fri, Nov 16, 2018 at 10:10 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
>
> Add panel driver for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  MAINTAINERS                                   |   6 +
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../drm/panel/panel-feiyang-fy07024di26a30d.c | 286 ++++++++++++++++++
>  4 files changed, 302 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3dac08d0b3cb..40c8bfc974f4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4620,6 +4620,12 @@ T:       git git://anongit.freedesktop.org/drm/drm-misc
>  S:     Maintained
>  F:     drivers/gpu/drm/tve200/
>
> +DRM DRIVER FOR FEIYANG FY07024DI26A30-D MIPI-DSI LCD PANELS
> +M:     Jagan Teki <jagan@amarulasolutions.com>
> +S:     Maintained
> +F:     drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> +F:     Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
> +
>  DRM DRIVER FOR ILITEK ILI9225 PANELS
>  M:     David Lechner <david@lechnology.com>
>  S:     Maintained
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index d0d4e60f5153..bc70896fe43c 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -47,6 +47,15 @@ config DRM_PANEL_SIMPLE
>           that it can be automatically turned off when the panel goes into a
>           low power state.
>
> +config DRM_PANEL_FEIYANG_FY07024DI26A30D
> +       tristate "Feiyang FY07024DI26A30-D MIPI-DSI LCD panel"
> +       depends on OF
> +       depends on DRM_MIPI_DSI
> +       depends on BACKLIGHT_CLASS_DEVICE
> +       help
> +         Say Y if you want to enable support for panels based on the
> +         Feiyang FY07024DI26A30-D MIPI-DSI interface.
> +

Any comments on this?
