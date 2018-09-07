Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1D9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DCB2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jFSR5NYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DCB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeIGWFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:05:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37086 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIGWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:05:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id v9-v6so12894188ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HoVU8pSwA1yNCBp+qfG/yzs73dsXV+Qkm7cKeM653ao=;
        b=jFSR5NYsf7V85JSI4hm9xPMqQTA5GkbfYDlHPRJSHR1YKAD3PweOSaBbEeMGhqU5iR
         TFeTSXYCKMmo8p22unrpuVRvn9Nm4XYJB7tS6agrfHX99iAyWdS1BEP/eTB5dXF1YW2w
         Fb9IwWzniJ8mO177voCKlsDQIMx0F35XgDFek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HoVU8pSwA1yNCBp+qfG/yzs73dsXV+Qkm7cKeM653ao=;
        b=e0dbBXLGtspa90tB0Jey+Hky3MhyE0ji45iL4y2vKwkDrPbmt8oUdys4+HLru5KPvc
         q8ismmcjPMwZrYfWHhtJzbzhv3o+iHyyQ5+x4H5wbwQKetUGcxIaz/etTobyPT3TZ/Xu
         hF354VMR9MMlw/nS/Cdvap3ja5D2fNIhXLBKN6xpTp02RRRSBr9zh4PokLHP6eyz0y8z
         SG3NWhqIAUXRExqc/Axf/E38tOrCDqbo46oswhEreW5vxcNuc09hwHMkuEWIweF3cYBt
         FY8q3MQVG+wcfWNzUQO17Y8axdQfAP4Zi0UzxQJZKNK9/2g6rEtCUf4VR9QOX0jAkUR+
         1V2w==
X-Gm-Message-State: APzg51AkbkqsHfzHL0drNqTxn+IYnfNbSuitVUfLnG+srgCjZDh9ZiCa
        D/vdT/tawB+5hGm1ZGoHKBMtyk4c+oRZXsshKDMiCG+Bhg4=
X-Google-Smtp-Source: ANB0Vda7vmT/WDrMnfUwxawLw1Q//1jreRTsI0bHJAqMi7TuUmlX+RlmDpP7NGqZkz7vIfd3XoMkNhPzUgekspblifk=
X-Received: by 2002:a2e:92c4:: with SMTP id k4-v6mr5793835ljh.18.1536340985307;
 Fri, 07 Sep 2018 10:23:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a20c:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 10:23:04 -0700 (PDT)
In-Reply-To: <105cb1cf-577a-043a-9b50-248a37090bdd@nvidia.com>
References: <20180711144403.1022829-1-arnd@arndb.de> <105cb1cf-577a-043a-9b50-248a37090bdd@nvidia.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 7 Sep 2018 22:53:04 +0530
Message-ID: <CA+G9fYuw66eL+d7pxhSbH3J-D4wdOU7BEPL3rCWu-ntfB4OWog@mail.gmail.com>
Subject: Re: [PATCH] [v3] drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=m
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 September 2018 at 15:11, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> On 11/07/18 15:43, Arnd Bergmann wrote:
>> Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
>> a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:
>>
>> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
>> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
>>
>> This solves the problem by adding a silent symbol for the tcon_top module,
>> building it as a separate module in exactly the cases that we need it,
>> but in a way that it is reachable by the other modules.
>>
>> Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
>> Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TCON TOP")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> I am seeing the following on today's -next (20180907) as well the last
> few -next versions for that matter ...
>
> ERROR: "sun8i_tcon_top_de_config" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
> ERROR: "sun8i_tcon_top_set_hdmi_src" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
>
> Seems like this issue has cropped up again as Arnd's fix is present. I
> am seeing this on ARM64 builds.

I do notice these failures on ARM64 builds on linux next 20180906 and 20180907.

11:40:55 | ERROR: "sun8i_tcon_top_de_config"
[drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
11:40:55 | ERROR: "sun8i_tcon_top_set_hdmi_src"
[drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
11:40:55 | ERROR: "sun8i_tcon_top_of_table"
[drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!

Build full log can be found on this link.
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=rpb,MACHINE=dragonboard-410c,label=docker-stretch-amd64/346/console

- Naresh

>
> Cheers
> Jon
>
> --
> nvpublic
