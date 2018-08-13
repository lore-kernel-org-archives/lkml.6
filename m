Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A66CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6512217DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZzF/U6VH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6512217DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbeHMTEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:04:39 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54483 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHMTEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:04:39 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so13871688itb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XkxG4sUqfnRENo/ZahLSmFgjYTdqFJhXsTUwuoXJyaA=;
        b=ZzF/U6VHfIErs8MtCPZaBfz2OTYXEqFA/StM4lqETrbXd8p+pbgecX+FIcGz0n1eCW
         ZX4m/992KTvWGXIIbV76DxoH1ja3rHe7iHVkxmHNf0UHlMCwKnm/xPoNsBshCzylVyze
         w83oX4XaCnvknhezLOHjJNAQQmI27zLFZsyqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XkxG4sUqfnRENo/ZahLSmFgjYTdqFJhXsTUwuoXJyaA=;
        b=VTLT0XVOUgqylWwCFFkGVRE5KiKHar/vYhIIp1oww4YgLtOvCLlJwqOoDIHhfUTy2R
         srecf+U1eUF/B0JzUdTb5CY9eW2QzpVWev4zriNGNkYxSQT/z4sDgbo6jgMdsDYpjWYi
         4n551p/UjwZ5KCPf/LKU48UkoCuk+C3YIWgVcl3UalmMi+pHMJXjXP4AQSx8Q2kBY5wh
         OVaHrtutXmnpDkUb5k8fBAObsgSjklGShTSd1/1UiXhGanqLLVKBb9ylE6EPEulXjKXf
         BMWisvYkm4SUzcxwRZ0vL+8dc/lJ1rVbXlBI8gMFhn7ogPr3rnX0XkEXMaZ6K1eXbou3
         qt8A==
X-Gm-Message-State: AOUpUlHp8YbOpXij7J3BA3Ygk+ps45r+jDaTKNdUpC7fzNOg/Wk7sHoP
        cZy2nPM4iVg75gQTUzmOOHgbfO5iH2mZmZ0lXDtqvg==
X-Google-Smtp-Source: AA+uWPxvvifpXkxFY1dUxoGROnH6nupR4hIZf1j3V5eUE3QJBhK+QYZvQ/ZvIQ6+gmdV6ImG9EtKp+cTljsbUfrbSaw=
X-Received: by 2002:a02:8952:: with SMTP id u18-v6mr15898265jaj.13.1534177304114;
 Mon, 13 Aug 2018 09:21:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:4441:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 09:21:43
 -0700 (PDT)
In-Reply-To: <d78a41e0-6602-e0f2-c00c-30b4766bb82c@gmail.com>
References: <bab196f91cbddca175c725ae6159c0af639bfe07.1522666398.git.viresh.kumar@linaro.org>
 <d78a41e0-6602-e0f2-c00c-30b4766bb82c@gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon, 13 Aug 2018 21:51:43 +0530
Message-ID: <CAKohpomCns5EepTGdqbpxcpE3sSj=TqZHy0Hf29nP7vWk0tfYg@mail.gmail.com>
Subject: Re: [PATCH V5] thermal: Add cooling device's statistics in sysfs
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 August 2018 at 21:36, Dmitry Osipenko <digetx@gmail.com> wrote:

> I'm working on adding support of OPP and cooling for NVIDIA Tegra20/30 CPUFreq driver and stumbled upon a bug that is introduced by this patch. It is triggered on the driver module unload.

The problem is that device_unregister() will end up freeing the cdev as well, so
the current sequence is surely wrong.

> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 6ab982309e6a..de53c821a282 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1102,8 +1102,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>         mutex_unlock(&thermal_list_lock);
>
>         ida_simple_remove(&thermal_cdev_ida, cdev->id);
> -       device_unregister(&cdev->device);
>         thermal_cooling_device_destroy_sysfs(cdev);
> +       device_unregister(&cdev->device);

But this looks wrong as well, as the device is still around while
memory of its sysfs data is gone.

Maybe something like this is what we need:

device_del();
thermal_cooling_device_destroy_sysfs();
device_put();

--
viresh
