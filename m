Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CE5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7435A206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mdragon-org.20150623.gappssmtp.com header.i=@mdragon-org.20150623.gappssmtp.com header.b="vdF9tqrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7435A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mdragon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439611AbeKWXlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:41:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39613 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436515AbeKWXlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:41:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so11939651wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 04:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mdragon-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2usijYfMfNnNlOQNpekYD4jqWrccJ4HmEaOA/gWGco=;
        b=vdF9tqrzqK9XnQexh/DAPj0LS2JXSshFMqxdK9LG8XFLQD1p+IB70SxuJZ1gzlFQIL
         WKFGu8oqx9xSTudJP9TTeE5OUGJW9qu1YDFZHi9PXP2PzHCThmTEhfPCZ6XVrj5EwykZ
         cMbiiOTrp1ND48SwWS6Z0KyAbDjLuovDo1rqwVGCGssuek6n7Ixa4JjUzy4Ql4m6xRUZ
         Tdahd6+4f+FrEiUwIqVpddm8iBdvpf7+ZWrCZzEzerSr1DtMe/1SlFcKQHymyixIgGpx
         B8uunZT/wWMmILJVmcoHRgXLqgpnuU7RRuxn+7/G8kuADvfMsC9SWv1lzOFoWuM12SMf
         4bPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2usijYfMfNnNlOQNpekYD4jqWrccJ4HmEaOA/gWGco=;
        b=gztoGziczpMT5Yu2vn807EKPhZk40Cz4KJ0PPOYiYWMnifkcUjflxwpJvjdhBYEDh/
         vx5PsNDHo0HVO7vyjAcacNbeYg7WAdRSFWNv+in2sZikuvTmZABk4XiZKGYXa9d8szKg
         E4QPvk6PoZ6X65HXxI7miSV4kzUwn1+vLP99/lT6xEsN9bGKPLHY2hsgEy28uBqqGqNS
         H7PZ8M47PQenOJfp/zdPn0XfxDvycrKm7buK6bKN+RBxOn7NayOGs7Xi09MtyAOSkRIy
         1IaLRx/C58G8Dd9msKNQjets83bRRfvXfOO3kT9daJreJofeBa0Rft1s8rs/3NpB1yPO
         1iXg==
X-Gm-Message-State: AA+aEWbijCWnX3fC8ciZDOgasUwcEm/Uy3TgcQMI1wLUhmvHWi274dso
        gL0zChy75P1BXgJDN5yjBryaMFJM6P5AhpjUldTA/w==
X-Google-Smtp-Source: AJdET5eZyzty699smt4uM2CYPkPDmIPakIuUD1zreJnkI/Wyr2kLcPo5cOwJfToJLIuRUXGMzrZhBDFCPRBq4FhQeik=
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr14285473wmc.106.1542977831316;
 Fri, 23 Nov 2018 04:57:11 -0800 (PST)
MIME-Version: 1.0
References: <1542793169-13008-1-git-send-email-christianshewitt@gmail.com> <2a9d9fa9-c9ba-c624-28da-dd3804faf438@baylibre.com>
In-Reply-To: <2a9d9fa9-c9ba-c624-28da-dd3804faf438@baylibre.com>
From:   Michal Lazo <michal.lazo@mdragon.org>
Date:   Fri, 23 Nov 2018 13:57:00 +0100
Message-ID: <CAFW1BFzC0wzwmjvpSqb90ipY4mzdWPMc3buXjkwvi4X5e8wGJg@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: add support for 1080p25 mode
To:     narmstrong@baylibre.com
Cc:     christianshewitt@gmail.com, airlied@linux.ie, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        carlo@caione.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would suggest same aproach as for
"meson_hdmi_encp_mode_1080p30"
and "meson_hdmi_encp_mode_1080p60"

so duplicate "meson_hdmi_encp_mode_1080p50"
with name "meson_hdmi_encp_mode_1080p25"

now the code looks really like common copy paste problem
Michal Lazo
On Wed, Nov 21, 2018 at 10:47 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 21/11/2018 10:39, Christian Hewitt wrote:
> > This essential mode for PAL users is missing, so add it.
> >
> > Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> > ---
> >  drivers/gpu/drm/meson/meson_venc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> > index acbbad3..ab16046 100644
> > --- a/drivers/gpu/drm/meson/meson_venc.c
> > +++ b/drivers/gpu/drm/meson/meson_venc.c
> > @@ -714,6 +714,7 @@ struct meson_hdmi_venc_vic_mode {
> >       { 5, &meson_hdmi_encp_mode_1080i60 },
> >       { 20, &meson_hdmi_encp_mode_1080i50 },
> >       { 32, &meson_hdmi_encp_mode_1080p24 },
> > +     { 33, &meson_hdmi_encp_mode_1080p50 },
> >       { 34, &meson_hdmi_encp_mode_1080p30 },
> >       { 31, &meson_hdmi_encp_mode_1080p50 },
> >       { 16, &meson_hdmi_encp_mode_1080p60 },
> >
>
> Exact, I forgot this mode...
>
> Thanks for the change !
>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
>
> I'll add :
> Fixes: 335e3713afb87 ("drm/meson: Add support for HDMI venc modes and settings")
> when applying to drm-misc-fixes.
>
> Neil
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic



-- 
Best Regards

Michal Lazo
Senior developer engineer
mdragon.org
Slovakia
