Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E84EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D3820685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mdragon-org.20150623.gappssmtp.com header.i=@mdragon-org.20150623.gappssmtp.com header.b="GItfzOTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D3820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mdragon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504531AbeKXAHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:07:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40134 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394528AbeKXAHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:07:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so11943716wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 05:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mdragon-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8AdCTUXJeqz+3rmXMfSlJMp0BXna5RN40apzl2CMN40=;
        b=GItfzOTuO7WThvYJbvdln6FsLRxv8dMgN1NgNJTg64Jt3XutiWoal2nK0riIewURV6
         8KFmmWWJUvMTCimvLe37PI3Zm1MfGa5hHl/sMwjHHavytv6lWNmUkDc+C7LsKYjNt3B5
         UGuOMYx9Y+NnNhSfyX9n1qJRfHBzc5Pjgx4sHIKk3jfSjibfrxOuNCaSaza6FkEJA1tn
         GYivp76AWYoJMrBKvcDJzwaJ01vV/ecH8FQ4DCEOcDH+tkCfVACNON5JQIsmVHXXd2q8
         IhFdD3+iY6okps4XTysKLq57JLsar4H73JQxtqJmj0yDO9qzfiJFzr+Bsb/sjPXNfr2y
         RH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8AdCTUXJeqz+3rmXMfSlJMp0BXna5RN40apzl2CMN40=;
        b=FB2eY3pibzsQR2wLRGVF0YKdhGoeAckw2AYtoPnSHb+SnNo9zgf/aI0n2MhBgZxGUs
         308+WRpnwNKUP8Bi9vyaqE030K2sqkWSuu9bhLS3PSYxSzvm/M+XLGA9eqLobnQZ7WZV
         IYk2QxGKjydWTuFOJg2QyF9/KGncSWqP9y5SDGfFOnbVy0pK9jkmUw/Oti87yFKWcKsT
         6c5Afv+Ek0YvFc8086ly2ev/XtkYy/FoMA0LGL0t8dxkaIVMhFz73eHwJZuSKUDc2z/X
         JEb0IjctSh2DxA+p1gGjQDoVTRL+vtM6UP3IMvrCTd9g390l7v9llnUKttXQKi8IfZvO
         BdSQ==
X-Gm-Message-State: AA+aEWYQgVeAbIq3qjAX8dpMTWBHi/08V4Bhxm9fuxhmx8Dmx878rfvO
        piZ/IWhgLcqDacOGw7wGC/W40jKevO9bJ8ZL+31lMQ==
X-Google-Smtp-Source: AJdET5dwONU7l7vAvKqkiSJBT2sPi1TaV3BhZ77E+vy9TUVMHgfSR8zRehCTPnMPlRofnMs/E6PxMUMw3MTauFuhGf4=
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr14380305wmc.106.1542979421424;
 Fri, 23 Nov 2018 05:23:41 -0800 (PST)
MIME-Version: 1.0
References: <1542793169-13008-1-git-send-email-christianshewitt@gmail.com>
 <2a9d9fa9-c9ba-c624-28da-dd3804faf438@baylibre.com> <CAFW1BFzC0wzwmjvpSqb90ipY4mzdWPMc3buXjkwvi4X5e8wGJg@mail.gmail.com>
 <ea9d3fd1-068f-7bec-4166-9399d0aea02f@baylibre.com>
In-Reply-To: <ea9d3fd1-068f-7bec-4166-9399d0aea02f@baylibre.com>
From:   Michal Lazo <michal.lazo@mdragon.org>
Date:   Fri, 23 Nov 2018 14:23:30 +0100
Message-ID: <CAFW1BFwocpL3brp8h66gaAiMgcCvsr1t=tU2+oNVFNOG4DMYPQ@mail.gmail.com>
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

I checked 1080p30/1080p60 and values are same
I didn't check others
so clean duplicates
or make duplicates :)


On Fri, Nov 23, 2018 at 2:15 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Michal,
>
> On 23/11/2018 13:57, Michal Lazo wrote:
> > I would suggest same aproach as for
> > "meson_hdmi_encp_mode_1080p30"
> > and "meson_hdmi_encp_mode_1080p60"
> >
> > so duplicate "meson_hdmi_encp_mode_1080p50"
> > with name "meson_hdmi_encp_mode_1080p25"
>
> The configs are litterally the same for 1080p25 and 1080p60 unlike 1080p30/1080p60,
> so I don't see the point about duplicating a same table for the sake of naming.
>
> We will the exact same thing to support the 2160p50/2160p60 modes by reusing the
> same config are 2160p25/2160p50, and I don't see the point of duplication the
> tables here aswell.
>
> Neil
>
> >
> > now the code looks really like common copy paste problem
> > Michal Lazo
> > On Wed, Nov 21, 2018 at 10:47 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> On 21/11/2018 10:39, Christian Hewitt wrote:
> >>> This essential mode for PAL users is missing, so add it.
> >>>
> >>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> >>> ---
> >>>  drivers/gpu/drm/meson/meson_venc.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> >>> index acbbad3..ab16046 100644
> >>> --- a/drivers/gpu/drm/meson/meson_venc.c
> >>> +++ b/drivers/gpu/drm/meson/meson_venc.c
> >>> @@ -714,6 +714,7 @@ struct meson_hdmi_venc_vic_mode {
> >>>       { 5, &meson_hdmi_encp_mode_1080i60 },
> >>>       { 20, &meson_hdmi_encp_mode_1080i50 },
> >>>       { 32, &meson_hdmi_encp_mode_1080p24 },
> >>> +     { 33, &meson_hdmi_encp_mode_1080p50 },
> >>>       { 34, &meson_hdmi_encp_mode_1080p30 },
> >>>       { 31, &meson_hdmi_encp_mode_1080p50 },
> >>>       { 16, &meson_hdmi_encp_mode_1080p60 },
> >>>
> >>
> >> Exact, I forgot this mode...
> >>
> >> Thanks for the change !
> >>
> >> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> >>
> >> I'll add :
> >> Fixes: 335e3713afb87 ("drm/meson: Add support for HDMI venc modes and settings")
> >> when applying to drm-misc-fixes.
> >>
> >> Neil
> >>
> >> _______________________________________________
> >> linux-amlogic mailing list
> >> linux-amlogic@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> >
> >
> >
>


-- 
Best Regards

Michal Lazo
Senior developer engineer
mdragon.org
Slovakia
