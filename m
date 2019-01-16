Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F360C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B705206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCtWDnHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfAPXct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:32:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52749 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfAPXct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:32:49 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so5991722itg.2;
        Wed, 16 Jan 2019 15:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nbc9G4EJdGPbNbf4uT1rUziUDfYyCd+r/f8x26MgC3Y=;
        b=jCtWDnHes6qR3IRtZsFqclH449lJ/ByOaskonN4LfT0GQIuNxCtx0UdS/1L8+ZaHOb
         M7grOqwxozqsg2jBCLhLTtHv0Ho7GgXhmW14MgxVW9/VCTKMk8UYxHxI+vPJUTZWGo0k
         jyZGCyEw5JwrsoGYYuQ+xYmbypJmqxvddXqP/4raKkLjoGDvbfGkNmVutiMgbzBBf0nB
         rrB8uMcDuOcNZUua7DR4I0136PLAinvUM3uIVwXlU9oPsgtQ7AV4PfGjgENq5rjsxJwP
         J7QjH5hJ2Nt9qE+aQ3+d7zcm9553iYbT31fWJuhB2Uqi2gJur1sHAlUmBSxhFvjzp0Kk
         PMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nbc9G4EJdGPbNbf4uT1rUziUDfYyCd+r/f8x26MgC3Y=;
        b=c/4NKhCkRFoV0UQSbiwiCkSav+vKsuEwSMXIqw80ea2lLZUlcc4Zg6DYDbfIxLlzW1
         G+yvbjdOVVOI68NUGxWEhiKS5TRCBWSB/Fb5S1e2DtjWiRuaqtagJz/ILkOIKXNAnM0q
         v5mrD+kQT1E68DybOyM9yuUxIO5vMpOWIFHJFD0wm19T4gwC4pIa5zUe7CFzGk3pDB6o
         TmNRfoewYupTwsDSspvIADnQz8ym2espa/TYXKo9R/60V8iVR7QL066KKvY6iFMSosr8
         iHhyXHylra6Re2xMK4ghN5PyBIXZw4FlA/X7EQBfFxIOl+CnqfoG4ligEHyMdswCZUHU
         t9pw==
X-Gm-Message-State: AJcUukeaxmXKqImqwr3MTUq25CgdaTU2E0W+4PlgsyCapbicgA+l/Txz
        jY+rusdeqRXP6NGENPuie3UM3WZrKwW13eTW/3c=
X-Google-Smtp-Source: ALg8bN5jW+0YzHxyfMFA99L/MM1fcoHFY3lWvYBvTJLmCh+JaCHEeFa2usJX1v/cehS+P2njj2uIQgWM22gXoFySeVQ=
X-Received: by 2002:a24:5314:: with SMTP id n20mr6669644itb.132.1547681567799;
 Wed, 16 Jan 2019 15:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20190116184623.77136-1-dianders@chromium.org>
In-Reply-To: <20190116184623.77136-1-dianders@chromium.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 16 Jan 2019 18:32:34 -0500
Message-ID: <CAF6AEGsQkKbWRTfT5uJvng7UQmq1rdL8SZrY5Fk205eNujWMCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/msm: Fix A6XX support for opp-level
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        freedreno <freedreno@lists.freedesktop.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s

On Wed, Jan 16, 2019 at 1:46 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> The bindings for Qualcomm opp levels changed after being Acked but
> before landing.  Thus the code in the GPU driver that was relying on
> the old bindings is now broken.
>
> Let's change the code to match the new bindings by adjusting the old
> string 'qcom,level' to the new string 'opp-level'.  See the patch
> ("dt-bindings: opp: Introduce opp-level bindings").
>
> NOTE: we will do additional cleanup to totally remove the string from
> the code and use the new dev_pm_opp_get_level() but we'll do it in a
> future patch.  This will facilitate getting the important code fix in
> sooner without having to deal with cross-maintainer dependencies.
>
> This patch needs to land before the patch ("arm64: dts: sdm845: Add
> gpu and gmu device nodes") since if a tree contains the device tree
> patch but not this one you'll get a crash at bootup.
>
> Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

thanks, I've pulled the first into msm-next and I'll grab the 2nd once
dev_pm_opp_get_level() lands

BR,
-R

> ---
>
> Changes in v2:
> - Split into two patches to facilitate landing.
>
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 5beb83d1cf87..ce1b3cc4bf6d 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -944,7 +944,7 @@ static u32 a6xx_gmu_get_arc_level(struct device *dev, unsigned long freq)
>         np = dev_pm_opp_get_of_node(opp);
>
>         if (np) {
> -               of_property_read_u32(np, "qcom,level", &val);
> +               of_property_read_u32(np, "opp-level", &val);
>                 of_node_put(np);
>         }
>
> --
> 2.20.1.97.g81188d93c3-goog
>
