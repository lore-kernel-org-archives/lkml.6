Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCB3C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D4520850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gPuWsQiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfARRwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:52:31 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42492 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfARRw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:52:29 -0500
Received: by mail-ua1-f65.google.com with SMTP id d21so4950058uap.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 09:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNip1d+gmnaVYee8c7IXM+XRAYIVovWHTmdMWrDOKy4=;
        b=gPuWsQiRqzq9GH8wmLfvfPzJIufKcKWjUFDFJiFjvfNR5i1VT85Yya7d6T6MKY6iLj
         2wlXA60h6UgzOzDVPba5T0ZH+T7XHTo6qkwBiR3u/FAE35e6GfeaiIc/JMDgwpxUArKl
         DaNFPbi9fEYEVWz/gwMAYIlXs0tkOv45/muRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNip1d+gmnaVYee8c7IXM+XRAYIVovWHTmdMWrDOKy4=;
        b=jXYwbgGfVq41kohmttByCwiuclQ7lEPo5Wi69O8Hv2GSHPgGQY6NwUWKV8DMoiQY0R
         fviKwHdwTKnTZ0j/0uWccZ0HQKyhM/zehBsUXZJXYq+wI/RuFX8S/efastDCzw/E68p5
         2x+NXJ43eTy0wWjxzb6NovR4FWG+2TIEqmjLX/U1G0OHsX8oFMqBshOf+ESkCsTDxSlk
         iSRLZyjIv2QBfKji/9+V1fkq8RrL45dW2l/wjeuJeq0zvMdUgnsxQ7SukpQhoVXw/bhw
         zE10jtn65gyrhm/Bth4NThLkyfnWqwn1jZsOTM2i04cu0CD0DlQF502YEcRLpJWGf+ru
         7Nkw==
X-Gm-Message-State: AJcUukcq9bVB6VEefYNMJ+RUB6YqvfNEqPI3NqQ5IAYrLEZYF54E6497
        Pg/aYfhKWnfXyvKMB/mMOiQxtPaokZk=
X-Google-Smtp-Source: ALg8bN4MCgH01WFkckYz2a6/QVFZvcfDuCnAoJXOeZlz39knUhkx3rs6H0WpBCN20PQXnKOAWRwl4A==
X-Received: by 2002:ab0:740a:: with SMTP id r10mr5676829uap.14.1547833948328;
        Fri, 18 Jan 2019 09:52:28 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id r130sm52831768vka.55.2019.01.18.09.52.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:52:26 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id b74so8898470vsd.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 09:52:25 -0800 (PST)
X-Received: by 2002:a67:dd94:: with SMTP id i20mr8631042vsk.111.1547833945530;
 Fri, 18 Jan 2019 09:52:25 -0800 (PST)
MIME-Version: 1.0
References: <1547056325-1919-1-git-send-email-jshekhar@codeaurora.org> <1547056325-1919-3-git-send-email-jshekhar@codeaurora.org>
In-Reply-To: <1547056325-1919-3-git-send-email-jshekhar@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Jan 2019 09:52:12 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XUeMTGH+CDwGs3PfK4igdQrCbwucw7_2ViBc4i7grvxg@mail.gmail.com>
Message-ID: <CAD=FV=XUeMTGH+CDwGs3PfK4igdQrCbwucw7_2ViBc4i7grvxg@mail.gmail.com>
Subject: Re: [v5 2/3] drm/msm/dpu: Integrate interconnect API in MDSS
To:     Jayant Shekhar <jshekhar@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        nganji@codeaurora.org, Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 9, 2019 at 9:52 AM Jayant Shekhar <jshekhar@codeaurora.org> wrote:
> @@ -127,7 +153,11 @@ static int dpu_mdss_enable(struct msm_mdss *mdss)
>  {
>         struct dpu_mdss *dpu_mdss = to_dpu_mdss(mdss);
>         struct dss_module_power *mp = &dpu_mdss->mp;
> -       int ret;
> +       int ret, i;
> +       u64 avg_bw = dpu_mdss->num_paths ? MAX_BW / dpu_mdss->num_paths : 0;
> +
> +       for (i = 0; i < dpu_mdss->num_paths; i++)
> +               icc_set(dpu_mdss->path[i], avg_bw, kBps_to_icc(MAX_BW));

You'll need to change icc_set() here to icc_set_bw() to match v13, AKA:

- https://patchwork.kernel.org/patch/10766335/
- https://lkml.kernel.org/r/20190116161103.6937-2-georgi.djakov@linaro.org


>         ret = msm_dss_enable_clk(mp->clk_config, mp->num_clk, true);
>         if (ret)
> @@ -140,12 +170,15 @@ static int dpu_mdss_disable(struct msm_mdss *mdss)
>  {
>         struct dpu_mdss *dpu_mdss = to_dpu_mdss(mdss);
>         struct dss_module_power *mp = &dpu_mdss->mp;
> -       int ret;
> +       int ret, i;
>
>         ret = msm_dss_enable_clk(mp->clk_config, mp->num_clk, false);
>         if (ret)
>                 DPU_ERROR("clock disable failed, ret:%d\n", ret);
>
> +       for (i = 0; i < dpu_mdss->num_paths; i++)
> +               icc_set(dpu_mdss->path[i], 0, 0);

This will also need to change to icc_set_bw()


I'm curious what the plan is for landing this series.  Sean / Rob /
Gerogi: do you have any preference?  Options I'd imagine:

A) Wait until interconnect lands (in 5.1?) and land this through
drm-misc / msm-next in the version after (5.2?)

B) Georgi provides an immutable branch for interconnect when his lands
(assuming he's sending his stuff upstream via pull request) and that
immutable branch gets merged into the the relevant drm tree.

C) Sean and/or Rob Acks this series and indicates that it should go in
through Gerogi's tree (probably only works if Georgi plans to send a
pull request).  If we're going this route then (IIUC) we'd want to
land this in Gerogi's tree sooner rather than later so it can get some
bake time in linux-next (we've been baking it in Chrome OS for a
while, but nice to see it in linux-next too).


Does anyone have a preference?  It's be nice if whoever is planning to
land this could indicate whether they'd prefer Jayant send a new
version to handle the API change or if the relevant maintainer can
just do the fixup when the patch lands.


Thanks!

-Doug
