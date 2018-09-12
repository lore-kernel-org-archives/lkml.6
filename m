Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD50C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406F3206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGjBG5vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406F3206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeILQaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:30:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45615 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILQaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:30:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id r4-v6so1328864lff.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 04:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2ia58s1wtxysOfqdF9/Lz9kf3jwpULB1gIbqZcxEgmY=;
        b=DGjBG5vlDBsveDo14kwZCax60mvp/NhKpu3pnhXjPkI6xtNXIW1LdZKv/J8Ur1UbyL
         CNgCHytrJlnuBhcpF+XRSFMevxCcC6dQB3G/MegkSFx4fBmlZw0JsyNAJ+8K0UU28iop
         kACis6OFoun9l7HZW50rAsRnrA0GTLtE67c98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2ia58s1wtxysOfqdF9/Lz9kf3jwpULB1gIbqZcxEgmY=;
        b=AX+TWIBVwZ+g6LZ2VO0c0IVovrfU2iYT7nTUy6s16jDn5oyEKFzvRdqua7sXEZOtBx
         hldqv6Hl65eutfqL2vmweIlJQXe+3Bzzpsu8wM4GJrYihqireOliNID4m9G6oLa19ZD7
         rZbOhk7mDEATFuKrGukMW0r3yj3E4S/t3HQAOvJojxzn4LoYUZYs3tKY9q7LHrYOL23Q
         sjUKlrkXS945CltIWaYJMKuKaQ7THlfzGe+R5QB2h8r9q8HpC89W8nD70mcsA4Fs+s0b
         hQVZUrZ2piE9vv115nB7wTzxkwvE6is78vJ5+I0WwjChpbnHAQHIsis68H78cywpJmBN
         4EEg==
X-Gm-Message-State: APzg51DObyfIw4hxyUTr1S0AsCyu05dynXk5pBmDSz5xKs4Ps/y2kGAs
        ZV8lSdHqVNm39mAuEkKpvbt/PLrd7eqWkQbCbTmHsw==
X-Google-Smtp-Source: ANB0Vda7o2u4wdAIZ5y4NbaDTdAzll+yBVcl/77bciD/4g0piI+LjER7foyhKY7DEV3ajTLoAbnPF6dRnI4ffBuMvbY=
X-Received: by 2002:a19:1dcf:: with SMTP id d198-v6mr1145666lfd.144.1536751575795;
 Wed, 12 Sep 2018 04:26:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:4d08:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 04:25:54
 -0700 (PDT)
In-Reply-To: <20180907114255.7j7r6wzolnz5qkk7@flea>
References: <20180711144403.1022829-1-arnd@arndb.de> <105cb1cf-577a-043a-9b50-248a37090bdd@nvidia.com>
 <CAK8P3a1w0SrxFNRwjt1nWhQPdqgt=bZ8oqGaPE=z9iHp84R5mw@mail.gmail.com> <20180907114255.7j7r6wzolnz5qkk7@flea>
From:   Matt Hart <matthew.hart@linaro.org>
Date:   Wed, 12 Sep 2018 12:25:54 +0100
Message-ID: <CAH+k93F_xJMtXmkKZuZ45AAQgMkgNfSRSM3QyEtATgQSW6Mb9A@mail.gmail.com>
Subject: Re: [PATCH] [v3] drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=m
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 September 2018 at 12:42, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Fri, Sep 07, 2018 at 01:26:30PM +0200, Arnd Bergmann wrote:
>> On Fri, Sep 7, 2018 at 11:41 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>> >
>> >
>> > On 11/07/18 15:43, Arnd Bergmann wrote:
>> > > Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
>> > > a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:
>> > >
>> > > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
>> > > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
>> > >
>> > > This solves the problem by adding a silent symbol for the tcon_top module,
>> > > building it as a separate module in exactly the cases that we need it,
>> > > but in a way that it is reachable by the other modules.
>> > >
>> > > Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
>> > > Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TCON TOP")
>> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > I am seeing the following on today's -next (20180907) as well the last
>> > few -next versions for that matter ...
>> >
>> > ERROR: "sun8i_tcon_top_de_config" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
>> > ERROR: "sun8i_tcon_top_set_hdmi_src" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
>> > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
>> >
>> > Seems like this issue has cropped up again as Arnd's fix is present. I
>> > am seeing this on ARM64 builds.
>>
>> I have not started build testing on linux-next since the merge window, but
>> looking at the changes that got queued up, I find commits cf77d79b4e29
>> ("drm/sun4i: tcon: Add another way for matching mixers with tcon") and
>> 0305189afb32 ("drm/sun4i: tcon: Add support for R40 TCON") that both
>> introduced a reference to the tcon_top file from sun4i_tcon.c.
>>
>> More IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) checks in
>> the caller like I did in my patch would help, or alternatively one could
>> decide to give up and just always include the TCON_TOP.
>
> Sorry for the breakage.
>
> Can you test:
>
> ----8<----
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 4834c90b4912..c78cd35a1294 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -974,7 +974,8 @@ static bool sun4i_tcon_connected_to_tcon_top(struct device_node *node)
>
>         remote = of_graph_get_remote_node(node, 0, -1);
>         if (remote) {
> -               ret = !!of_match_node(sun8i_tcon_top_of_table, remote);
> +               ret = !!(IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
> +                        of_match_node(sun8i_tcon_top_of_table, remote));
>                 of_node_put(remote);
>         }
>
> @@ -1402,13 +1403,20 @@ static int sun8i_r40_tcon_tv_set_mux(struct sun4i_tcon *tcon,
>         if (!pdev)
>                 return -EINVAL;
>
> -       if (encoder->encoder_type == DRM_MODE_ENCODER_TMDS) {
> +       if (IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
> +           encoder->encoder_type == DRM_MODE_ENCODER_TMDS) {
>                 ret = sun8i_tcon_top_set_hdmi_src(&pdev->dev, id);
>                 if (ret)
>                         return ret;
>         }
>
> -       return sun8i_tcon_top_de_config(&pdev->dev, tcon->id, id);
> +       if (IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP)) {
> +               ret = sun8i_tcon_top_de_config(&pdev->dev, tcon->id, id);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
>  }
>
>  static const struct sun4i_tcon_quirks sun4i_a10_quirks = {
> ----8<----

Works for me, and still broken in todays next

>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
