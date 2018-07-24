Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F958C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BFC20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X55jWUcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BFC20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388804AbeGXWBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:01:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37775 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388728AbeGXWBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:01:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so5387021wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DeHks6dBxIiXZRjHtqhRveQgloczJ79Y3xgrdO7wTj8=;
        b=X55jWUcTxp2YZCzCgRIviZO/14iM3b98EFhtW9nbLwS4y3+kj62TNcKtCNt17bo6iG
         Feh34faEjYYDipNtRYqv6qNw5vSFTkOjpepLdEoQjnUm3e8tyaAvGxDwkkDTYpJCSybC
         wUVKg0ZAci+7qCBhbSndvgCYaXhC/Ht8WmEdxJZ/aP3rhh6lyQ4mTHzpHxsrBxRt5GMM
         yOvewRokjDP3Zt4QLNIDXaBsTJaxTCwQwOvJRS4TwgVPv8koZSr9cDJgITPD1/P2iYhf
         QQfQrzCZJVIfHuuempt83ZOq+Z2XnquIrVXigWjzALG8Q2iBOjxt123hCMjBayMXVkwV
         /7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DeHks6dBxIiXZRjHtqhRveQgloczJ79Y3xgrdO7wTj8=;
        b=iJaOfQWUW5dH4eijFTIR7vuziq2wAJc8CivHSRgiC/SzWZBpC5GRxRFeny2TUM02Yt
         dofZmHfA2MBDCj/DNg/EjTivqwz/G7djLamcSMhb5dixw7BrQQU72x4LgL41ziWFTgEf
         1ND08AIextym0fIt4yQy7uItsAUfrnw5/kfobRYIpJxMOaXnV5J/Xhdjfwv1Y4V4CbVj
         kJoy3J5uPWSX+f0DRDMOM2VOF8NBt+vyJEwU+ytBtSFQrgC08vwAXDN14e9CGMOsIwcb
         ixV6hh+cWMA3TSFrYbSpPuHW1YeMT6UytKLNyi9g+iowGgvMQJxbHSjQlML68D38w9nx
         nOjg==
X-Gm-Message-State: AOUpUlGIp0p9H9zG5yBs3S29eJy4E/PBiBu3K57g+C7olm96vwWl2Nmt
        6/VG4naDZSPZbLV15uEqjjzsqxlChjDazDoNAUI=
X-Google-Smtp-Source: AAOMgpc8KHGzswivRTZhiHX48CC+0MpXCAIXj1mvhw9UyMFqqB7PmGHFGyz6ExoukY1ZrHlyAo7AnXUStHvXWXZD7yo=
X-Received: by 2002:adf:83c6:: with SMTP id 64-v6mr12169361wre.5.1532465600753;
 Tue, 24 Jul 2018 13:53:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:979e:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 13:53:20
 -0700 (PDT)
In-Reply-To: <20180723163232.GA17358@embeddedor.com>
References: <20180723163232.GA17358@embeddedor.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Jul 2018 16:53:20 -0400
Message-ID: <CADnq5_Ons4y+sweZGg4LgJpfn8wzgg8xdpytLt-78PVqqg-LpA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Fix potential Spectre v1
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 12:32 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> idx can be indirectly controlled by user-space, hence leading to a
> potential exploitation of the Spectre variant 1 vulnerability.
>
> This issue was detected with the help of Smatch:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:408 amdgpu_set_pp_force_state()
> warn: potential spectre issue 'data.states'
>
> Fix this by sanitizing idx before using it to index data.states

Is this actually necessary?  We already check that idx is valid a few
lines before:
        if (ret || idx >= ARRAY_SIZE(data.states)) {
                        count = -EINVAL;
                        goto fail;
                }

Alex


>
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
>
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 15a1192..a446c7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -31,7 +31,7 @@
>  #include <linux/power_supply.h>
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
> -
> +#include <linux/nospec.h>
>
>  static int amdgpu_debugfs_pm_init(struct amdgpu_device *adev);
>
> @@ -403,6 +403,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
>                         count = -EINVAL;
>                         goto fail;
>                 }
> +               idx = array_index_nospec(idx, ARRAY_SIZE(data.states));
>
>                 amdgpu_dpm_get_pp_num_states(adev, &data);
>                 state = data.states[idx];
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
