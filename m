Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B184C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D443921908
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KHZy10Zs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732882AbeLTTaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:30:39 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33985 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731025AbeLTTaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:30:39 -0500
Received: by mail-ua1-f66.google.com with SMTP id c24so942655uak.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 11:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/blw1YdLnqvQq2TIiLZ1He/GkpVkv1gGkeGqrxzVK/A=;
        b=KHZy10ZsjH49p3LVRxRqCADW+ak7KPlCGwinUoZ5G/+OFN4Jx4j6eNK9lVU6Jba7nM
         dDY5RUhncoPUMjLYN1k0GPtXp5B/pagPYQkF8yxDUuW3+T1msdmInADQK1zCZ1cQcwmT
         DsfsgwvZOZS9p5ofwf6KT1zhrn//OTAn6xrLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/blw1YdLnqvQq2TIiLZ1He/GkpVkv1gGkeGqrxzVK/A=;
        b=PqHtsxuDBl+UBgPXXovCsN5X+q0sLcbLLCbc9YaLH5aRl8DAA1/EVa0OfODV11s2qL
         WdKTqYDD+DCJgpZ581+z2F3SHCt13GSuoFzPriPUdPtJcf67i7TA4lHOiXJ0ZBaM3x0u
         Xj9yeCgg2cmdwjS6nCUq5sSgzwcFnEMDOsO3rSF5X+a3YujYqTofZFxuLrULvr9kBd2p
         ft/2l471XKrIRtjAU5n4CGLwfbvZhI7476DJcUy0crGBS/20YHX1YbrA0+Iz15zUVZre
         LlvjyNyG89pZ/gEAccGU2ZAi1EqxSoaMuh+3ImQg2buiydj6FfgfSv7/ZCc0HstnfuWD
         +0rQ==
X-Gm-Message-State: AA+aEWaUQihHsSydVdJOxBI7UAw4OrY1YinYYEj+i6dxoCVz9xur0bOg
        34BRFO6DBFDExZF+c29d8Uz++lLzs4A=
X-Google-Smtp-Source: AFSGD/Voqa+rAkyt4Mf7O4xlVUrk10rPrYMFrK8CkEsekrMKIzcnjl+hVaFFLQ+Ylt3iRtiUha2Jvg==
X-Received: by 2002:ab0:2bc9:: with SMTP id s9mr11820797uar.91.1545334237821;
        Thu, 20 Dec 2018 11:30:37 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id t10sm6491256ual.13.2018.12.20.11.30.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:30:36 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id z11so940976uaa.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 11:30:36 -0800 (PST)
X-Received: by 2002:ab0:45d4:: with SMTP id u78mr5870631uau.52.1545334236310;
 Thu, 20 Dec 2018 11:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20181220173026.3857-1-jcrouse@codeaurora.org> <20181220173026.3857-3-jcrouse@codeaurora.org>
In-Reply-To: <20181220173026.3857-3-jcrouse@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Dec 2018 11:30:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X4ZxZJt1+RbP1v_XXcVx3xNux1+K7MUWWwtc_TwuX0RQ@mail.gmail.com>
Message-ID: <CAD=FV=X4ZxZJt1+RbP1v_XXcVx3xNux1+K7MUWWwtc_TwuX0RQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: drm/msm/a6xx: Document interconnect
 properties for GPU
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 20, 2018 at 9:30 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Add documentation for the interconnect and interconnect-names bindings
> for the GPU node as detailed by bindings/interconnect/interconnect.txt.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  Documentation/devicetree/bindings/display/msm/gpu.txt | 4 ++++
>  1 file changed, 4 insertions(+)

I would have been fine if you had kept my tag (even though 50% of the
patch changed!).  ...but here it is again:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I assume this will be going through Georgi's tree w/ the previous patch.

-Doug
