Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24786C7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4A420671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5xZ38BL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4A420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeJXBei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:34:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41874 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbeJXBei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:34:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id c32so2143374otb.8;
        Tue, 23 Oct 2018 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncWcM9DGWaPmyt0qeW1DV8mg6dg8K6TB59ZY+H1rCrY=;
        b=X5xZ38BLEMFudfE1xUWLivqQLOQzefdjZogjHCsTn6tvDTaosdqHMBwlUJFO1jyWgI
         a1aZrfYIzWJ1cSEy6xN16ug1kq3DsHXnbgZu0VI3zJVDoEs8fMy5W1GJJlig9R8l99Hb
         WAoahhqvqPTAFgd0zagmPSEP+qx5WVEFkonwvmpvfLTtwevIoiA4kaM6Mqxxsed6G2tK
         K+c5YmKsSVfitKQc25d/nhEskKqzDyru1bdYg6gjmxqvqEQcoOYAmBcjaEI3GMlzcsSU
         +QoUMvwDM+8E0KT2GoFGLRzzbafVBRK0/fe4iYVdQktEqgen9SvRJgHNrI/1QoFjTKZ1
         sS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncWcM9DGWaPmyt0qeW1DV8mg6dg8K6TB59ZY+H1rCrY=;
        b=cf6f25fhOe4dSeA/emFVuiU4VLebEduAvCGbfRIhMQnrXCQWjaGEZtMJ8DfQKVirZ3
         Q3AEKxjBCNeTX8bGBlMspbMzDEzy6CZ5zJ8WY3WdaCO9luxgXvLqCCRvuoPhDjbBVhki
         +3+asDS6llZs4y7mgnzOY3PZnMpRt8vSSIpTixnNxfssIts0yt/AwJAYu0UHHiO2ncwf
         szkYPuHWfTQLzqZXW47iNudDNfRJb1JEcsoS0RNSN2TCh+nz0CDBom9c50YKxcccth1Q
         zDptHhKj61Qvtfp+uMikp1rpkam7aue4S56y8rfhfTKfghobCZwjfcGajjnaRMw+QEXJ
         rA6g==
X-Gm-Message-State: AGRZ1gIm/SjrgVk+f4exUm69fXbygnjFzYiB8Vw04H5J4dylLDVYiQkt
        EU2OML/XPnYwtzmaF8NARFyPPRyFLJc1IBgHnVc=
X-Google-Smtp-Source: AJdET5c1D5ID4dhTVzhcRrw1JL2swMfwJbyCRR5rgBcT4VXC+WN3pjN9LXPnlSKRDU/2jadIykTybcT0Kcy+cWz9BAM=
X-Received: by 2002:a9d:5910:: with SMTP id t16mr3814014oth.99.1540314622397;
 Tue, 23 Oct 2018 10:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181023155035.9101-1-jagan@amarulasolutions.com> <20181023155035.9101-4-jagan@amarulasolutions.com>
In-Reply-To: <20181023155035.9101-4-jagan@amarulasolutions.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Tue, 23 Oct 2018 10:10:22 -0700
Message-ID: <CA+E=qVcs0xT2Vqksjs4tz5eBtp_RZ_dqX0AEPfjSaJqA5YBt-g@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] clk: sunxi-ng: Add check for maximum rate to NKM PLLs
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        michael@amarulasolutions.com,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 8:51 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Some NKM PLLs, frequency can be set above PLL working range.
>
> Add a constraint for maximum supported rate. This way, drivers can
> specify which is maximum allowed rate for PLL.

I'd squash patches 2 and 3 into a single patch.

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - new patch
>
>  drivers/clk/sunxi-ng/ccu_nkm.c | 7 +++++++
>  drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index d17539dc88dd..574fd2cd2a79 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -132,6 +132,13 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
>                 return rate;
>         }
>
> +       if (nkm->max_rate && rate > nkm->max_rate) {
> +               rate = nkm->max_rate;
> +               if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +                       rate /= nkm->fixed_post_div;
> +               return rate;
> +       }
> +
>         ccu_nkm_find_best(*parent_rate, rate, &_nkm);
>
>         rate = *parent_rate * _nkm.n * _nkm.k / _nkm.m;
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
> index ff5bd00f429f..c82590481188 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.h
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.h
> @@ -36,6 +36,7 @@ struct ccu_nkm {
>
>         unsigned int            fixed_post_div;
>         unsigned int            min_rate;
> +       unsigned int            max_rate;
>
>         struct ccu_common       common;
>  };
> --
> 2.18.0.321.gffc6fa0e3
>
