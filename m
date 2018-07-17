Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99858ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E294204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CInMWVXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E294204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbeGQNOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:14:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39731 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731213AbeGQNOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:14:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so1116042wre.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzdrUWz9VjdE4NgXCJFxMRCriZeOEmexdblLyrGAMDM=;
        b=CInMWVXn0SmWu0OodOH/CeFkkr634uADEajoacxQyf2KPOjmPNYlhv1vNrtGs+j/Zg
         ivaZyysd/JOF2Dcp7W51sF7B9VKj/FQR9nHUHikbi5t8L0pzWt3fsYRaZw43z9VJdTnv
         mr72sZhf38/SGvlnielUthspcHPYL0O6Zej/Z5bD32Conaaga8sx/4o000PUSOsst/zy
         p2AcmHonTYdhfrw8Kq8LpTw4InNn5aI0Ctmhxqwvk4oTWPaWHktqC3iYYMTTOXVZ476D
         GRM+zPHkZPI79NGPfPoGYuV/DfHVlOHPDw7H82WO3NJs4FDuFikdr4l30ROfjoPhiQ7i
         kRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzdrUWz9VjdE4NgXCJFxMRCriZeOEmexdblLyrGAMDM=;
        b=LYpXXHlcts0BhYVlLbN0y9LkeTaDzt3moPHniQFYAWvpF3OQfgVOfssVHT8O991CwS
         fjCghUIkeWEYmBL8+9MGfT2vNWgDOSw9LkE54OgBuFsQmrYkEZ6FsZllcA1eTaTihQ6N
         u8+siFAtz/mMw9jmnF5x8ctYVP6qRugMewVEITaVR2U91hsPk6ofRLIIc8LPaB4Ojsg3
         GZSDIdUck2Z0sgf7avqO2jkEdHjABFpK7IIFTNUxYWnBjHO1d36Kn2PKdR9f/g2I21HQ
         tZNrHzOVmbJND60UKpp1kEu4/J1TalL7swcIpbLf9ZPdubBtateNVfVRVArX3GLUsOrl
         JKJQ==
X-Gm-Message-State: AOUpUlEGmxZ7Z7F6gj3oYvLak8vJSEApt6lEx7mH08sBTRN2HsNNUCfH
        YdrJdp29GYvU0ihy/v6Y949Bq/elukgLyg0LgVQ=
X-Google-Smtp-Source: AAOMgpfntRnHwuMOUZfKuyZBb2u9HJfyUd7PtSG4dI8wda0bSkkaGPTY5+1ADhpduVW3O/LAPng/yZSmWkmh/7V4KnI=
X-Received: by 2002:adf:c891:: with SMTP id k17-v6mr1374124wrh.6.1531831295502;
 Tue, 17 Jul 2018 05:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180717085230.17472-1-paul.kocialkowski@bootlin.com> <20180717085230.17472-2-paul.kocialkowski@bootlin.com>
In-Reply-To: <20180717085230.17472-2-paul.kocialkowski@bootlin.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Tue, 17 Jul 2018 22:41:20 +1000
Message-ID: <CAGRGNgX27bbJz2qe3FOb4eP5WKgDYFUNxoz7SkUbN_QDF25pAg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/2] drm/sun4i: sun4i: Introduce a quirk for
 lowest plane alpha support
To:     paul.kocialkowski@bootlin.com
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        thomas.petazzoni@bootlin.com,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Jul 17, 2018 at 6:53 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Not all sunxi platforms with the first version of the Display Engine
> support an alpha component on the plane with the lowest z position
> (as in: lowest z-pos), that gets blended with the background color.
>
> In particular, the A13 is known to have this limitation. However, it was
> recently discovered that the A20 and A33 are capable of having alpha on
> their lowest plane.
>
> Thus, this introduces a specific quirk to indicate such support,
> per-platform. Since this was not tested on sun4i and sun6i platforms, a
> conservative approach is kept and this feature is not supported.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index a3cc398d4d80..cdc4a8a91ea2 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -584,8 +587,9 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
>         }
>
>         /* We can't have an alpha plane at the lowest position */
> -       if (plane_states[0]->fb->format->has_alpha ||
> -           (plane_states[0]->alpha != DRM_BLEND_ALPHA_OPAQUE))
> +       if ((plane_states[0]->fb->format->has_alpha ||
> +           (plane_states[0]->alpha != DRM_BLEND_ALPHA_OPAQUE)) &&
> +           !backend->quirks->supports_lowest_plane_alpha)

From a readability perspective, it'd be fractionally nicer if the
quirk check was before the alpha checks.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
