Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F97BC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1832054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J+vDoW8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfARVwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:52:37 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44459 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729677AbfARVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:52:36 -0500
Received: by mail-vs1-f67.google.com with SMTP id u11so9310997vsp.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 13:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0eOPfx1oRo+N7wuBX4DqqAFZ4MGnCdoDeMf1bAjWf7w=;
        b=J+vDoW8TF9asc3EJ8NrMqFopNqf9/IvnisGuqhZwhpUJ1PXyrtqU9k3tgCBDH35fSL
         m9Ez0EZTK29K0qN9TwCyxoC7hVbGwt/CP85S465wMpfn4ACI9xgD/fN7ZsjsVici+qY7
         Wth9In0MfOyMaR+6EVEWzNYT5izovUiMhdUAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0eOPfx1oRo+N7wuBX4DqqAFZ4MGnCdoDeMf1bAjWf7w=;
        b=S3YQMbIGB5wl09xYt19cc9C9FO94I/Rvc2XmfkOHW1JqrVQx+C5C+nAww62IbUQdST
         D16WLV9Rv+Y7am4O8W496IWd4lszsIBx99KatZoiHpBYWmlZdkWTkz/JlTUdLo4w/MGj
         qsc3/Yqz7XDy7KWnAKejrrM6sFscXyrY8k8h6/i+beCPLuvLLUNALv8BHdRKxMgQPxhy
         3anvPDy/LaWKYcxLP7mu/CGgSiBBMIBoCUNAkEFKpNOxVmAtJ+LO1/4FKoVRJMSTcBVA
         5fJ2QsLZVKV5eePCrmTal3TIvAvv20GBjVrRsrCuminryrSaJERWGUV9+yH6heWasHnJ
         6F4g==
X-Gm-Message-State: AJcUukeWdP6bBQrr1/SQmF+FGi0qqeUIubpcIssmfGC6kry6F7sHsOwU
        q3VNoXK4v7L0KcelB0NuCxZBZb81dMk=
X-Google-Smtp-Source: ALg8bN6LJXGBE6oVRfyqZ02y4wXvPS6YTl1cDOmFKwzXgImvsmHiMT7AXXvfSyyZjnSGTnadAej9HA==
X-Received: by 2002:a67:2a83:: with SMTP id q125mr2954927vsq.230.1547848355488;
        Fri, 18 Jan 2019 13:52:35 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id r8sm7519554uan.0.2019.01.18.13.52.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 13:52:34 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id c24so5197686uak.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 13:52:32 -0800 (PST)
X-Received: by 2002:ab0:45d4:: with SMTP id u78mr8051406uau.52.1547848352515;
 Fri, 18 Jan 2019 13:52:32 -0800 (PST)
MIME-Version: 1.0
References: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Jan 2019 13:52:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XBBk31zqgJMqcTeNLoEWxLzow=LxQ=2geJAaf6Cpui_Q@mail.gmail.com>
Message-ID: <CAD=FV=XBBk31zqgJMqcTeNLoEWxLzow=LxQ=2geJAaf6Cpui_Q@mail.gmail.com>
Subject: Re: [PATCH v6] drm/msm/a6xx: Add support for an interconnect path
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 18, 2019 at 12:24 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Try to get the interconnect path for the GPU and vote for the maximum
> bandwidth to support all frequencies. This is needed for performance.
> Later we will want to scale the bandwidth based on the frequency to
> also optimize for power but that will require some device tree
> infrastructure that does not yet exist.
>
> v6: use icc_set_bw() instead of icc_set()
> v5: Remove hardcoded interconnect name and just use the default
> v4: Don't use a port string at all to skip the need for names in the DT
> v3: Use macros and change port string per Georgi Djakov
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/gpu/drm/msm/Kconfig             |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
>  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
>  4 files changed, 33 insertions(+)

Presumably this should go in together with the bindings:

- https://patchwork.kernel.org/patch/10739233/
- https://lkml.kernel.org/r/20181220173026.3857-3-jcrouse@codeaurora.org

...since bindings and code usually go in the same tree together.


As per discussion in v3 AKA v5
<https://patchwork.kernel.org/patch/10739231/>, we're trying to figure
out where to land this.  ;-)

-Doug
