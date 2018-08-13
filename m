Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C429C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C912086B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWHyVKtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C912086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbeHMTgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:36:36 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36382 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMTgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:36:36 -0400
Received: by mail-it0-f65.google.com with SMTP id p81-v6so15067849itp.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=866J3lLfoola58rTZKvXrT+ZuJoNtsFOlVCq0Eq9G6I=;
        b=DWHyVKtQIJYtnWeYD5fcYWMOJstCP0EJE1FIXVmr8Pi8BiR8NDi7y9wMZWIWT3V6Az
         8n1yZW8W3hNjoiRcSmuFVyOlrr6dl9OKRoCZ9p4YNaI1AWzQW4aFiF8jClwHDRlKrHqj
         a7RbiKQu0MT8txvv0fIPD4M6XzldPDMx6nbbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=866J3lLfoola58rTZKvXrT+ZuJoNtsFOlVCq0Eq9G6I=;
        b=aVAC+O+qyMGQnvOhBCgji5ZVt5KNBwH15W7rzboFCVj4e7/mYmxbcGs4r1LBF3KWXD
         VYQjfb+1S6kyDRlIiH/i7IulfMOJ9O7laWnMQ5MWeR1Xnndltmq+WieKXGnL3kf3BkRt
         yEMbB2v4BcTpiRJW6KRHslIOr2bmltEygpGoVp+RmiEMRa09h6Fq+eibf+E6Vx7rIT39
         zI3hfLc0HB0XG77Xo9jf9PhCfQKoTn4hi1qf6kSCZqVobbPlKvGIpfac4yT/lJItiHhb
         MKAcnlVyggwO9+Ua93ONFgV7vyJCuLPjXWMJ2mb0VkcthIq5Mu4OoWkB1985v/8qE5yS
         6Pnw==
X-Gm-Message-State: AOUpUlF8gP/aYaxHsbkk5TE6/A36w9DzmDp+STWJV7uywNcHkPDchAOs
        TNBx0TchV9F/ukfx4frPPbpjC9b0g2Fyo/UNBdiniA==
X-Google-Smtp-Source: AA+uWPySqsGowbbDab3PBn89k5vtdyYA6jd5RZCa/OAs+GGbaWiWMWXWn0LoMYIKUiFr67phpGtZh4XGHf93TikbezU=
X-Received: by 2002:a24:4cd1:: with SMTP id a200-v6mr12369861itb.36.1534179213637;
 Mon, 13 Aug 2018 09:53:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:4441:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 09:53:33
 -0700 (PDT)
In-Reply-To: <3394204.qE6hlQGZ2Z@dimapc>
References: <bab196f91cbddca175c725ae6159c0af639bfe07.1522666398.git.viresh.kumar@linaro.org>
 <d78a41e0-6602-e0f2-c00c-30b4766bb82c@gmail.com> <CAKohpomCns5EepTGdqbpxcpE3sSj=TqZHy0Hf29nP7vWk0tfYg@mail.gmail.com>
 <3394204.qE6hlQGZ2Z@dimapc>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon, 13 Aug 2018 22:23:33 +0530
Message-ID: <CAKohpo=BnVJ5uO5+6p6ONhucHkxS893t6d1gtHJZW1kKB0EXOw@mail.gmail.com>
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

On 13 August 2018 at 22:13, Dmitry Osipenko <digetx@gmail.com> wrote:
> On Monday, 13 August 2018 19:21:43 MSK Viresh Kumar wrote:
>> On 13 August 2018 at 21:36, Dmitry Osipenko <digetx@gmail.com> wrote:
>> > I'm working on adding support of OPP and cooling for NVIDIA Tegra20/30
>> > CPUFreq driver and stumbled upon a bug that is introduced by this patch.
>> > It is triggered on the driver module unload.
>> The problem is that device_unregister() will end up freeing the cdev as
>> well, so the current sequence is surely wrong.
>>
>> > diff --git a/drivers/thermal/thermal_core.c
>> > b/drivers/thermal/thermal_core.c index 6ab982309e6a..de53c821a282 100644
>> > --- a/drivers/thermal/thermal_core.c
>> > +++ b/drivers/thermal/thermal_core.c
>> > @@ -1102,8 +1102,8 @@ void thermal_cooling_device_unregister(struct
>> > thermal_cooling_device *cdev)>
>> >         mutex_unlock(&thermal_list_lock);
>> >
>> >         ida_simple_remove(&thermal_cdev_ida, cdev->id);
>> >
>> > -       device_unregister(&cdev->device);
>> >
>> >         thermal_cooling_device_destroy_sysfs(cdev);
>> >
>> > +       device_unregister(&cdev->device);
>>
>> But this looks wrong as well, as the device is still around while
>> memory of its sysfs data is gone.
>
> Indeed.
>
>> Maybe something like this is what we need:
>>
>> device_del();
>> thermal_cooling_device_destroy_sysfs();
>> device_put();
>
> [I just realized that thermal_zone and cooling_device are not interrelated.
> I'm not familiar with the thermal/ code]
>
> Thank you Viresh, your proposal looks good to me and works fine. Will you make
> a proper patch?

Maybe you send a patch for this and take the credit as well :)
