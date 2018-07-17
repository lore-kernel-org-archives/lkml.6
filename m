Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A7BECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC3020BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="wG1C8ZlT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ieDwlMeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC3020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeGQE3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:29:39 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:38914 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeGQE3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:29:38 -0400
Received: by mail-yw0-f196.google.com with SMTP id r184-v6so9629951ywg.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 20:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wb8a8VVMbD9RuXap3yxmm/bL4TJRLEdZmAl9R+SNxds=;
        b=wG1C8ZlTzZ7Ii0tJz4x7vYeOOxYnLGt1UJgzkQM2VHTTqmU/F0dSnPZaGjwlpvGP/Y
         /NXZ6VWD2bXOun8OCiEtKKT5eatURsle43bNT8Q8txbM5gng633QT5+c0lHIhUJh+LCK
         v9sJlOFfRGuQUBsrsUBWw2aaq/i8uPX3ojMg7nvVDEatFS6Yh5QCdmuwC8bOX6Y2gmHY
         Q15w9Z6l//VwybUN0Ev1A79PlcfrV4m37IuXWm7406+lcoEFpzE0CcvTIXlhaGuAINyL
         EDWh/TJCnNWzsugHFUk1zJnfCY17Rk53ifLzjeyTPSQ0R0A2vVsxiy6M1Z+QGtgPp8Xg
         bEHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wb8a8VVMbD9RuXap3yxmm/bL4TJRLEdZmAl9R+SNxds=;
        b=ieDwlMePj2RBXRdHw1kJ7LNZ6Mo7ZNHHuYL+d6Dv9TtGysYiskCORScxGuqx98siuF
         Nt7YLEnUThS7nmjRPzwCX6KlAVVwYiTu2AqAysA1xeizTsiRo5Y9eOjeLXfomVqg6keD
         sDJv6yUvHmLnesjrSNFGviu09zmsVeskKs298=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wb8a8VVMbD9RuXap3yxmm/bL4TJRLEdZmAl9R+SNxds=;
        b=adAGA/HbvGL+vzx8SLtu+UvFrGIYeJzjMPh+WyG4z3CrorTWR+KIfcym4Le77Xs/Ko
         nDr+hY6x7b95flaRxdjUZWHZn215mnTRhbdI/q+1fCpReIpXJs4ZPJRpPxtmZ+bwSMnE
         yE85QnslkJFGsXOmH2cWNvlP/YY7WLsTjtrnkPnOHZr7SDFDmvimMnyqZg6J68HHDce4
         D/VwANVTEP6xnaBq10zhRIYY7hvocqvKWeIE1Pan0HF6/j5MVEgj3+aUoOD49Ye7u5Ka
         PCRHYuCc6ydJh+ruhvcKycdjtsI9xIzKVlta3cyTMgO7Dg6RCNaPVB07AB1YWU0VCkqt
         FA+w==
X-Gm-Message-State: AOUpUlE0kWcb1uSAiV2WfU1Jfn16PJ70fxExry5fN/p2sFNgI3FWwmcW
        G7hB4ecXKYRSsVXrJjUoNOoCNT5WGXR0+/L+0qUG7A==
X-Google-Smtp-Source: AAOMgpeG97sGeDu0bCd9qvoaYIJfevwAvkRU5LnV4bXqXhmnb/O3ATkZMawhwhMpRH+LJZl572qcsN5GuNCNXaWy+Sg=
X-Received: by 2002:a0d:fa42:: with SMTP id k63-v6mr9709080ywf.53.1531799947851;
 Mon, 16 Jul 2018 20:59:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 20:59:07
 -0700 (PDT)
In-Reply-To: <20180620182647.GA24405@beast>
References: <20180620182647.GA24405@beast>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 16 Jul 2018 20:59:07 -0700
X-Google-Sender-Auth: LrNuw_jk20V7gBdF7zki0GArTHs
Message-ID: <CAGXu5jK74ew7iTw2_OqJSj4wYjBggPpkN-ENEFRpuq0C-eGRDg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Remove VLA usage
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:26 AM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> uses the maximum sane buffer size and removes copy/paste code.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Friendly ping! Who's tree should this go through?

Thanks!

-Kees

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 100 +++++++++++--------------
>  1 file changed, 42 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index b455da487782..5eb98cde22ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -593,40 +593,59 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
>                 return snprintf(buf, PAGE_SIZE, "\n");
>  }
>
> -static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
> -               struct device_attribute *attr,
> -               const char *buf,
> -               size_t count)
> +/*
> + * Worst case: 32 bits individually specified, in octal at 12 characters
> + * per line (+1 for \n).
> + */
> +#define AMDGPU_MASK_BUF_MAX    (32 * 13)
> +
> +static ssize_t amdgpu_read_mask(const char *buf, size_t count, uint32_t *mask)
>  {
> -       struct drm_device *ddev = dev_get_drvdata(dev);
> -       struct amdgpu_device *adev = ddev->dev_private;
>         int ret;
>         long level;
> -       uint32_t mask = 0;
>         char *sub_str = NULL;
>         char *tmp;
> -       char buf_cpy[count];
> +       char buf_cpy[AMDGPU_MASK_BUF_MAX + 1];
>         const char delimiter[3] = {' ', '\n', '\0'};
> +       size_t bytes;
>
> -       memcpy(buf_cpy, buf, count+1);
> +       *mask = 0;
> +
> +       bytes = min(count, sizeof(buf_cpy) - 1);
> +       memcpy(buf_cpy, buf, bytes);
> +       buf_cpy[bytes] = '\0';
>         tmp = buf_cpy;
>         while (tmp[0]) {
> -               sub_str =  strsep(&tmp, delimiter);
> +               sub_str = strsep(&tmp, delimiter);
>                 if (strlen(sub_str)) {
>                         ret = kstrtol(sub_str, 0, &level);
> -
> -                       if (ret) {
> -                               count = -EINVAL;
> -                               goto fail;
> -                       }
> -                       mask |= 1 << level;
> +                       if (ret)
> +                               return -EINVAL;
> +                       *mask |= 1 << level;
>                 } else
>                         break;
>         }
> +
> +       return 0;
> +}
> +
> +static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
> +               struct device_attribute *attr,
> +               const char *buf,
> +               size_t count)
> +{
> +       struct drm_device *ddev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = ddev->dev_private;
> +       int ret;
> +       uint32_t mask = 0;
> +
> +       ret = amdgpu_read_mask(buf, count, &mask);
> +       if (ret)
> +               return ret;
> +
>         if (adev->powerplay.pp_funcs->force_clock_level)
>                 amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);
>
> -fail:
>         return count;
>  }
>
> @@ -651,32 +670,15 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = ddev->dev_private;
>         int ret;
> -       long level;
>         uint32_t mask = 0;
> -       char *sub_str = NULL;
> -       char *tmp;
> -       char buf_cpy[count];
> -       const char delimiter[3] = {' ', '\n', '\0'};
>
> -       memcpy(buf_cpy, buf, count+1);
> -       tmp = buf_cpy;
> -       while (tmp[0]) {
> -               sub_str =  strsep(&tmp, delimiter);
> -               if (strlen(sub_str)) {
> -                       ret = kstrtol(sub_str, 0, &level);
> +       ret = amdgpu_read_mask(buf, count, &mask);
> +       if (ret)
> +               return ret;
>
> -                       if (ret) {
> -                               count = -EINVAL;
> -                               goto fail;
> -                       }
> -                       mask |= 1 << level;
> -               } else
> -                       break;
> -       }
>         if (adev->powerplay.pp_funcs->force_clock_level)
>                 amdgpu_dpm_force_clock_level(adev, PP_MCLK, mask);
>
> -fail:
>         return count;
>  }
>
> @@ -701,33 +703,15 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = ddev->dev_private;
>         int ret;
> -       long level;
>         uint32_t mask = 0;
> -       char *sub_str = NULL;
> -       char *tmp;
> -       char buf_cpy[count];
> -       const char delimiter[3] = {' ', '\n', '\0'};
> -
> -       memcpy(buf_cpy, buf, count+1);
> -       tmp = buf_cpy;
>
> -       while (tmp[0]) {
> -               sub_str =  strsep(&tmp, delimiter);
> -               if (strlen(sub_str)) {
> -                       ret = kstrtol(sub_str, 0, &level);
> +       ret = amdgpu_read_mask(buf, count, &mask);
> +       if (ret)
> +               return ret;
>
> -                       if (ret) {
> -                               count = -EINVAL;
> -                               goto fail;
> -                       }
> -                       mask |= 1 << level;
> -               } else
> -                       break;
> -       }
>         if (adev->powerplay.pp_funcs->force_clock_level)
>                 amdgpu_dpm_force_clock_level(adev, PP_PCIE, mask);
>
> -fail:
>         return count;
>  }
>
> --
> 2.17.1
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
