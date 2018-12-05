Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D347BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B31A20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ago62cqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B31A20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeLERY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:24:29 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50977 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeLERY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:24:29 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so22591970iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJIU5qPm0FWz6VlyDVJI6HhxPQrbh3vWQhdmJaDqXII=;
        b=ago62cqjasKEph8jw6fM4KZisk1vJjJIjahBE4+/dyxc3gT7rtjWjC7pF17I7qFK3U
         A9b3rcDm/sJdTEiAJu8W3tDpX2TukaU60/ji5yHcGcif27VyGZqePxtJhEYD/qn7x/+4
         cmwcCjKK/VMRxDTnZKldfbE6P34E6btP6VrwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJIU5qPm0FWz6VlyDVJI6HhxPQrbh3vWQhdmJaDqXII=;
        b=jNh7dA6CXfMEvs6BYH+RcTaaf7QRmuGHyETyUcNW2gzCft5Jv3hszu+3NRivdPNgYN
         xROKbDFbo7KMCEd1ByvqFp66fekh1TE/NJ2meqvSdyoGxhpCJOy3fdyHyMlnFu10/kR5
         RTfaMeMINfzdKNTxX0EGzH3S5em5DIPGvM9m9aEOv90UJ71UXXPEv5uNge1rNBtoE0be
         eCxSmCpOlWrBvSPvFMfSOvl63KsH42DDFfg0tDrOVPoXqWVP3d+fqkwTnkTTXWBv3p/N
         W7lRasESGq8ADnTb3/qCbgdJTGYbc3SfjhLs9bk0zWXmxRC9cbmnU/PF0byt6Ml+cBtY
         EMRg==
X-Gm-Message-State: AA+aEWZZ7DROE0f2Z5GuC6UteIwwLbFawVqfIk96xn+PwwLOoq9nFf9i
        oZUHiZlPgBE/fU5nDMHMND4xrV25doZ/JBOKb+nJ9g==
X-Google-Smtp-Source: AFSGD/WndxEYCJe+B1h3fR8jRvsFAGkt6W2jotSAufegGWj/fUHQf3BmDj+/l2qzbsos2R9cXU5JoQFqVi/T+nWA5X0=
X-Received: by 2002:a05:660c:34f:: with SMTP id b15mr16466076itl.146.1544030668000;
 Wed, 05 Dec 2018 09:24:28 -0800 (PST)
MIME-Version: 1.0
References: <1543653585-108277-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1543653585-108277-1-git-send-email-yuehaibing@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 5 Dec 2018 10:24:16 -0700
Message-ID: <CANLsYkzyVCrV8UG7Fim0an2Rto2a4WTd6fSZLr8tt=gLZACesA@mail.gmail.com>
Subject: Re: [PATCH -next] coresight: stm: remove set but not used variable 'res_size'
To:     yuehaibing@huawei.com
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2018 at 01:31, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/hwtracing/coresight/coresight-stm.c: In function 'stm_probe':
> drivers/hwtracing/coresight/coresight-stm.c:796:9: warning:
>  variable 'res_size' set but not used [-Wunused-but-set-variable]
>
> It never used since introduction in commit
> 237483aa5cf4 ("coresight: stm: adding driver for CoreSight STM component")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied - thanks,
Mathieu

> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index ef339ff..f07825d 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -793,7 +793,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>         struct stm_drvdata *drvdata;
>         struct resource *res = &adev->res;
>         struct resource ch_res;
> -       size_t res_size, bitmap_size;
> +       size_t bitmap_size;
>         struct coresight_desc desc = { 0 };
>         struct device_node *np = adev->dev.of_node;
>
> @@ -833,15 +833,11 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>
>         drvdata->write_bytes = stm_fundamental_data_size(drvdata);
>
> -       if (boot_nr_channel) {
> +       if (boot_nr_channel)
>                 drvdata->numsp = boot_nr_channel;
> -               res_size = min((resource_size_t)(boot_nr_channel *
> -                                 BYTES_PER_CHANNEL), resource_size(res));
> -       } else {
> +       else
>                 drvdata->numsp = stm_num_stimulus_port(drvdata);
> -               res_size = min((resource_size_t)(drvdata->numsp *
> -                                BYTES_PER_CHANNEL), resource_size(res));
> -       }
> +
>         bitmap_size = BITS_TO_LONGS(drvdata->numsp) * sizeof(long);
>
>         guaranteed = devm_kzalloc(dev, bitmap_size, GFP_KERNEL);
>
>
>
