Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C258C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440C7217DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAvhOMvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440C7217DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbeHMT0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:26:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45864 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMT0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:26:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id j143-v6so11698743lfj.12;
        Mon, 13 Aug 2018 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6saDLgMA0drvxYeBdxL3b9/qzhMZg6AozgQqYEsVFrg=;
        b=cAvhOMvtA5Yhlrc2Y0f6BNeDeA1W9QHb+0XVfCC4MEx8u3VtjWP6+lFheJ1sLcWD4/
         xPtWNYr324sFo0NhLwvAQ5WIlf/8KpAiXTtmUW5NXb9i+qqFYc8/430C0MD/qsb39r9X
         OkLYDwNGEQOZTNWxETk2ElahbZZQ/WGgrDxtzL0MA4k514rl/xjg8ryS+2k6J80t5P2l
         019QPqLk2r6jtyeS96bDXg3zO7aTHeuDdaNDX0CdjlTH0xT3bQA3r7cp+NtOWgBpXcFv
         rZykpL+hOAf2ObBeEeGYEIq7iLWvS/cKN2156UNnD+9aeXRC9chij7vM1a7H/unrkjzC
         ochA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6saDLgMA0drvxYeBdxL3b9/qzhMZg6AozgQqYEsVFrg=;
        b=ACCqA/BICbDuYeof/mq+EjUp9rvjLFhGglOluchpf1OkppMDqruSLvOfL2lkTaTYGX
         5LyxMWlItUX04WOcvYniMaI44KAhEMG7LE1gT9OAWIqIYdMd7EIBtAZchxRUhc/e2K4M
         t3ohXYtHtYWVH+V7J84gGy3Zg5mvvutcGzgiP1fRq30PqYhf0DMIir0O1OQeOViwn9AR
         yf5i6pP1pQbZte/OKWATy6yTmQbBn5CxxLMOOnaPC6NZHM9gydF96belIFq/QzBKtkYQ
         dGn4qYWnU+Hhvj5HDZ4qma3MKHZjFVMcs3VuLb/pe+Mext2uDVaaDwUJIToVa9uWRGtf
         SBbg==
X-Gm-Message-State: AOUpUlEdsJtmGj0jdjH1ST5ktcxTqk2g6sGGIPlohaygnMUd3OpwYTj8
        UIvt/oohsd13nvR+QfpGyKA=
X-Google-Smtp-Source: AA+uWPxIWJjcBUtxod1PW+/byuN2AZQO7NPSvx3v1Lqode8gBcy2avIC4MjbdxdEuawTghpijUK54g==
X-Received: by 2002:a19:7403:: with SMTP id v3-v6mr11533919lfe.97.1534178598294;
        Mon, 13 Aug 2018 09:43:18 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id f129-v6sm3418407lff.37.2018.08.13.09.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:43:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V5] thermal: Add cooling device's statistics in sysfs
Date:   Mon, 13 Aug 2018 19:43:15 +0300
Message-ID: <3394204.qE6hlQGZ2Z@dimapc>
In-Reply-To: <CAKohpomCns5EepTGdqbpxcpE3sSj=TqZHy0Hf29nP7vWk0tfYg@mail.gmail.com>
References: <bab196f91cbddca175c725ae6159c0af639bfe07.1522666398.git.viresh.kumar@linaro.org> <d78a41e0-6602-e0f2-c00c-30b4766bb82c@gmail.com> <CAKohpomCns5EepTGdqbpxcpE3sSj=TqZHy0Hf29nP7vWk0tfYg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 13 August 2018 19:21:43 MSK Viresh Kumar wrote:
> On 13 August 2018 at 21:36, Dmitry Osipenko <digetx@gmail.com> wrote:
> > I'm working on adding support of OPP and cooling for NVIDIA Tegra20/30
> > CPUFreq driver and stumbled upon a bug that is introduced by this patch.
> > It is triggered on the driver module unload.
> The problem is that device_unregister() will end up freeing the cdev as
> well, so the current sequence is surely wrong.
> 
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c index 6ab982309e6a..de53c821a282 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1102,8 +1102,8 @@ void thermal_cooling_device_unregister(struct
> > thermal_cooling_device *cdev)> 
> >         mutex_unlock(&thermal_list_lock);
> >         
> >         ida_simple_remove(&thermal_cdev_ida, cdev->id);
> > 
> > -       device_unregister(&cdev->device);
> > 
> >         thermal_cooling_device_destroy_sysfs(cdev);
> > 
> > +       device_unregister(&cdev->device);
> 
> But this looks wrong as well, as the device is still around while
> memory of its sysfs data is gone.

Indeed.

> Maybe something like this is what we need:
> 
> device_del();
> thermal_cooling_device_destroy_sysfs();
> device_put();

[I just realized that thermal_zone and cooling_device are not interrelated. 
I'm not familiar with the thermal/ code]

Thank you Viresh, your proposal looks good to me and works fine. Will you make 
a proper patch?


