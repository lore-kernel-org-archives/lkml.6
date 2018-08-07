Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4A3C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD98521770
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FV/8cuLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD98521770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389229AbeHGPvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:51:43 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45717 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388581AbeHGPvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:51:43 -0400
Received: by mail-oi0-f66.google.com with SMTP id q11-v6so28385774oic.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JWIeNwjbQUu/EisriLOTgFF+kJrKHL+JPXQe34sbIso=;
        b=FV/8cuLXtIhdGnX9ldeOS7gLnabBPaFBIINZLADHUnMqOHDA1zqZfC4GH+Q0Zef+td
         kUAYGE4bWOaaJ+6E6H1LbEJIuRrsdBk8TMOyDNpxM7CBS/4132MWaUrS/VPr7JP3ZxPN
         Z5rT+OBjfUPIV5iSslc85skSkQvB71REMhCYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JWIeNwjbQUu/EisriLOTgFF+kJrKHL+JPXQe34sbIso=;
        b=gv4kHPt9KRD7KdAaMR6UpqXZbUytjSTrmpMfPYDDZFfp1mfyeALDuWkrWRcJnJF51l
         TVvPRwdxC2Pn6HgJ1+UwNhOjhjVlxzsgiGfrsjz4vIDAg3uhK7rS8RHc9VIwfpfT8E+T
         kGpDXk5wVZMiekLm+6flSdwlJa/6qziKPImS00NUs/Zye7+rX2vlrW52mH2jk0EVpEzc
         tuEdccTPQlhiOELYruru0t4z2s66gKbg07xZabr/VA9U2PN60NY83r2wNWFGohHXpbOD
         6aUGzsJuDFcYfyZPS9hbEHxOYRnBzS+831i1wFAXvkv/sdqUjlhiIh8ZUGSwJ3Q798oB
         hKIA==
X-Gm-Message-State: AOUpUlEgPS4IRLsVhMj/v4o8F5ChnNVAzu8EtmXlVjbs7ZFdTA5wzpgn
        g6Ht6KqPosBPl+Cmr1kPc7R+RlDJpNIgObRQTxgzcfloaSA=
X-Google-Smtp-Source: AAOMgpeCzqyWWW1AfYwdhrHMTDP0UWoltZ4gRJPAoTV9h+sfgApUN2vOS9PlND5DapJLO9vmUimGtpgRxw9W2L9r/nI=
X-Received: by 2002:aca:d609:: with SMTP id n9-v6mr17794552oig.357.1533649040821;
 Tue, 07 Aug 2018 06:37:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:191f:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 06:37:20 -0700 (PDT)
In-Reply-To: <20180806061910.29914-2-peda@axentia.se>
References: <20180806061910.29914-1-peda@axentia.se> <20180806061910.29914-2-peda@axentia.se>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 7 Aug 2018 15:37:20 +0200
Message-ID: <CA+M3ks5mHE6G9EeKbRO4hO=-8PsK2xuTz4S5T7ojkVwx1_=wmQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/sti: do not remove the drm_bridge that was
 never added
To:     Peter Rosin <peda@axentia.se>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Vincent Abriou <vincent.abriou@st.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-06 8:19 GMT+02:00 Peter Rosin <peda@axentia.se>:
> Removing the drm_bridge_remove call should avoid a NULL dereference
> during list processing in drm_bridge_remove if the error path is ever
> taken.
>
> The more natural approach would perhaps be to add a drm_bridge_add,
> but there are several other bridges that never call drm_bridge_add.
> Just removing the drm_bridge_remove is the easier fix.
>
> Fixes: 84601dbdea36 ("drm: sti: rework init sequence")
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Pushed on drm-misc-next,

Thanks,
Benjamin

> ---
>  drivers/gpu/drm/sti/sti_hda.c  | 1 -
>  drivers/gpu/drm/sti/sti_hdmi.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
> index 67bbdb49fffc..199db13f565c 100644
> --- a/drivers/gpu/drm/sti/sti_hda.c
> +++ b/drivers/gpu/drm/sti/sti_hda.c
> @@ -721,7 +721,6 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
>         return 0;
>
>  err_sysfs:
> -       drm_bridge_remove(bridge);
>         return -EINVAL;
>  }
>
> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
> index 58f431102512..932724784942 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> @@ -1315,7 +1315,6 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
>         return 0;
>
>  err_sysfs:
> -       drm_bridge_remove(bridge);
>         hdmi->drm_connector = NULL;
>         return -EINVAL;
>  }
> --
> 2.11.0
>
